local QBCore = exports['qb-core']:GetCoreObject()

local isActive = false
local Hack1 = false
local Hack2 = false
local Hack3 = false
local Loot1 = false
local Loot2 = false
local Loot3 = false
local CurrentCops = 0
local Buyer = nil

-- get all info on player Load to prevent exploiting 
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('nxte-FIB:server:SetInfoOnLoad')
end)

local function CallCops()
 -- your code here 
end

local function OnHack1Done(success)
    if success then 
        TriggerServerEvent('nxte-FIB:server:SetHack1', true)
        if Config.SpawnPedsOnHack1 then 
            TriggerEvent('nxte-FIB:client:SpawnLocals', 1)
        end
        QBCore.Functions.Notify("You disabled the camera system", "success")
        QBCore.Functions.Notify("Go to the top floor to hack the communication system")
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack1Item], 'remove')
        TriggerServerEvent('nx-fib:server:RemoveItem', Config.Hack1Item, 1)
    else
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack1Item], 'remove')
        TriggerServerEvent('nx-fib:server:RemoveItem', Config.Hack1Item, 1)
        QBCore.Functions.Notify("Failed hacking the computer", "error")
    end
end

local function OnHack3Done(success)
    if success then 
        TriggerServerEvent('nxte-FIB:server:SetDoorHack', true)
        if Config.SpawnPedsOnHack3 then
            TriggerEvent('nxte-FIB:client:SpawnLocals', 3)
        end
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack3Item], 'remove')
        TriggerServerEvent('nx-fib:server:RemoveItem', Config.Hack3Item, 1)
        QBCore.Functions.Notify("Completed hacking the computer", "success")
        QBCore.Functions.Notify("Go loot the secured lockers!")
    else
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack3Item], 'remove')
        TriggerServerEvent('nx-fib:server:RemoveItem', Config.Hack3Item, 1)
        QBCore.Functions.Notify("Failed hacking the locks", "error")
    end
end
------------------------------------------------------------ EVENTS --------------------------------------------------
-- Start Mission
RegisterNetEvent('nxte-FIB:client:startheist',function()
    TriggerServerEvent('nxte-FIB:server:GetCops')
    local Player = QBCore.Functions.GetPlayerData()
    local cash = Player.money.cash
    TriggerEvent('animations:client:EmoteCommandStart', {"knock"})
    QBCore.Functions.Progressbar("Talk", "Knocking on door...", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if cash >= Config.JobPrice then     
            if not isActive then
                if CurrentCops >= Config.MinCop then 
                    TriggerServerEvent('nxte-FIB:server:SetActive', true)
                    Buyer = Player.source
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify('You paid $'..Config.JobPrice.. ' for the heist', 'success')
                    QBCore.Functions.Notify("Go to the 47th floor to hack the camera system")
                    TriggerServerEvent('nxte-FIB:server:removecash', Config.JobPrice)
                else 
                    QBCore.Functions.Notify('There is currently not enough police', 'error')
                end
            else
                QBCore.Functions.Notify('no one is opening the door', 'error')
            end
        else
            QBCore.Functions.Notify('HAHAHA you think i\'ll help you for free ??', 'error')
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled knocking on door", "error")
    end)
end)

-------------------
------ HACK -------
-------------------

-- Hack 1
RegisterNetEvent('nxte-FIB:client:StartHack1', function()
    if isActive then
        if not Hack1 then 
            if QBCore.Functions.HasItem(Config.Hack1Item) then 
                TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
                QBCore.Functions.Progressbar("hack", "hacking camera system", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerEvent('nxte-FIB:anim:hack1')
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify("Canceled hacking camera system", "error")
                end)
            else 
                QBCore.Functions.Notify('You cant hack without the right tools', 'error')
            end
        else
            QBCore.Functions.Notify('The camera system has already been hacked', 'error')
        end
    else
        QBCore.Functions.Notify('You can not do this now', 'error')
    end
end)

RegisterNetEvent('nxte-FIB:anim:hack1', function()
    local loc = {x,y,z,h}
    loc.x = 119.29 
    loc.y = -726.71
    loc.z = 235.0
    loc.h = 345.27

    local animDict = 'anim@heists@ornate_bank@hack'
    RequestAnimDict(animDict)
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('hei_prop_hst_laptop')
        or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        Wait(100)
    end

    local ped = PlayerPedId()
    SetEntityCoords(ped, vector3(3105.34, -4811.65,  7.03))
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    SetPedComponentVariation(ped, 5, Config.HideBagID, 1, 1)
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Config.Hack1Time, Config.Hack1Squares, Config.Hack1Repeat, function(success) -- time . blocks . repeat 
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        SetPedComponentVariation(ped, 5, Config.BagUseID, 0, 1)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
        OnHack1Done(success)
    end)
