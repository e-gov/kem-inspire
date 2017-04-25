<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:lcv="http://inspire.ec.europa.eu/schemas/lcv/4.0" xmlns:base="http://inspire.ec.europa.eu/schemas/base/3.3" xmlns:ogc="http://www.opengis.net/ogc" xmlns:sld="http://www.opengis.net/sld" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>LC.LandCoverSurfaces.CORINE</sld:Name>
    <sld:UserStyle>
      <sld:Name>CORINE</sld:Name>
      <sld:FeatureTypeStyle>
        <!--sld:FeatureTypeName>lcv:LandCoverUnit</sld:FeatureTypeName-->
        <sld:Rule>
          <sld:Name>LC.LandCoverSurfaces CORINE Style</sld:Name>
          <sld:PolygonSymbolizer>
            <sld:Geometry><ogc:PropertyName>lcv:geometry</ogc:PropertyName></sld:Geometry>
            <sld:Fill>
              <sld:CssParameter name="fill">
                <ogc:Function name="Recode">
                    <!--ogc:PropertyName>class_code</ogc:PropertyName-->
                  <ogc:PropertyName>lcv:landCoverObservation/lcv:LandCoverObservation/lcv:class/@xlink:title</ogc:PropertyName>

                  <!-- 111, Tiheda hoonestusega alad -->

                  <ogc:Literal>111</ogc:Literal>
                  <ogc:Literal>#a80000</ogc:Literal>

                  <!-- 112, Hõredalt hoonestatud alad -->

                  <ogc:Literal>112</ogc:Literal>
                  <ogc:Literal>#ff0000</ogc:Literal>

                  <!-- 121, Tööstus- ja/või kaubandusterritooriumid -->

                  <ogc:Literal>121</ogc:Literal>
                  <ogc:Literal>#a80084</ogc:Literal>

                  <!-- 122, Maantee- ja raudteevõrk ja piirnev ala -->

                  <ogc:Literal>122</ogc:Literal>
                  <ogc:Literal>#ff7f7f</ogc:Literal>

                  <!-- 123, Sadamad -->

                  <ogc:Literal>123</ogc:Literal>
                  <ogc:Literal>#d79e9e</ogc:Literal>

                  <!-- 124, Lennuväljad -->

                  <ogc:Literal>124</ogc:Literal>
                  <ogc:Literal>#9c9c9c</ogc:Literal>

                  <!-- 131, Karjäärid -->

                  <ogc:Literal>131</ogc:Literal>
                  <ogc:Literal>#8400a8</ogc:Literal>

                  <!-- 132, Prügiplatsid -->

                  <ogc:Literal>132</ogc:Literal>
                  <ogc:Literal>#73004c</ogc:Literal>

                  <!-- 133, Ehitusplatsid -->

                  <ogc:Literal>133</ogc:Literal>
                  <ogc:Literal>#df73ff</ogc:Literal>

                  <!-- 141, Asula haljasalad -->

                  <ogc:Literal>141</ogc:Literal>
                  <ogc:Literal>#e8beff</ogc:Literal>

                  <!-- 142, Puhkealad, pargid, kalmistud -->

                  <ogc:Literal>142</ogc:Literal>
                  <ogc:Literal>#ffbee8</ogc:Literal>

                  <!-- 211, Niisutuseta haritav maa -->

                  <ogc:Literal>211</ogc:Literal>
                  <ogc:Literal>#ffebbe</ogc:Literal>

                  <!-- 222, Puuvilja- ja marjaaiad -->

                  <ogc:Literal>222</ogc:Literal>
                  <ogc:Literal>#e6e600</ogc:Literal>

                  <!-- 231, Karjamaad -->

                  <ogc:Literal>231</ogc:Literal>
                  <ogc:Literal>#ffff73</ogc:Literal>

                  <!-- 242, Kompleksmaaviljelus (haritavat maad > 75%) -->

                  <ogc:Literal>242</ogc:Literal>
                  <ogc:Literal>#ffbf33</ogc:Literal>

                  <!-- 243, Põllumajanduslik maa (<75%) loodusliku taimkatte osalusega -->

                  <ogc:Literal>243</ogc:Literal>
                  <ogc:Literal>#ffd37f</ogc:Literal>

                  <!-- 311, Heitlehised lehtmetsad -->

                  <ogc:Literal>311</ogc:Literal>
                  <ogc:Literal>#75ad59</ogc:Literal>

                  <!-- 312, Okasmetsad -->

                  <ogc:Literal>312</ogc:Literal>
                  <ogc:Literal>#144d0d</ogc:Literal>

                  <!-- 313, Segametsad -->

                  <ogc:Literal>313</ogc:Literal>
                  <ogc:Literal>#427838</ogc:Literal>

                  <!-- 321, Looduslikud rohumaad -->

                  <ogc:Literal>321</ogc:Literal>
                  <ogc:Literal>#d2ff32</ogc:Literal>

                  <!-- 322, Loopealsed põõsastikud, nõmm, nõmmraba -->

                  <ogc:Literal>322</ogc:Literal>
                  <ogc:Literal>#98e600</ogc:Literal>

                  <!-- 331, Mererand, liivaluited, liivikud -->

                  <ogc:Literal>331</ogc:Literal>
                  <ogc:Literal>#e1e1e1</ogc:Literal>

                  <!-- 333, Hõreda taimkattega alad -->

                  <ogc:Literal>333</ogc:Literal>
                  <ogc:Literal>#b4dc9e</ogc:Literal>

                  <!-- 421, Rannasoolakud -->

                  <ogc:Literal>421</ogc:Literal>
                  <ogc:Literal>#00a0b9</ogc:Literal>

                  <!-- 511, Vooluveed -->

                  <ogc:Literal>511</ogc:Literal>
                  <ogc:Literal>#0070ff</ogc:Literal>

                  <!-- 512, Veekogud -->

                  <ogc:Literal>512</ogc:Literal>
                  <ogc:Literal>#9be2f2</ogc:Literal>

                  <!-- 521, Rannikulaguunid -->

                  <ogc:Literal>521</ogc:Literal>
                  <ogc:Literal>#73dfff</ogc:Literal>

                  <!-- 523, Meri ja ookean -->

                  <ogc:Literal>523</ogc:Literal>
                  <ogc:Literal>#bee8ff</ogc:Literal>

                  <!-- 3241, üleminekulised metsaalad mineraalmaal -->

                  <ogc:Literal>3241</ogc:Literal>
                  <ogc:Literal>#4ce600</ogc:Literal>

                  <!-- 3242, üleminekulised metsaalad soodes -->

                  <ogc:Literal>3242</ogc:Literal>
                  <ogc:Literal>#728944</ogc:Literal>

                  <!-- 4111, Kalda- ja rannikuroostikud -->

                  <ogc:Literal>4111</ogc:Literal>
                  <ogc:Literal>#b0a3db</ogc:Literal>

                  <!-- 4112, Lagedad madal- ja siirdesood -->

                  <ogc:Literal>4112</ogc:Literal>
                  <ogc:Literal>#8f88d5</ogc:Literal>

                  <!-- 4121, Lagedad rabad puhmaste ja üksikute puudega -->

                  <ogc:Literal>4121</ogc:Literal>
                  <ogc:Literal>#5e66b3</ogc:Literal>

                  <!-- 4122, Turbavõtualad -->

                  <ogc:Literal>4122</ogc:Literal>
                  <ogc:Literal>#38427d</ogc:Literal>

                </ogc:Function>
              </sld:CssParameter>
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