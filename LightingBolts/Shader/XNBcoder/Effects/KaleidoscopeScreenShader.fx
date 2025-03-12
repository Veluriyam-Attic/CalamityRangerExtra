sampler2D uScreen;  // ��������
float2 uCenter;     // ��Ͳ����
float uSegments;    // ������
float uRadius;      // ���÷�Χ
float uOpacity;     // ͸���ȿ���

// **��ת����**
float2 Rotate(float2 coord, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float2(coord.x * c - coord.y * s, coord.x * s + coord.y * c);
}

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float2 uv = coords;
    float2 offset = uv - uCenter;
    float dist = length(offset);

    // **������Χ����Ӱ�컭��**
    if (dist > uRadius) {
        return tex2D(uScreen, uv);
    }

    float segmentAngle = 6.283185 / uSegments; // 360�� / uSegments
    float angle = atan2(offset.y, offset.x);

    angle = fmod(angle, segmentAngle);
    if (angle < 0) angle += segmentAngle;

    float2 mirroredOffset = Rotate(offset, -angle);
    float2 finalCoord = uCenter + mirroredOffset;

    float4 color = tex2D(uScreen, finalCoord);

    // **Ӧ��͸����**
    return lerp(tex2D(uScreen, uv), color, uOpacity);
}

// **���� Shader**
technique KaleidoscopeEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}

// ����������е����⣬�Ȳ�Ҫ����