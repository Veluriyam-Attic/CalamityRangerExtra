// **FrostCrystalTrail.fx - ˪��������β**
sampler uImage0 : register(s0);  // ��β������
sampler uImage1 : register(s1);  // ͸���ȿ�������Fade Map��

float3 uColor;  // ����ɫ
float3 uSecondaryColor; // ������ɫ
float uOpacity;  // ��β͸����
float uBlurAmount;  // ģ���̶�
float uTime;  // ȫ��ʱ��
float uSpeedFactor; // �ٶ�Ӱ����β��̬
matrix uWorldViewProjection;  // �任����

// **����ṹ**
struct VertexShaderInput {
    float4 Position : POSITION0;
    float4 Color : COLOR0;
    float3 TextureCoordinates : TEXCOORD0;
};

// **����ṹ**
struct VertexShaderOutput {
    float4 Position : SV_POSITION;
    float4 Color : COLOR0;
    float3 TextureCoordinates : TEXCOORD0;
};

// **������ɫ��**
VertexShaderOutput VertexShaderFunction(VertexShaderInput input) {
    VertexShaderOutput output;
    output.Position = mul(input.Position, uWorldViewProjection);
    output.Color = input.Color;
    output.TextureCoordinates = input.TextureCoordinates;
    return output;
}

// **���ߺ��������Բ�ֵ**
float InverseLerp(float a, float b, float x) {
    return saturate((x - a) / (b - a));
}

// **������ɫ��**
float4 PixelShaderFunction(VertexShaderOutput input) : COLOR0{
    float2 coords = input.TextureCoordinates.xy;

// **���� UV ���꣬��ֹ����**
coords.y = (coords.y - 0.5) / input.TextureCoordinates.z + 0.5;

// **�������Ӷ�̬**
float iceParticle = tex2D(uImage1, coords * 2.5 - float2(uTime * 0.4, uTime * 0.2)).r;

// **����͸����**
float4 fadeMapColor = tex2D(uImage1, coords - float2(uTime * 0.6, 0));
float opacity = fadeMapColor.r * pow(sin(coords.y * 3.141), 1.5) * uOpacity;

// **����ģ��Ч��**
float blurEffect = 1.0 - pow(smoothstep(0.0, 0.6, coords.x), uBlurAmount);

// **��ɫ���䣨���� - ���ף�**
float3 frostColor = lerp(uColor, uSecondaryColor, iceParticle);

// **������ɫ����**
return float4(frostColor * blurEffect, opacity);
}

// **Shader Pass**
technique TrailTechnique{
    pass TrailPass {
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}



//public Color TrailColor(float completionRatio)
//{
//    float opacity = Utils.GetLerpValue(1f, 0.7f, completionRatio, true) * Projectile.Opacity;
//    return new Color(120, 200, 255) * opacity; // ����ɫ��β
//}
//public float TrailWidth(float completionRatio)
//{
//    return MathHelper.SmoothStep(8f, 20f, Utils.GetLerpValue(0f, 1f, completionRatio, true));
//}
//public override bool PreDraw(ref Color lightColor)
//{
//    Texture2D texture = Terraria.GameContent.TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition + Vector2.UnitY * Projectile.gfxOffY;
//    Vector2 origin = texture.Size() * 0.5f;
//
//    Main.spriteBatch.EnterShaderRegion();
//
//    GameShaders.Misc["ModNamespace:TrailFrostCrystalEffect"]
//        .SetShaderTexture(ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/Trails/FabstaffStreak"));
//
//    GameShaders.Misc["ModNamespace:TrailFrostCrystalEffect"]
//        .UseColor(new Color(120, 200, 255)) // ����ɫ
//        .UseSecondaryColor(new Color(255, 255, 255)) // ���ף�����Ч����
//        .Apply();
//
//    PrimitiveRenderer.RenderTrail(Projectile.oldPos,
//        new(TrailWidth, TrailColor, (_) = > Projectile.Size * 0.5f, shader: GameShaders.Misc["ModNamespace:TrailFrostCrystalEffect"]),
//        10);
//
//    Main.spriteBatch.ExitShaderRegion();
//
//    Main.EntitySpriteDraw(texture, drawPosition, null, Projectile.GetAlpha(Color.White), Projectile.rotation, origin, Projectile.scale, 0, 0);
//
//    return false;
//}