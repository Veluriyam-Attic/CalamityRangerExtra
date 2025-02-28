#region using太多了，折叠了
using CalamityMod.Items.Ammo;
using CalamityMod.Items.Materials;
using CalamityRangerExtra.Content.Ammunition.APreHardMode.AerialiteBullet;
using CalamityRangerExtra.Content.Ammunition.APreHardMode.TinkleshardBullet;
using CalamityRangerExtra.Content.Ammunition.APreHardMode.WulfrimBullet;
using CalamityRangerExtra.Content.Ammunition.BPrePlantera.CryonicBullet;
using CalamityRangerExtra.Content.Ammunition.BPrePlantera.StarblightSootBullet;
using CalamityRangerExtra.Content.Ammunition.CPreMoodLord.AstralBullet;
using CalamityRangerExtra.Content.Ammunition.CPreMoodLord.PerennialBullet;
using CalamityRangerExtra.Content.Ammunition.CPreMoodLord.PlagueBullet;
using CalamityRangerExtra.Content.Ammunition.CPreMoodLord.ScoriaBullet;
using CalamityRangerExtra.Content.Ammunition.DPreDog.DivineGeodeBullet;
using CalamityRangerExtra.Content.Ammunition.DPreDog.EffulgentFeatherBullet;
using CalamityRangerExtra.Content.Ammunition.DPreDog.PolterplasmBullet;
using CalamityRangerExtra.Content.Ammunition.DPreDog.ToothBullet;
using CalamityRangerExtra.Content.Ammunition.DPreDog.UelibloomBullet;
using CalamityRangerExtra.Content.Ammunition.EAfterDog.AuricBulet;
using CalamityRangerExtra.Content.Ammunition.EAfterDog.EndothermicEnergyBullet;
using CalamityRangerExtra.Content.Ammunition.EAfterDog.MiracleMatterBullet;
using CalamityRangerExtra.Content.Arrows.APreHardMode.AerialiteArrow;
using CalamityRangerExtra.Content.Arrows.APreHardMode.PrismArrow;
using CalamityRangerExtra.Content.Arrows.APreHardMode.WulfrimArrow;
using CalamityRangerExtra.Content.Arrows.BPrePlantera.StarblightSootArrow;
using CalamityRangerExtra.Content.Arrows.CPreMoodLord.AstralArrow;
using CalamityRangerExtra.Content.Arrows.CPreMoodLord.LifeAlloyArrow;
using CalamityRangerExtra.Content.Arrows.CPreMoodLord.PerennialArrow;
using CalamityRangerExtra.Content.Arrows.CPreMoodLord.PlagueArrow;
using CalamityRangerExtra.Content.Arrows.CPreMoodLord.ScoriaArrow;
using CalamityRangerExtra.Content.Arrows.DPreDog.DivineGeodeArrow;
using CalamityRangerExtra.Content.Arrows.DPreDog.EffulgentFeatherArrow;
using CalamityRangerExtra.Content.Arrows.DPreDog.ToothArrow;
using CalamityRangerExtra.Content.Arrows.DPreDog.UelibloomArrow;
using CalamityRangerExtra.Content.Arrows.EAfterDog.AuricArrow;
using CalamityRangerExtra.Content.Arrows.EAfterDog.EndothermicEnergyArrow;
using CalamityRangerExtra.Content.Arrows.EAfterDog.MiracleMatterArrow;
using CalamityRangerExtra.Content.Gel.APreHardMode.AerialiteGel;
using CalamityRangerExtra.Content.Gel.APreHardMode.GeliticGel;
using CalamityRangerExtra.Content.Gel.APreHardMode.HurricaneGel;
using CalamityRangerExtra.Content.Gel.APreHardMode.WulfrimGel;
using CalamityRangerExtra.Content.Gel.BPrePlantera.CryonicGel;
using CalamityRangerExtra.Content.Gel.BPrePlantera.StarblightSootGel;
using CalamityRangerExtra.Content.Gel.CPreMoodLord.AstralGel;
using CalamityRangerExtra.Content.Gel.CPreMoodLord.LifeAlloyGel;
using CalamityRangerExtra.Content.Gel.CPreMoodLord.LivingShardGel;
using CalamityRangerExtra.Content.Gel.CPreMoodLord.PerennialGel;
using CalamityRangerExtra.Content.Gel.CPreMoodLord.PlagueGel;
using CalamityRangerExtra.Content.Gel.CPreMoodLord.ScoriaGel;
using CalamityRangerExtra.Content.Gel.DPreDog.BloodstoneCoreGel;
using CalamityRangerExtra.Content.Gel.DPreDog.DivineGeodeGel;
using CalamityRangerExtra.Content.Gel.DPreDog.EffulgentFeatherGel;
using CalamityRangerExtra.Content.Gel.DPreDog.PolterplasmGel;
using CalamityRangerExtra.Content.Gel.DPreDog.ToothGel;
using CalamityRangerExtra.Content.Gel.DPreDog.UelibloomGel;
using CalamityRangerExtra.Content.Gel.DPreDog.UnholyEssenceGel;
using CalamityRangerExtra.Content.Gel.EAfterDog.AuricGel;
using CalamityRangerExtra.Content.Gel.EAfterDog.CosmosGel;
using CalamityRangerExtra.Content.Gel.EAfterDog.EndothermicEnergyGel;
using CalamityRangerExtra.Content.Gel.EAfterDog.MiracleMatterGel;
using CalamityRangerExtra.Content.Gel.ZBag;
using Microsoft.Xna.Framework;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Terraria;
using Terraria.ID;
using Terraria.Localization;
using Terraria.ModLoader;
using Terraria.ModLoader.Default;
using Terraria.Testing;
using Terraria.UI;

