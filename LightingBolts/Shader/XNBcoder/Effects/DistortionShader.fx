sampler2D uImage0; // ������
float uTime;       // ʱ�����
float uDistortionStrength; // Ť��ǿ��

// ��Ҫ������ɫ��
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    // ���㲨��Ť��ƫ��
    float wave = sin(uTime * 3 + coords.y * 15) * 0.02 * uDistortionStrength;
    coords.x += wave; // �� x ��������ƫ��

    // ��ȡ��Ť�������ɫ
    float4 color = tex2D(uImage0, coords);
    return color;
}

// ���� Technique
technique Basic{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
