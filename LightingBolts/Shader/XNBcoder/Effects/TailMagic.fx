// MagicTrailShader.fx - ħ��������β
sampler uImage0 : register(s0);  // ��β������
sampler uImage1 : register(s1);  // ͸���ȿ�������Fade Map��

float3 uColor;
float3 uSecondaryColor;
float uOpacity;
float uGlowIntensity;
float uTime;
matrix uWorldViewProjection;

struct VertexShaderInput {
    float4 Position : POSITION0;
    float4 Color : COLOR0;
    float3 TextureCoordinates : TEXCOORD0;
};

struct VertexShaderOutput {
    float4 Position : SV_POSITION;  // ���� `POSITION`
    float4 Color : COLOR0;
    float3 TextureCoordinates : TEXCOORD0;
};

VertexShaderOutput VertexShaderFunction(VertexShaderInput input) {
    VertexShaderOutput output;
    output.Position = mul(input.Position, uWorldViewProjection);
    output.Color = input.Color;
    output.TextureCoordinates = input.TextureCoordinates;
    return output;
}

float4 PixelShaderFunction(VertexShaderOutput input) : COLOR0{
    float2 coords = input.TextureCoordinates.xy;
    coords.y = (coords.y - 0.5) / input.TextureCoordinates.z + 0.5;  // ���� UV ����

    float glowEffect = saturate(abs(sin(coords.y * 3.14159 + uTime * 2.0))) * uGlowIntensity;
    float4 baseColor = float4(lerp(uColor, uSecondaryColor, glowEffect), uOpacity);

    float4 fadeMapColor = tex2D(uImage1, coords - float2(uTime * 0.6, 0));  // ͸��������
    float opacity = fadeMapColor.r * glowEffect;

    return float4(baseColor.rgb, opacity);
}

technique TrailTechnique{
    pass TrailPass {  // ȷ�� `Pass` �� `GameShaders.Misc` ��ƥ��
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}





//public Color TrailColor(float completionRatio)
//{
//    float hue = (Main.GlobalTimeWrappedHourly * 0.6f + completionRatio * 1.2f) % 1f;
//    float brightness = MathHelper.SmoothStep(0.5f, 1f, Utils.GetLerpValue(0.3f, 0f, completionRatio, true));
//    float opacity = Utils.GetLerpValue(1f, 0.8f, completionRatio, true) * Projectile.Opacity;
//    Color color = Main.hslToRgb(hue, 1f, brightness) * opacity;
//    return color;
//}
//
//
//public float TrailWidth(float completionRatio)
//{
//    return MathHelper.SmoothStep(10f, 25f, Utils.GetLerpValue(0f, 1f, completionRatio, true));
//}
//
//public override bool PreDraw(ref Color lightColor)
//{
//    Texture2D texture = Terraria.GameContent.TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition + Vector2.UnitY * Projectile.gfxOffY;
//    Vector2 origin = texture.Size() * 0.5f;
//
//    Main.spriteBatch.EnterShaderRegion();
//
//    GameShaders.Misc["ModNamespace:TailMagicEffect"]
//        .SetShaderTexture(ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/Trails/FabstaffStreak"));
//
//    GameShaders.Misc["ModNamespace:TailMagicEffect"]
//        .UseColor(new Color(120, 60, 255)) // ����ɫ����ɫħ������
//        .UseSecondaryColor(new Color(255, 255, 120)) // ����ɫ����ɫ����
//        .Apply();
//
//    PrimitiveRenderer.RenderTrail(Projectile.oldPos,
//        new(TrailWidth, TrailColor, (_) = > Projectile.Size * 0.5f, shader: GameShaders.Misc["ModNamespace:TailMagicEffect"]),
//        10);
//
//    Main.spriteBatch.ExitShaderRegion();
//
//    Main.EntitySpriteDraw(texture, drawPosition, null, Projectile.GetAlpha(Color.White), Projectile.rotation, origin, Projectile.scale, 0, 0);
//
//    return false;
//}