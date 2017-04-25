<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:ps="http://inspire.ec.europa.eu/schemas/ps/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>PS.ProtectedSite.Ramsar.Ramsar</sld:Name>
    <sld:UserStyle>
      <sld:Name>PS.ProtectedSite.Ramsar.Ramsar</sld:Name>
      <sld:Title>Protected Sites - Ramsar: Ramsar</sld:Title>
      <sld:Abstract>
      </sld:Abstract>
      <sld:FeatureTypeStyle>

        <sld:Rule>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ps:siteDesignation/ps:DesignationType/ps:designationScheme/@xlink:title</ogc:PropertyName>
                <ogc:Literal>ramsar</ogc:Literal>
			  </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ps:siteDesignation/ps:DesignationType/ps:designation/@xlink:title</ogc:PropertyName>
                <ogc:Literal>ramsar</ogc:Literal>
			  </ogc:PropertyIsEqualTo>
            </ogc:And>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>ps:geometry</ogc:PropertyName>
            </sld:Geometry>
            <sld:Fill>
              <sld:CssParameter name="fill">#10aaaa</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.6</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#10aaaa</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1</sld:CssParameter>              
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>