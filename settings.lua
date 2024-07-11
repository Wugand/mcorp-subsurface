data:extend({
  {
	type = "bool-setting",
	setting_type = "startup",
	name = "pollution-trains",
	default_value = true
  },
  {
	type = "string-setting",
	setting_type = "startup",
	name = "pollution-trains-excludes",
	default_value = "electric-locomotive,deg-electric-locomotive",
	allow_blank = true,
	auto_traim = true
  },
  {
	type = "int-setting",
	setting_type = "runtime-global",
	name = "subsurface-limit",
	default_value = 20,
	minimum_value = 1
  },
  {
	type = "double-setting",
	setting_type = "runtime-global",
	name = "resource-richness-factor",
	default_value = 1.25
  },
  {
	type = "double-setting",
	setting_type = "runtime-global",
	name = "resource-richness-offset",
	default_value = 0.8
  },
  {
	type = "double-setting",
	setting_type = "runtime-global",
	name = "resource-size-factor",
	default_value = 1.25
  },
  {
	type = "double-setting",
	setting_type = "runtime-global",
	name = "resource-size-offset",
	default_value = 0.75
  },
  {
	type = "double-setting",
	setting_type = "runtime-global",
	name = "resource-frequency-factor",
	default_value = 0.95
  },
  {
	type = "double-setting",
	setting_type = "runtime-global",
	name = "resource-frequency-offset",
	default_value = 2.5
  }
})
