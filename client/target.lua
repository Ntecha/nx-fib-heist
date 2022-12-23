exports['qb-target']:AddBoxZone("nxte-FIB:startheist", vector3(-589.46, -708.78, 36.38), 0.5, 3, {
	name = "nxte-FIB:startheist",
	heading = 359.83,
	debugPoly = false,
	minZ = 35.4,
	maxZ = 37.5,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:startheist",
			icon = "fas fa-circle",
			label = "Knock on Door",
		},
	},
	distance = 2.5
})

exports['qb-target']:AddBoxZone("nxte-FIB:hack1", vector3(119.15, -726.7, 235.48), 0.3, 0.4, {
	name = "nxte-FIB:hack1",
	heading = 249.85,
	debugPoly = false,
	minZ = 233.9,
	maxZ = 234.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:StartHack1",
			icon = "fas fa-circle",
			label = "Hack",
		},
	},
	distance = 2.5
})

exports['qb-target']:AddBoxZone("nxte-FIB:hack2", vector3(118.54, -754.74, 259.23), 1, 1, {
	name = "nxte-FIB:hack2",
	heading = 160.0,
	debugPoly = false,
	minZ = 258,
	maxZ = 258.6,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:StartHack2",
			icon = "fas fa-circle",
			label = "Hack",
		},
	},
	distance = 2.5
})

exports['qb-target']:AddBoxZone("nxte-FIB:hack3", vector3(124.34, -725.88, 243.45), 1, 0.8, {
	name = "nxte-FIB:hack3",
	heading = 159.14,
	debugPoly = false,
	minZ = 242.3,
	maxZ = 242.7,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:StartHack3",
			icon = "fas fa-circle",
			label = "Hack",
		},
	},
	distance = 2.5
})

exports['qb-target']:AddBoxZone("nxte-FIB:loot1", vector3(143.98, -764.57, 243.16), 0.4, 0.8, {
	name = "nxte-FIB:loot1",
	heading = 68.61,
	debugPoly = false,
	minZ = 241.5,
	maxZ = 243.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:StartLoot1",
			icon = "fas fa-circle",
			label = "Search",
		},
	},
	distance = 2.5
})

exports['qb-target']:AddBoxZone("nxte-FIB:loot2", vector3(145.12, -762.12, 243.3), 0.4, 0.8, {
	name = "nxte-FIB:loot2",
	heading = 68.61,
	debugPoly = false,
	minZ = 241.5,
	maxZ = 243.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:StartLoot2",
			icon = "fas fa-circle",
			label = "Search",
		},
	},
	distance = 2.5
})

exports['qb-target']:AddBoxZone("nxte-FIB:loot3", vector3(152.27, -735.49, 243.47), 0.4, 2.5, {
	name = "nxte-FIB:loot3",
	heading = 160 ,
	debugPoly = false,
	minZ = 241.2,
	maxZ = 243.2,
}, {
	options = {
		{
            type = "client",
            event = "nxte-FIB:client:StartLoot3",
			icon = "fas fa-circle",
			label = "Search",
		},
	},
	distance = 2.5
})