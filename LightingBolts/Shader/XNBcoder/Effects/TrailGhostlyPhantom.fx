// **TrailGhostlyPhantom.fx - ������Ӱ��β**
sampler uImage0 : register(s0);  // ��β������
sampler uImage1 : register(s1);  // ͸���ȿ�������Fade Map��

float3 uColor;  // ����ɫ������ɫ��
float3 uSecondaryColor; // ����ɫ������ɫ��
float uOpacity;  // ��β͸����
float uTime;  // ȫ��ʱ��
float uGhostFade; // Ӱ���Ӱ��ɢ�ٶ�
matrix uWorldViewProjection;  // �任����

// **����ṹ**
struct VertexShaderInput {
    float4 Position : POSITION0;
    float4 Color : COLOR0;
    float3 TextureCoordinates : TEXCOORD0;
};

// **����ṹ**
struct VertexShaderOutput {
    float4 Position : SV_POSITION;  // ���� `POSITION`
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

// **����͸���ȣ������ӰЧ����**
float4 fadeMapColor = tex2D(uImage1, coords - float2(uTime * 0.4, 0));
float ghostOpacity = fadeMapColor.r * pow(sin(coords.y * 3.141 + uTime * 2.0), 1.3) * uOpacity;

// **��ɫ���䣨����ɫ - ����ɫ��**
float3 ghostlyColor = lerp(uColor, uSecondaryColor, sin(uTime * 1.2 + coords.x * 3.0) * 0.5 + 0.5);

// **��������Ӱ�Ӳ�ӰЧ��**
float ghostFade = pow(1.0 - coords.x, uGhostFade);

return float4(ghostlyColor * ghostFade, ghostOpacity);
}

// **Shader Pass**
technique TrailTechnique{
    pass TrailPass {
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}



//public override bool PreDraw(ref Color lightColor)
//{
//    Texture2D texture = Terraria.GameContent.TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition + Vector2.UnitY * Projectile.gfxOffY;
//    Vector2 origin = texture.Size() * 0.5f;
//
//    Main.spriteBatch.EnterShaderRegion();
//
//    GameShaders.Misc["ModNamespace:TrailGhostlyPhantom"]
//        .SetShaderTexture(ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/Trails/FabstaffStreak"));
//
//    GameShaders.Misc["ModNamespace:TrailGhostlyPhantom"]
//        .UseColor(new Color(80, 255, 120)) // ����ɫ
//        .UseSecondaryColor(new Color(180, 120, 255)) // ����ɫ�Ļ����
//        .Apply();
//
//    PrimitiveRenderer.RenderTrail(Projectile.oldPos,
//        new(TrailWidth, TrailColor, (_) = > Projectile.Size * 0.5f, shader: GameShaders.Misc["ModNamespace:TrailGhostlyPhantom"]),
//        10);
//
//    Main.spriteBatch.ExitShaderRegion();
//
//    Main.EntitySpriteDraw(texture, drawPosition, null, Projectile.GetAlpha(Color.White), Projectile.rotation, origin, Projectile.scale, 0, 0);
//
//    return false;
//}
//public Color TrailColor(float completionRatio)
//{
//    float opacity = Utils.GetLerpValue(1f, 0.6f, completionRatio, true) * Projectile.Opacity;
//    return new Color(80, 255, 120) * opacity; // ����ɫ��β
//}
//public float TrailWidth(float completionRatio)
//{
//    return MathHelper.SmoothStep(10f, 22f, Utils.GetLerpValue(0f, 1f, completionRatio, true));
//}
