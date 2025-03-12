sampler2D uImage0; // ������
float uThreshold;   // ��Ե�����ֵ
float4 uGlowColor;  // ������ɫ

// Sobel ���Ӽ����ݶȣ����ڼ���Ե��
float EdgeDetection(float2 coords) {
    float2 offsets[4] = { float2(-1, 0), float2(1, 0), float2(0, -1), float2(0, 1) };
    float4 color = tex2D(uImage0, coords);
    float edge = 0.0;

    for (int i = 0; i < 4; i++) {
        float4 sample = tex2D(uImage0, coords + offsets[i] * 0.002);
        edge += abs(sample.r - color.r) + abs(sample.g - color.g) + abs(sample.b - color.b);
    }

    return edge;
}

// ��Ҫ������ɫ��
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float edge = EdgeDetection(coords);

// �����Եǿ�ȸ�����ֵ����ʹ�÷�����ɫ
if (edge > uThreshold)
    return uGlowColor;

// ����������ʾ
return tex2D(uImage0, coords);
}

// ���� Technique
technique Basic{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
