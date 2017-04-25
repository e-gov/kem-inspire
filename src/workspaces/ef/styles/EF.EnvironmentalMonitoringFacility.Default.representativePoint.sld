<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:ef="http://inspire.ec.europa.eu/schemas/ef/4.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>EF.EnvironmentalFacilities.Default</sld:Name>
    <sld:UserStyle>
      <sld:Name>INSPIRE_Default</sld:Name>
      <sld:FeatureTypeStyle>
         <sld:Title>Environmental Monitoring Facilities Default Style Representative Point</sld:Title>
         <sld:Abstract> 
            Style using the representativePoint attribute. The geometry is rendered as a square with a size of 6 pixels, with a 50% grey (#808080) fill and a black (#000000) outline.
          </sld:Abstract>
        <sld:Rule>
          <sld:PointSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>ef:representativePoint</ogc:PropertyName>
            </sld:Geometry>
            <sld:Graphic>
              <sld:Mark>
                <sld:WellKnownName>square</sld:WellKnownName>
                <sld:Fill>
                  <sld:CssParameter name="fill">#808080</sld:CssParameter>
                </sld:Fill>
                <sld:Stroke>
                  <sld:CssParameter name="stroke">#000000</sld:CssParameter>
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