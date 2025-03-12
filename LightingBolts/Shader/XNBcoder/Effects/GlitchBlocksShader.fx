// ʧ��Ʒ��ʧ��ԭ���޷��ָ�ɫ�飬�������ɫ����Ծû����
//sampler2D uImage0;  // ��Ʒ�Ļ�������
//float uTime;        // ʱ�����
//float uBlockSize;   // С����ߴ磨Ĭ�� 6x6��
//float uOpacity;     // Ⱦɫ͸����
//
//// **HSV ת RGB**
//float3 HUEtoRGB(float H) {
//    float R = abs(H * 6 - 3) - 1;
//    float G = 2 - abs(H * 6 - 2);
//    float B = 2 - abs(H * 6 - 4);
//    return saturate(float3(R, G, B));
//}
//
//// **α�������**
//float random(float2 p) {
//    return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
//}
//
//// ��Ҫ������ɫ��
//float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
//    float4 baseColor = tex2D(uImage0, coords); // ��ȡ��Ʒ����ɫ
//
//// **����͸������**
//if (baseColor.a < 0.01) return baseColor;
//
//// **����С����Ĺ̶�����**
//float2 blockCoords = floor(coords / uBlockSize) * uBlockSize;
//
//// **������С�������ɫһ��**
//float2 blockID = blockCoords / uBlockSize; // ����С���������
//float hue = random(blockID + floor(uTime * 3)) * 1.0; // ����ɫ��Ծ�仯
//float3 glitchColor = HUEtoRGB(hue); // ���ɲʺ�ɫ
//
//// **����������ɫ**
//float4 glitchEffect = float4(glitchColor, 1.0);
//
//// **��ɫ���**
//return lerp(baseColor, glitchEffect, uOpacity) * baseColor.a;
//}
//
//// ���� Technique
//technique GlitchBlocksEffect{
//    pass P0 {
//        PixelShader = compile ps_2_0 PixelShaderFunction();
//    }
//}

        // ����ɫ��
//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.GlitchBlocksShader;
//    if (shader == null) return true;
//
//    // **���� Shader ����**
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uBlockSize"].SetValue(3f); // ÿ��С����Ĵ�С 6x6
//    shader.Parameters["uOpacity"].SetValue(0.7f); // ͸���ȣ�0.7 ��ʾ 70% Ⱦɫǿ��
//
//    // **Ӧ�� Shader**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.PointClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    // **��ȡ��Ļ��ͼ**
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    int frameHeight = texture.Height / Main.projFrames[Projectile.type]; // ���㵥֡�߶�
//    Rectangle sourceRect = new Rectangle(0, Projectile.frame * frameHeight, texture.Width, frameHeight); // ѡȡ��ǰ֡
//
//    // **���Ƶ�Ļ**
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, frameHeight / 2), Projectile.scale, SpriteEffects.None, 0f);
//
//    // **�ָ� SpriteBatch**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false; // `false` ��ʾ����Ĭ��   ���ƽ��У������Ѿ��ֶ�������
//}





// ʧ��Ʒ2�ţ�ʧ��ԭ�����������ϸУ����ǲ���ǿ�ң���ɫҲ��ò���ǿ��
//sampler2D uImage0;  // ��Ʒ�Ļ�������
//float uTime;        // ʱ�����
//float uBlockSize;   // С����ߴ�
//float uOpacity;     // Ⱦɫ͸����
//
//// **HSV ת RGB**
//float3 HUEtoRGB(float H) {
//    float R = abs(H * 6 - 3) - 1;
//    float G = 2 - abs(H * 6 - 2);
//    float B = 2 - abs(H * 6 - 4);
//    return saturate(float3(R, G, B));
//}
//
//// **�����������**
//float random(float2 p) {
//    return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
//}
//
//// **�Ż������������������ָ�**
//float glitchNoise(float2 coords) {
//    return frac(sin(coords.x * 0.1 + coords.y * 0.1 + uTime * 3.0) * 100.0);
//}
//
//// ��Ҫ������ɫ��
//float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
//    float4 baseColor = tex2D(uImage0, coords); // ��ȡ��Ʒ����ɫ
//
//// **����͸������**
//if (baseColor.a < 0.01) return baseColor;
//
//// **���㷽������**
//float2 blockCoords = floor(coords / uBlockSize) * uBlockSize;
//
//// **���ټ����������ⳬ�� `ps_2_0` ����**
//float hue = random(blockCoords + uTime) * 1.0;
//float3 glitchColor = HUEtoRGB(hue);
//
//// **���� smoothstep()���� noise ���**
//float edgeFactor = glitchNoise(coords);
//
//// **����������ɫ**
//float4 glitchEffect = float4(glitchColor, 1.0);
//
//// **��ɫ���**
//return lerp(baseColor, glitchEffect, uOpacity * edgeFactor) * baseColor.a;
//}
//
//// **���� `ps_2_0` ���㸺��**
//technique GlitchBlocksEffect{
//    pass P0 {
//        PixelShader = compile ps_2_0 PixelShaderFunction();
//    }
//}

