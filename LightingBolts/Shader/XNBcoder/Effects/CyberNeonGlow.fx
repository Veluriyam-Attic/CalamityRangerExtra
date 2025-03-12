
// ʧ��Ʒʧ��ԭ�����޺���ߣ����Ǵ��������ߣ���������ɫ������������
//sampler2D uTexture;       // ������ͼ
//float2 uResolution;       // ��Ļ�ֱ���
//float uTime;              // ȫ��ʱ��
//float3 uNeonColor;        // �޺���ɫ
//float uGlowIntensity;     // ����ǿ��
//float uPulseSpeed;        // �޺������ٶ�
//float uGlowRange;         // ������ɢ��Χ
//
//// **�������صı�Եǿ��**
//float GetEdgeFactor(float2 coords) {
//    float4 centerColor = tex2D(uTexture, coords);
//    float edgeFactor = 0.0;
//
//    float2 offsets[4] = {
//        float2(-1, 0), float2(1, 0),
//        float2(0, -1), float2(0, 1)
//    };
//
//    for (int i = 0; i < 4; i++) {
//        float4 neighborColor = tex2D(uTexture, coords + offsets[i] / uResolution);
//        edgeFactor += distance(centerColor.rgb, neighborColor.rgb);
//    }
//
//    return saturate(edgeFactor * 4.0);
//}
//
//// **������ɫ��**
//float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
//    float4 color = tex2D(uTexture, coords);
//    float edge = GetEdgeFactor(coords);
//
//    // **�޺�����Ч��**
//    float glow = sin(uTime * uPulseSpeed) * 0.5 + 0.5;
//
//    // **������ɢ**
//    float glowMask = smoothstep(0.0, uGlowRange, edge);
//    float3 finalGlow = glowMask * glow * uGlowIntensity * uNeonColor;
//
//    // **����޺����**
//    float3 finalColor = color.rgb + finalGlow;
//
//    return float4(finalColor, color.a);
//}
//
//// **���� Technique**
//technique CyberNeonGlowEffect{
//    pass P0 {
//        PixelShader = compile ps_2_0 PixelShaderFunction();
//    }
//}




//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.CyberNeonGlow;
//    if (shader == null) return true;
//
//    // **���� Shader ����**
//    shader.Parameters["uResolution"].SetValue(new Vector2(Main.screenWidth, Main.screenHeight));
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uNeonColor"].SetValue(new Vector3(0.1f, 0.8f, 1.0f)); // �޺���ɫ
//    shader.Parameters["uGlowIntensity"].SetValue(3.0f); // �޺�ǿ�ȣ��ɵ���
//    shader.Parameters["uPulseSpeed"].SetValue(6.0f); // �޺������ٶȣ��ɵ���
//    shader.Parameters["uGlowRange"].SetValue(1.2f); // ������ɢ��Χ���ɵ���
//
//    // **Ӧ�� Shader**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    // **���Ƶ�Ļ**
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    Rectangle sourceRect = new Rectangle(0, Projectile.frame * texture.Height / Main.projFrames[Projectile.type], texture.Width, texture.Height / Main.projFrames[Projectile.type]);
//
//    // **�������λ��**
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, sourceRect.Height / 2), Projectile.scale, SpriteEffects.None, 0f);
//
//    // **�ָ�Ĭ�ϻ���**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false;
//}








// ���Ǵ���һЩ��ص����⣬ֻ�ܼ��һ������ģ�����һ�������������ⲻ��

//sampler2D uTexture;       // ������ͼ
//float2 uResolution;       // ��Ļ�ֱ���
//float uTime;              // ȫ��ʱ��
//float3 uNeonColor;        // �޺���ɫ
//float uGlowIntensity;     // ����ǿ��
//float uPulseSpeed;        // �޺������ٶ�
//float uGlowRange;         // ������ɢ��Χ
//
//// **�Ľ���Ե���**
//float GetEdgeFactor(float2 coords) {
//    float alphaCenter = tex2D(uTexture, coords).a;
//    float edgeFactor = 0.0;
//
//    // **�Ľ���Ե��⣺���ˮƽ����ֱ���Խ��߱仯**
//    float2 offsets[8] = {
//        float2(-1, 0), float2(1, 0),   // ˮƽ�����ң�
//        float2(0, -1), float2(0, 1),   // ��ֱ�����£�
//        float2(-1, -1), float2(1, 1),  // �Խ��� ���ϡ�����
//        float2(-1, 1), float2(1, -1)   // �Խ��� ���ϡ�����
//    };
//
//    for (int i = 0; i < 8; i++) {
//        float alphaNeighbor = tex2D(uTexture, coords + offsets[i] / uResolution).a;
//        edgeFactor += abs(alphaCenter - alphaNeighbor); // ����͸���Ȳ���
//    }
//
//    return saturate(edgeFactor * 4.0);
//}
//
//// **������ɫ��**
//float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
//    float4 color = tex2D(uTexture, coords);
//    float edge = GetEdgeFactor(coords);
//
//    // **�޺�����Ч��**
//    float glow = sin(uTime * uPulseSpeed) * 0.5 + 0.5;
//
//    // **������ɢ**
//    float glowMask = smoothstep(0.0, uGlowRange, edge);
//    float3 finalGlow = glowMask * glow * uGlowIntensity * uNeonColor;
//
//    // **����޺����**
//    float3 finalColor = color.rgb + finalGlow;
//
//    return float4(finalColor, color.a);
//}
//
//// **���� Technique**
//technique CyberNeonGlowEffect{
//    pass P0 {
//        PixelShader = compile ps_2_0 PixelShaderFunction();
//    }
//}



