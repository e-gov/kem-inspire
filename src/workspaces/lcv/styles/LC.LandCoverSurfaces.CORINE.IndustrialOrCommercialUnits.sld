<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:lcv="http://inspire.ec.europa.eu/schemas/lcv/4.0" xmlns:base="http://inspire.ec.europa.eu/schemas/base/3.3" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>LC.LandCoverSurfaces.CORINE.IndustrialOrCommercialUnits</sld:Name>
    <sld:UserStyle>
      <sld:Name>CORINE</sld:Name>
      <sld:FeatureTypeStyle>
        <!--sld:FeatureTypeName>lcv:LandCoverUnit</sld:FeatureTypeName-->
        <sld:Rule>
          <sld:Name>Industrial or Commercial Units</sld:Name>
          <ogc:Filter>
		    <ogc:PropertyIsEqualTo>
			  <ogc:PropertyName>lcv:landCoverObservation/lcv:LandCoverObservation/lcv:class/@xlink:title</ogc:PropertyName>
			  <ogc:Literal>121</ogc:Literal>
			</ogc:PropertyIsEqualTo>
		  </ogc:Filter>
          <sld:PolygonSymbolizer>
            <sld:Geometry><ogc:PropertyName>lcv:geometry</ogc:PropertyName></sld:Geometry>
            <sld:Fill>
              <sld:CssParameter name="fill">#a80084</sld:CssParameter>
            </sld:Fill>
			<sld:Stroke>
              <sld:CssParameter name="stroke-width">0.3</sld:CssParameter>
			  <sld:CssParameter name="stroke-opacity">0.1</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>