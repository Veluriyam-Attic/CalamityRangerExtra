sampler2D uImage0;  // ��Ʒ�Ļ�������
float2 uCenter;     // ��Ͳ���ĵ㣨��Ļ���ģ�
float uSegments;    // ��Ͳ��������Ĭ�� 6��
float uOpacity;     // ͸���ȣ�1.0 = ��ȫ����ԭ���棩

// **������ת�������**
float2 Rotate(float2 coord, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return float2(coord.x * c - coord.y * s, coord.x * s + coord.y * c);
}

// **��Ҫ������ɫ��**
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    // **���㵱ǰ���ص����ĵ��ƫ��**
    float2 offset = coords - uCenter;

// **����ָ�Ƕ�**
float segmentAngle = 6.283185 / uSegments; // 360�� / uSegments��6.283185 �� 2��

// **���㵱ǰ���صĽǶ�**
float angle = atan2(offset.y, offset.x);

// **���Ƕ����Ƶ���һ������**
angle = fmod(angle, segmentAngle);
if (angle < 0) angle += segmentAngle;

// **��ת�ػ�׼����**
float2 mirroredOffset = Rotate(offset, -angle);

// **��ȡ���ղ�������**
float2 finalCoord = uCenter + mirroredOffset;

// **������ɫ**
float4 color = tex2D(uImage0, finalCoord);

// **Ӧ��͸����**
return lerp(tex2D(uImage0, coords), color, uOpacity);
}

// **���� Technique**
technique KaleidoscopeEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}



//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.KaleidoscopeShader;
//    if (shader == null) return true;
//
//    // **��ȡ��Ļ���ĵ㣨��һ�����꣩**
//    Vector2 screenCenter = (Projectile.Center - Main.screenPosition) / new Vector2(Main.screenWidth, Main.screenHeight);
//
//    // **���� Shader ����**
//    shader.Parameters["uCenter"].SetValue(screenCenter);
//    shader.Parameters["uSegments"].SetValue(6f); // Ĭ�� 6 ������
//    shader.Parameters["uOpacity"].SetValue(1.0f); // 1.0 ��ȫ����ԭ����
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
//
//    return false; // `false` ��ʾ����Ĭ�ϻ��ƽ��У������Ѿ��ֶ�������
//}
