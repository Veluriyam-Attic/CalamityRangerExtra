using Terraria.Graphics.Effects;
using Terraria.Graphics.Shaders;
using Microsoft.Xna.Framework.Graphics;
using Terraria.ModLoader;
using Terraria;
using ReLogic.Content;

namespace CalamityRangerExtra.LightingBolts.Shader
{
    internal class ShaderGames : Mod
    {
        //public static Effect FirstShader;

        //public override void Load()
        //{
        //    // 加载 Shader
        //    FirstShader = ModContent.Request<Effect>("CalamityRangerExtra/LightingBolts/Shader/FirstShader").Value;

        //    // 用 MiscShaderData 进行封装，并注册到 GameShaders.Misc
        //    GameShaders.Misc["CalamityRangerExtra:FirstShader"] = new MiscShaderData(new Ref<Effect>(FirstShader), "ElectricBolt");
        //}


        public static Asset<Effect> FirstShader;

        public override void Load()
        {
            // 1. 使用 Asset<Effect> 加载 Shader
            FirstShader = ModContent.Request<Effect>("CalamityRangerExtra/LightingBolts/Shader/FirstShader");

            // 2. 直接用 Asset<Effect> 版本的 MiscShaderData（1.4.5+ 的正确写法）
            GameShaders.Misc["CalamityRangerExtra:FirstShader"] = new MiscShaderData(FirstShader, "ElectricBolt");
        }
    }
}
