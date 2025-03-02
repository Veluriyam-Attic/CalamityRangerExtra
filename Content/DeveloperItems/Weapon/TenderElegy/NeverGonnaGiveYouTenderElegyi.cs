﻿using CalamityMod.Items.TreasureBags;
using Humanizer;
using Mono.Cecil.Cil;
using MonoMod.Cil;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Terraria;
using Terraria.GameContent.ItemDropRules;
using Terraria.ModLoader;

namespace CalamityRangerExtra.Content.DeveloperItems.Weapon.TenderElegy
{
    internal class NeverGonnaGiveYouTenderElegyi : GlobalItem
    {
        public override bool AppliesToEntity(Item entity, bool lateInstantiation)
        {
            // 只针对 DraedonBag 生效
            return entity.type == ModContent.ItemType<DraedonBag>();
        }

        public override void ModifyItemLoot(Item item, ItemLoot itemLoot)
        {
            base.ModifyItemLoot(item, itemLoot);

            // 确保修改的物品是 DraedonBag
            if (item.type == ModContent.ItemType<DraedonBag>())
            {
                // 让 DraedonBag 每次都掉落 TenderElegyi
                itemLoot.Add(ItemDropRule.Common(ModContent.ItemType<TenderElegyi>(), 1));
            }
        }
    }
}