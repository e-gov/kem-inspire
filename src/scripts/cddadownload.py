# -*- coding: UTF-8 -*-

# A script for crunching GeoServer WFS responses to CDDA reporting datasets.
# -------------------------------------------------------------------------
#
# For more details please visit
# https://github.com/e-gov/kem-inspire/blob/reporting/doc/cdda/README.md
#
# CC BY 4.0: Estonian Ministry of the Environment IT Center
# https://github.com/e-gov/kem-inspire/blob/reporting/LICENSE
"""
This script can be executed on the command-line via

$ python src/scripts/cddadownload.py --url http://localhost:8080/geoserver/dd11/ows?

If the dd11 workspace needs authentication, a user name can be supplied. The
script will ask for user's password:

$ python src/scripts/cddadownload.py --url http://localhost:8080/geoserver/dd11/ows? -U myuser
Password for myuser@http://localhost:8080/geoserver/dd11/ows?:

Alternatively OS environment variables can be used (e.g for a cron job setup):

$ EXPORT CDDA_WFS_URL=http://localhost:8080/geoserver/dd11/ows?
$ EXPORT CDDA_WFS_USER=myuser
$ EXPORT CDDA_WFS_PASS=mypass

By default SSL verification for https is used, but this can be surpressed by
setting the --verify command-line switch to False (or false, False, f, no, n, 0)

$ python src/scripts/cddadownload.py --url https://localhost:8443/geoserver/dd11/ows? --verify no

or using an environment variable

$ EXPORT CDDA_WFS_URL_VERIFY=False

Command line options and further help can be invoked via
$ python src/scripts/cddadownload.py --help

"""

import argparse
import getpass
import os
import requests
from datetime import datetime
from lxml import etree

SSL_VERIFY = True

def _get(url, params, username, password):
    """Do a HTTP GET query, return response content.

    HTTP errors are raised.
    """
    session = requests.Session()
    if username != None:
        session.auth = (username, password)
    r = session.get(url, params=params, verify=SSL_VERIFY)
    r.raise_for_status()
    return r.content

def _get_feature(url, username, password, **kwargs):
    """Do a WFS GetFeature query

    Checks whether kwargs['typenames'] is present.
    """
    assert kwargs.get('typenames') != None, 'typename for request=GetFeature query missing!'
    params = dict(
        service='WFS',
        version='2.0.0',
        request='GetFeature'
    )
    params.update(kwargs)
    return _get(url, params, username, password)

def validate_response(responsexml):
    """Check WFS response and raise exce if needed.

    We're expecting all WFS service exceptions to be in the
    http://www.opengis.net/ows/1.1 namespace. This is necessary only for ows
    exceptions. If the service replies with HTTP error that gets handled
    elsewhere.
    """
    exce = responsexml.find(
        'ows:Exception',
        namespaces={'ows':'http://www.opengis.net/ows/1.1'})
    if exce:
        msg = exce.find(
            'ows:ExceptionText',
            namespaces={'ows':'http://www.opengis.net/ows/1.1'}).text
        raise IOError('Computer says: "NO!" - %s' % msg)

def clean_namespaces(el, **kwargs):
    """Remove unnecessary namespace declarations from input element."""
    cleaned = etree.Element(el.tag, el.attrib, nsmap=kwargs)
    cleaned[:] = el[:]
    return cleaned


def iter_linkeddataset(cdda, username, password):
    """Iterates CDDA/LinkedDataset/Row elements, and yields
    their WFS GetFeature responses.
    """
    for row in cdda.xpath(
        'wfs:member/dd11:CDDA/dd874:LinkedDataset/dd874:Row',
        namespaces=cdda.nsmap):
        filename = row.find('dd874:gmlFileName',namespaces=row.nsmap).text
        datasetid = row.find('dd874:datasetId',namespaces=row.nsmap).text
        url = row.find('dd874:wfsEndpoint',namespaces=row.nsmap).text
        version = row.find('dd874:wfsVersion',namespaces=row.nsmap).text or '2.0.0'
        assert url != None, "dd11:CDDA/dd874:LinkedDataset instance missing wfsEndpoint URL"
        assert datasetid != None, "%s dd11:CDDA/dd874:LinkedDataset instance missing datasetId" % url
        assert filename != None, "%s dd11:CDDA/dd874:LinkedDataset instance missing gmlFilename" % url
        params = dict(
            version=version,
            typenames='dd11:ProtectedSite',
            cql_filter='datasetId=%s' % datasetid
        )
        yield (_get_feature(url, username, password, **params), filename)

