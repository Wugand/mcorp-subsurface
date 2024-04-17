local collision_mask_util = require("collision-mask-util")

if settings.startup["pollution-trains"].value then
	local exclude_prototypes = {}
	for p in string.gmatch(settings.startup["pollution-trains-excludes"].value, "[^%s,]+") do
		if p == "" then exclude_prototypes[p] = true end
	end
	for _,e in pairs(data.raw["locomotive"]) do
		if not exclude_prototypes[e.name] and e.burner then
			e.burner.emissions_per_minute = e.burner.emissions_per_minute or 10
		end
	end
end

if data.raw.technology["cliff-explosives"] then
	table.insert(data.raw.technology["cliff-explosives"].effects, {type = "unlock-recipe", recipe = "rock-explosives"})
end
