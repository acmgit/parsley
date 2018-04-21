--[[
	**********************************************
	***                        Parsley                         ***
	**********************************************
	
]]--

local farming_default = true

-- looking if farming_redo is activ?
if(farming.mod ~= nil and farming.mod == "redo") then

	farming_default = false

end

if (farming_default) then

	print("[MOD] " .. minetest.get_current_modname() .. " set to default mode.")
	
	-- Parsley
	farming.register_plant("parsley:parsley", {
		description = "Parsley",
		inventory_image = "parsley_seed.png",
		steps = 5,
		minlight = 11,
		maxlight = default.LIGHT_MAX,
		fertility = {"grassland"},
		groups = {flammable = 4},
	})
	
	-- Register for Mapgen
	minetest.register_node("parsley:wild_parsley", {
		description = "Wild Parsley",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"parsley:seed_parsley 3"}},
						{items = {"parsley:parsley"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"parsley_parsley_5.png"},
		groups = {snappy = 3, dig_immediate=1, flammable=2, plant=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})

else

	print("[MOD] " .. minetest.get_current_modname() .. " set to redo mode.")
	
	-- Parsley
	minetest.register_node("parsley:seed", {
		description = "Parsley Seed",
		tiles = {"parsley_seed.png"},
		inventory_image = "parsley_seed.png",
		wield_image = "parsley_seed.png",
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1, dig_immediate=1, flammable = 4},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = farming.select,
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, "parsley:parsley_1")
		end,
	})

	minetest.register_craftitem("parsley:parsley", {
		description = "Parsley",
		inventory_image = "parsley_parsley.png",
		groups = {flammable = 4},
		})
	
	-- Parsley definition
	local crop_def = {
		drawtype = "plantlike",
		tiles = {"parsley_parsley_1.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop =  "",
		selection_box = farming.select,
		groups = {
			flammable = 4, snappy=3, dig_immediate=1, plant = 1, attached_node = 1,
			not_in_creative_inventory = 1, growing = 1
		},
		sounds = default.node_sound_leaves_defaults()
	}

	-- stage 1
	minetest.register_node("parsley:parsley_1", table.copy(crop_def))

	-- stage 2
	crop_def.tiles = {"parsley_parsley_2.png"}
	minetest.register_node("parsley:parsley_2", table.copy(crop_def))

	-- stage 3
	crop_def.tiles = {"parsley_parsley_3.png"}
	minetest.register_node("parsley:parsley_3", table.copy(crop_def))

	-- stage 4
	crop_def.tiles = {"parsley_parsley_4.png"}
	crop_def.drop = {
		items = {
			{items = {"parsley:parsley"}, rarity = 1},
			{items = {"parsley:seed"}, rarity = 2},
		}
	}
	minetest.register_node("parsley:parsley_4", table.copy(crop_def))

	-- stage 5
	crop_def.tiles = {"parsley_parsley_5.png"}
	crop_def.drop = {
		items = {
			{items = {"parsley:parsley"}, rarity = 1},
			{items = {"parsley:parsley"}, rarity = 1},
			{items = {"parsley:parsley"}, rarity = 3},
			{items = {"parsley:seed"}, rarity = 1},
			{items = {"parsley:seed"}, rarity = 1},
			{items = {"parsley:seed"}, rarity = 3},

		}
	}
	minetest.register_node("parsley:parsley_5", table.copy(crop_def))

	-- Register for Mapgen
	minetest.register_node("parsley:wild_parsley", {
		description = "Wild Parsley",
		paramtype = "light",
		walkable = false,
		drop = { 
				items = { 
						{items = {"parsley:seed 3"}},
						{items = {"parsley:parsley"}},
					}
				},
		drawtype = "plantlike",
		paramtype2 = "facedir",
		tiles = {"parsley_parsley_5.png"},
		groups = {snappy=3, dig_immediate=1, flammable=2, plant=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
				},
		},
	})
	
end -- if( default ....)


minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.02,
		spread = {x = 70, y = 70, z = 70},
		seed = 7133,
		octaves = 4,
		persist = 0.6
	},
	y_min = 0,
	y_max = 100,
	decoration = "parsley:wild_parsley",
})

minetest.register_craft({
	type = "fuel",
	recipe = "parsley:parsley",
	burntime = 1,
})

minetest.register_craftitem("parsley:parsley", {
	description = "Parsley",
	inventory_image = "parsley_parsley.png",
	groups = {flammable = 1, food = 1, eatable = 1},
	on_use = minetest.item_eat(1),
})

print("[MOD] " .. minetest.get_current_modname() .. " loaded.")