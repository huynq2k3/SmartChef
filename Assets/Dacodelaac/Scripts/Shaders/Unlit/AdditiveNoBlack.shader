﻿Shader "Dacodelaac/Unlit/AdditiveNoBlack"
{
	Properties
	{
		_Tint("Tint Color", Color) = (0.5, 0.5, 0.5, 0.5)
		_MainTex("Particle Texture", 2D) = "white" {}
		_Strength("Strength", Range(0, 2)) = 1
	}

	CGINCLUDE

	#include "UnityCG.cginc"

	sampler2D _MainTex;
	float4 _MainTex_ST;

	UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_DEFINE_INSTANCED_PROP(float, _Strength)				
		UNITY_DEFINE_INSTANCED_PROP(fixed4, _Tint)				
	UNITY_INSTANCING_BUFFER_END(Props)

	struct appdata_t
	{
		float4 position : POSITION;
		float4 texcoord : TEXCOORD0;
		float4 color : COLOR;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	struct v2f
	{
		float4 position : SV_POSITION;
		float2 texcoord : TEXCOORD0;
		float4 color : COLOR;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	v2f vert(appdata_t v)
	{
		v2f o;

		UNITY_SETUP_INSTANCE_ID(v);
		UNITY_TRANSFER_INSTANCE_ID(v, o);

		o.position = UnityObjectToClipPos(v.position);
		o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.color = v.color;

		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		UNITY_SETUP_INSTANCE_ID(i);
		
		float strength = UNITY_ACCESS_INSTANCED_PROP(Props, _Strength);	
		fixed4 tint = UNITY_ACCESS_INSTANCED_PROP(Props, _Tint);	

		fixed4 col = tint * i.color * tex2D(_MainTex, i.texcoord) * strength;
		col.a = lerp(0, 1, col);
		return col;
	}

	ENDCG

	SubShader
	{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "Transparent" = "Opque" "PreviewType" = "Plane" }

		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_particles			
			#pragma multi_compile_instancing	

			ENDCG
		}
	}
}