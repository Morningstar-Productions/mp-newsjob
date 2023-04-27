Config = Config or {}

Config.Debug = true -- Used to Debug the resource

Config.UseBlips = true -- If true enables the blip location for Weazel News

Config.Teleporter = true -- Used for elevator use if NOT using MLO

Config.Fuel = 'cdn-fuel' -- Fueling script for use of vehicles

Config.Items = {
	{
        name = "newscam",
        price = 500,
    },
    {
        name = "newsbmic",
        price = 350,
    },
    {
        name = "newsmic",
        price = 250,
    },
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
		["rumpo"] = "Rumpo",
	},
	-- Grade 1
	[1] = {
		["rumpo"] = "Rumpo",
	},
	-- Grade 2
	[2] = {
		["rumpo"] = "Rumpo",
	},
	-- Grade 3
	[3] = {
		["rumpo"] = "Rumpo",
	},
	-- Grade 4
	[4] = {
		["rumpo"] = "Rumpo",
	}
}

Config.Helicopters = {
	-- Grade 0
	[0] = {
		["frogger"] = "Frogger",
	},
	-- Grade 1
	[1] = {
		["frogger"] = "Frogger",
	},
	-- Grade 2
	[2] = {
		["frogger"] = "Frogger",
	},
	-- Grade 3
	[3] = {
		["frogger"] = "Frogger",
	},
	-- Grade 4
	[4] = {
		["frogger"] = "Frogger",
	}
}
