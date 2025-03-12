
// ����ʧ��Ʒ�����ȷʵ�м���������Ч����ֻ�Ƿ���̫��
sampler2D uTexture;         // ԭʼ����
float uTime;                // ʱ�����
float uFlowSpeed;           // �������٣���ȷ������
float uIntensity;           // ������ɫǿ��

// �򻯵�������� (����ps_2_0)
float rand(float2 co) {
    return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.54);
}

// �����HSVתRGB
float3 HSVtoRGB(float h) {
    float3 rgb = abs(h * 6 - float3(3, 2, 4)) - 1;
    return saturate(rgb);
}

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0
{
    float4 baseColor = tex2D(uTexture, coords);
    if (baseColor.a < 0.05) return baseColor;

    // ����Ч����������⸴���ԣ�
    float wave = sin(coords.y * 10.0 + uTime * uFlowSpeed) * 0.5 + 0.5;

    // ��������Ŷ�
    float noise = (rand(coords.xy * 20.0 + uTime) - 0.5) * 0.3;
    wave += noise;

    // ���ݲ���������ɫ���䣨��̬ɫ�ࣩ
    float hue = frac(coords.y * 0.5 + uTime * 0.1);
    float3 auroraRGB = HSVtoRGB(hue);

    // ����������ɫ
    float4 auroraColor = float4(auroraRGB, 1.0) * wave;

    // ��ԭʼ��ɫ�ں�
    float4 baseColorMix = lerp(tex2D(uTexture, coords), auroraColor, 0.7 * wave);

    return baseColorMix;
}

// Technique����
technique AuroraWaveEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}


//public override bool PreDraw(ref Color lightColor)
//{
//    Effect shader = ShaderGames.AuroraWaveShader;
//    if (shader == null) return true;
//
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uFlowSpeed"].SetValue(1.0f);  // ���Ʋ����ٶȣ��ɵ���
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
