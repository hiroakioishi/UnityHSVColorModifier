Shader "Hidden/HSVColorModifier"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}


	CGINCLUDE

	#include "UnityCG.cginc"
			
	sampler2D _MainTex;

	float _HueScale;
	float _HueOffset;
	float _SaturationScale;
	float _SaturationOffset;
	float _ValueScale;
	float _ValueOffset;

	fixed3 rgb2hsv(fixed3 c) {
		fixed4 K = fixed4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
		fixed4 p = lerp(fixed4(c.b, c.g, K.w, K.z), fixed4(c.g, c.b, K.x, K.y), step(c.b, c.g));
		fixed4 q = lerp(fixed4(p.x, p.y, p.w, c.r), fixed4(c.r, p.y, p.z, p.x), step(p.x, c.r));

		float d = q.x - min(q.w, q.y);
		float e = 1.0e-10;
		return fixed3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
	}

	fixed3 hsv2rgb(fixed3 c){
		fixed4 K = fixed4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		fixed3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
		return c.z * lerp(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
	}

	fixed4 frag (v2f_img i) : SV_Target
	{
		fixed4 col = tex2D(_MainTex, i.uv);

		fixed3 hsvCol = rgb2hsv(col.rgb);

		hsvCol.x = hsvCol.x * _HueScale        + _HueOffset;
		hsvCol.y = hsvCol.y * _SaturationScale + _SaturationOffset;
		hsvCol.z = hsvCol.z * _ValueScale      + _ValueOffset;

		col.rgb = hsv2rgb(hsvCol);

		return col;
	}
	ENDCG

	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex   vert_img
			#pragma fragment frag
			ENDCG
		}
	}
}
