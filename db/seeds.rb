# Champions

# Champion.create!(
#   name: "Caitlyn", 
#   description: "Ranged attack damage carry",
#   base_hp: 510,
#   base_ad: 62,
#   base_ap: 0,
#   base_mr: 30,
#   base_armor: 28,
#   hp_scaling: 93,
#   ad_scaling: 3.8,
#   ap_scaling: 0,
#   mr_scaling: 0.5,
#   armor_scaling: 3.5,
# )

# Champion.create!(
#   name: "Garen", 
#   description: "Bruiser",
#   base_hp: 620,
#   base_ad: 66,
#   base_ap: 0,
#   base_mr: 32,
#   base_armor: 36,
#   hp_scaling: 84,
#   ad_scaling: 4.5,
#   ap_scaling: 0,
#   mr_scaling: 0.75,
#   armor_scaling: 3.0,
# )

# # Abilities

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
#   keywords: "SINGLE PROC",
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
#   keywords: "SINGLE PROC",
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
#   keywords: "SINGLE PROC",
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
#   keywords: "AA STEROID",
#   champion_id: 2
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