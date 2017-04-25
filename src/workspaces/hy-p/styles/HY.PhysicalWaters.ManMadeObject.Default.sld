<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:hy-p="http://inspire.ec.europa.eu/schemas/hy-p/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>HY.PhysicalWaters.ManMadeObject</sld:Name>
    <sld:UserStyle>
      <sld:Name>HY.PhysicalWaters.ManMadeObject.Default</sld:Name>
      <sld:Title>Man-made Object</sld:Title>
      <sld:Abstract>
        There are only depicted the fully functional 
        objects. Punctual objects are depicted with symbols; if the geometry is a 
        curve they are depicted in solid or dashed lines with different stroke width 
        and different colours depending on the feature type; if the geometry is a 
        surface it will be a filled polygon of solid colour adding or not some marks, 
        depending on the feature type.
      </sld:Abstract>
      <sld:FeatureTypeStyle>
        <!--sld:FeatureTypeName>hy-p:DamOrWeir</sld:FeatureTypeName-->
        <sld:Rule>
          <ogc:Filter>
            <!-- FULLY FUNCTIONAL -->
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>hy-p:condition/@xlink:title</ogc:PropertyName>
              <ogc:Literal>functional</ogc:Literal>
            </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#999999</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#666666</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:PolygonSymbolizer>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#666666</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:LineSymbolizer>
          <sld:PointSymbolizer>
            <!--sld:Geometry>
              <ogc:PropertyName>hy-p:geometry</ogc:PropertyName>
            </sld:Geometry-->
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>X</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#666666</sld:CssParameter>
                </sld:Fill>
              </sld:Mark>
              <sld:Size>12</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>