end)
-- Hack 2
RegisterNetEvent('nxte-FIB:client:StartHack2', function()
    if isActive then
        if Hack1 then
            if not Hack2 then 
                if QBCore.Functions.HasItem(Config.Hack2Item) then
                    TriggerEvent('animations:client:EmoteCommandStart', {"type"})
                    QBCore.Functions.Progressbar("hack", "hacking computer", 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        exports["memorygame"]:thermiteminigame(Config.Hack2Blocks, Config.Hack2Fails, Config.Hack2Time, Config.Hack2Timer,
                        function() -- success
                            if Config.SpawnPedsOnHack2 then
                                TriggerEvent('nxte-FIB:client:SpawnLocals', 2)
                            end
                            CallCops()
                            TriggerServerEvent('nxte-FIB:server:SetHack2', true)
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack2Item], 'remove')
                            TriggerServerEvent('nx-fib:server:RemoveItem', Config.Hack2Item, 1)
                            QBCore.Functions.Notify("Completed hacking the computer", "success")
                            QBCore.Functions.Notify("Go to floor 49 to hack the lock system")
                        end,
                        function() -- failure
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Hack2Item], 'remove')
                            TriggerServerEvent('nx-fib:server:RemoveItem', Config.Hack2Item, 1)
                            QBCore.Functions.Notify("Failed hacking the computer", "error")
                        end)
                    end, function() -- Cancel
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                        QBCore.Functions.Notify("Canceled hacking the computer", "error")
                    end)
                else 
                    QBCore.Functions.Notify('You cant hack the computer without the right tools', 'error')
                end
            else
                QBCore.Functions.Notify('This computer has already been hacked', 'error')
            end
        else 
            QBCore.Functions.Notify('The camera system is still active', 'error')
        end
    else
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

-- Hack3
RegisterNetEvent('nxte-FIB:client:StartHack3', function()
    if isActive then
        if Hack2 then
            if not Hack3 then 
                if QBCore.Functions.HasItem(Config.Hack3Item) then
                    TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
                    QBCore.Functions.Progressbar("hack", "hacking server", 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        TriggerEvent('nxte-FIB:anim:hack3')
                    end, function() -- Cancel
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                        QBCore.Functions.Notify("Canceled hacking the lock", "error")
                    end)
                else 
                    QBCore.Functions.Notify('You cant hack the locks without the right tools', 'error')
                end
            else
                QBCore.Functions.Notify('The locks have already been hacked', 'error')
            end
        else 
            QBCore.Functions.Notify('The alarm system is still active', 'error')
        end
    else
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

RegisterNetEvent('nxte-FIB:anim:hack3', function()
    local loc = {x,y,z,h}
    loc.x = 123.38 
    loc.y = -725.93
    loc.z = 243.0
    loc.h = 345.27

    local animDict = 'anim@heists@ornate_bank@hack'
    RequestAnimDict(animDict)
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded('hei_prop_hst_laptop')
        or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        Wait(100)
    end

    local ped = PlayerPedId()
    SetEntityCoords(ped, vector3(3105.34, -4811.65,  7.03))
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    SetPedComponentVariation(ped, 5, Config.HideBagID, 1, 1)
    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Config.Hack3Time, Config.Hack3Squares, Config.Hack3Repeat, function(success) -- time . blocks . repeat 
        NetworkStartSynchronisedScene(netScene3)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        SetPedComponentVariation(ped, 5, Config.BagUseID, 0, 1)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
        OnHack3Done(success)
    end)
end)


-----------------------
-------- REWARD -------
-----------------------
--Loot 1
RegisterNetEvent('nxte-FIB:client:StartLoot1', function()
    if isActive then
        if Hack3 then
            if not Loot1 then
                TriggerServerEvent('nxte-FIB:server:SetLoot1', true)
                TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
                QBCore.Functions.Progressbar("loot", "Grabbing Loot", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('nx-fib:server:AddItem', Config.Loot1item, Config.Loot1count)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot1item], 'add', Config.Loot1count)
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify("Canceled grabbing loot", "error")
                end)
            else 
                QBCore.Functions.Notify('This closet is empty', 'error')
            end
        else
            QBCore.Functions.Notify('The door lock is still active', 'error')
        end
    else
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

--Loot 2
RegisterNetEvent('nxte-FIB:client:StartLoot2', function()
    if isActive then
        if Hack3 then
            if not Loot2 then
                TriggerServerEvent('nxte-FIB:server:SetLoot2', true)
                TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
                QBCore.Functions.Progressbar("loot", "Grabbing Loot", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('nx-fib:server:AddItem', Config.Loot2item, Config.Loot2count)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot2item], 'add', Config.Loot2count)
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify("Canceled grabbing loot", "error")
                end)
            else 
                QBCore.Functions.Notify('This closet is empty', 'error')
            end
        else
            QBCore.Functions.Notify('The door lock is still active', 'error')
        end
    else
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)

