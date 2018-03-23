<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:ps="http://inspire.ec.europa.eu/schemas/ps/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>PS.ProtectedSite.UNESCOManAndBiosphere.BioshpereReserve</sld:Name>
    <sld:UserStyle>
      <sld:Name>PS.ProtectedSite.UNESCOManAndBiosphere.BioshpereReserve</sld:Name>
      <sld:Title>Protected Sites - UNESCOManAndBiosphere - Bioshpere Reserve</sld:Title>
      <sld:Abstract>
      </sld:Abstract>
      <sld:FeatureTypeStyle>

        <sld:Rule>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ps:siteDesignation/ps:DesignationType/ps:designationScheme/@xlink:href</ogc:PropertyName>
                <ogc:Literal>http://dd.eionet.europa.eu/vocabulary/inspire/DesignationSchemeValue/UNESCOManAndBiosphereProgramme</ogc:Literal>
			  </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>ps:geometry</ogc:PropertyName>
            </sld:Geometry>
            <sld:Fill>
              <sld:CssParameter name="fill">#5f9a9e</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.6</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#5f9a9e</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1</sld:CssParameter>              
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>