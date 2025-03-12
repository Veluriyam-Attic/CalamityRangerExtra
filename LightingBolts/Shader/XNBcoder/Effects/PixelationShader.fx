sampler2D uTexture;        // ԭʼ����
float2 uScreenPosition;    // ��Ļ����Ļ�ϵľ���λ��
float uPixelSize;          // ������ǿ�ȣ���Ļ��λ��

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0
{
    // ʹ�õ�Ļ����Ļ����������������˻���
    float2 screenCoords = coords + uScreenPosition;

// ������Ļ���껮��������
float2 pixelatedScreenCoords = floor(screenCoords / uPixelSize) * uPixelSize;

// ת���ص�Ļ����ռ�
float2 pixelatedUV = pixelatedScreenCoords - uScreenPosition;

// ����������ɫ
return tex2D(uTexture, pixelatedUV);
}

technique PixelationEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}


//public override bool PreDraw(ref Color lightColor)
//{
//    Effect shader = ShaderGames.PixelationShader;
//    if (shader == null) return true;
//
//    // ��Ļ��Ļ����ľ���λ��
//    Vector2 screenPos = Projectile.position - Main.screenPosition;
//
//    // ����shader����
//    shader.Parameters["uScreenPosition"].SetValue(screenPos);
//    shader.Parameters["uPixelSize"].SetValue(0.3f); // ��ֵԽ��������Ч��Խ����
//
//    shader.CurrentTechnique.Passes[0].Apply();
//
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.PointClamp,
//        DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//
//    Main.spriteBatch.Draw(texture, drawPosition, null, Color.White, Projectile.rotation,
//        texture.Size() * 0.5f, Projectile.scale, SpriteEffects.None, 0f);
//
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp,
//        DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false;
//}
