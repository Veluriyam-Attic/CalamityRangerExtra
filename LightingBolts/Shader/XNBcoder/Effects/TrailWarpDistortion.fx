// **TrailWarpDistortion.fx - �ռ�Ť����β**
sampler uImage0 : register(s0);  // ��β������
sampler uImage1 : register(s1);  // ͸���ȿ�������Fade Map��
sampler uBackground : register(s2); // ����������������Ч����

float3 uColor;  // ��Ҫ��ɫ���ռ�������
float uOpacity;  // ��β͸����
float uTime;  // ȫ��ʱ��
float uWarpIntensity; // Ť��ǿ��
float uDistortionSpeed; // �ٶ�Ӱ��Ť���̶�
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

// **������ɫ��**
float4 PixelShaderFunction(VertexShaderOutput input) : COLOR0{
    float2 coords = input.TextureCoordinates.xy;

// **���� UV ���꣬��ֹ����**
coords.y = (coords.y - 0.5) / input.TextureCoordinates.z + 0.5;

// **ʱ����ƿռ䶶��**
float timeWarp = sin(uTime * 2.0 + coords.x * 5.0) * 0.05;

// **����͸���ȣ����ƺڶ��¼��ӽ磩**
float4 fadeMapColor = tex2D(uImage1, coords - float2(uTime * 0.4, 0));
float opacity = fadeMapColor.r * pow(sin(coords.y * 3.141 + uTime * 2.0), 2.0) * uOpacity;

// **�ռ�Ť��Ч��**
float2 warpOffset = float2(sin(coords.y * 10.0 + uTime * uDistortionSpeed), cos(coords.x * 10.0 + uTime * uDistortionSpeed)) * uWarpIntensity;

// **���䱳��������β���������۵��ռ�**
float4 bgColor = tex2D(uBackground, coords + warpOffset);

// **��ɫ��ʱ��仯**
float3 spaceColor = lerp(uColor, bgColor.rgb, 0.6 + 0.4 * sin(uTime * 1.5 + coords.x * 5.0));

return float4(spaceColor, opacity);
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
//    GameShaders.Misc["ModNamespace:TrailWarpDistortion"]
//        .SetShaderTexture(ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/Trails/FabstaffStreak"))
//        .UseColor(new Color(80, 30, 200)) // ��ɫʱ��Ť��
//        .Apply();
//
//    PrimitiveRenderer.RenderTrail(Projectile.oldPos, new(TrailWidth, TrailColor, (_) = > Projectile.Size * 0.5f, shader: GameShaders.Misc["ModNamespace:TrailWarpDistortion"]), 10);
//    Main.spriteBatch.ExitShaderRegion();
//
//    Main.EntitySpriteDraw(texture, drawPosition, null, Projectile.GetAlpha(Color.White), Projectile.rotation, origin, Projectile.scale, 0, 0);
//    return false;
//}
//
//public Color TrailColor(float completionRatio) {
//    float opacity = Utils.GetLerpValue(1f, 0.5f, completionRatio, true) * Projectile.Opacity;
//    return new Color(80, 30, 200) * opacity; // ����ɫ�ռ�Ť��
//}
//
//public float TrailWidth(float completionRatio) {
//    return MathHelper.SmoothStep(10f, 22f, Utils.GetLerpValue(0f, 1f, completionRatio, true));
//}
