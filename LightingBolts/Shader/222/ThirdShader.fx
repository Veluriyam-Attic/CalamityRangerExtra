sampler2D uImage0; // ������
float uTime;       // ʱ�����
float4 uColor;     // ��ɫ����
float uOpacity;    // ͸����

// HSV ת RGB������ɫ��ʱ��仯��
float3 HUEtoRGB(float H) {
    float R = abs(H * 6 - 3) - 1;
    float G = 2 - abs(H * 6 - 2);
    float B = 2 - abs(H * 6 - 4);
    return saturate(float3(R, G, B));
}

// ��Ҫ������ɫ��
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float4 color = tex2D(uImage0, coords); // ��ȡԭʼ��ɫ
    if (!any(color)) return color; // �����ɫ�ǿյģ�ֱ�ӷ���

    float hue = frac(uTime * 0.2 + coords.x); // ��ʱ��仯��ɫ��
    float3 rgb = HUEtoRGB(hue); // ת��Ϊ RGB
    float4 finalColor = float4(rgb, 1.0) * uOpacity; // Ӧ��͸����
    return finalColor;
}

// ���� Technique
technique Basic{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
