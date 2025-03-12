sampler2D uTexture;      // ԭʼ����
float uTime;             // ȫ��ʱ��
float uBurnSpeed;        // ���������ٶ�
float uIntensity;        // ����ǿ�ȣ��Ƽ�0.2~1.5��

// ���������������ps_2_0
float rand(float2 uv) {
    return frac(sin(dot(uv, float2(12.98, 78.23))) * 43758.54);
}

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0
{
    float4 baseColor = tex2D(uTexture, coords);

    if (baseColor.a < 0.05) return baseColor;

    // ��̬����ȼ��Ч��
    float flameLine = coords.y * 2.0 - frac(uTime * uBurnSpeed);

    // ��������ԵЧ��
    float noise = frac(sin(dot(coords.xy * 20.0, float2(12.98, 78.23))) * 43758.54);

    // ���ƻ��淶Χ��ǿ��
    float flame = saturate(flameLine + noise * 0.5);
    flame = flame * (1.0 - coords.y);  // ���涥������

    // ǿ����������
    flame = saturate(pow(flame, 2.0));

    // �����ĳ�ɫ������ɫ���Ƽ��Ⱥ�ɫ��
    float4 flameColor = float4(1.0, 0.4, 0.0, baseColor.a) * flame * uIntensity;

    // ���ԭʼ��ɫ�����Ч��
    return lerp(baseColor, baseColor + flameColor, flame);
}

technique FireBurnEffect
{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}


//public override bool PreDraw(ref Color lightColor)
//{
//    Effect shader = ShaderGames.FireBurnShader;
//    if (shader == null) return true;
//
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uBurnSpeed"].SetValue(1.6f);      // �ɵ����ٶ�
//    shader.Parameters["uIntensity"].SetValue(5.5f);      // ����ǿ�ȵ���
//
//    shader.CurrentTechnique.Passes[0].Apply();
//
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.LinearClamp,
//        DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, null, Color.White, Projectile.rotation, texture.Size() * 0.5f, Projectile.scale, SpriteEffects.None, 0f);
//
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp,
//        DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false;
//}