Shader "Unlit/MarioBox"
{
    Properties
    {
          _Color("Solid Color", Color) = (1, 1, 1, 1)
        _MarioBox ("Texture", 2D) = "white" {}  // Propiedad para la textura principal
         _Ramp ("Texture", 2D) = "white" {}  // Propiedad para la textura secundaria
        _TimeMult("Time Multiplier", Range(0,1)) = 0.3 // Propiedad para el multiplicador de tiempo
       // _TimeTemp ("Float for time", Float) = 1
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
             uniform fixed4 _Color;

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
               fixed4 color : COLOR; //Pixel Color
                float4 vertex : SV_POSITION;
            };

            sampler2D _MarioBox;
            float4 _MarioBox_ST;
            sampler2D _Ramp;
            float4 _Ramp_ST;
            float _TimeMult; // Variable para el multiplicador de tiempo
            //float _TimeTemp;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MarioBox);
                o.color = _Color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float a = _Time.y * _TimeMult;  // Obtener el tiempo y aplicar el multiplicador
                float animatedValue = a + 1.0;  // Suma de tiempo y valor float
                fixed4 col = tex2D(_MarioBox, i.uv);
                //fixed4 text2 = tex2D(_Ramp, i.uv);
                float2 offset = float2(animatedValue ,0) + col.rgba*1;
                fixed4 textureSample = tex2D(_Ramp,i.uv+offset);
                fixed4 finalColor = textureSample;
                // sample the texture
                return finalColor * i.color;
            }
            ENDCG
        }
    }
}
