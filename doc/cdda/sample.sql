/** Sample data for CDDA reporting.
*   -------------------------------
*   This script creates three tables (inspire__cdda_reporting,
*   inspire_cdda_reporting_dataset and inspire__cdda_desig_area) and inserts
*   some sample data in them. The syntax used, is suitable for PostgreSQL,
*   other DB brands have not been tested, possibly slight modifications are
*   needed. No PK-FK relationshis are created.
*
*   Details can be found at:
*   https://github.com/e-gov/kem-inspire/blob/reporting/doc/cdda/README.md
*/

create table inspire__cdda_reporting (
	id integer not null
);

create table inspire__cdda_reporting_dataset (
    cdda_reporting not null
    datasetid integer not null,
    filename character varying(255) not null,
    wfsendpoint character varying(1000),
    wfsversion character varying(5),
    wfsstoredquery character varying(1000)
);

create table inspire__cdda_desig_area (
    datasetid integer not null,
    cdda_reporting integer not null,
    cdda_id integer,
    national_id integer,
    ps_local_id character varying(100),
    ps_namespace character varying(100),
    ps_version_id character varying(100),
    designated_area_type character varying(100),
    cdda_country_code character varying(100),
    cdda_region_code character varying(100),
    designation_type_code character varying(100),
    iucn_category character varying(100),
    site_area numeric,
    major_ecosystem_type character varying(100),
    marine_area_percentage numeric,
    spatial_data_dissemination character varying(100),
    spatial_resolution_code character varying(100),
    eionet_change_date timestamp,
    eionet_change_type character varying(100),
    eionet_edited_by character varying(100),
    eionet_institute character varying(100),
    remark text,
    site_ended boolean
);

/** SAMPLE DATA
*/

insert into inspire__cdda_reporting(
    id
) values (
    1
);

-- insert two linked datasets

insert into inspire__cdda_reporting_dataset(
    cdda_reporting, datasetid, filename,
    wfsendpoint, wfsversion, wfsstoredquery
) values (
    1, 999, 'nn.gml',
    'http://n.io/ows?', '2.0.0', 'http://n.io/ops/getspatialdataset'
), (
    1, 1000, 'mm.gml',
    'http://n.io/ows?', '2.0.0', 'http://n.io/ops/getsomethingelse'
);

-- insert three sample designated areas

insert into inspire__cdda_desig_area(
    datasetid, cdda_reporting, cdda_id, national_id,
    ps_local_id, ps_namespace,
    ps_version_id, designated_area_type,
    cdda_country_code, cdda_region_code, designation_type_code,
    iucn_category, site_area, major_ecosystem_type, marine_area_percentage,
    spatial_data_dissemination, spatial_resolution_code, eionet_change_date,
    eionet_change_type, eionet_edited_by, eionet_institute,
    remark, site_ended
) values (
    999, 1, 180617, 1731,
    '1731', 'http://registry.envir.ee/datasets/eelis/ala', '20140213090427',
    'designatedSite', 'EE', 'EE', 'EE13',
    'V', 8.8, 'marineAndTerrestrial', null,
    'public', 'scaleLarger100K', '2017-12-13 12:57:42',
    'U', 'editor-name', 'eionet-institute-name',
    null, false
), (
    999, 1, 171902, 111,
    '111', 'http://registry.envir.ee/datasets/eelis/ala', '20140313143829',
    'designatedSite', 'EE', 'EE', 'EE18',
    'III', 0, 'terrestrial', null,
    'public', 'scaleLarger100K', '2017-12-13 12:57:42',
    'U', 'editor-name', 'eionet-institute-name',
    null, false
), (
    1000, 1, 392351, 1974541864,
    '1974541864', 'http://registry.envir.ee/datasets/eelis/ala', '20140306105812',
    'designatedSite', 'EE', 'EE', 'EE03',
    'IV', 29.5, 'marineAndTerrestrial', null,
    'public', 'scaleLarger100K', '2017-12-13 12:57:42',
    'U', 'editor-name', 'eionet-institute-name',
    null, false
);
