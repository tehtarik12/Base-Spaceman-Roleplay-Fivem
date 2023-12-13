-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if GetResourceState('vinzz') ~= 'started' then return end
ESX = exports['vinzz']:getSharedObject()
Framework, PlayerLoaded, PlayerData = 'esx', nil, {}
local firstLog = true

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    TriggerEvent('wasabi_ambulance:playerLoaded')
    PlayerData = xPlayer
    PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerSpawn', function()
    if firstLog then firstLog = nil return end
    TriggerEvent('wasabi_ambulance:onPlayerSpawn')
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    TriggerEvent('wasabi_ambulance:onPlayerDeath', data)
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    table.wipe(PlayerData)
    PlayerLoaded = false
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
    TriggerEvent('wasabi_ambulance:setJob', job.name)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not ESX.PlayerLoaded then return end
    PlayerData = ESX.GetPlayerData()
    PlayerLoaded = true
    if Config.UseRadialMenu then
        AddRadialItems()
    end
end)

AddEventHandler('esx:setPlayerData', function(key, value)
    if GetInvokingResource() ~= 'vinzz' then return end
    PlayerData[key] = value
end)

HasGroup = function(filter)
    if not PlayerData.job then return false, false end
    local type = type(filter)

    if type == 'string' then
        if PlayerData.job.name == filter then
            return PlayerData.job.name, PlayerData.job.grade
        end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            local grade = filter[PlayerData.job.name]

            if grade and grade <= PlayerData.job.grade then
                return PlayerData.job.name, PlayerData.job.grade
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                if PlayerData.job.name == filter[i] then
                    return PlayerData.job.name, PlayerData.job.grade
                end
            end
        end
    end
end

GetGroup = function()
    return PlayerData.job.name, PlayerData.job.grade
end

IsOnDuty = function()
    if PlayerData.job.name:sub(0, 3) == 'off' then
        return false
    else
        return true
    end
end

OpenBossMenu = function()
    TriggerEvent('esx_society:openBossMenu', PlayerData.job.name, function(data, menu)
        menu.close()
    end, {wash = false})
end
