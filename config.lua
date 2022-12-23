Config = {}

Config.StartTimer = 90 -- in min how long after the start of the mission it should reset the heist
Config.FinishTimer = 45 -- in min how long after the finish of the mission it should reset the heist
-- cop requirement
Config.MinCop = 4 -- Min amount of cops needed to do mission  

-- Prices
Config.JobPrice = 10000 -- Price to start the job

-- hack 1
Config.Hack1Item = 'electronickit' -- item needed for 1st hack

Config.Hack1Time = 12 -- amount of time to do the hack in seconds
Config.Hack1Squares = 4 -- Amount of squares to hack 
Config.Hack1Repeat = 3 -- Amount of times you need to hack to succeed 

-- hack 2
Config.Hack2Item = 'trojan_usb' -- item needed for 2nd hack

Config.Hack2Blocks = 8 -- Number of correct blocks the player needs to click 
Config.Hack2Fails = 3 -- Number of incorrect blocks after which the game will fail
Config.Hack2Time = 5 -- time in secs for which the right blocks will be shown
Config.Hack2Timer = 10 -- maximum time after timetoshow expires for player to select the right blocks

-- Hack 3
Config.Hack3Item = 'gatecrack' -- item needed for 3th hack

Config.Hack3Time = 15 -- amount of time to do the hack in seconds
Config.Hack3Squares = 5 -- Amount of squares to hack 
Config.Hack3Repeat = 3 -- Amount of times you need to hack to succeed 


-- Type of Loot
Config.Loot1item = 'weapon_heavypistol'   -- Reward from 1st crate
Config.Loot2item = 'weapon_carbinerifle' -- Reward from 2nd crate
Config.Loot3itemA = 'pistol_ammo' -- Reward A from 3th crate
Config.Loot3itemB = 'rifle_ammo' -- Reward B from 3th crate

-- Amount of Loot
Config.Loot1count = 5 -- Amount of times Reward in 1st crate is given 
Config.Loot2count = 2 -- Amount of times Reward in 2nd crate is given 
Config.Loot3countA = 25 -- Amount of times Reward A in 3th crate is given 
Config.Loot3countB = 25 -- Amount of times Reward B in 3th crate is given 

-- Spwan peds 
Config.SpawnPedsOnHack1 = true -- spawns ped on the 1st hack 
Config.SpawnPedsOnHack2 = true -- spawns ped on the 2nd hack 
Config.SpawnPedsOnHack3 = true -- spawns ped on the 3th hack 

-- Ped weapon 
Config.PedGun = `WEAPON_CARBINERIFLE`

-- Ped coords
Config.Shooters = {
    ['soldiers'] = {
        locations = {
            [1] = { -- Hack 1
                peds = {vector3(138.63, -765.85, 234.15),vector3(137.59, -767.8, 234.15),vector3(134.82, -764.49, 234.15),vector3(130.98, -765.9, 234.15),vector3(125.03, -761.0, 234.15),vector3(119.62, -761.47, 234.15),vector3(118.54, -753.97, 234.15)}
            },
            [2] = { -- Hack 2
                peds = {vector3(119.18, -729.56, 258.15),vector3(121.08, -730.6, 258.15),vector3(120.49, -732.34, 258.15),vector3(118.48, -733.63, 258.15),vector3(154.93, -763.23, 258.15),vector3(156.45, -760.32, 258.15)}
            },
            [3] = { -- Hack 3
                peds = {vector3(150.06, -738.62, 242.15),vector3(148.13, -745.67, 242.15),vector3(151.61, -751.18, 242.13),vector3(151.61, -751.18, 242.13),vector3(143.12, -761.55, 242.15),vector3(141.64, -765.28, 242.15),vector3(135.59, -764.93, 242.15),vector3(123.88, -768.93, 242.15),vector3(122.07, -754.45, 242.15),vector3(124.58, -744.99, 242.15),vector3(131.11, -742.41, 242.15),vector3(140.84, -745.79, 242.15)} 
            },
        },
    }
}