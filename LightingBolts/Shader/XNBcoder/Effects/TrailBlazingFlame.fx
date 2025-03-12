// **TrailBlazingFlame.fx - ���Ȼ�����β**
sampler uImage0 : register(s0);  // ��β������
sampler uImage1 : register(s1);  // ͸���ȿ�������Fade Map��

float3 uColor;  // ��������ɫ����ɫ��
float3 uSecondaryColor; // ����ȼ����ɫ����ڣ�
float uOpacity;  // ��β͸����
float uTime;  // ȫ��ʱ��
float uFlameIntensity; // ����ڶ�ǿ��
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

// **����ڶ�Ч��**
float flameMotion = sin(coords.y * 10.0 + uTime * 5.0) * uFlameIntensity;

// **͸���ȿ���**
float4 fadeMapColor = tex2D(uImage1, coords - float2(uTime * 0.6, 0));
float opacity = fadeMapColor.r * pow(sin(coords.y * 3.141 + uTime * 1.5), 1.8) * uOpacity;

// **������ɫ�仯����ɫ �� ��ɫ �� ��ɫ��**
float3 fireColor = lerp(uColor, uSecondaryColor, InverseLerp(0.2, 0.8, coords.x));

// **������ɫ����**
return float4(fireColor * (1.0 + flameMotion * 0.2), opacity);
}

// **Shader Pass**
technique TrailTechnique{
    pass TrailPass {
        VertexShader = compile vs_3_0 VertexShaderFunction();
        PixelShader = compile ps_3_0 PixelShaderFunction();
    }
}



//public override bool PreDraw(ref Color lightColor) {
//    Texture2D texture = Terraria.GameContent.TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition + Vector2.UnitY * Projectile.gfxOffY;
//    Vector2 origin = texture.Size() * 0.5f;
//
//    Main.spriteBatch.EnterShaderRegion();
//    GameShaders.Misc["ModNamespace:TrailBlazingFlame"]
//        .SetShaderTexture(ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/Trails/FabstaffStreak"))
//        .UseColor(new Color(255, 140, 0)) // ��ɫ����
//        .UseSecondaryColor(new Color(150, 30, 30)) // ̿�����
//        .Apply();
//
//    PrimitiveRenderer.RenderTrail(Projectile.oldPos, new(TrailWidth, TrailColor, (_) = > Projectile.Size * 0.5f, shader: GameShaders.Misc["ModNamespace:TrailBlazingFlame"]), 10);
//    Main.spriteBatch.ExitShaderRegion();
//
//    Main.EntitySpriteDraw(texture, drawPosition, null, Projectile.GetAlpha(Color.White), Projectile.rotation, origin, Projectile.scale, 0, 0);
//    return false;
//}
//
//public Color TrailColor(float completionRatio) {
//    float opacity = Utils.GetLerpValue(1f, 0.5f, completionRatio, true) * Projectile.Opacity;
//    return new Color(255, 140, 0) * opacity; // ��ɫ����
//}
//
//public float TrailWidth(float completionRatio) {
//    return MathHelper.SmoothStep(12f, 25f, Utils.GetLerpValue(0f, 1f, completionRatio, true));
//}