//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.CyberNeonGlow;
//    if (shader == null) return true;
//
//    // **���� Shader ����**
//    shader.Parameters["uResolution"].SetValue(new Vector2(Main.screenWidth, Main.screenHeight));
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uNeonColor"].SetValue(new Vector3(1.0f, 0.2f, 0.7f)); // �����޺����ɫ
//    shader.Parameters["uGlowIntensity"].SetValue(4.0f); // �޺�ǿ�ȣ��ɵ���
//    shader.Parameters["uPulseSpeed"].SetValue(6.0f); // �޺������ٶȣ��ɵ���
//    shader.Parameters["uGlowRange"].SetValue(1.5f); // ������ɢ��Χ���ɵ���
//
//    // **Ӧ�� Shader**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    // **���Ƶ�Ļ**
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    Rectangle sourceRect = new Rectangle(0, Projectile.frame * texture.Height / Main.projFrames[Projectile.type], texture.Width, texture.Height / Main.projFrames[Projectile.type]);
//
//    // **�������λ��**
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, sourceRect.Height / 2), Projectile.scale, SpriteEffects.None, 0f);
//
//    // **�ָ�Ĭ�ϻ���**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false;
//}


// ������������˵�3��
sampler2D uTexture;       // ������ͼ
float2 uResolution;       // ��Ļ�ֱ���
float uTime;              // ȫ��ʱ��
float3 uNeonColor;        // �޺���ɫ
float uGlowIntensity;     // ����ǿ��
float uPulseSpeed;        // �޺������ٶ�
float uGlowRange;         // ������ɢ��Χ

// **�Ľ���Ե��⣺�����͸�������Ƿ�Ӵ���͸������**
float GetEdgeFactor(float2 coords) {
    float alphaCenter = tex2D(uTexture, coords).a;
    if (alphaCenter > 0.0) return 0.0; // ����͸�����أ�����

    // **����ĸ�����**
    float2 offsets[4] = {
        float2(-1, 0), float2(1, 0),   // ����
        float2(0, -1), float2(0, 1)    // ����
    };

    for (int i = 0; i < 4; i++) {
        float alphaNeighbor = tex2D(uTexture, coords + offsets[i] / uResolution).a;
        if (alphaNeighbor > 0.0) return 1.0; // ����������ز�͸����˵���Ǳ߽�
    }

    return 0.0; // ���Ǳ߽磬���� 0
}

// **������ɫ��**
float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0{
    float4 color = tex2D(uTexture, coords);
    float edge = GetEdgeFactor(coords);

    // **�޺�����Ч��**
    float glow = sin(uTime * uPulseSpeed) * 0.5 + 0.5;

    // **������ɢ**
    float glowMask = smoothstep(0.0, uGlowRange, edge);
    float3 finalGlow = glowMask * glow * uGlowIntensity * uNeonColor;

    // **����޺����**
    float3 finalColor = color.rgb + finalGlow;

    return float4(finalColor, color.a);
}

// **���� Technique**
technique CyberNeonGlowEffect{
    pass P0 {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}





//public override bool PreDraw(ref Color lightColor)
//{
//    // **ȷ�� Shader ����**
//    Effect shader = ShaderGames.CyberNeonGlow;
//    if (shader == null) return true;
//
//    // **���� Shader ����**
//    shader.Parameters["uResolution"].SetValue(new Vector2(Main.screenWidth, Main.screenHeight));
//    shader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
//    shader.Parameters["uNeonColor"].SetValue(new Vector3(1.0f, 0.2f, 0.7f)); // �����޺����ɫ
//    shader.Parameters["uGlowIntensity"].SetValue(4.0f); // �޺�ǿ�ȣ��ɵ���
//    shader.Parameters["uPulseSpeed"].SetValue(6.0f); // �޺������ٶȣ��ɵ���
//    shader.Parameters["uGlowRange"].SetValue(3.5f); // ������ɢ��Χ���ɵ���
//
//    // **Ӧ�� Shader**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, shader, Main.GameViewMatrix.TransformationMatrix);
//
//    // **���Ƶ�Ļ**
//    Texture2D texture = TextureAssets.Projectile[Projectile.type].Value;
//    Rectangle sourceRect = new Rectangle(0, Projectile.frame * texture.Height / Main.projFrames[Projectile.type], texture.Width, texture.Height / Main.projFrames[Projectile.type]);
//
//    // **�������λ��**
//    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
//    Main.spriteBatch.Draw(texture, drawPosition, sourceRect, Color.White, Projectile.rotation, new Vector2(texture.Width / 2, sourceRect.Height / 2), Projectile.scale, SpriteEffects.None, 0f);
//
//    // **�ָ�Ĭ�ϻ���**
//    Main.spriteBatch.End();
//    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);
//
//    return false;
//}



