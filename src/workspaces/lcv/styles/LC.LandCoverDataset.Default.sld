<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:lcv="http://inspire.ec.europa.eu/schemas/lcv/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>LC.LandCoverDataset.Default</sld:Name>
    <sld:UserStyle>
      <sld:Name>INSPIRE_Default</sld:Name>
      <sld:FeatureTypeStyle>
         <sld:Title>LC.LandCoverDataset Default Style</sld:Title>
         <sld:Abstract> 
            This Style defined the default INSPIRE style for Land Cover dataset.
          </sld:Abstract>
        <sld:Rule>
          <sld:PolygonSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>gml:location/gml:Polygon</ogc:PropertyName>
            </sld:Geometry>
            <sld:Fill>
              <sld:CssParameter name="fill">#ffffff</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.8</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#000000</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">0.9</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>