using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.Graphics.Shaders;
using System;
using CalamityMod.Graphics.Primitives;
using CalamityMod.Particles;
using CalamityMod;
using CalamityRangerExtra.LightingBolts.Shader;
using Terraria.DataStructures;
using Terraria.GameContent;
using Microsoft.CodeAnalysis.Text;

namespace CalamityRangerExtra.Content.DeveloperItems.Weapon.Pyroblast
{
    internal class PyroblastRocketScorpio : ModProjectile
    {
        private int chosenForm;
        private bool trackingActivated = false; // 是否进入追踪模式

        public override void SetStaticDefaults()
        {
            //Main.projFrames[Projectile.type] = 4; // 4 帧动画
            ProjectileID.Sets.TrailCacheLength[Projectile.type] = 60;
            ProjectileID.Sets.TrailingMode[Projectile.type] = 1;
        }

        public override void SetDefaults()
        {
            Projectile.width = 11;
            Projectile.height = 24;
            Projectile.friendly = true;
            Projectile.DamageType = DamageClass.Ranged;
            Projectile.penetrate = 1;
            Projectile.timeLeft = 300;
            Projectile.usesLocalNPCImmunity = true;
            Projectile.localNPCHitCooldown = 14;
            Projectile.ignoreWater = true;
            Projectile.arrow = true;
            Projectile.extraUpdates = 1;
        }

        public override void OnSpawn(IEntitySource source)
        {
            // **随机选择形态（只执行一次）**
            chosenForm = Main.rand.Next(3);
        }

        public override void AI()
        {
            // **旋转调整**
            Projectile.rotation = Projectile.velocity.ToRotation() + MathHelper.PiOver2;

            // **加速飞行**
            if (Projectile.timeLeft > 270)
            {
                Projectile.velocity *= 1.02f; // 逐渐加速
                if (Projectile.velocity.Length() > 16f)
                    Projectile.velocity = Vector2.Normalize(Projectile.velocity) * 16f; // 速度限制
            }
            else
            {
                // **进入追踪模式**
                NPC target = Projectile.Center.ClosestNPCAt(5800);
                if (target != null)
                {
                    Vector2 direction = (target.Center - Projectile.Center).SafeNormalize(Vector2.Zero);
                    Projectile.velocity = Vector2.Lerp(Projectile.velocity, direction * 10f, 0.08f);
                }

                // **刚进入追踪模式时，释放橙色特效**
                if (!trackingActivated)
                {
                    trackingActivated = true;
                    for (int i = 0; i < 10; i++)
                    {
                        Particle nanoDust = new NanoParticle(Projectile.Center, -Projectile.velocity.RotatedBy(Main.rand.NextFloat(-0.2f, 0.2f)), Color.Orange, Main.rand.NextFloat(0.65f, 0.9f), Main.rand.Next(15, 20 + 1), Main.rand.NextBool(), true);
                        GeneralParticleHandler.SpawnParticle(nanoDust);
                    }
                }
            }

            // **动画帧控制**
            //Projectile.frameCounter++;
            //if (Projectile.frameCounter >= 4)
            //{
            //    Projectile.frame = (Projectile.frame + 1) % Main.projFrames[Projectile.type];
            //    Projectile.frameCounter = 0;
            //}
        }

        //public override bool PreDraw(ref Color lightColor)
        //{
        //    //// **选择拖尾 Shader**
        //    //MiscShaderData trailShader = chosenForm switch
        //    //{
        //    //    0 => GameShaders.Misc["ModNamespace:TailMagic"],
        //    //    1 => GameShaders.Misc["ModNamespace:TailModern"],
        //    //    _ => GameShaders.Misc["ModNamespace:TailTechnology"],
        //    //};

        //    //// **拖尾绘制**
        //    //trailShader.SetShaderTexture(ModContent.Request<Texture2D>("CalamityMod/ExtraTextures/GreyscaleGradients/EternityStreak"));
        //    //trailShader.UseImage2("Images/Extra_189");
        //    //trailShader.UseColor(Color.White);
        //    //trailShader.UseSecondaryColor(Color.Gray);
        //    //trailShader.Apply();

        //    //// **正确调用拖尾 Shader**
        //    //PrimitiveRenderer.RenderTrail(Projectile.oldPos, new(PrimitiveWidthFunction, PrimitiveColorFunction, (_) => Projectile.Size * 0.5f, shader: trailShader), 53);




        //    // **本体染色 Shader**
        //    //Effect bodyShader = chosenForm switch
        //    //{
        //    //    0 => ShaderGames.RainbowShader,
        //    //    1 => ShaderGames.DistortionShader,
        //    //    _ => ShaderGames.EdgeGlowShader,
        //    //};

        //    Effect bodyShader = ShaderGames.EnchantmentShader;


        //    if (bodyShader != null)
        //    {
        //        bodyShader.Parameters["uTime"].SetValue(Main.GlobalTimeWrappedHourly);
        //        bodyShader.Parameters["uOpacity"].SetValue(1f);

        //        Main.spriteBatch.End();
        //        Main.spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, bodyShader, Main.GameViewMatrix.TransformationMatrix);
        //    }

        //    // **绘制弹幕**
        //    Texture2D texture = Terraria.GameContent.TextureAssets.Projectile[Projectile.type].Value;
        //    Vector2 drawPosition = Projectile.Center - Main.screenPosition;
        //    Vector2 origin = texture.Size() * 0.5f;
        //    Main.spriteBatch.Draw(texture, drawPosition, new Rectangle(0, Projectile.frame * texture.Height / 4, texture.Width, texture.Height / 4), lightColor, Projectile.rotation, origin, Projectile.scale, SpriteEffects.None, 0f);
        //    Main.spriteBatch.End();
        //    Main.spriteBatch.Begin(SpriteSortMode.Deferred, BlendState.AlphaBlend, SamplerState.LinearClamp, DepthStencilState.Default, RasterizerState.CullNone, null, Main.GameViewMatrix.TransformationMatrix);

        //    return false;
        //}























        // **拖尾宽度**
        public float PrimitiveWidthFunction(float completionRatio) => Projectile.scale * 30f;

        // **拖尾颜色**
        public Color PrimitiveColorFunction(float _) => Color.Lime * Projectile.Opacity;
    }
}
