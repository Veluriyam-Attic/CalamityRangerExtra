using CalamityMod.Items.Weapons.Ranged;
using CalamityMod.Items;
using CalamityMod.Rarities;
using Microsoft.Xna.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria;
using CalamityMod;
using CalamityMod.Items.Materials;
using CalamityMod.Items.Weapons.Magic;

namespace CalamityRangerExtra.Content.DeveloperItems.Weapon.TenderElegy
{
    internal class TenderElegyi : ModItem, ILocalizedModType
    {
        public new string LocalizationCategory => "DeveloperItems.TenderElegy";
        public override void SetStaticDefaults()
        {

        }
        public override void SetDefaults()
        {
            Item.width = 60;
            Item.height = 60;
            Item.damage = 500;
            Item.DamageType = DamageClass.Ranged;
            Item.useTime = Item.useAnimation = 3;
            Item.useStyle = ItemUseStyleID.Shoot;
            Item.knockBack = 2f;
            Item.UseSound = SoundID.Item5;
            Item.autoReuse = true;
            Item.shootSpeed = 19f;

            Item.value = CalamityGlobalItem.RarityHotPinkBuyPrice;
            Item.rare = ModContent.RarityType<HotPink>();
            Item.Calamity().devItem = true;
        }

        //public override void AddRecipes()
        //{
        //    Recipe recipe = CreateRecipe(1);
        //    recipe.AddIngredient<PlagueTaintedSMG>(1);
        //    recipe.AddIngredient<Lazhar>(1);
        //    recipe.AddIngredient<Scorpio>(1);
        //    recipe.AddIngredient(ItemID.IllegalGunParts, 2);
        //    recipe.AddIngredient(ItemID.LunarBar, 10);
        //    recipe.AddIngredient<DivineGeode>(10);
        //    recipe.AddTile(TileID.LunarCraftingStation);
        //    recipe.Register();
        //}
    }
}
