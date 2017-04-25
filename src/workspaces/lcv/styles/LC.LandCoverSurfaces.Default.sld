<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">

  <NamedLayer>
    <se:Name>LC.LandCoverSurfaces</se:Name>
    <UserStyle>
      <se:Name>INSPIRE_Default</se:Name>
      <IsDefault>1</IsDefault>
      <se:FeatureTypeStyle version="1.1.0">
        <se:Description>
          <se:Title>LC.LandCoverSurfaces Default Style</se:Title>
          <se:Abstract> 
            This Style defined the default INSPIRE style for Land Cover data supported by a set of non overlapping of polygons. As there is no required nomenclature, only the geometry is represented, ie only polygons with a white (#FFFFFF) fill and a black outline (#000000) of 3 pixels width.
          </se:Abstract>
        </se:Description>
        <se:Rule>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">3</se:SvgParameter>              
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>