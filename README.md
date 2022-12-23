# nxte-FIB-heist

 Free open-source FIB heist easy to adjust to your server with the config.lua
 
- preview : https://youtu.be/JO3LpbQ50_I
 
Dependency's:
- qb-lift
- qb-core
- qb-target
- Hack : https://github.com/Prime-Script/prime-vangelico/tree/main/assets ( hacking folder )
- Thermite game : https://github.com/pushkart2/memorygame

- NPC code from : github.com/Lionh34rt
- TO DO : replace the current FIB lift with this snippet in -- > qb-lift/config.lua
```    
    ["FIB"] = {
        Group = {},                                                      
        Sound = "liftSoundBellRing",                                                
        Name = "FIB Lift",
        Floors = {
            [1] = {
                Label = "Floor 1",
                FloorDesc = "Floor 1",
                Restricted = false,                                                  
                Coords = vector3(136.4, -760.96, 45.75),
                ExitHeading = "161.37"
            },
            [2] = {
                Label = "Floor 47",
                FloorDesc = "Floor 47",
                Restricted = false,
                Coords = vector3(136.37, -760.85, 234.15),
                ExitHeading = "156.97"
            },
            [3] = {
                Label = "Floor 49",
                FloorDesc = "Floor 49",
                Restricted = false,
                Coords = vector3(136.29, -761.01, 242.15),
                ExitHeading = "157.92"
            },
            [4] = {
                Label = "Floor 53",
                FloorDesc = "Offices",
                Restricted = false,
                Coords = vector3(114.92, -742.09, 258.15),
                ExitHeading = "344.13"
            },
        }
    },
