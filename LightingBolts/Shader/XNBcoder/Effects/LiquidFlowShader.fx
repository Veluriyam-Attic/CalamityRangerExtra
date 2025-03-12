sampler2D uTexture;             // ������ͼ
float uTime;                    // ʱ�����
float2 uFlowDirection;          // Ť���������� (�磺(1,0)��ʾ����(0,1)����)
float uFlowIntensity;           // Ť��ǿ��
float uFlowSpeed;               // Ť���ٶ�

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0
{
    // ������ɫ����
    float4 baseColor = tex2D(uTexture, coords);

// ����Ť��ƫ������ʹ�ÿɿط�����ǿ�ȣ�
float wave = sin(dot(coords, uFlowDirection) * 20 + uTime * uFlowSpeed);

// ����ǿ�ȿ���Ť��ƫ����
float2 offset = uFlowIntensity * uFlowDirection * wave * 0.01;

// Ӧ��ƫ�Ʋ���Ť�������ɫ
float4 distortedColor = tex2D(uTexture, coords + offset);

// ��Ť����ɫ�������ɫ���
return lerp(baseColor, distortedColor, 0.5);
}

// Shader Technique����
technique LiquidFlowEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}



//public override bool PreDraw(ref Color lightColor)
//{
//    Effect shader = ShaderGames.LiquidFlowShader;
//    if (shader == null) return true;
//
//    // ����Shader��̬����
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uFlowIntensity"].SetValue(5f);           // Ť��ǿ�ȣ���̬�ɵ���
//    shader.Parameters["uFlowSpeed"].SetValue(4.0f);            // �����ٶȣ��ɵ���
//    shader.Parameters["uFlowDirection"].SetValue(new Vector2(1f, 0.5f)); // X��Y���򣨿ɵ���
//
//    // Ӧ��Shader����
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.LinearClamp,
//        DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, null, Color.White, Projectile.rotation, texture.Size() * 0.5f, Projectile.scale, SpriteEffects.None, 0f);
//
//    // �ָ�Ĭ�ϻ���ģʽ
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp,
//        DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false;
//}