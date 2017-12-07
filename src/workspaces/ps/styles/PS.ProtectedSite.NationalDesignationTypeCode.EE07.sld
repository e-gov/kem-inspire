<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:ps="http://inspire.ec.europa.eu/schemas/ps/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>PS.ProtectedSite.NationalDesignationTypeCode.EE07</sld:Name>
    <sld:UserStyle>
      <sld:Name>PS.ProtectedSite.NationalDesignationTypeCode.EE07</sld:Name>
      <sld:Title>Protected Sites - NationalDesignationTypeCode EE07</sld:Title>
      <sld:Abstract>
        Rahvuspargi looduslik sihtkaitsevöönd [et] | Wilderness conservation zone of national park [eng]
      </sld:Abstract>
      <sld:FeatureTypeStyle>

        <sld:Rule>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ps:siteDesignation/ps:DesignationType/ps:designation/@xlink:href</ogc:PropertyName>
                <ogc:Literal>http://dd.eionet.europa.eu/vocabulary/cdda/designations/EE07</ogc:Literal>
			  </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:Function name="dimension">
                  <ogc:PropertyName>ps:geometry</ogc:PropertyName>
                </ogc:Function>
                <ogc:Literal>2</ogc:Literal>
            </ogc:PropertyIsEqualTo> 
            </ogc:And>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>ps:geometry</ogc:PropertyName>
            </sld:Geometry>
            <sld:Fill>
              <sld:CssParameter name="fill">#E55934</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.6</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#E55934</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1</sld:CssParameter>              
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>ps:siteDesignation/ps:DesignationType/ps:designation/@xlink:href</ogc:PropertyName>
                <ogc:Literal>http://dd.eionet.europa.eu/vocabulary/cdda/designations/EE07</ogc:Literal>
			  </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:Function name="dimension">
                  <ogc:PropertyName>ps:geometry</ogc:PropertyName>
                </ogc:Function>
                <ogc:Literal>0</ogc:Literal>
            </ogc:PropertyIsEqualTo> 
            </ogc:And>
		  </ogc:Filter>
          <sld:PointSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>ps:geometry</ogc:PropertyName>
            </sld:Geometry>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>square</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#E55934</sld:CssParameter>
                  <sld:CssParameter name="fill-opacity">0.6</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="stroke">#E55934</sld:CssParameter>
                </sld:Stroke>
              </sld:Mark>
              <sld:Size>6</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>