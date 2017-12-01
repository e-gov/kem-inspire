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

![CDDA reporting linked approach](../img/cdda_linked_approach.png)

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

## Input data model

## Sample queries and output