#endregion

namespace CalamityRangerExtra
{
    public class AnyRecipes : ModSystem
    {
        public override void AddRecipeGroups()
        {
            #region 箭矢组
            RecipeGroup AnyArrow = new RecipeGroup(() => Language.GetTextValue("Mods.CalamityRangerExtra.RecipeGroup.Arrow"), new int[]
            {
                #region 本Mod箭矢
                ModContent.ItemType<LifeAlloyArrow>(),
                ModContent.ItemType<AerialiteArrow>(),
                ModContent.ItemType<PrismArrow>(),
                ModContent.ItemType<WulfrimArrow>(),
                ModContent.ItemType<StarblightSootArrow>(),
                ModContent.ItemType<AstralArrow>(),
                ModContent.ItemType<PerennialArrow>(),
                ModContent.ItemType<PlagueArrow>(),
                ModContent.ItemType<ScoriaArrow>(),
                ModContent.ItemType<DivineGeodeArrow>(),
                ModContent.ItemType<EffulgentFeatherArrow>(),
                ModContent.ItemType<ToothArrow>(),
                ModContent.ItemType<UelibloomArrow>(),
                ModContent.ItemType<AuricArrow>(),
                ModContent.ItemType<EndothermicEnergyArrow>(),
                ModContent.ItemType<MiracleMatterArrow>(),
                #endregion
                #region 原版箭矢
                ItemID.WoodenArrow,
                ItemID.FlamingArrow,
                ItemID.UnholyArrow,
                ItemID.JestersArrow,
                ItemID.HellfireArrow,
                ItemID.HolyArrow,
                ItemID.CursedArrow,
                ItemID.FrostburnArrow,
                ItemID.ChlorophyteArrow,
                ItemID.IchorArrow,
                ItemID.VenomArrow,
                ItemID.BoneArrow,
                ItemID.MoonlordArrow,
                ItemID.ShimmerArrow,
                #endregion
                #region Calamity箭矢
                ModContent.ItemType<CinderArrow>(),
                ModContent.ItemType<VeriumBolt>(),
                ModContent.ItemType<SproutingArrow>(),
                ModContent.ItemType<IcicleArrow>(),
                ModContent.ItemType<ElysianArrow>(),
                ModContent.ItemType<BloodfireArrow>(),
                ModContent.ItemType<VanquisherArrow>()
                #endregion
            });
            AnyArrow.IconicItemId = ItemID.WoodenArrow;
            RecipeGroup.RegisterGroup("CalamityRangerExtra:RecipeGroupArrow", AnyArrow);
            #endregion

            #region 子弹组
            RecipeGroup AnyBullet = new RecipeGroup(() => Language.GetTextValue("Mods.CalamityRangerExtra.RecipeGroup.Bullet"), new int[]
            {
                #region 本Mod子弹
                ModContent.ItemType<AerialiteBullet>(),
                ModContent.ItemType<TinkleshardBullet>(),
                ModContent.ItemType<WulfrimBullet>(),
                ModContent.ItemType<CryonicBullet>(),
                ModContent.ItemType<StarblightSootBullet>(),
                ModContent.ItemType<AstralBullet>(),
                ModContent.ItemType<PerennialBullet>(),
                ModContent.ItemType<PlagueBullet>(),
                ModContent.ItemType<ScoriaBullet>(),
                ModContent.ItemType<DivineGeodeBullet>(),
                ModContent.ItemType<EffulgentFeatherBullet>(),
                ModContent.ItemType<PolterplasmBullet>(),
                ModContent.ItemType<ToothBullet>(),
                ModContent.ItemType<UelibloomBullet>(),
                ModContent.ItemType<AuricBulet>(),
                ModContent.ItemType<EndothermicEnergyBullet>(),
                ModContent.ItemType<MiracleMatterBullet>(),
                #endregion
                #region 原版子弹
                ItemID.MusketBall,
                ItemID.MeteorShot,
                ItemID.SilverBullet,
                ItemID.CrystalBullet,
                ItemID.CursedBullet,
                ItemID.ChlorophyteBullet,
                ItemID.HighVelocityBullet,
                ItemID.IchorBullet,
                ItemID.VenomBullet,
                ItemID.PartyBullet,
                ItemID.NanoBullet,
                ItemID.ExplodingBullet,
                ItemID.GoldenBullet,
                ItemID.MoonlordBullet,
                ItemID.TungstenBullet,
                #endregion
                #region Calamity子弹
                ModContent.ItemType<FlashRound>(),
                ModContent.ItemType<MarksmanRound>(),
                ModContent.ItemType<HallowPointRound>(),
                ModContent.ItemType<DryadsTear>(),
                ModContent.ItemType<HailstormBullet>(),
                ModContent.ItemType<BubonicRound>(),
                ModContent.ItemType<MortarRound>(),
                ModContent.ItemType<RubberMortarRound>(),
                ModContent.ItemType<HyperiusBullet>(),
                ModContent.ItemType<HolyFireBullet>(),
                ModContent.ItemType<BloodfireBullet>(),
                ModContent.ItemType<GodSlayerSlug>()
                #endregion

            });
            AnyBullet.IconicItemId = ItemID.MusketBall;
            RecipeGroup.RegisterGroup("CalamityRangerExtra:RecipeGroupBullet", AnyBullet);
            #endregion

            #region 凝胶组
            RecipeGroup AnyGel = new RecipeGroup(() => Language.GetTextValue("Mods.CalamityRangerExtra.RecipeGroup.Gel"), new int[]
            {
                #region 本Mod凝胶
                ModContent.ItemType<AerialiteGel>(),
                ModContent.ItemType<GeliticGel>(),
                ModContent.ItemType<HurricaneGel>(),
                ModContent.ItemType<WulfrimGel>(),
                ModContent.ItemType<CryonicGel>(),
                ModContent.ItemType<StarblightSootGel>(),
                ModContent.ItemType<AstralGel>(),
                ModContent.ItemType<LifeAlloyGel>(),
                ModContent.ItemType<LivingShardGel>(),
                ModContent.ItemType<PerennialGel>(),
                ModContent.ItemType<PlagueGel>(),
                ModContent.ItemType<ScoriaGel>(),
                ModContent.ItemType<BloodstoneCoreGel>(),
                ModContent.ItemType<DivineGeodeGel>(),
                ModContent.ItemType<EffulgentFeatherGel>(),
                ModContent.ItemType<PolterplasmGel>(),
                ModContent.ItemType<ToothGel>(),
                ModContent.ItemType<UelibloomGel>(),
                ModContent.ItemType<UnholyEssenceGel>(),
                ModContent.ItemType<AuricGel>(),
                ModContent.ItemType<CosmosGel>(),
                ModContent.ItemType<EndothermicEnergyGel>(),
                ModContent.ItemType<MiracleMatterGel>(),
                #endregion
                #region 原版凝胶
                ItemID.Gel,
                ItemID.PinkGel,
                #endregion
                #region Calamity凝胶
                ModContent.ItemType<BlightedGel>(),
                ModContent.ItemType<PurifiedGel>()
                #endregion
            });
            AnyGel.IconicItemId = ItemID.Gel;
            RecipeGroup.RegisterGroup("CalamityRangerExtra:RecipeGroupGel", AnyGel);
            #endregion
        }

    }
}