--Loot 3
RegisterNetEvent('nxte-FIB:client:StartLoot3', function()
    if isActive then
        if Hack3 then
            if not Loot3 then
                TriggerServerEvent('nxte-FIB:server:SetLoot3', true)
                TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
                QBCore.Functions.Progressbar("loot", "Grabbing Loot", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('nx-fib:server:AddItem', Config.Loot3itemA, Config.Loot3countA)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot3itemA], 'add', Config.Loot3countA)
                    Citizen.Wait(1000)
                    TriggerServerEvent('nx-fib:server:AddItem', Config.Loot3itemB, Config.Loot3countB)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Loot3itemB], 'add', Config.Loot3countB)
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify("Canceled grabbing loot", "error")
                end)
            else 
                QBCore.Functions.Notify('This closet is empty', 'error')
            end
        else
            QBCore.Functions.Notify('The door lock is still active', 'error')
        end
    else
        QBCore.Functions.Notify('You can not do this right now', 'error')
    end
end)


-----------------------
--- GET server data ---
-----------------------
-- get isactive status
RegisterNetEvent('nxte-FIB:client:SetActive', function(active)
    isActive = active
end)

-- get hack1 status
RegisterNetEvent('nxte-FIB:client:SetHack1', function(status)
    Hack1 = status
end)

-- get hack2 status
RegisterNetEvent('nxte-FIB:client:SetHack2', function(status)
    Hack2 = status
end)

-- get Door Hack status
RegisterNetEvent('nxte-FIB:client:SetDoorHack', function(status)
    Hack3 = status
end)

-- get loot 1 status 
RegisterNetEvent('nxte-FIB:client:SetLoot1', function(status)
    Loot1 = status
end)

-- get loot 2 status 
RegisterNetEvent('nxte-FIB:client:SetLoot2', function(status)
    Loot2 = status
end)

-- get loot 3 status 
RegisterNetEvent('nxte-FIB:client:SetLoot3', function(status)
    Loot3 = status
end)

-- set cops
RegisterNetEvent('nxte-FIB:client:GetCops', function(amount)
    CurrentCops = amount
end)



-- Spawn Peds 

RegisterNetEvent('nxte-FIB:client:SpawnLocals', function(position)
    QBCore.Functions.TriggerCallback('nxte-FIB:server:SpawnNPC', function(netIds, position)
        Wait(1000)
        local ped = PlayerPedId()
        for i=1, #netIds, 1 do
            local npc = NetworkGetEntityFromNetworkId(netIds[i])
            SetPedDropsWeaponsWhenDead(npc, false)
            GiveWeaponToPed(npc, Config.PedGun, 250, false, true)
            SetPedMaxHealth(npc, 500)
            SetPedArmour(npc, 200)
            SetCanAttackFriendly(npc, true, false)
            TaskCombatPed(npc, ped, 0, 16)
            SetPedCombatAttributes(npc, 46, true)
            SetPedCombatAttributes(npc, 0, false)
            SetPedCombatAbility(npc, 100)
            SetPedAsCop(npc, true)
            SetPedRelationshipGroupHash(npc, `HATES_PLAYER`)
            SetPedAccuracy(npc, 60)
            SetPedFleeAttributes(npc, 0, 0)
            SetPedKeepTask(npc, true)
            --TaskGoStraightToCoord(npc, vehLoc.x, vehLoc.y, vehLoc.z, 1, -1, 0.0, 0.0)
            SetBlockingOfNonTemporaryEvents(npc, true)
        end
    end, position)
end)

-- Check if player is dead to stop mission
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isActive then
            local Player = QBCore.Functions.GetPlayerData()
            local Playerid = Player.source
            if Player.source == Buyer then
                if not Loot1 and not Loot2 and not Loot3 then
                    if Player.metadata["inlaststand"] or Player.metadata["isdead"] then
                        QBCore.Functions.Notify('Mission Failed', 'error')
                        Citizen.Wait(2000)
                        TriggerServerEvent('nxte-FIB:server:ResetMission')
                    end
                end
            end
        end
    end
end)

-- reset heist after start
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if isActive then
            Citizen.Wait(Config.StartTimer*60000)
            RemoveBlip(heistBlip)
            TriggerServerEvent('nxte-FIB:server:ResetMission')
        end
    end
end)

-- reset heist after success
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if Loot1 and Loot2 and Loot3 then
            RemoveBlip(heistBlip)
            Citizen.Wait(Config.FinishTimer*60000)
            TriggerServerEvent('nxte-FIB:server:ResetMission')
        end
    end
end)
