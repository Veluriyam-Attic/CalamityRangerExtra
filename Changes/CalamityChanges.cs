﻿#region Using Gay;
using CalamityMod;
using CalamityMod.Items.Accessories;
using System.Collections.Generic;
using Terraria;
using Terraria.ID;
using Terraria.Localization;
using Terraria.ModLoader;
using Microsoft.Xna.Framework;
using CalamityMod.Items.Weapons.Ranged;
using Terraria.UI;
using System.Linq;
using System.Threading.Tasks;
using System;
using CalamityMod.Items.Ammo;
using CalamityMod.Items.Weapons.DraedonsArsenal;
#endregion


namespace CalamityRangerExtra.Changes
{
    #region 暴政之终*捐赠物品提示
    public class IDTyrannysEnd : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<TyrannysEnd>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            int num = tooltips.FindIndex(num => num.Name.Equals("CalamityDonor"));
            var line = (new TooltipLine(Mod, "IDTyrannysEnd", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.TyrannysEnd")));
            tooltips.Insert(num, line);
        }
    }
    #endregion
    #region 派对弹
    public class IDPartyBullet : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ItemID.PartyBullet;

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDPartyBullet", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Vanilla.PartyBullet")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 迫击炮弹
    public class IDMortarRound : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<MortarRound>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDMortarRound", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.MortarRound")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 橡胶迫击炮弹
    public class IDRubberMortarRound : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<RubberMortarRound>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDRubberMortarRound", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.RubberMortarRound")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 异象纳米枪*捐赠物品提示
    public class IDTheAnomalysNanogun : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<TheAnomalysNanogun>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            int num = tooltips.FindIndex(num => num.Name.Equals("CalamityDonor"));
            var line = (new TooltipLine(Mod, "IDTheAnomalysNanogun", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.TheAnomalysNanogun")));
            tooltips.Insert(num, line);
        }
    }
    #endregion
    #region 神圣空尖弹
    public class IDHallowPointRound : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<HallowPointRound>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDHallowPointRound", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.HallowPointRoundLine1") + "\n" + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.HallowPointRoundLine2")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 海伯里斯弹
    public class IDHyperiusBullet : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<HyperiusBullet>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDHyperiusBullet", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.HyperiusBulletLine1") + "\n" + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.HyperiusBulletLine2")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 血炎箭
    public class IDBloodfireArrow : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<BloodfireArrow>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDBloodfireArrow", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.BloodfireArrow")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 血炎弹
    public class IDBloodfireBullet : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<BloodfireBullet>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            var line = (new TooltipLine(Mod, "IDBloodfireBullet", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.BloodfireBullet")));
            tooltips.Add(line);
        }
    }
    #endregion
    #region 绝路Prime*捐赠物品提示
    public class IDRubicoPrime : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<RubicoPrime>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            int num = tooltips.FindIndex(num => num.Name.Equals("CalamityDonor"));
            var line = (new TooltipLine(Mod, "IDRubicoPrime", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.RubicoPrime")));
            tooltips.Insert(num, line);
        }
    }
    #endregion
    #region 满弹霰弹枪*捐赠物品提示
    public class IDBulletFilledShotgun : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<BulletFilledShotgun>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            int num = tooltips.FindIndex(num => num.Name.Equals("CalamityDonor"));
            var line = (new TooltipLine(Mod, "IDBulletFilledShotgun", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.BulletFilledShotgun")));
            tooltips.Insert(num, line);
        }
    }
    #endregion
    #region 天堂之风击败终灾前搭配星流箭降低伤害，击败终灾取消这段提示
    public class IDHeavenlyGale : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation) => entity.type == ModContent.ItemType<HeavenlyGale>();

        public override void ModifyTooltips(Item item, List<TooltipLine> tooltips)
        {
            if (DownedBossSystem.downedExoMechs && DownedBossSystem.downedCalamitas)
            {

            }
            else
            {
                var line = (new TooltipLine(Mod, "IDHeavenlyGale", Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.PreText") + Language.GetTextValue("Mods.CalamityRangerExtra.TooltipChanges.Calamity.HeavenlyGale")));
                tooltips.Add(line);
            }
        }
    }
    #endregion
}
