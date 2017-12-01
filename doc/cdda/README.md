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
@TODO: a placeholder for the expected Type2 xml output file contents.
```
> Example Type2 dataset encoding provided by the EEA.

In order for the xsd files to be used with GeoServer app-schema a slight
adjustment is needed in both the DesignatedArea and LinkedDataset schema files:
both the DesignatedArea/Row and LinkedDataset/Row types need to be made
available at the respective schema root level. Otherwise the mapping seems to
fail with a "no top element found" exception. For a further discussion on the
subject refer to discussion about the [GML "striping" rules](
http://docs.geoserver.org/stable/en/user/data/app-schema/mapping-file.html#targetattributenode-optional).


## Input data model
The input relational data model is sketched on the following figure

![Fig 2. Relational data model for input data](../img/cdda_input_datamodel.svg)

We are going to be mapping three elements `dd11:CDDA` (from the table
`inspire__cdda_reporting`) and it's immediate children `dd873:DesignatedArea`
(from `inspire__cdda_desig_area`) and `dd874:LinkedDataset`
(from `inspire__cdda_reporting_dataset`). The XML namespace notation is the
same as the previous [samples](#XSD) are using.

@TODO: should we also have DDL syntax for DB structures creation?

The `inspire__cdda_reporting` table should have as many rows
as many `dd11:CDDA` elements are needed which should amount to 1. This is the
element that shall be encoded within a single `wfs:FeatureCollection/wfs:member`.

Because the multiplicity of both `dd874:LinkedDataset` and `dd873:DesignatedArea`
within `dd11:CDDA` is defined as `maxOccurs="1" minOccurs="1"` these will be
encoded as single elements. If you'd think of `dd11:CDDA` as a DBMS schema then
the LinkedDataset and DesignatedArea elements could be thought of as DB
tables, each with a 0 to "unbounded" number of rows.

The `inspire__cdda_reporting_dataset` holds the data for the
`dd874:LinkedDataset` elemen. It's relation to `inspire__cdda_reporting` is
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


## Packaging of Type1 and Type2
@TODO
