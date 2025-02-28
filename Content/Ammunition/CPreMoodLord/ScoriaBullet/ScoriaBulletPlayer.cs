using Microsoft.Xna.Framework;
using System;
using Terraria;
using Terraria.ModLoader;

namespace CalamityRangerExtra.Content.Ammunition.CPreMoodLord.ScoriaBullet
{
    public class ScoriaBulletPlayer : ModPlayer
    {
        private float accelerationBonus = 0f; // 移动加速度加成
        private int bonusDamagePercentage = 0; // 伤害提升百分比
        private int lastHitTime = 0; // 记录最后一次命中的时间
        private float accRunSpeedBonus = 0f; // 冲刺速度加成
        private float wingRunAccelerationBonus = 0f; // 翅膀加速倍率

        public override void ResetEffects()
        {
            // 移除上一帧加成
            Player.runAcceleration -= accelerationBonus;
            Player.GetDamage(DamageClass.Generic) -= bonusDamagePercentage / 100f;
            Player.accRunSpeed -= accRunSpeedBonus;
            Player.wingRunAccelerationMult -= wingRunAccelerationBonus;

            // 超过 10 秒未命中，重置所有加成
            if (lastHitTime > 0 && Main.GameUpdateCount - lastHitTime > 600)
            {
                accelerationBonus = 0f;
                bonusDamagePercentage = 0;
                accRunSpeedBonus = 0f;
                wingRunAccelerationBonus = 0f;
            }

            // 重新应用加成
            Player.runAcceleration += accelerationBonus;
            Player.GetDamage(DamageClass.Generic) += bonusDamagePercentage / 100f;
            Player.accRunSpeed += accRunSpeedBonus;
            Player.wingRunAccelerationMult += wingRunAccelerationBonus;


            //Player.runAcceleration += 5;
            //Player.accRunSpeed += 5;
            //Player.wingRunAccelerationMult += 5;
        }

        public void OnScoriaBulletHit()
        {
            // 限制加成上限
            if (accelerationBonus >= 0.30f)
                return;

            // 提升跑步加速度
            accelerationBonus = MathHelper.Clamp(accelerationBonus + 0.01f, 0f, 0.30f); // 最后一个值控制了他的上限
            bonusDamagePercentage = (int)(accelerationBonus * 100); // 1% 加速度 = 1% 伤害提升

            // 提升冲刺速度
            accRunSpeedBonus = MathHelper.Clamp(accRunSpeedBonus + 0.01f, 0f, 0.30f);

            // 提升翅膀加速倍率
            wingRunAccelerationBonus = MathHelper.Clamp(wingRunAccelerationBonus + 0.01f, 0f, 0.30f);

            // 记录最后命中时间
            lastHitTime = (int)Main.GameUpdateCount;

            // 直接小幅度增加玩家移动速度
            Player.velocity += new Vector2(0.15f, 0); // 轻微加速（仅限于水平移动）
        }
    }
}
