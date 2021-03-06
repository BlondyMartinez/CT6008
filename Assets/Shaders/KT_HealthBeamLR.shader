// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:32719,y:32712,varname:node_4013,prsc:2|diff-3314-OUT,emission-3314-OUT,alpha-1896-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32203,y:32838,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.08433735,c3:0,c4:1;n:type:ShaderForge.SFN_Tex2d,id:5630,x:32203,y:32633,ptovrint:False,ptlb:Beam Texture,ptin:_BeamTexture,varname:node_5630,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1412f5243063a244dbfdc427cf8a02d0,ntxv:0,isnm:False|UVIN-5353-UVOUT;n:type:ShaderForge.SFN_Multiply,id:3314,x:32388,y:32703,varname:node_3314,prsc:2|A-5630-RGB,B-1304-RGB;n:type:ShaderForge.SFN_Panner,id:5353,x:32001,y:32516,varname:node_5353,prsc:2,spu:2,spv:0|UVIN-6309-UVOUT,DIST-2271-OUT;n:type:ShaderForge.SFN_Time,id:9866,x:31648,y:32168,varname:node_9866,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2271,x:31844,y:32249,varname:node_2271,prsc:2|A-9866-T,B-4886-OUT;n:type:ShaderForge.SFN_Slider,id:3477,x:32124,y:33061,ptovrint:False,ptlb:Line Opacity,ptin:_LineOpacity,varname:node_3477,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:1896,x:32432,y:32925,varname:node_1896,prsc:2|A-5630-A,B-3477-OUT;n:type:ShaderForge.SFN_TexCoord,id:6309,x:31633,y:32518,varname:node_6309,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Slider,id:4886,x:31476,y:32337,ptovrint:False,ptlb:Tiling Speed,ptin:_TilingSpeed,varname:node_4886,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.156522,max:1;proporder:5630-1304-3477-4886;pass:END;sub:END;*/

Shader "Shader Forge/KT_HealthBeamLR" {
    Properties {
        _BeamTexture ("Beam Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,0.08433735,0,1)
        _LineOpacity ("Line Opacity", Range(0, 1)) = 1
        _TilingSpeed ("Tiling Speed", Range(0, 1)) = 0.156522
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _BeamTexture; uniform float4 _BeamTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _LineOpacity)
                UNITY_DEFINE_INSTANCED_PROP( float, _TilingSpeed)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 node_9866 = _Time;
                float _TilingSpeed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _TilingSpeed );
                float2 node_5353 = (i.uv0+(node_9866.g*_TilingSpeed_var)*float2(2,0));
                float4 _BeamTexture_var = tex2D(_BeamTexture,TRANSFORM_TEX(node_5353, _BeamTexture));
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float3 node_3314 = (_BeamTexture_var.rgb*_Color_var.rgb);
                float3 diffuseColor = node_3314;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = node_3314;
/// Final Color:
                float3 finalColor = diffuse + emissive;
                float _LineOpacity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LineOpacity );
                fixed4 finalRGBA = fixed4(finalColor,(_BeamTexture_var.a*_LineOpacity_var));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _BeamTexture; uniform float4 _BeamTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _LineOpacity)
                UNITY_DEFINE_INSTANCED_PROP( float, _TilingSpeed)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 node_9866 = _Time;
                float _TilingSpeed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _TilingSpeed );
                float2 node_5353 = (i.uv0+(node_9866.g*_TilingSpeed_var)*float2(2,0));
                float4 _BeamTexture_var = tex2D(_BeamTexture,TRANSFORM_TEX(node_5353, _BeamTexture));
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float3 node_3314 = (_BeamTexture_var.rgb*_Color_var.rgb);
                float3 diffuseColor = node_3314;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                float _LineOpacity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LineOpacity );
                fixed4 finalRGBA = fixed4(finalColor * (_BeamTexture_var.a*_LineOpacity_var),0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
