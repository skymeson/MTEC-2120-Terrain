Shader "Custom/Standard Specular UV Free Snow"
{
	Properties
	{
		_ShapeBumpScale("Shape BumpScale", Range( 0 , 2)) = 1
		_ShapeBumpMap("Shape BumpMap", 2D) = "bump" {}
		[NoScaleOffset]_ShapeAmbientOcclusionG("Shape Ambient Occlusion (G)", 2D) = "white" {}
		_ShapeAmbientOcclusionPower("Shape Ambient Occlusion Power", Range( 0 , 1)) = 1
		_MainTex("MainTex ", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Tiling("Tiling", Range( 0.0001 , 100)) = 15
		_TriplanarFalloff("Triplanar Falloff", Range( 0 , 100)) = 100
		_BumpMap("BumpMap", 2D) = "bump" {}
		_BumpScale("BumpScale", Range( 0 , 5)) = 5
		_SpecularRGBSmoothnessA("Specular (RGB) Smoothness (A)", 2D) = "white" {}
		_SpecularPower("Specular Power", Range( 0 , 2)) = 2
		_SmoothnessPower("Smoothness Power", Range( 0 , 2)) = 1
		_AmbientOcclusionG("Ambient Occlusion (G)", 2D) = "white" {}
		_AmbientOcclusionPower("Ambient Occlusion Power", Range( 0 , 2)) = 1
		[Toggle(_USESNOW_ON)] _UseSnow("Use Snow", Float) = 1
		[Toggle(_USEDYNAMICSNOWTSTATICMASKF_ON)] _UseDynamicSnowTStaticMaskF("Use Dynamic Snow (T) Static Mask (F)", Float) = 1
		_SnowMaskB("Snow Mask (B)", 2D) = "white" {}
		_SnowMaskPower("Snow Mask Power", Range( 0 , 10)) = 1
		_SnowAlbedoRGB("Snow Albedo (RGB)", 2D) = "white" {}
		_SnowTiling("Snow Tiling", Range( 0.0001 , 100)) = 15
		_SnowColor("Snow Color", Color) = (1,1,1,1)
		_SnowTriplanarFalloff("Snow Triplanar Falloff", Range( 0 , 100)) = 100
		_SnowNormalRGB("Snow Normal (RGB)", 2D) = "bump" {}
		_SnowNormalScale("Snow Normal Scale", Range( 0 , 5)) = 1
		_SnowSpecularRGBSmoothnessA("Snow Specular (RGB) Smoothness (A)", 2D) = "white" {}
		_SnowSpecularPower("Snow Specular Power", Range( 0 , 2)) = 1
		_SnowSmoothnessPower("Snow Smoothness Power", Range( 0 , 2)) = 1
		_SnowAmbientOcclusionG("Snow Ambient Occlusion(G)", 2D) = "white" {}
		_SnowAmbientOcclusionPower("Snow Ambient Occlusion Power", Range( 0 , 1)) = 1
		_Snow_Amount("Snow_Amount", Range( 0 , 2)) = 0.1411765
		_SnowMaxAngle("Snow Max Angle", Range( 0.001 , 90)) = 90
		_SnowHardness("Snow Hardness", Range( 0 , 5)) = 5
		_Snow_Min_Height("Snow_Min_Height", Range( -1000 , 10000)) = -1000
		_Snow_Min_Height_Blending("Snow_Min_Height_Blending", Float) = 0
		_DetailMask("DetailMask", 2D) = "white" {}
		_DetailMapAlbedoRNyGNxA("Detail Map Albedo(R) Ny(G) Nx(A)", 2D) = "black" {}
		_DetailAlbedoPower("Detail Albedo Power", Range( 0 , 2)) = 0
		_DetailNormalMapScale("DetailNormalMapScale", Range( 0 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature _USESNOW_ON
		#pragma shader_feature _USEDYNAMICSNOWTSTATICMASKF_ON
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		#include "NM_indirect.cginc"
		#pragma multi_compile GPU_FRUSTUM_ON __
		#pragma instancing_options procedural:setup
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _ShapeBumpScale;
		uniform sampler2D _ShapeBumpMap;
		uniform float4 _ShapeBumpMap_ST;
		uniform sampler2D _BumpMap;
		uniform float _Tiling;
		uniform float _TriplanarFalloff;
		uniform float _BumpScale;
		uniform sampler2D _DetailMapAlbedoRNyGNxA;
		uniform float4 _DetailMapAlbedoRNyGNxA_ST;
		uniform float _DetailNormalMapScale;
		uniform sampler2D _DetailMask;
		uniform float4 _DetailMask_ST;
		uniform sampler2D _SnowNormalRGB;
		uniform float _SnowTiling;
		uniform float _SnowTriplanarFalloff;
		uniform float _SnowNormalScale;
		uniform float _Snow_Amount;
		uniform float _SnowMaxAngle;
		uniform float _SnowHardness;
		uniform float _Snow_Min_Height;
		uniform float _Snow_Min_Height_Blending;
		uniform sampler2D _MainTex;
		uniform float4 _Color;
		uniform float _DetailAlbedoPower;
		uniform sampler2D _SnowAlbedoRGB;
		uniform float4 _SnowColor;
		uniform sampler2D _SnowMaskB;
		uniform float4 _SnowMaskB_ST;
		uniform float _SnowMaskPower;
		uniform float _SpecularPower;
		uniform sampler2D _SpecularRGBSmoothnessA;
		uniform sampler2D _SnowSpecularRGBSmoothnessA;
		uniform float _SnowSpecularPower;
		uniform float _SmoothnessPower;
		uniform float _SnowSmoothnessPower;
		uniform sampler2D _ShapeAmbientOcclusionG;
		uniform float _ShapeAmbientOcclusionPower;
		uniform sampler2D _AmbientOcclusionG;
		uniform float _AmbientOcclusionPower;
		uniform sampler2D _SnowAmbientOcclusionG;
		uniform float _SnowAmbientOcclusionPower;


		inline float3 TriplanarSamplingSNF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			xNorm.xyz = half3( UnpackScaleNormal( xNorm, normalScale.y ).xy * float2( nsign.x, 1.0 ) + worldNormal.zy, worldNormal.x ).zyx;
			yNorm.xyz = half3( UnpackScaleNormal( yNorm, normalScale.x ).xy * float2( nsign.y, 1.0 ) + worldNormal.xz, worldNormal.y ).xzy;
			zNorm.xyz = half3( UnpackScaleNormal( zNorm, normalScale.y ).xy * float2( -nsign.z, 1.0 ) + worldNormal.xy, worldNormal.z ).xyz;
			return normalize( xNorm.xyz * projNormal.x + yNorm.xyz * projNormal.y + zNorm.xyz * projNormal.z );
		}


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv0_ShapeBumpMap = i.uv_texcoord * _ShapeBumpMap_ST.xy + _ShapeBumpMap_ST.zw;
			float temp_output_3715_0 = ( 1.0 / _Tiling );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 triplanar3771 = TriplanarSamplingSNF( _BumpMap, ase_worldPos, ase_worldNormal, _TriplanarFalloff, temp_output_3715_0, _BumpScale, 0 );
			float3 tanTriplanarNormal3771 = mul( ase_worldToTangent, triplanar3771 );
			float2 uv0_DetailMapAlbedoRNyGNxA = i.uv_texcoord * _DetailMapAlbedoRNyGNxA_ST.xy + _DetailMapAlbedoRNyGNxA_ST.zw;
			float4 tex2DNode3787 = tex2D( _DetailMapAlbedoRNyGNxA, uv0_DetailMapAlbedoRNyGNxA );
			float2 appendResult11_g1 = (float2(tex2DNode3787.a , tex2DNode3787.g));
			float2 temp_output_4_0_g1 = ( ( ( appendResult11_g1 * float2( 2,2 ) ) + float2( -1,-1 ) ) * _DetailNormalMapScale );
			float2 break8_g1 = temp_output_4_0_g1;
			float dotResult5_g1 = dot( temp_output_4_0_g1 , temp_output_4_0_g1 );
			float temp_output_9_0_g1 = sqrt( ( 1.0 - saturate( dotResult5_g1 ) ) );
			float3 appendResult10_g1 = (float3(break8_g1.x , break8_g1.y , temp_output_9_0_g1));
			float2 uv_DetailMask = i.uv_texcoord * _DetailMask_ST.xy + _DetailMask_ST.zw;
			float4 tex2DNode3795 = tex2D( _DetailMask, uv_DetailMask );
			float3 lerpResult3793 = lerp( tanTriplanarNormal3771 , BlendNormals( tanTriplanarNormal3771 , appendResult10_g1 ) , tex2DNode3795.a);
			float temp_output_3742_0 = ( 1.0 / _SnowTiling );
			float3 triplanar3778 = TriplanarSamplingSNF( _SnowNormalRGB, ase_worldPos, ase_worldNormal, _SnowTriplanarFalloff, temp_output_3742_0, 1.0, 0 );
			float3 tanTriplanarNormal3778 = mul( ase_worldToTangent, triplanar3778 );
			float3 appendResult3779 = (float3(_SnowNormalScale , _SnowNormalScale , 1.0));
			float clampResult3644 = clamp( ase_worldNormal.y , 0.0 , 0.999999 );
			float temp_output_3640_0 = ( _SnowMaxAngle / 45.0 );
			float clampResult3659 = clamp( ( clampResult3644 - ( 1.0 - temp_output_3640_0 ) ) , 0.0 , 2.0 );
			float temp_output_3637_0 = ( ( 1.0 - _Snow_Min_Height ) + ase_worldPos.y );
			float clampResult3657 = clamp( ( temp_output_3637_0 + 1.0 ) , 0.0 , 1.0 );
			float clampResult3656 = clamp( ( ( 1.0 - ( ( temp_output_3637_0 + _Snow_Min_Height_Blending ) / temp_output_3637_0 ) ) + -0.5 ) , 0.0 , 1.0 );
			float clampResult3670 = clamp( ( clampResult3657 + clampResult3656 ) , 0.0 , 1.0 );
			float temp_output_3673_0 = ( pow( ( clampResult3659 * ( 1.0 / temp_output_3640_0 ) ) , _SnowHardness ) * clampResult3670 );
			float3 lerpResult3676 = lerp( BlendNormals( UnpackScaleNormal( tex2D( _ShapeBumpMap, uv0_ShapeBumpMap ), _ShapeBumpScale ) , lerpResult3793 ) , ( tanTriplanarNormal3778 * appendResult3779 ) , ( saturate( ( ase_worldNormal.y * _Snow_Amount ) ) * temp_output_3673_0 ));
			o.Normal = lerpResult3676;
			float4 triplanar3768 = TriplanarSamplingSF( _MainTex, ase_worldPos, ase_worldNormal, _TriplanarFalloff, temp_output_3715_0, 1.0, 0 );
			float4 temp_output_3393_0 = ( triplanar3768 * _Color );
			float4 temp_cast_2 = (( _DetailAlbedoPower * tex2DNode3787.r )).xxxx;
			float4 blendOpSrc3786 = temp_output_3393_0;
			float4 blendOpDest3786 = temp_cast_2;
			float4 lerpResult3794 = lerp( temp_output_3393_0 , (( blendOpDest3786 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest3786 - 0.5 ) ) * ( 1.0 - blendOpSrc3786 ) ) : ( 2.0 * blendOpDest3786 * blendOpSrc3786 ) ) , ( _DetailAlbedoPower * tex2DNode3795.a ));
			float4 triplanar3776 = TriplanarSamplingSF( _SnowAlbedoRGB, ase_worldPos, ase_worldNormal, _SnowTriplanarFalloff, temp_output_3742_0, 1.0, 0 );
			float2 uv0_SnowMaskB = i.uv_texcoord * _SnowMaskB_ST.xy + _SnowMaskB_ST.zw;
			float clampResult3806 = clamp( ( tex2D( _SnowMaskB, uv0_SnowMaskB ).b * _SnowMaskPower ) , 0.0 , 1.0 );
			#ifdef _USEDYNAMICSNOWTSTATICMASKF_ON
				float staticSwitch3796 = ( clampResult3806 * saturate( ( ( (WorldNormalVector( i , lerpResult3676 )).y * _Snow_Amount ) * ( ( _Snow_Amount * _SnowHardness ) * temp_output_3673_0 ) ) ) );
			#else
				float staticSwitch3796 = clampResult3806;
			#endif
			#ifdef _USESNOW_ON
				float staticSwitch3799 = staticSwitch3796;
			#else
				float staticSwitch3799 = 0.0;
			#endif
			float SnowCover3801 = staticSwitch3799;
			float4 lerpResult3317 = lerp( lerpResult3794 , ( triplanar3776 * _SnowColor ) , SnowCover3801);
			float4 clampResult3290 = clamp( lerpResult3317 , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			o.Albedo = clampResult3290.xyz;
			float4 triplanar3775 = TriplanarSamplingSF( _SpecularRGBSmoothnessA, ase_worldPos, ase_worldNormal, _TriplanarFalloff, temp_output_3715_0, 1.0, 0 );
			float4 break3388 = triplanar3775;
			float3 appendResult3389 = (float3(break3388.x , break3388.y , break3388.z));
			float4 triplanar3780 = TriplanarSamplingSF( _SnowSpecularRGBSmoothnessA, ase_worldPos, ase_worldNormal, _SnowTriplanarFalloff, temp_output_3742_0, 1.0, 0 );
			float4 break3454 = triplanar3780;
			float3 appendResult3467 = (float3(break3454.x , break3454.y , break3454.z));
			float3 lerpResult3332 = lerp( ( _SpecularPower * appendResult3389 ) , ( appendResult3467 * _SnowSpecularPower ) , SnowCover3801);
			o.Specular = lerpResult3332;
			float lerpResult3345 = lerp( ( break3388.w * _SmoothnessPower ) , ( break3454.w * _SnowSmoothnessPower ) , SnowCover3801);
			o.Smoothness = lerpResult3345;
			float clampResult3626 = clamp( tex2D( _ShapeAmbientOcclusionG, uv0_ShapeBumpMap ).g , ( 1.0 - _ShapeAmbientOcclusionPower ) , 1.0 );
			float4 triplanar3774 = TriplanarSamplingSF( _AmbientOcclusionG, ase_worldPos, ase_worldNormal, _TriplanarFalloff, temp_output_3715_0, 1.0, 0 );
			float clampResult3629 = clamp( triplanar3774.y , ( 1.0 - _AmbientOcclusionPower ) , 1.0 );
			float4 triplanar3783 = TriplanarSamplingSF( _SnowAmbientOcclusionG, ase_worldPos, ase_worldNormal, _SnowTriplanarFalloff, temp_output_3742_0, 1.0, 0 );
			float clampResult3632 = clamp( 0.0 , ( triplanar3783.y - _SnowAmbientOcclusionPower ) , 1.0 );
			float lerpResult3333 = lerp( clampResult3629 , clampResult3632 , SnowCover3801);
			o.Occlusion = ( clampResult3626 + lerpResult3333 );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}