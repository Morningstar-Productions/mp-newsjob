Config = Config or {}

Config.Debug = true -- Used to Debug the resource

Config.UseBlips = true -- If true enables the blip location for Weazel News

--Config.Teleporter = true -- Used for elevator use if NOT using MLO | COMING SOON

Config.Items = {
	{ name = "newscamera", price = 100 },
	{ name = "newsboom", price = 100 },
	{ name = "newsmic", price = 100 },
	{ name = 'newslight', price = 100 }
}

Config.Locations = {
	duty = {
		vec3(-594.17, -928.67, 22.87),
	},
	vehicle = {
        vec4(-556.47, -925.2, 23.86, 267.24),
	},
    heli = {
		vec4(-583.08, -930.55, 36.83, 89.26),
	},
	shop = {
		vec3(-590.2, -916.1, 22.87),
	},
}

Config.Vehicles = {
	-- Grade 0
	[0] = {
		["newsvan"] = "Weazel News Van",
	},
	-- Grade 1
	[1] = {
		["newsvan"] = "Weazel News Van",
	},
	-- Grade 2
	[2] = {
		["newsvan"] = "Weazel News Van",
	},
	-- Grade 3
	[3] = {
		["newsvan"] = "Weazel News Van",
	},
	-- Grade 4
	[4] = {
		["newsvan"] = "Weazel News Van",
	}
}

Config.Helicopters = {
	-- Grade 0
	[0] = {
		["newsmav"] = "Weazel News Maverick",
	},
	-- Grade 1
	[1] = {
		["newsmav"] = "Weazel News Maverick",
	},
	-- Grade 2
	[2] = {
		["newsmav"] = "Weazel News Maverick",
	},
	-- Grade 3
	[3] = {
		["newsmav"] = "Weazel News Maverick",
	},
	-- Grade 4
	[4] = {
		["newsmav"] = "Weazel News Maverick",
	}
}

QBCore = exports['qb-core']:GetCoreObject()
