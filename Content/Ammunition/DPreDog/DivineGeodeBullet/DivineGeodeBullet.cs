﻿using CalamityMod.Items.Materials;
using CalamityRangerExtra.Content.Ammunition.BPrePlantera.CryonicBullet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria;
using CalamityMod.Projectiles.Pets;
using CalamityRangerExtra.Content.Ammunition.DPreDog.DivineGeodeBullet;
using CalamityMod.Items.Ammo;

namespace CalamityRangerExtra.Content.Ammunition.DPreDog.DivineGeodeBullet
{
    public class DivineGeodeBullet : ModItem, ILocalizedModType
    {
        public new string LocalizationCategory => "Ammunition.DPreDog";


        public override void SetDefaults()
        {
            Item.width = 8;
            Item.height = 18;
            Item.damage = 28;
            Item.DamageType = DamageClass.Ranged;
            Item.maxStack = 9999;
            Item.consumable = true;
            Item.knockBack = 3f;
            Item.value = Item.sellPrice(copper: 12);
            Item.rare = ItemRarityID.Pink;
            Item.shoot = ModContent.ProjectileType<DivineGeodeBulletPROJ>();
            Item.shootSpeed = 9f;
            Item.ammo = AmmoID.Bullet;
        }

        public override void AddRecipes()
        {
            Recipe recipe = CreateRecipe(250);
            recipe.AddRecipeGroup("CalamityRangerExtra:RecipeGroupBullet", 250);
            recipe.AddIngredient<DivineGeode>(1);
            recipe.AddTile(TileID.LunarCraftingStation);
            recipe.Register();
        }
    }
}
