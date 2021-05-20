Shader "Custom/Post Process/Old Tv Effect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        
        _VerticalPixelCount("Vertical pixel count", float) = 10
        
        _VerticalPixelIntensity("Vertical Pixel Intensity", Range(0.0, 1.0)) = 1
        
        _VignetteColor("Vignette Color", Color) = (0, 0, 0, 1)
        _VignetteIntensity("Vignette Intensity", float) = 1
        _VignetteSmoothness("Vignette Smoothness", float) = 1
        _VignetteRoundness("Vignette Roundness", float) = 1
        
        _DistorsionIntensity("Distorsion Intensity", float) = 1
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            float4 _MainTex_ST;
            
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_TexelSize;
            uniform float _VerticalPixelCount;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            
            #define float_to_float3(f) float3(f, f, f)
            
            float _DistorsionIntensity;
            
            // https://www.imaginationtech.com/blog/speeding-up-gpu-barrel-distortion-correction-in-mobile-vr/
            float2 distort_input(float2 pos) {
                pos = pos * 2 - 1;
                pos /= 1 + _DistorsionIntensity * (1 - length(pos));
                return (pos + 1) * 0.5;
            }
            
            float line_coeff(float y) {
                return pow(abs(cos(y * _VerticalPixelCount)), 0.90);
            }
            
            float _VignetteIntensity;
            float _VignetteSmoothness;
            float _VignetteRoundness;
            
            float vignette_effect(float2 uv, float screenRatio) {
                half2 d = abs(uv - float2(0.5, 0.5)) * _VignetteIntensity;
                d *= screenRatio;
                d = pow(saturate(d), _VignetteRoundness);
                return pow(saturate(1.0 - dot(d, d)), _VignetteSmoothness);
            }
            
            float texture_ratio() {
                return _MainTex_TexelSize.z * _MainTex_TexelSize.y;
            }
            
            float _VerticalPixelIntensity;
            float4 _VignetteColor;
           
            fixed4 frag (v2f i) : SV_Target
            {
                float2 pos = distort_input(i.uv);
                float4 col = tex2D(_MainTex, pos);
                col *= lerp(_VerticalPixelIntensity , 1, line_coeff(pos.y));
                col = lerp(_VignetteColor, col, vignette_effect(i.uv, texture_ratio()));
                return col;
            }
            ENDCG
        }
    }
}