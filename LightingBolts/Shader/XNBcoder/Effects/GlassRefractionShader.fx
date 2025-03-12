sampler2D uImage0; // ������
sampler2D uBackground; // ��������
float uRefractStrength; // ����ǿ��
float uOpacity; // ͸����

// ��Ҫ������ɫ��
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float4 color = tex2D(uImage0, coords);
    if (!any(color)) return color; // ͸����������

    // ��������ƫ��
    float2 offset = float2(sin(coords.y * 50) * 0.005, cos(coords.x * 50) * 0.005) * uRefractStrength;
    float4 bgColor = tex2D(uBackground, coords + offset);

    // ͸���ں�
    return lerp(bgColor, color, uOpacity);
}

// ���� Technique
technique Basic{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
