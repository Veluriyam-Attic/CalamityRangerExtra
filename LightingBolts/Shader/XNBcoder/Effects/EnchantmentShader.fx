
// ʧ��Ʒ��ʧ��ԭ�����ǲʺ�ɫ�л�����Ȼ����Ч����࣬������ɫ��Χ����
//sampler2D uImage0;  // ��Ʒ�Ļ�������
//float uTime;        // ʱ�����
//float4 uGlowColor;  // ħ����Ч����ɫ
//float uGlowIntensity; // ����ǿ��
//float uOpacity;     // ��Ч͸����
//
//// HSV ת RGB������ɫ��������ħ����Ч
//float3 HUEtoRGB(float H) {
//    float R = abs(H * 6 - 3) - 1;
//    float G = 2 - abs(H * 6 - 2);
//    float B = 2 - abs(H * 6 - 4);
//    return saturate(float3(R, G, B));
//}
//
//// ��Ҫ������ɫ��
//float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
//    float4 baseColor = tex2D(uImage0, coords); // ��ȡ��Ʒ����ɫ
//
//// **����͸������**����һ���ǳ���Ҫ������������Ⱦ���������壬����������ĵ�Ļ��ͼ��
//if (baseColor.a < 0.01) return baseColor;
//
//// ����ħ����Ч����������
//float noise = sin(coords.x * 10 + uTime) * cos(coords.y * 10 + uTime);
//noise = (noise + 1) * 0.5; // ��һ���� 0 ~ 1
//
//// �ù�Ч��ɫ��ʱ������
//float hue = frac(uTime * 0.1 + coords.y); // ����ɫ�ʱ仯
//float3 glowRGB = HUEtoRGB(hue);
//
//// ��������ħ����Ч
//float4 glowEffect = float4(glowRGB, 1.0) * uGlowIntensity * noise;
//
//// ͨ�� lerp() �ù�Ч��Ȼ�ںϣ������� alpha ֵ
//return lerp(baseColor, glowEffect, uOpacity) * baseColor.a;
//}
//
//// ���� Technique
//technique EnchantmentEffect{
//    pass P0 {
//        PixelShader = compile ps_2_0 PixelShaderFunction();
//    }
//}


        // �ɸ�ħ
        //public override bool PreDraw(ref Color lightColor)
        //{
        //    // **ȷ�� Shader ����**
        //    Effect shader = ShaderGames.EnchantmentShader;
        //    if (shader == null) return true;

        //    // **���� Shader ����**
        //    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
        //    shader.Parameters["uGlowColor"].SetValue(Color.Purple.ToVector4()); // ħ����Ч��ɫ
        //    shader.Parameters["uGlowIntensity"].SetValue(0.8f); // ��Чǿ��
        //    shader.Parameters["uOpacity"].SetValue(0.6f); // ͸���ȿ���

        //    // **Ӧ�� Shader**
        //    Main.spriteBatch.End();
        //    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.PointClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);

        //    // **��ȡ��Ļ��ͼ**
        //    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
        //    int frameHeight = texture.Height / Main.projFrames[Projectile.type]; // ���㵥֡�߶�
        //    Rectangle sourceRect = new Rectangle(0, Projectile.frame * frameHeight, texture.Width, frameHeight); // ѡȡ��ǰ֡

        //    // **���Ƶ�Ļ**
        //    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
        //    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, frameHeight / 2), Projectile.scale, SpriteEffects.None, 0f);

        //    // **�ָ� SpriteBatch**
        //    Main.spriteBatch.End();
        //    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);

        //    return false; // `false` ��ʾ����Ĭ�ϻ��ƽ��У������Ѿ��ֶ�������
        //}



sampler2D uImage0;  // ��Ʒ�Ļ�������
float uTime;        // ʱ�����
float uGlowIntensity; // ����ǿ��
float uOpacity;     // ��Ч͸����

// **Minecraft ��ħ��ɫѡ��**
static const float4 enchantColors[4] = {
    float4(0.6, 0.8, 1.0, 1.0),  // ǳ��ɫ
    float4(0.7, 0.9, 1.0, 1.0),  // ��������ɫ
    float4(0.6, 0.6, 0.7, 1.0),  // ǳ����ɫ
    float4(0.5, 0.5, 0.6, 1.0)   // ������ɫ
};

// **α�������**
float random(float2 p) {
    return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

// ��Ҫ������ɫ��
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float4 baseColor = tex2D(uImage0, coords); // ��ȡ��Ʒ����ɫ

// **����͸������**
if (baseColor.a < 0.01) return baseColor;

// **��������+ʱ������α�������**
float noiseFactor = random(coords * 10 + uTime * 5);
int colorIndex = (int)(noiseFactor * 4) % 4; // ���� 0-3 ֮�������
float4 selectedColor = enchantColors[colorIndex]; // ѡ���Ӧ�ĸ�ħ��ɫ

// **��ɫ����Ч��**
float pulse = sin(uTime * 6) * 0.5 + 0.5; // ����ɫ���ȶ�̬�仯
selectedColor *= (0.8 + 0.2 * pulse); // ������Ч����

// **����������ɫ**
float4 glowEffect = selectedColor * uGlowIntensity;
return lerp(baseColor, glowEffect, uOpacity) * baseColor.a; // ֻӰ���͸������
}

// ���� Technique
technique EnchantmentEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}




//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.EnchantmentShader;
//    if (shader == null) return true;

//    // **���� Shader ����**
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uGlowIntensity"].SetValue(0.7f); // ���ù�Чǿ��
//    shader.Parameters["uOpacity"].SetValue(0.5f); // ͸���ȿ���

//    // **Ӧ�� Shader**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.PointClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);

//    // **��ȡ��Ļ��ͼ**
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    int frameHeight = texture.Height / Main.projFrames[Projectile.type]; // ���㵥֡�߶�
//    Rectangle sourceRect = new Rectangle(0, Projectile.frame * frameHeight, texture.Width, frameHeight); // ѡȡ��ǰ֡

//    // **���Ƶ�Ļ**
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, frameHeight / 2), Projectile.scale, SpriteEffects.None, 0f);

//    // **�ָ� SpriteBatch**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);

//    return false; // `false` ��ʾ����Ĭ�ϻ��ƽ��У������Ѿ��ֶ�������
//}