Config = {}

Config.UseBlips = true

Config.BlipLocation = {
	{
        title = "Weazel News", 
        colour = 1, 
        id = 459, 
        x = -597.89, 
        y = -929.95, 
        z = 24.0
    },
}

Config.Items = {
	[1] = {
        name = "newscam",
        price = 500,
        amount = 5,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "newsbmic",
        price = 350,
        amount = 5,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "newsmic",
        price = 250,
        amount = 5,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.Locations = {
	["duty"] = {
		[1] = vector3(-591.53, -931.58, 23.86),
	},
   	["vehicle"] = {
       	 	label = "Vehicle Storage",
        	coords = vector4(-556.47, -925.2, 23.86, 267.24),
    	},
    	["heli"] = {
		label = "Helicopter Storage",
		coords = vector4(-583.08, -930.55, 36.83, 89.26),
	},
	["shop"] = {
		[1] = vector3(-562.08, -934.93, 23.88),
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
