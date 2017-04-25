<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:hy-p="http://inspire.ec.europa.eu/schemas/hy-p/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>HY.PhysicalWaters.Catchments</sld:Name>
    <sld:UserStyle>
      <sld:Name>HY.PhysicalWaters.Catchments.Default</sld:Name>
      <sld:Title>Catchments default style</sld:Title>
      <sld:Abstract>
        Drainage Basin areas are portrayed by no filled
        polygons with a solid blue (#0066FF) border with stroke width of 4 pixel the
        RiverBasin features and with stroke width of 2 pixel the DrainageBasin
        ones.
      </sld:Abstract>
      <sld:FeatureTypeStyle>
        <!--sld:FeatureTypeName>hyp:DrainageBasin</sld:FeatureTypeName-->
        <sld:Rule>
          <sld:Name>DrainageBasin</sld:Name>
          <sld:MaxScaleDenominator>500000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>hy-p:geometry</ogc:PropertyName>
            </sld:Geometry>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#0066FF</sld:CssParameter>
              <sld:CssParameter name="stroke-width">4</sld:CssParameter>
            </sld:Stroke>        
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <!--sld:FeatureTypeStyle>
        <sld:FeatureTypeName>hyp:RiverBasin</sld:FeatureTypeName>
        <sld:Rule>
          <sld:Name>RiverBasin</sld:Name>
          <sld:PolygonSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#0066FF</sld:CssParameter>
              <sld:CssParameter name="stroke-width">2</sld:CssParameter>
            </sld:Stroke>        
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle-->
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>