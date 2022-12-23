local QBCore = exports['qb-core']:GetCoreObject()

local isActive = false
local Hack1 = false
local Hack2 = false
local Hack3 = false
local Loot1 = false
local Loot2 = false
local Loot3 = false
local CurrentCops = 0

-- remove money 
RegisterNetEvent('nxte-FIB:server:removecash', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.Functions.RemoveMoney('cash', tonumber(amount))
end)

-- send isActive to client
RegisterNetEvent('nxte-FIB:server:SetActive', function(active)
    isActive = active
    TriggerClientEvent('nxte-FIB:client:SetActive', -1, active)
end)    

-- send hack 1 status to client
RegisterNetEvent('nxte-FIB:server:SetHack1', function(hackstatus)
    Hack1 = hackstatus
    TriggerClientEvent('nxte-FIB:client:SetHack1', -1, hackstatus)
end)

-- send hack 2 status to client
RegisterNetEvent('nxte-FIB:server:SetHack2', function(hackstatus)
    Hack2 = hackstatus
    TriggerClientEvent('nxte-FIB:client:SetHack2',-1, hackstatus)
end)

-- send door hack status to client
RegisterNetEvent('nxte-FIB:server:SetDoorHack', function(hackstatus)
    Hack3 = hackstatus
    TriggerClientEvent('nxte-FIB:client:SetDoorHack',-1, hackstatus)
end)

-- send loot 1 status to client
RegisterNetEvent('nxte-FIB:server:SetLoot1', function(status)
    Loot1 = status
    TriggerClientEvent('nxte-FIB:client:SetLoot1', -1, status)
end)

-- send loot 2 status to client
RegisterNetEvent('nxte-FIB:server:SetLoot2', function(status)
    Loot2 = status
    TriggerClientEvent('nxte-FIB:client:SetLoot2', -1, status)
end)

-- send loot 3 status to client
RegisterNetEvent('nxte-FIB:server:SetLoot3', function(status)
    Loot3 = status
    TriggerClientEvent('nxte-FIB:client:SetLoot3', -1, status)
end)


-- send all info on player Load to prevent exploiting 
RegisterNetEvent('nxte-FIB:server:SetInfoOnLoad', function()
    TriggerClientEvent('nxte-FIB:client:SetActive', -1, isActive)
    TriggerClientEvent('nxte-FIB:client:SetHack1', -1, Hack1)
    TriggerClientEvent('nxte-FIB:client:SetHack2', -1, Hack2)
    TriggerClientEvent('nxte-FIB:client:SetDoorHack', -1, Hack3)
    TriggerClientEvent('nxte-FIB:client:SetLoot1', -1, Loot1)
    TriggerClientEvent('nxte-FIB:client:SetLoot2', -1, Loot2)
    TriggerClientEvent('nxte-FIB:client:SetLoot3', -1, Loot3)
end)

-- reset mission
RegisterNetEvent('nxte-FIB:server:ResetMission', function()
    TriggerClientEvent('nxte-FIB:client:SetActive', -1, false)
    TriggerClientEvent('nxte-FIB:client:SetHack1', -1,false)
    TriggerClientEvent('nxte-FIB:client:SetHack2', -1, false)
    TriggerClientEvent('nxte-FIB:client:SetDoorHack', -1, false)
    TriggerClientEvent('nxte-FIB:client:SetLoot1', -1, false)
    TriggerClientEvent('nxte-FIB:client:SetLoot2', -1, false)
    TriggerClientEvent('nxte-FIB:client:SetLoot3', -1, false)
end)

-- getting cops
RegisterNetEvent('nxte-FIB:server:GetCops', function()
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    print(amount)
    CurrentCops = amount
    TriggerClientEvent('nxte-FIB:client:GetCops', -1, amount)
end)

-- spawning peds
local peds = { -- You can add extra ped models in here
    `a_m_m_og_boss_01`,
    `a_m_m_hillbilly_02`,
    `a_m_m_salton_04`,
    `a_m_m_soucent_01`,
}

local getRandomNPC = function()
    return peds[math.random(#peds)]
end

QBCore.Functions.CreateCallback('nxte-FIB:server:SpawnNPC', function(source, cb, loc)
    local netIds = {}
    local netId
    local npc
    for i=1, #Config.Shooters['soldiers'].locations[loc].peds, 1 do
        npc = CreatePed(30, getRandomNPC(), Config.Shooters['soldiers'].locations[loc].peds[i], true, false)
        while not DoesEntityExist(npc) do Wait(10) end
        netId = NetworkGetNetworkIdFromEntity(npc)
        netIds[#netIds+1] = netId
    end
    cb(netIds)
end)



RegisterNetEvent('nx-fib:server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item,amount)
end)
RegisterNetEvent('nx-fib:server:AddItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item,amount)
end)