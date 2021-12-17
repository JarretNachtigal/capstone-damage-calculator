# ALL BASE STATS SHOULD BE OFFSET BY 1 LEVEL TO ALLOW FOR SCALING TO BE ACCURATE
# EX. CAIT BASE HP = 510 -> BASE_HP = 417, HP_SCALING = 93

# Champions ----------------------------------------

# Champion.create!(
#   name: "Caitlyn", 
#   description: "Ranged attack damage carry",
#   base_hp: 417,
#   base_ad: 58.2,
#   base_mr: 29.5,
#   base_armor: 24.5,
#   hp_scaling: 93,
#   ad_scaling: 3.8,
#   mr_scaling: 0.5,
#   armor_scaling: 3.5,
#   crit_damage_multiplier: 1.75
# )

# Champion.create!(
#   name: "Garen", 
#   description: "Bruiser",
#   base_hp: 536,
#   base_ad: 61.5,
#   base_mr: 31.25,
#   base_armor: 33,
#   hp_scaling: 84,
#   ad_scaling: 4.5,
#   mr_scaling: 0.75,
#   armor_scaling: 3.0,
#   crit_damage_multiplier: 1.75
# )

# Champion.create!(
#   name: "Akali", 
#   description: "ap assassin",
#   base_hp: 395,
#   base_ad: 59.7,
#   base_mr: 35.75,
#   base_armor: 19.5,
#   hp_scaling: 105,
#   ad_scaling: 3.3,
#   mr_scaling: 1.25,
#   armor_scaling: 3.5,
#   crit_damage_multiplier: 1.75
# )

# Champion.create!(
#   name: "Dummy", 
#   description: "for testing",
#   base_hp: 1000,
#   base_ad: 0,
#   base_mr: 50,
#   base_armor: 50,
#   hp_scaling: 0,
#   ad_scaling: 0,
#   mr_scaling: 0,
#   armor_scaling: 0,
#   crit_damage_multiplier: 1.75
# )



# # # Abilities ----------------------------------------

# Ability.create!(
#   name: "Piltover Peacemaker",
#   description: "Caitlyn Q",
#   damage_type: "physical",
#   base_ad: 10,
#   base_ap: 0,
#   base_ad_scaling: 40,
#   base_ap_scaling: 0,
#   ad_scaling: 130,
#   ap_scaling: 0,
#   ad_scaling_per_level: 15,
#   ap_scaling_per_level: 0,
#   keywords: "caitlyn_q",
#   champion_id: 1
# )

# Ability.create!(
#   name: "90 Caliber Net",
#   description: "Caitlyn E",
#   damage_type: "magic",
#   base_ad: 0,
#   base_ap: 30,
#   base_ad_scaling: 0,
#   base_ap_scaling: 40,
#   ad_scaling: 0,
#   ap_scaling: 80,
#   ad_scaling_per_level: 0,
#   ap_scaling_per_level: 0,
#   keywords: "caitlyn_e",
#   champion_id: 1
# )

# Ability.create!(
#   name: "Ace In The Hole",
#   description: "Caitlyn R",
#   damage_type: "physical",
#   base_ad: 75,
#   base_ap: 0,
#   base_ad_scaling: 225,
#   base_ap_scaling: 0,
#   ad_scaling: 200,
#   ap_scaling: 0,
#   ad_scaling_per_level: 0,
#   ap_scaling_per_level: 0,
#   keywords: "caitlyn_r",
#   champion_id: 1
# )

# Ability.create!(
#   name: "Decisive Strike",
#   description: "Garen Q",
#   damage_type: "physical",
#   base_ad: 0,
#   base_ap: 0,
#   base_ad_scaling: 30,
#   base_ap_scaling: 0,
#   ad_scaling: 50,
#   ap_scaling: 0,
#   ad_scaling_per_level: 0,
#   ap_scaling_per_level: 0,
#   keywords: "garen_q",
#   champion_id: 2
# )

# # this ability has a lot of weird behavior, handle individually for now
# Ability.create!(
#   name: "Judgment",
#   description: "Garen E",
#   damage_type: "physical",
#   base_ad: 0,
#   base_ap: 0,
#   base_ad_scaling: 4,
#   base_ap_scaling: 0,
#   ad_scaling: 30,
#   ap_scaling: 0,
#   ad_scaling_per_level: 2,
#   ap_scaling_per_level: 0,
#   keywords: "garen_e",
#   champion_id: 2
# )

# # this ability does true damage, handle individually for now
# Ability.create!(
#   name: "Demacian Justice",
#   description: "Garen R",
#   damage_type: "true",
#   base_ad: 0, # remember how level scaling works
#   base_ap: 0,
#   base_ad_scaling: 0,
#   base_ap_scaling: 0,
#   ad_scaling: 0,
#   ap_scaling: 0,
#   ad_scaling_per_level: 0,
#   ap_scaling_per_level: 0,
#   keywords: "garen_r",
#   champion_id: 2
# )

# # cait passive
# Ability.create!(
#   name: "Headshot",
#   description: "Caitlyn Passive",
#   damage_type: "physical",
#   base_ad: 0, # remember how level scaling works
#   base_ap: 0,
#   base_ad_scaling: 0,
#   base_ap_scaling: 0,
#   ad_scaling: 25,
#   ap_scaling: 0,
#   ad_scaling_per_level: 25,
#   ap_scaling_per_level: 0,
#   keywords: "caitlyn_passive",
#   champion_id: 1
# )

# # cait passive boost, write cait passive first
# Ability.create!(
#   name: "Yordle Snap Trap",
#   description: "Caitlyn W",
#   damage_type: "physical",
#   base_ad: 15, # remember how level scaling works
#   base_ap: 0,
#   base_ad_scaling: 45,
#   base_ap_scaling: 0,
#   ad_scaling: 25,
#   ap_scaling: 0,
#   ad_scaling_per_level: 15,
#   ap_scaling_per_level: 0,
#   keywords: "caitlyn_w", 
#   champion_id: 1
# )

# # Items ----------------

# Item.create!(
#   name: "Doran's Blade",
#   description: "ad starter item",
#   ad: 8,
#   ap: 0,
#   hp: 80
# )

# Item.create!(
#   name: "Doran's Ring",
#   description: "ap starter item",
#   ad: 0,
#   ap: 15,
#   hp: 70
# )


# # calculations

# # caitlyn piltover peacekeeper into garen
# # this wont give an output, keep for reference

# # Calculation.create!(
# #   champion_id_one: 1,
# #   champion_id_two: 2,
# #   ability_id: 1,
# #   champ_one_level: 6,
# #   champ_two_level: 6,
# #   ability_level: 3,
# #   output: ""
# # )