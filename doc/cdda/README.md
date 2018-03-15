# CDDA eReporting
The 2018 [Common Database on DesignatedAreas (CDDA) eReporting](
https://www.eea.europa.eu/themes/biodiversity/document-library/cdda-2018-reporting)
is planned to use the data that has already been published under the [Inspire
ProtectedSites theme](http://inspire.ec.europa.eu/theme/ps). The European
Environmental Agency (EEA) has decided to use a "linked approach" meaning that
the current CDDA data model is split in two:
- data available through the Inspire ps:ProtectedSite download service (Type1 data)
- data relevant to CDDA reporting objectives (Type2 data)

The following figure from a presentation by Stefania Morrone during the NRC EIS
November 2018 meeting illustrates how the process is envisioned through two
possible alternatives.

![Fig 1. CDDA reporting linked approach](../img/cdda_linked_approach.png)

> Excerpt from a presentation by Stefania Morrone during the 23.11.2017 NRC EIS
meeting. The full presentation is available for download at [the NRC EIS library](https://forum.eionet.europa.eu/nrc-eis-environmental-information-systems/library/meetings/2017-nrc-eis-meeting/presentations/linked-approach-epsilon-23.11.17)

The first alternative requires a multi-file package to be uploaded to Reportnet
(the software used by the EEA to manage all reporting-related questions). This
multi-file package will consist of 1 or more GML files with spatial data from
an Inspire compliant ps:ProtectedSite dataset (called Type1 data), and one
XML file with all the required reporting-data (called Type2 data). The Type2
dataset will have references to the Type1 dataset on an object basis so
every "row" in the Type2 dataset will have a reference to feature in the Type1
dataset.

The second alternative has the same overall structure with the difference that
no GML data will be provided beforehand - only the Type2 reporting data with
relevant links to Inspire ps:ProtectedSite datasets (1 or many). After uploading
the Type2 package to Reportnet, EEA will harvest the related ps:ProtectedSite
download services and produce the required GML files.

During the 2018 reporting campaign the first alternative will be used.

## How it works
The idea behind this implemention is to use the [GeoServer](http://geoserver.org)
[app-schema plugin](http://docs.geoserver.org/stable/en/user/data/app-schema/index.html)
by utilizing the xsd schemas published by the EEA in their
[Data Dictionary](http://dd.eionet.europa.eu/). Although a web-service oriented
approach is not required at the moment we can still make use of the power the
[app-schema plugin](http://docs.geoserver.org/stable/en/user/data/app-schema/index.html)
offers for schema transformation (since our "linked" ps:ProtectedSite WFS will
be using the same set of tools). We'll let GeoServer handle the schema
transformation for the Type2 CDDA reporting dataset and then we can use a simple
[WFS GetFeature request](#sample-queries-and-output) to query the dataset.

This means that the response we get will not be 100% schema compliant as it will
be served as a `wfs:member` in a `wfs:FeatureCollection`. So we'll need to go
a step further and use [an extra tool](#packaging-of-type1-and-type2) to extract
the required portion of the response (Type2) and pregenerate the ProtectedSite
GML files (Type1) aswell.  


## XSD files
The EEA has published the XML schemas for use in data transformation on their
[Data Dictionary webpage](http://dd.eionet.europa.eu/datasets/3344). These
XSD files will produce a XML document with the following structure:

```
- {http://dd.eionet.europe.eu/namespaces/11}:CDDA
    - {http://dd.eionet.europe.eu/namespaces/873}:DesignatedArea
        - {http://dd.eionet.europe.eu/namespaces/873}:Row
            - {http://dd.eionet.europe.eu/namespaces/873}:cddaId
            - {http://dd.eionet.europe.eu/namespaces/873}:nationalId
            - {http://dd.eionet.europe.eu/namespaces/873}:PSlocalId
            - [...]
        - {http://dd.eionet.europe.eu/namespaces/873}:Row
        - {http://dd.eionet.europe.eu/namespaces/873}:Row
        - [...]
    - {http://dd.eionet.europe.eu/namespaces/874}:LinkedDataset
            - {http://dd.eionet.europe.eu/namespaces/874}:Row
                - {http://dd.eionet.europe.eu/namespaces/874}:datasetId
                - {http://dd.eionet.europe.eu/namespaces/874}:gmlFileName
                - [...]
            - [...]
```

As an example output, let's consider:

```
<?xml version="1.0" encoding="UTF-8"?>
<CDDA
    xmlns="http://dd.eionet.europa.eu/namespaces/11"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://dd.eionet.europa.eu/namespaces/11  http://dd.eionet.europa.eu/v2/dataset/3344/schema-dst-3344.xsd">
    <DesignatedArea xmlns="http://dd.eionet.europa.eu/namespaces/873">
        <Row>
            <cddaId/>
            <nationalId/>
            <PSlocalId/>
            <PSnamespace/>
            <PSversionId/>
            <designatedAreaType/>
            <cddaCountryCode/>
            <cddaRegionCode/>
            <designationTypeCode/>
            <iucnCategory/>
            <siteArea/>
            <majorEcosystemType/>
            <marineAreaPercentage/>
            <spatialDataDissemination/>
            <spatialResolutionCode/>
            <eionetChangeDate/>
            <eionetChangeType/>
            <eionetEditedBy/>
            <eionetInstitute/>
            <remark/>
            <siteEnded/>
            <containedBy/>
        </Row>
		<Row>
            <cddaId/>
            <nationalId/>
            <PSlocalId/>
            <PSnamespace/>
            <PSversionId/>
            <designatedAreaType/>
            <cddaCountryCode/>
            <cddaRegionCode/>
            <designationTypeCode/>
            <iucnCategory/>
            <siteArea/>
            <majorEcosystemType/>
            <marineAreaPercentage/>
            <spatialDataDissemination/>
            <spatialResolutionCode/>
            <eionetChangeDate/>
            <eionetChangeType/>
            <eionetEditedBy/>
            <eionetInstitute/>
            <remark/>
            <siteEnded/>
            <containedBy/>
        </Row>
    </DesignatedArea>
    <LinkedDataset xmlns="http://dd.eionet.europa.eu/namespaces/874">
        <Row>
            <datasetId/>
            <gmlFileName/>
            <wfsEndpoint/>
            <wfsVersion/>
            <wfsStoredQuery/>
        </Row>
        <Row>
            <datasetId/>
            <gmlFileName/>
            <wfsEndpoint/>
            <wfsVersion/>
            <wfsStoredQuery/>
        </Row>		
    </LinkedDataset>
</CDDA>
```
> Example Type2 dataset structure provided by the EEA.

The latter example has two (empty) instances (rows) for both: DesignatedArea
and LinkedDataset.

In order for the xsd files to be used with GeoServer app-schema a slight
adjustment is needed in both the DesignatedArea and LinkedDataset schema files:
both the DesignatedArea/Row and LinkedDataset/Row types need to be made
available at the respective schema root level. Otherwise the mapping seems to
fail with a "no top element found" exception. For a further discussion on the
subject refer to documentation on GeoServer app-schemas and the
[GML "striping" rules](http://docs.geoserver.org/stable/en/user/data/app-schema/mapping-file.html#targetattributenode-optional).

The difference between the original XSD (downloaded from the EEA Data Dictionary
on 23.11.2017) and the modified one can be seen in the commit history of this
repo:
- [schema-tbl-11022.xsd](https://github.com/e-gov/kem-inspire/commit/8aba6c021cd36833e61d44ae769b2ab770a7e277?diff=split#diff-1a14292e57abfb7ca97cf2e53671b9d6)
- [schema-tbl-11023.xsd](https://github.com/e-gov/kem-inspire/commit/8aba6c021cd36833e61d44ae769b2ab770a7e277?diff=split#diff-56c568136b9c1de58815257b357c03e2)

The third xsd [schema-dst-3344.xsd](https://github.com/e-gov/kem-inspire/commit/8aba6c021cd36833e61d44ae769b2ab770a7e277?diff=split#diff-bbe09d95908dc2be5109a30a79daec76)
does not require any changes.


## Input data model
The input relational data model is sketched on the following figure

![Fig 2. Relational data model for input data](../img/cdda_input_datamodel.svg)

We are going to be mapping three elements `dd11:CDDA` (from the table
`inspire__cdda_reporting`) and it's immediate children `dd873:DesignatedArea`
(from `inspire__cdda_desig_area`) and `dd874:LinkedDataset`
(from `inspire__cdda_reporting_dataset`). The XML namespace notation is the
same as the previous [samples](#xsd-files) are using.

Sample DDL SQL file is available [here](sample.sql).

The `inspire__cdda_reporting` table should have as many rows
as many `dd11:CDDA` elements are needed which should amount to 1. This is the
element that shall be encoded within a single `wfs:FeatureCollection/wfs:member`.

Because the multiplicity of both `dd874:LinkedDataset` and `dd873:DesignatedArea`
within `dd11:CDDA` is defined as `maxOccurs="1" minOccurs="1"` these will be
encoded as single elements. If you'd think of `dd11:CDDA` as a DBMS schema then
the LinkedDataset and DesignatedArea elements could be thought of as DB
tables, each with a 0 to "unbounded" number of rows.

The `inspire__cdda_reporting_dataset` holds the data for the
`dd874:LinkedDataset` element. It's relation to `inspire__cdda_reporting` is
defined through

```
inspire__cdda_reporting.id = inspire__cdda_reporting_dataset.cdda_reporting
```

Every row in the `inspire__cdda_reporting_dataset` will represent one Type1
GML file / WFS service query and each row maps to `dd874:Row`.

The `ìnspire__cdda_desig_area` table holds the data for the
`dd873:DesignatedArea` element. It's relation to specific Type1 dataset is
defined through

```
inspire__cdda_desig_area.datasetid = inspire__cdda_reporting_dataset.datasetid
```

and to `dd11:CDDA` through

```
inspire__cdda_desig_area.cdda_reporting = inspire__cdda_reporting.id
```

Every row in the `inspire__cdda_desig_area` will represent one designated area
that's reported upon and each row here maps to `dd873:Row`.


## Sample queries and output
Sample queries are based on a sample dataset available from [here](sample.sql)

### Type1 data
Because the CDDA Type1 dataset is two-fold: supersecret protected sites'
locations and public locations we'll use an extended ps:ProtectedSite schema.
The extension is that we'll add a `datasetId` property to the `ProtectedSite`
featuretype. This property will be the same as for CDDA/LinkedDataset/datasetId
so we could in the end use a process of
1. download the CDDA Type2 dataset
2. loop through CDDA/LinkedDataset elements
3. download those LinkedDataset datasets.

Because this extension of ps:ProtectedSite is required for CDDA reporting, we'll
place it in the `dd11` namespace. The extended app-schema is available at
[app-schema-cache/eu/europa/eionet/dd/namespaces/11/ProtectedSites.xsd](
..). A sample `GetFeature` query

```
$ http "http://localhost:8080/geoserver/dd11/ows?service=WFS&version=2.0.0&request=GetFeature&typeName=dd11:ProtectedSite"
```

will yield a response (identiation added by hand for readability, coordinates
truncated).

```
<?xml version="1.0" encoding="UTF-8"?>
<wfs:FeatureCollection
    xmlns:wfs="http://www.opengis.net/wfs/2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:isoattrs="http://dd.eionet.europa.eu/namespaces/2"
    xmlns:ddattrs="http://dd.eionet.europa.eu/namespaces/3"
    xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:dd874="http://dd.eionet.europa.eu/namespaces/874"
    xmlns:dd873="http://dd.eionet.europa.eu/namespaces/873"
    xmlns:datasets="http://dd.eionet.europa.eu/namespaces/1"
    xmlns:dd11="http://dd.eionet.europa.eu/namespaces/11"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    numberMatched="unknown" numberReturned="3" timeStamp="2018-03-15T07:58:49.138Z"
    xsi:schemaLocation="http://www.opengis.net/wfs/2.0
        http://schemas.opengis.net/wfs/2.0/wfs.xsd
        http://dd.eionet.europa.eu/namespaces/11
        http://dd.eionet.europa.eu/namespaces/11/ProtectedSites.xsd
        http://www.opengis.net/gml/3.2
        http://schemas.opengis.net/gml/3.2.1/gml.xsd">
  <wfs:member>
    <dd11:ProtectedSite gml:id="http://registry.envir.ee/datasets/eelis/ala/1731/20140213090427">
      <gml:boundedBy>
        <gml:Envelope srsDimension="2" srsName="urn:ogc:def:crs:EPSG::4258">
          <gml:lowerCorner>59.34956340219641 26.347750816668285</gml:lowerCorner>
          <gml:upperCorner>59.35356038020356 26.35272371832018</gml:upperCorner>
        </gml:Envelope>
      </gml:boundedBy>
      <dd11:datasetId>999</dd11:datasetId>
      <dd11:geometry>
        <gml:Polygon gml:id="http://registry.envir.ee/datasets/eelis/ala/1731/20140213090427/geometry" srsDimension="2" srsName="urn:ogc:def:crs:EPSG::4258">
          <gml:exterior>
            <gml:LinearRing>
              <gml:posList>59.353061271964386 26.347750816668285 59.35313329430295 [...] 26.34776313259779 59.353061271964386 26.347750816668285</gml:posList>
            </gml:LinearRing>
          </gml:exterior>
        </gml:Polygon>
      </dd11:geometry>
      <dd11:inspireID>
        <base:Identifier>
          <base:localId>1731</base:localId>
          <base:namespace>http://registry.envir.ee/datasets/eelis/ala</base:namespace>
          <base:versionId>20140213090427</base:versionId>
        </base:Identifier>
      </dd11:inspireID>
      <dd11:legalFoundationDate>1971-04-21T00:00:00Z</dd11:legalFoundationDate>
      <dd11:legalFoundationDocument>
        <gmd:CI_Citation>
          <gmd:title>
            <gco:CharacterString>Rakvere raj. RSN TK otsus nr.100&#13;
Kohaliku tähtsusega looduskaitse alla kuuluvate parkide ja botaaniliste üksikobjektide nimekirjade muutmise kohta.&#13;
</gco:CharacterString>
          </gmd:title>
        </gmd:CI_Citation>
      </dd11:legalFoundationDocument>
      <dd11:siteDesignation>
        <dd11:DesignationType>
          <dd11:designationScheme xlink:href="http://dd.eionet.europa.eu/vocabulary/inspire/DesignationSchemeValue/nationalDesignationTypeCode" xlink:title="National CDDA designations"/>
          <dd11:designation xlink:href="http://dd.eionet.europa.eu/vocabulary/cdda/designations/EE13" xlink:title="Limited management zone of protected landscape"/>
          <dd11:percentageUnderDesignation>100</dd11:percentageUnderDesignation>
        </dd11:DesignationType>
      </dd11:siteDesignation>
      <dd11:siteName>
        <gn:GeographicalName>
          <gn:language>est</gn:language>
          <gn:nativeness xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:nameStatus xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:sourceOfName xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:pronunciation xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:spelling>
            <gn:SpellingOfName>
              <gn:text>Rakvere Rahvapark ehk Rakvere mõisa park</gn:text>
              <gn:script>Latn</gn:script>
            </gn:SpellingOfName>
          </gn:spelling>
        </gn:GeographicalName>
      </dd11:siteName>
      <dd11:siteProtectionClassification>natureConservation</dd11:siteProtectionClassification>
    </dd11:ProtectedSite>
  </wfs:member>
  <wfs:member>
    <dd11:ProtectedSite gml:id="http://registry.envir.ee/datasets/eelis/ala/111/20140313143829">
      <gml:boundedBy>
        <gml:Envelope srsDimension="2" srsName="urn:ogc:def:crs:EPSG::4258">
          <gml:lowerCorner>59.12179156072728 25.190648496538845</gml:lowerCorner>
          <gml:upperCorner>59.12194213527627 25.190800628284503</gml:upperCorner>
        </gml:Envelope>
      </gml:boundedBy>
      <dd11:datasetId>999</dd11:datasetId>
      <dd11:geometry>
        <gml:MultiSurface gml:id="http://registry.envir.ee/datasets/eelis/ala/111/20140313143829/geometry" srsDimension="2" srsName="urn:ogc:def:crs:EPSG::4258">
          <gml:surfaceMember>
            <gml:Polygon gml:id="http://registry.envir.ee/datasets/eelis/ala/111/20140313143829/geometry.1" srsDimension="2">
              <gml:exterior>
                <gml:LinearRing>
                  <gml:posList>59.12180031546256 25.190683322728756 59.121795885352164 [...] 25.190674962413773 59.12180479831618 25.19068058725165 59.12180031546256 25.190683322728756</gml:posList>
                </gml:LinearRing>
              </gml:exterior>
            </gml:Polygon>
          </gml:surfaceMember>
          <gml:surfaceMember>
            <gml:Polygon gml:id="http://registry.envir.ee/datasets/eelis/ala/111/20140313143829/geometry.2" srsDimension="2">
              <gml:exterior>
                <gml:LinearRing>
                  <gml:posList>59.12193298493119 25.190800628284503 59.1219285548237 [...] 25.190797892812117 59.12193298493119 25.190800628284503</gml:posList>
                </gml:LinearRing>
              </gml:exterior>
            </gml:Polygon>
          </gml:surfaceMember>
        </gml:MultiSurface>
      </dd11:geometry>
      <dd11:inspireID>
        <base:Identifier>
          <base:localId>111</base:localId>
          <base:namespace>http://registry.envir.ee/datasets/eelis/ala</base:namespace>
          <base:versionId>20140313143829</base:versionId>
        </base:Identifier>
      </dd11:inspireID>
      <dd11:legalFoundationDate>1958-10-02T00:00:00Z</dd11:legalFoundationDate>
      <dd11:legalFoundationDocument>
        <gmd:CI_Citation>
          <gmd:title>
            <gco:CharacterString>Kose rajooni Töörahva Saadikute Nõukogu Täitevkomitee otsus 2.10.1958 nr 178 Loodus- ja kultuurimälestusmärkide kaitse organiseerimisest Kose rajoonis</gco:CharacterString>
          </gmd:title>
        </gmd:CI_Citation>
      </dd11:legalFoundationDocument>
      <dd11:siteDesignation>
        <dd11:DesignationType>
          <dd11:designationScheme xlink:href="http://dd.eionet.europa.eu/vocabulary/inspire/DesignationSchemeValue/nationalDesignationTypeCode" xlink:title="National CDDA designations"/>
          <dd11:designation xlink:href="http://dd.eionet.europa.eu/vocabulary/cdda/designations/EE18" xlink:title="Protected nature monument"/>
          <dd11:percentageUnderDesignation>100</dd11:percentageUnderDesignation>
        </dd11:DesignationType>
      </dd11:siteDesignation>
      <dd11:siteName>
        <gn:GeographicalName>
          <gn:language>est</gn:language>
          <gn:nativeness xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:nameStatus xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:sourceOfName xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:pronunciation xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:spelling>
            <gn:SpellingOfName>
              <gn:text>Ojasoo männid (2)</gn:text>
              <gn:script>Latn</gn:script>
            </gn:SpellingOfName>
          </gn:spelling>
        </gn:GeographicalName>
      </dd11:siteName>
      <dd11:siteProtectionClassification>natureConservation</dd11:siteProtectionClassification>
    </dd11:ProtectedSite>
  </wfs:member>
  <wfs:member>
    <dd11:ProtectedSite gml:id="http://registry.envir.ee/datasets/eelis/ala/1974541864/20140306105812">
      <gml:boundedBy>
        <gml:Envelope srsDimension="2" srsName="urn:ogc:def:crs:EPSG::4258">
          <gml:lowerCorner>58.97413448643376 22.481623899879693</gml:lowerCorner>
          <gml:upperCorner>58.98071538658622 22.49769229158287</gml:upperCorner>
        </gml:Envelope>
      </gml:boundedBy>
      <dd11:datasetId>1000</dd11:datasetId>
      <dd11:geometry>
        <gml:Polygon gml:id="http://registry.envir.ee/datasets/eelis/ala/1974541864/20140306105812/geometry" srsDimension="2" srsName="urn:ogc:def:crs:EPSG::4258">
          <gml:exterior>
            <gml:LinearRing>
              <gml:posList>58.97675811520198 22.493155584487774 58.97668927243729 [...] 22.492701588321186 58.97675811520198 22.493155584487774</gml:posList>
            </gml:LinearRing>
          </gml:exterior>
        </gml:Polygon>
      </dd11:geometry>
      <dd11:inspireID>
        <base:Identifier>
          <base:localId>1974541864</base:localId>
          <base:namespace>http://registry.envir.ee/datasets/eelis/ala</base:namespace>
          <base:versionId>20140306105812</base:versionId>
        </base:Identifier>
      </dd11:inspireID>
      <dd11:legalFoundationDate>2009-04-24T00:00:00Z</dd11:legalFoundationDate>
      <dd11:legalFoundationDocument>
        <gmd:CI_Citation>
          <gmd:title>
            <gco:CharacterString>httdd11://www.riigiteataja.ee/akt/13171813?leiaKehtiv</gco:CharacterString>
          </gmd:title>
        </gmd:CI_Citation>
      </dd11:legalFoundationDocument>
      <dd11:siteDesignation>
        <dd11:DesignationType>
          <dd11:designationScheme xlink:href="http://dd.eionet.europa.eu/vocabulary/inspire/DesignationSchemeValue/nationalDesignationTypeCode" xlink:title="National CDDA designations"/>
          <dd11:designation xlink:href="http://dd.eionet.europa.eu/vocabulary/cdda/designations/EE03" xlink:title="Managed conservation zone of nature reserve"/>
          <dd11:percentageUnderDesignation>100</dd11:percentageUnderDesignation>
        </dd11:DesignationType>
      </dd11:siteDesignation>
      <dd11:siteName>
        <gn:GeographicalName>
          <gn:language>est</gn:language>
          <gn:nativeness xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:nameStatus xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:sourceOfName xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:pronunciation xsi:nil="true" nilReason="http://inspire.ec.europa.eu/codelist/VoidReasonValue/Unpopulated"/>
          <gn:spelling>
            <gn:SpellingOfName>
              <gn:text>Kõrgessaare LKA, Kõrgessaare skv.</gn:text>
              <gn:script>Latn</gn:script>
            </gn:SpellingOfName>
          </gn:spelling>
        </gn:GeographicalName>
      </dd11:siteName>
      <dd11:siteProtectionClassification>natureConservation</dd11:siteProtectionClassification>
    </dd11:ProtectedSite>
  </wfs:member>
</wfs:FeatureCollection>
```


### Type 2 data
As stated before the main idea of this work is to make use of a known API for
querying CDDA Type2 data and the OGC WebFeatureService (WFS) is one possibility
here. So using the `GetFeature` request we can do

```
$ http "http://localhost:8080/geoserver/dd11/ows?service=WFS&version=2.0.0&request=GetFeature&typeName=dd11:CDDA"
```

which will yield response HTTP headers

```
HTTP/1.1 200 OK
Content-Disposition: inline; filename=geoserver-GetFeature.text
Content-Encoding: gzip
Content-Type: text/xml; subtype=gml/3.2
Server: Jetty(9.2.13.v20150730)
Transfer-Encoding: chunked
```

and based on sample dataset from the
[Estonian Environment Agency](http://keskkonnaagentuur.ee/en) will return
a HTTP response like (identiation added by hand for readability)

```
<?xml version="1.0" encoding="UTF-8"?>
<wfs:FeatureCollection
    xmlns:wfs="http://www.opengis.net/wfs/2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:isoattrs="http://dd.eionet.europa.eu/namespaces/2"
    xmlns:ddattrs="http://dd.eionet.europa.eu/namespaces/3"
    xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:dd874="http://dd.eionet.europa.eu/namespaces/874"
    xmlns:dd873="http://dd.eionet.europa.eu/namespaces/873"
    xmlns:datasets="http://dd.eionet.europa.eu/namespaces/1"
    xmlns:dd11="http://dd.eionet.europa.eu/namespaces/11"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    numberMatched="unknown" numberReturned="1" timeStamp="2017-12-18T08:13:22.528Z"
    xsi:schemaLocation="http://www.opengis.net/wfs/2.0
    http://localhost:8080/geoserver/schemas/wfs/2.0/wfs.xsd
    http://dd.eionet.europa.eu/namespaces/11
    http://dd.eionet.europa.eu/namespaces/11/schema-dst-3344.xsd
    http://www.opengis.net/gml/3.2 http://localhost:8080/geoserver/schemas/gml/3.2.1/gml.xsd">
    <wfs:member>
        <dd11:CDDA gml:id="1">
            <dd873:DesignatedArea>
                <dd873:Row>
                    <dd873:cddaId>180617</dd873:cddaId>
                    <dd873:nationalId>1731</dd873:nationalId>
                    <dd873:PSlocalId>1731</dd873:PSlocalId>
                    <dd873:PSnamespace>http://registry.envir.ee/datasets/eelis/ala</dd873:PSnamespace>
                    <dd873:PSversionId>20140213090427</dd873:PSversionId>
                    <dd873:designatedAreaType>designatedSite</dd873:designatedAreaType>
                    <dd873:cddaCountryCode>EE</dd873:cddaCountryCode>
                    <dd873:cddaRegionCode>EE</dd873:cddaRegionCode>
                    <dd873:designationTypeCode>EE13</dd873:designationTypeCode>
                    <dd873:iucnCategory>V</dd873:iucnCategory>
                    <dd873:siteArea>8.8</dd873:siteArea>
                    <dd873:majorEcosystemType>marineAndTerrestrial</dd873:majorEcosystemType>
                    <dd873:spatialDataDissemination>public</dd873:spatialDataDissemination>
                    <dd873:spatialResolutionCode>scaleLarger100K</dd873:spatialResolutionCode>
                    <dd873:eionetChangeDate>2017-12-13 12:57:42Z</dd873:eionetChangeDate>
                    <dd873:eionetChangeType>U</dd873:eionetChangeType>
                    <dd873:eionetEditedBy>editor-name</dd873:eionetEditedBy>
                    <dd873:eionetInstitute>eionet-institute-name</dd873:eionetInstitute>
                    <dd873:siteEnded>0</dd873:siteEnded>
                    <dd873:containedBy>999</dd873:containedBy>
                </dd873:Row>
                <dd873:Row>
                    <dd873:cddaId>171902</dd873:cddaId>
                    <dd873:nationalId>111</dd873:nationalId>
                    <dd873:PSlocalId>111</dd873:PSlocalId>
                    <dd873:PSnamespace>http://registry.envir.ee/datasets/eelis/ala</dd873:PSnamespace>
                    <dd873:PSversionId>20140313143829</dd873:PSversionId>
                    <dd873:designatedAreaType>designatedSite</dd873:designatedAreaType>
                    <dd873:cddaCountryCode>EE</dd873:cddaCountryCode>
                    <dd873:cddaRegionCode>EE</dd873:cddaRegionCode>
                    <dd873:designationTypeCode>EE18</dd873:designationTypeCode>
                    <dd873:iucnCategory>III</dd873:iucnCategory>
                    <dd873:siteArea>0.0</dd873:siteArea>
                    <dd873:majorEcosystemType>terrestrial</dd873:majorEcosystemType>
                    <dd873:spatialDataDissemination>public</dd873:spatialDataDissemination>
                    <dd873:spatialResolutionCode>scaleLarger100K</dd873:spatialResolutionCode>
                    <dd873:eionetChangeDate>2017-12-13 12:57:42Z</dd873:eionetChangeDate>
                    <dd873:eionetChangeType>U</dd873:eionetChangeType>
                    <dd873:eionetEditedBy>editor-name</dd873:eionetEditedBy>
                    <dd873:eionetInstitute>eionet-institute-name</dd873:eionetInstitute>
                    <dd873:siteEnded>0</dd873:siteEnded>
                    <dd873:containedBy>999</dd873:containedBy>
                </dd873:Row>
                <dd873:Row>
                    <dd873:cddaId>392351</dd873:cddaId>
                    <dd873:nationalId>1974541864</dd873:nationalId>
                    <dd873:PSlocalId>1974541864</dd873:PSlocalId>
                    <dd873:PSnamespace>http://registry.envir.ee/datasets/eelis/ala</dd873:PSnamespace>
                    <dd873:PSversionId>20140306105812</dd873:PSversionId>
                    <dd873:designatedAreaType>designatedSite</dd873:designatedAreaType>
                    <dd873:cddaCountryCode>EE</dd873:cddaCountryCode>
                    <dd873:cddaRegionCode>EE</dd873:cddaRegionCode>
                    <dd873:designationTypeCode>EE03</dd873:designationTypeCode>
                    <dd873:iucnCategory>IV</dd873:iucnCategory>
                    <dd873:siteArea>29.5</dd873:siteArea>
                    <dd873:majorEcosystemType>marineAndTerrestrial</dd873:majorEcosystemType>
                    <dd873:spatialDataDissemination>public</dd873:spatialDataDissemination>
                    <dd873:spatialResolutionCode>scaleLarger100K</dd873:spatialResolutionCode>
                    <dd873:eionetChangeDate>2017-12-13 12:57:42Z</dd873:eionetChangeDate>
                    <dd873:eionetChangeType>U</dd873:eionetChangeType>
                    <dd873:eionetEditedBy>editor-name</dd873:eionetEditedBy>
                    <dd873:eionetInstitute>eionet-institute-name</dd873:eionetInstitute>
                    <dd873:siteEnded>0</dd873:siteEnded>
                    <dd873:containedBy>1000</dd873:containedBy>
                </dd873:Row>            
            </dd873:DesignatedArea>
            <dd874:LinkedDataset>
                <dd874:Row>
                    <dd874:datasetId>999</dd874:datasetId>
                    <dd874:gmlFileName>nn.gml</dd874:gmlFileName>
                    <dd874:wfsEndpoint>http://localhost:8080/geoserver/dd11/ows?</dd874:wfsEndpoint>
                    <dd874:wfsVersion>2.0.0</dd874:wfsVersion>
                </dd874:Row>
                <dd874:Row>
                    <dd874:datasetId>1000</dd874:datasetId>
                    <dd874:gmlFileName>mm.gml</dd874:gmlFileName>
                    <dd874:wfsEndpoint>http://localhost:8080/geoserver/dd11/ows?</dd874:wfsEndpoint>
                    <dd874:wfsVersion>2.0.0</dd874:wfsVersion>
                </dd874:Row>
            </dd874:LinkedDataset>
        </dd11:CDDA>
    </wfs:member>
</wfs:FeatureCollection>
```

## Packaging of Type1 and Type2
We'll need to take some extra steps in order to make the GeoServer based WFS
response schema-compliant for CDDA reporting. Namely:
1. for Type2 data we'll need to take the `{http://dd.eionet.europa.eu/namespaces/11}CDDA`
element out of `{http://www.opengis.net/wfs/2.0}FeatureCollection/{http://www.opengis.net/wfs/2.0}member`
and make it the root element of our type2 xml;
2. and for Type1 data process the `{http://dd.eionet.europa.eu/namespaces/11}ProtectedSite` WFS
elements and
    - remove the `{http://dd.eionet.europa.eu/namespaces/11}ProtectedSite/{http://dd.eionet.europa.eu/namespaces/11}datasetId`
element;
    - redefine the target namespace for ProtectedSite to point to the official
http://inspire.ec.europa.eu/schemas/ps/4.0
    - rename `{http://www.opengis.net/wfs/2.0}FeatureCollection/{http://www.opengis.net/wfs/2.0}member`
elements to `{http://www.opengis.net/gml/3.2}FeatureCollection/{http://www.opengis.net/gml/3.2}featureMember`
elements.

The necessary script for doing it in Python in one go is available at
[doc/script/download.py](..) but we'll go the whole process over
[here](#fixing-type1-data-and-saving-a-gml) and [here](#fixing-type2-data-and-saving-a-xml)
aswell

The script will firstly download the dd11:CDDA xml and then do separate
requests to the url specified in
`dd11:CDDA/dd874:LinkedDataset/dd874:Row/dd874:wfsEndpoint` with the
`cql_query` parameter set at `datasetid=n` where *n* is the
`dd11:CDDA/dd874:LinkedDataset/dd874:Row/dd874:datasetId` specified for that
LinkedDataset instance.

### Fixing Type1 data and saving a GML

We'll use Python: the `requests` library for retrieving data and `lxml` for
manipulating xml content.

```
import requests
from lxml import etree

# download data from

url = 'http://localhost:8080/geoserver/dd11/ows?
params = dict(
    service='WFS',
    version='2.0.0',
    request='GetFeature',
    typeName='dd11:ProtectedSite'    
)
r = requests.get(url, params=params)
r.raise_for_status()
type1data = r.content

# ... FIX TARGETNAMESPACE TO INSPIRE PS OFFICIAL ...

type1data = type1data.replace(
    'http://dd.eionet.europa.eu/namespaces/11',
    'http://inspire.ec.europa.eu/schemas/ps/4.0')

# ... and create a XML object

ps = etree.fromstring(type1data)

# these are the namespaces we're going to use.
# and we're switching dd11 to point to ps official

xsi = ps.nsmap['xsi']
schemaLocation = "http://inspire.ec.europa.eu/schemas/ps/4.0 http://inspire.ec.europa.eu/schemas/ps/4.0/ProtectedSites.xsd"
gml = ps.nsmap['gml']
dd11 = ps.nsmap['ps']
base = ps.nsmap['base']
gmd = ps.nsmap['gmd']
gco = ps.nsmap['gco']
xlink = ps.nsmap['xlink']
gn = ps.nsmap['gn']

# set schemaLocation to Inspire official

ps.attrib["{%s}schemaLocation" % xsi] = schemaLocation

# remove some xml root attributes not applicable for GML

for att in ['numberReturned', 'timeStamp', 'numberMatched']:
    if ps.attrib.get(att):
        del ps.attrib[att]

# switch tag names

ps.tag = "{%s}FeatureCollection" % gml
for member in ps.xpath('wfs:member', namespaces=ps.nsmap):
    member.tag = "{%s}featureMember" % gml

# Remove dd11:ProtectedSite/dd11:datasetId elements

for datasetid in ps.xpath('gml:featureMember/dd11:ProtectedSite/dd11:datasetId',
    namespaces=ps.nsmap):
    datasetid.getparent().remove(datasetid)

# aaaand create a clean GML file without unnecessary namespace declarations:

namespaces = dict(
    gml=gml,
    ps=dd11,
    base=base,
    gmd=gmd,
    gco=gco,
    xlink=xlink,
    gn=gn
)

cleaned = etree.Element(ps.tag, ps.attrib, nsmap=namespaces)
cleaned[:] = el[:]

# To finish off, save the file.
# NB! keep in mind that the filename should actually be the same
# as reported for CDDA/LinkedDataset/gmlFileName
# remember the xml_declaration=True or CDR will not recognize the GML for upload.

filepath = 'cdda-type1.gml'
with open (filepath, 'w') as f:
    f.write(etree.tostring(
        cleaned,
        encoding='UTF-8',
        xml_declaration=True,
        pretty_print=True))
```

### Fixing Type2 data and saving a XML

And without any further ado:

```
url = 'http://localhost:8080/geoserver/dd11/ows?
params = dict(
    service='WFS',
    version='2.0.0',
    request='GetFeature',
    typeName='dd11:CDDA'    
)
r = requests.get(url, params=params)
r.raise_for_status()
cdda = etree.fromstring(r.content)

# remove redundant namespaces

cleaned = etree.Element(cdda.tag, cdda.attrib)
cleaned[:] = el[:]

#  get the CDDA element

type2data = cleaned.find('wfs:member/dd11:CDDA', namespaces=cdda.nsmap)

# Fix xsi:schemaLocation to xml declaration as

xsi = "http://www.w3.org/2001/XMLSchema-instance"
schemaLocation="http://dd.eionet.europa.eu/namespaces/11  http://dd.eionet.europa.eu/v2/dataset/3344/schema-dst-3344.xsd"
type2data.attrib["{%s}schemaLocation" % xsi] = schemaLocation

## save type2 file
filepath = 'cdda-type2.xml'
# Save the type2 XML file
with open (filepath, 'w') as f:
    f.write(etree.tostring(type2data, encoding='UTF-8', pretty_print=True))

```


## Setup for reporting
@TODO: + we should create a separate, easy copy-paste filepackage for settng
this workflow up.
