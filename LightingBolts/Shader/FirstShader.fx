// 声明纹理采样器，用于获取纹理颜色

sampler uImage0 : register(s0);

// 定义外部变量（这些变量会由C#代码传递进来）
float3 uColor;            // 主颜色（例如蓝色）
float uOpacity;           // 透明度
float uTime;              // 时间变量（用于动画）

// 矩阵用于处理世界投影
matrix uWorldViewProjection;

// 结构体：顶点着色器输入
struct VertexShaderInput
{
    float4 Position : POSITION0; // 顶点位置
    float4 Color : COLOR0;       // 颜色
    float2 TexCoord : TEXCOORD0; // 纹理坐标
};

// 结构体：顶点着色器输出（给像素着色器使用）
struct VertexShaderOutput
{
    float4 Position : SV_POSITION; // 计算后的屏幕位置
    float4 Color : COLOR0;         // 颜色
    float2 TexCoord : TEXCOORD0;   // 纹理坐标
};

// 顶点着色器（Vertex Shader）
// 主要作用：计算顶点位置，传递颜色和纹理坐标
VertexShaderOutput VertexShaderFunction(in VertexShaderInput input)
{
    VertexShaderOutput output = (VertexShaderOutput)0;

    // 计算世界投影位置
    output.Position = mul(input.Position, uWorldViewProjection);

    // 传递顶点颜色
    output.Color = input.Color;

    // 传递纹理坐标
    output.TexCoord = input.TexCoord;

    return output;
}

// 计算插值（用于渐变）
float InverseLerp(float from, float to, float x)
{
    return saturate((x - from) / (to - from));
}

// 像素着色器（Pixel Shader）
// 主要作用：处理颜色，添加电光效果
float4 PixelShaderFunction(VertexShaderOutput input) : COLOR0
{
    float2 coords = input.TexCoord;

// 读取基础纹理颜色
float4 baseColor = tex2D(uImage0, coords);

// 计算电光闪烁效果（用时间变量制造波动）
float glowFactor = sin(uTime * 5 + coords.y * 10) * 0.5 + 0.5;

// 计算最终颜色（用 uColor 进行调节）
float4 finalColor = float4(uColor * glowFactor, 1.0) * baseColor;

// 透明度控制
finalColor.a *= uOpacity;

return finalColor;
}

// 定义 Shader 的 Technique
technique ElectricBolt
{
    pass P0
    {
        // 指定顶点和像素着色器
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