//֮ǰ����һЩ���⣬���ѱ��޸�����Ҫ�������£�
//��ɫ��ָ���
//
//ps_2_0 ������� 64 ������ָ���ԭ���Ĵ���ʹ���� 104 ����
//ps_2_0 ���� 96 ��ָ����������ԭ���Ĵ������� 105 ����
//��Ҫ���겿�֣�
//����� sin() / cos() ���� �� ����������Ӱ�� glitchNoise()��
//smoothstep() �Ĵ���ʹ�� �� smoothstep() ��Ҫ���ָ��ִ�и������㡣
//���ӵ�������� �� ԭ random() ������ڸ��ӣ�ָ����ࡣ
//ps_2_0 ������
//
//tModLoader ֻ��ʹ�� ps_2_0������ ps_3_0 ���Ƹ��ϸ�
//ps_2_0 ��֧��ѭ���͸��ӵ���ѧ���㣬����ָ���������׳��ꡣ


        //public override bool PreDraw(ref Color lightColor)
        //{
        //    // **ȷ�� Shader ����**
        //    Effect shader = ShaderGames.GlitchBlocksShader;
        //    if (shader == null) return true;

        //    // **���� Shader ����**
        //    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
        //    shader.Parameters["uBlockSize"].SetValue(8f); // ����ɫ���С
        //    shader.Parameters["uOpacity"].SetValue(0.7f); // ����Ⱦɫǿ��

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





// ע�⣬�����3���汾���������Ե�ƫ��ɫ���󣬵����Ѿ�����ʹ����
sampler2D uImage0;  // ��Ʒ�Ļ�������
float uTime;        // ʱ�����
float uBlockSize;   // ���Ͽ�ߴ�
float uOpacity;     // ����Ч��͸����

// **�Ż�����������**
float random(float2 p) {
    return frac(sin(dot(p, float2(23.140692632779, 2.665144142690225))) * 43758.5453);
}

// **�Ż���Ĺ�������**
float chaosNoise(float2 coords) {
    return frac(sin(coords.x * 0.1 + coords.y * 0.1 + uTime * 3.0) * 100.0);
}

// **RGB ��ɫ��**
static const float3 colorPool[6] = {
    float3(1.0, 0.0, 0.0), // ��ɫ
    float3(0.0, 1.0, 0.0), // ��ɫ
    float3(0.0, 0.0, 1.0), // ��ɫ
    float3(1.0, 1.0, 0.0), // ��ɫ
    float3(1.0, 0.0, 1.0), // ��ɫ
    float3(0.0, 1.0, 1.0)  // ��ɫ
};

// **��Ҫ������ɫ��**
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float4 baseColor = tex2D(uImage0, coords); // ��ȡԭʼ��ɫ������ʹ�ã�

// **����͸������**
if (baseColor.a < 0.01) return baseColor;

// **���㲻����ɫ�������**
float2 blockCoords = floor(coords / uBlockSize) * uBlockSize;

// **ֱ�Ӵ���ɫ�������ѡȡ��ɫ**
int colorIndex = (int)(random(blockCoords) * 6) % 6;
float3 glitchColor = colorPool[colorIndex];

// **������������ѷ�**
float glitchEffect = chaosNoise(coords * 1.5) > 0.6 ? 1.0 : 0.3; // ���ѷ��������

// **�������չ�����ɫ**
float4 finalGlitch = float4(glitchColor * glitchEffect, 1.0);

// **��ȫ����ԭʼ��ɫ**
return lerp(baseColor, finalGlitch, uOpacity) * baseColor.a;
}

// **���� Shader**
technique GlitchChaosEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}



//chaosNoise() ���������� �� ���� sin() + cos() ����̫�࣬����ָ��ޡ�
//random() ������ڸ��� �� ��Ҫ�򻯣��� Shader ����Ӧ ps_2_0 ���ơ�



//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.GlitchBlocksShader;
//    if (shader == null) return true;
//
//    // **���� Shader ����**
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uBlockSize"].SetValue(8f); // ���ƹ��Ͽ��С
//    shader.Parameters["uOpacity"].SetValue(1.0f); // ���׸���ԭʼ��ɫ
//
//    // **Ӧ�� Shader**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.PointClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    // **��ȡ��Ļ��ͼ**
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    int frameHeight = texture.Height / Main.projFrames[Projectile.type]; // ���㵥֡�߶�
//    Rectangle sourceRect = new Rectangle(0, Projectile.frame * frameHeight, texture.Width, frameHeight); // ѡȡ��ǰ֡
//
//    // **���Ƶ�Ļ**
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, frameHeight / 2), Projectile.scale, SpriteEffects.None, 0f);
//
//    // **�ָ� SpriteBatch**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false; // `false` ��ʾ����Ĭ�ϻ��ƽ��У������Ѿ��ֶ�������
//}
