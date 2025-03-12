// ��βЧ������ɫ�ں� - �� - ��֮�䶯̬�仯������ѭ���任���������ɫ��βЧ����
// ͸���ȿ��ƣ����� uImage1��Fade Map���� sin() ���㣬ʹ��ββ���𽥵�����

// **��β������������**
sampler uImage0 : register(s0);  // ��β��������
sampler uImage1 : register(s1);  // �����͸���ȿ�������

// **��β�Ķ�̬����**
float3 uColor;            // ��β�Ļ�����ɫ
float uTime;              // ȫ��ʱ�䣬���ڶ�̬��ɫ
float uOpacity;           // ��β��͸����
matrix uWorldViewProjection;  // ���ڼ��㶥��λ�õı任����

// **����ṹ��������ɫ����**
struct VertexShaderInput
{
    float4 Position : POSITION0;  // ����λ��
    float4 Color : COLOR0;        // ��ɫ
    float3 TextureCoordinates : TEXCOORD0;  // �������꣨�ĳ� `float3`��
};

// **����ṹ�����ݸ�������ɫ����**
struct VertexShaderOutput
{
    float4 Position : SV_POSITION;  // �����Ķ���λ��
    float4 Color : COLOR0;          // ��ɫ
    float3 TextureCoordinates : TEXCOORD0;  // ��������
};

// **������ɫ��**
VertexShaderOutput VertexShaderFunction(in VertexShaderInput input)
{
    VertexShaderOutput output = (VertexShaderOutput)0;
    output.Position = mul(input.Position, uWorldViewProjection); // ��������任
    output.Color = input.Color; // ����������ɫ
    output.TextureCoordinates = input.TextureCoordinates; // ������������
    return output;
}

// **���ߺ��������Բ�ֵ**
float InverseLerp(float a, float b, float x)
{
    return saturate((x - a) / (b - a));
}

// **������ɫ��**
float4 PixelShaderFunction(VertexShaderOutput input) : COLOR0
{
    // **���� UV ���꣬��ֹ����**
    float2 coords = input.TextureCoordinates.xy;
    coords.y = (coords.y - 0.5) / input.TextureCoordinates.z + 0.5;

    // **�������л�ȡ������ɫ**
    float4 baseColor = tex2D(uImage0, coords);

    // **�� `uImage1` ��ȡ͸���ȿ��ƣ�Fade Map��**
    float4 fadeMapColor = tex2D(uImage1, coords - float2(uTime * 0.3, 0));
    float opacity = fadeMapColor.r * pow(sin(coords.y * 3.141), 1.5) * uOpacity;

    // **����һ��ʱ��仯���ӣ�������ɫ**
    float timeFactor = (sin(uTime * 1.5) + 1.0) * 0.5;  // 0~1 ֮��仯

    // **��̬��ɫ�仯���� - �� - ����**
    float3 dynamicColor = lerp(float3(1, 0, 0), float3(0, 0, 1), timeFactor);

    // **������ɫ����**
    return float4(baseColor.rgb * dynamicColor, opacity);
}

// **���� Pass ���ƣ�ȷ���� `RegisterTrailShader()` ƥ��**
technique TrailTechnique
{
    pass TrailPass
    {
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}



//public Color TrailColor(float completionRatio)
//{
//    // **��̬��ɫ�仯���� - �� - ����**
//    float hue = (Main.GlobalTimeWrappedHourly * 0.5f + completionRatio) % 1f; // ����ɫ��ʱ��任
//    float opacity = Utils.GetLerpValue(1f, 0.5f, completionRatio, true) * Projectile.Opacity; // ��β��͸��
//    Color color = Main.hslToRgb(hue, 1f, 0.8f) * opacity; // ��ɫ���䣨HSL ת����
//    color.A = (byte)(int)(Utils.GetLerpValue(0f, 0.2f, completionRatio) * 128); // �������͸����
//    return color;
//}
//
//public float TrailWidth(float completionRatio)
//{
//    float widthInterpolant = Utils.GetLerpValue(0f, 0.3f, completionRatio, true) * Utils.GetLerpValue(1.0f, 0.7f, completionRatio, true);
//    return MathHelper.SmoothStep(6f, 20f, widthInterpolant); // ����β����β��խ
//}
//
//public override bool PreDraw(ref Color lightColor)
//{
//    Texture2D texture = Terraria.GameContent.TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition + Vector2.UnitY * Projectile.gfxOffY;
//    Vector2 origin = texture.Size() * 0.5f;
//
//    // **���� Shader ��Ⱦ����**
//    Main.spriteBatch.EnterShaderRegion();
//
//    // **������β Shader ��ͼ**
//    GameShaders.Misc["ModNamespace:TailSecondEffect"].SetShaderTexture(
//        ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/Trails/FabstaffStreak")
//    );
//
//    // **Ӧ�� Shader**
//    GameShaders.Misc["ModNamespace:TailSecondEffect"].Apply();
//
//    // **��Ⱦ��β**
//    PrimitiveRenderer.RenderTrail(
//        Projectile.oldPos,
//        new(TrailWidth, TrailColor, (_) = > Projectile.Size * 0.5f, shader: GameShaders.Misc["ModNamespace:TailSecondEffect"]),
//        10
//    );
//
//    // **�˳� Shader ��Ⱦ**
//    Main.spriteBatch.ExitShaderRegion();
//
//    // **���Ƶ�Ļ����**
//    Main.EntitySpriteDraw(texture, drawPosition, null, Projectile.GetAlpha(Color.White), Projectile.rotation, origin, Projectile.scale, 0, 0);
//
//    return false;
//}