def cdda_save(url, path="", username=None, password=None):
    """Download CDDA reporting type1 and type2 datasets

    type1 (Inspire PS schema) - dd11:ProtectedSite
    type2 (CDDA reporting dataset) - d11:CDDA

    Both datasets are expected to be available in the same WFS service
    endpoint.
    """
    r = _get_feature(url, username, password, typenames='dd11:CDDA')
    cdda = etree.fromstring(r)
    ## validate the response somehow
    ## e.g go looking for owsexception
    validate_response(cdda)

    # iterate LinkedDataset/Row and download GML files (Type1 datasets)
    for type1data, filename in iter_linkeddataset(cdda, username, password):
        # FIX TARGETNAMESPACE TO INSPIRE PS OFFICIAL
        type1data = type1data.replace(
            'http://dd.eionet.europa.eu/namespaces/11',
            'http://inspire.ec.europa.eu/schemas/ps/4.0')
        ps = etree.fromstring(type1data)
        validate_response(ps)

        xsi = ps.nsmap['xsi']
        schemaLocation = "http://inspire.ec.europa.eu/schemas/ps/4.0 http://inspire.ec.europa.eu/schemas/ps/4.0/ProtectedSites.xsd"
        gml = ps.nsmap['gml']
        dd11 = ps.nsmap['ps']
        base = ps.nsmap['base']
        gmd = ps.nsmap['gmd']
        gco = ps.nsmap['gco']
        xlink = ps.nsmap['xlink']
        gn = ps.nsmap['gn']

        ps.attrib["{%s}schemaLocation" % xsi] = schemaLocation
        ps.tag = "{%s}FeatureCollection" % gml

        for member in ps.xpath('wfs:member', namespaces=ps.nsmap):
            member.tag = "{%s}featureMember" % gml

        for att in ['numberReturned', 'timeStamp', 'numberMatched']:
            if ps.attrib.get(att):
                del ps.attrib[att]

        # Remove dd11:ProtectedSite/dd11:datasetId elements
        for datasetid in ps.xpath('gml:featureMember/dd11:ProtectedSite/dd11:datasetId', namespaces=ps.nsmap):
            datasetid.getparent().remove(datasetid)

        # Remove unnecessary namespace declarations
        cleaned = clean_namespaces(ps,
            gml=gml, ps=dd11, base=base, gmd=gmd, gco=gco, xlink=xlink, gn=gn)

        # Save type1 GML file
        # NB! filename came from dd874:LinkedDataset/dd874:Row/dd874:gmlFileName
        filepath = os.path.join(path, filename)
        with open (filepath, 'w') as f:
            f.write(etree.tostring(cleaned,
                encoding='UTF-8', xml_declaration=True,
                pretty_print=True))

    # Luke, patience you mast have,
    # All done with type1, with type2 you proceed now
    cleaned = clean_namespaces(cdda)

    ## save type2 file
    filepath = os.path.join(path, 'cdda-type2.xml')
    # Save the type2 XML file
    with open (filepath, 'w') as f:
        type2data = cleaned.find('wfs:member/dd11:CDDA', namespaces=cdda.nsmap)
        ## Add xsi:schemaLocation to xml declaration as
        ## xsi:schemaLocation="http://dd.eionet.europa.eu/namespaces/11 http://dd.eionet.europa.eu/v2/dataset/3344/schema-dst-3344.xsd"

        xsi = "http://www.w3.org/2001/XMLSchema-instance"
        schemaLocation="http://dd.eionet.europa.eu/namespaces/11  http://dd.eionet.europa.eu/v2/dataset/3344/schema-dst-3344.xsd"
        type2data.attrib["{%s}schemaLocation" % xsi] = schemaLocation

        f.write(etree.tostring(type2data, pretty_print=True))

def _str2bool(v):
    """Bool typeconversion for agrparse."""
    if v == None:
        return
    if v.lower() in ('yes', 'true', 't', 'y', '1'):
        return True
    elif v.lower() in ('no', 'false', 'f', 'n', '0'):
        return False
    else:
        raise argparse.ArgumentTypeError('Boolean value expected.')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog='cdda')
    parser.add_argument(
        '-p', '--path',
        help='Path where to store the resulting type1 and type2 files. Defaults to current path.',
        default='.')
    parser.add_argument(
        '-a', '--url',
        help='URL to the dd11:CDDA WFS service endpoint. Defaults to env variable CDDA_WFS_URL.')
    parser.add_argument(
        '-s', '--verify',
        help='1 or 0. Whether to use SSL verification for HTTP requests. Useful for those self-signed HTTPS certificates in the non-public test environments. Defaults to 1.',
        type=_str2bool)
    parser.add_argument(
        '-U', '--username',
        help='Username for the dd11:CDDA WFS service. Defaults to env variable CDDA_WFS_USER. If not found then the service is expected to not need authentication.')
    args = parser.parse_args()

    ## working dir.
    path = args.path
    assert os.path.exists(path), 'Path "%s" does not exist!' % path
    # create a YYYYMMDDHH24MISS named dir inside
    # that will be our output dir
    path = os.path.join(path, datetime.strftime(datetime.now(), '%Y%m%d%H%M%S'))
    os.mkdir(path)

    ## WFS service
    cdda_url = args.url or os.environ.get('CDDA_WFS_URL')
    SSL_VERIFY = args.verify
    if SSL_VERIFY == None:
        SSL_VERIFY == os.environ.get('CDDA_WFS_URL_VERIFY')
    if SSL_VERIFY == None:
        SSL_VERIFY == True

    ## the WFS service has authentication?
    cdda_user = args.username or os.environ.get('CDDA_WFS_USER')
    assert cdda_url is not None, 'No dd11:CDDA WFS endpoint url specified'

    ## check WFS user password
    if cdda_user is not None:
        cdda_password = os.environ.get('CDDA_WFS_PASS') or \
            getpass.getpass('Password for %s@%s: ' % (cdda_user, cdda_url))
    else:
        cdda_password = None

    cdda_save(cdda_url, path=path, username=cdda_user, password=cdda_password)
