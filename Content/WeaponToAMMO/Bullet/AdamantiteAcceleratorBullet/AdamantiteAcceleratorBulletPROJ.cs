using CalamityMod;
using CalamityRangerExtra.CREConfigs;
using Microsoft.Xna.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Terraria.Audio;
using Terraria.DataStructures;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria;
using CalamityMod.Particles;

namespace CalamityRangerExtra.Content.WeaponToAMMO.Bullet.AdamantiteAcceleratorBullet
{
    internal class AdamantiteAcceleratorBulletPROJ : ModProjectile, ILocalizedModType
    {
        public new string LocalizationCategory => "WeaponToAMMO.Bullet.AdamantiteAcceleratorBullet";
        public override string Texture => "CalamityMod/Projectiles/InvisibleProj";

        public override void SetStaticDefaults()
        {
            ProjectileID.Sets.TrailCacheLength[Projectile.type] = 8;
            ProjectileID.Sets.TrailingMode[Projectile.type] = 2;
        }

        public override bool PreDraw(ref Color lightColor)
        {
            CalamityUtils.DrawAfterimagesCentered(Projectile, ProjectileID.Sets.TrailingMode[Projectile.type], lightColor, 1);
            return false;
        }

        public override void SetDefaults()
        {
            Projectile.width = 14;
            Projectile.height = 14;
            Projectile.friendly = true;
            Projectile.hostile = false;
            Projectile.DamageType = DamageClass.Ranged;
            Projectile.penetrate = 2; // 根据模式设置穿透次数
            Projectile.timeLeft = 150;
            Projectile.light = 0.5f;
            Projectile.ignoreWater = true;
            Projectile.tileCollide = true;
            Projectile.extraUpdates = 3;
            Projectile.usesLocalNPCImmunity = true;
            Projectile.localNPCHitCooldown = 11;
        }
        public override void OnSpawn(IEntitySource source)
        {
            // 在弹幕生成时，将速度固定为 Xf
            Projectile.velocity = Projectile.velocity.SafeNormalize(Vector2.Zero) * 2.1f;
        }

        public override void AI()
        {
            // 保持弹幕旋转与速度方向一致
            Projectile.rotation = Projectile.velocity.ToRotation() + MathHelper.PiOver2;

            // 添加光源效果，使用橙色光照
            Lighting.AddLight(Projectile.Center, Color.Red.ToVector3() * 0.55f);

            // 每帧生成 0~1 个红色方形粒子特效，粒子滞留在原地
            for (int i = 0; i < Main.rand.Next(0,2); i++)
            {
                Vector2 randomOffset = Main.rand.NextVector2Circular(16f, 16f); // 随机生成偏移位置
                Vector2 particlePosition = Projectile.Center + randomOffset;
                Vector2 particleVelocity = Main.rand.NextVector2Circular(0.5f, 0.5f); // 粒子初速度

                SquareParticle squareParticle = new SquareParticle(
                    particlePosition,
                    particleVelocity,
                    false,
                    30, // 粒子存活时间
                    1.7f + Main.rand.NextFloat(0.6f), // 粒子大小
                    Color.Red * 1.5f // 粒子颜色
                );
                GeneralParticleHandler.SpawnParticle(squareParticle);
            }

            // 弹幕速度逐帧增加，范围在 1.X ~ 1.Y 倍
            Projectile.velocity *= Main.rand.NextFloat(1.005f, 1.025f);
        }

        public override void ModifyHitNPC(NPC target, ref NPC.HitModifiers modifiers)
        {
            // 根据弹幕当前速度计算伤害倍率
            float damageMultiplier = 1.0f + Projectile.velocity.Length() / 4f;
            modifiers.FinalDamage *= damageMultiplier;
        }

        public override void OnHitNPC(NPC target, NPC.HitInfo hit, int damageDone)
        {
            // 计算生成的红色光环特效数量
            int particleCount = 3 + (int)(Projectile.velocity.Length() / 1f);

            // 在敌人周围生成粒子特效
            for (int i = 0; i < particleCount; i++)
            {
                Color bloom = Color.Red;
                Vector2 randomDirection = Main.rand.NextVector2Circular(1f, 1f).SafeNormalize(Vector2.Zero) * Main.rand.NextFloat(8f, 17f);

                GeneralParticleHandler.SpawnParticle(new CritSpark(
                    target.Center,
                    randomDirection,
                    Color.IndianRed,
                    bloom,
                    0.7f + Main.rand.NextFloat(0f, 0.6f), // 粒子大小
                    30, // 粒子存活时间
                    0.4f, 0.6f // 初始和最终透明度
                ));
            }


            // 添加红色光环特效
            int auraCount = 3 + (int)(Projectile.velocity.Length() / 4f);
            for (int i = 0; i < auraCount; i++)
            {
                float polarity = Main.rand.NextFloat(-1f, 1f); // 随机方向
                Color pulseColor = Color.Red;
                AuraPulseRing auraPulse = new AuraPulseRing(
                    pulseColor,
                    new Vector2(Math.Max(target.width / 156f * 1.1f, 0.25f), 0.3f),
                    new Vector2(Math.Max(target.width / 156f * 1.5f, 0.4f), 0.01f),
                    40, // 持续时间
                    target
                );
                GeneralParticleHandler.SpawnParticle(auraPulse);
            }
        }

    }
}