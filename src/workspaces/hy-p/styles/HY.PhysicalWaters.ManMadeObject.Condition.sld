<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:hy-p="http://inspire.ec.europa.eu/schemas/hy-p/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>HY.PhysicalWaters.ManMadeObject</sld:Name>
    <sld:UserStyle>
      <sld:Name>HY.PhysicalWaters.ManMadeObject.Condition</sld:Name>
      <sld:Title>Man-made Objects : condition</sld:Title>
      <sld:Abstract>
        Man-made objects categorized by condition of facility
      </sld:Abstract>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:Name>Functional</sld:Name>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>hy-p:condition/@xlink:title</ogc:PropertyName>
              <ogc:Literal>functional</ogc:Literal>
            </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#7EA8BE</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>

          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#7EA8BE</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:LineSymbolizer>
          
          <sld:PointSymbolizer>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>X</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#7EA8BE</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="fill">#0C1012</sld:CssParameter>
                </sld:Stroke>
              </sld:Mark>
              <sld:Size>12</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>

        <sld:Rule>
          <sld:Name>Disused</sld:Name>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>hy-p:condition/@xlink:title</ogc:PropertyName>
              <ogc:Literal>disused</ogc:Literal>
            </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#C2948A</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>

          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#C2948A</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:LineSymbolizer>
          
          <sld:PointSymbolizer>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>X</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#C2948A</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="fill">#0C1012</sld:CssParameter>
                </sld:Stroke>
              </sld:Mark>
              <sld:Size>12</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>

        <sld:Rule>
          <sld:Name>Decommissioned</sld:Name>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>hy-p:condition/@xlink:title</ogc:PropertyName>
              <ogc:Literal>decommissioned</ogc:Literal>
            </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#BBB193</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>

          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#BBB193</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:LineSymbolizer>
          
          <sld:PointSymbolizer>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>X</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#BBB193</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="fill">#0C1012</sld:CssParameter>
                </sld:Stroke>
              </sld:Mark>
              <sld:Size>12</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>

        <sld:Rule>
          <sld:Name>Projected</sld:Name>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>hy-p:condition/@xlink:title</ogc:PropertyName>
              <ogc:Literal>projected</ogc:Literal>
            </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#476A6F</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>

          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#476A6F</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:LineSymbolizer>
          
          <sld:PointSymbolizer>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>X</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#476A6F</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="fill">#0C1012</sld:CssParameter>
                </sld:Stroke>
              </sld:Mark>
              <sld:Size>12</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>

        <sld:Rule>
          <sld:Name>Under construction</sld:Name>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>hy-p:condition/@xlink:title</ogc:PropertyName>
              <ogc:Literal>underconstruction</ogc:Literal>
            </ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#519E8A</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>

          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#519E8A</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>        
          </sld:LineSymbolizer>
          
          <sld:PointSymbolizer>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>X</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#519E8A</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="fill">#0C1012</sld:CssParameter>
                </sld:Stroke>
              </sld:Mark>
              <sld:Size>12</sld:Size>
            </sld:Graphic>
          </sld:PointSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>