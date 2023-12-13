-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
Framework = 'qb'

GetPlayer = function(source)
    return QBCore.Functions.GetPlayer(source)
end

GetPlayers = function()
    return QBCore.Functions.GetPlayers()
end

KickPlayer = function(source, reason)
    QBCore.Functions.Kick(source, reason, true, true)
end

HasGroup = function(source, filter)
    local groups = { 'job', 'gang' }
    local player = GetPlayer(source)
    if not player then return false, false end
    local type = type(filter)

    if type == 'string' then
        for i = 1, #groups do
            local data = player.PlayerData[groups[i]]

            if data.name == filter then
                return data.name, data.grade.level
            end
        end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            for i = 1, #groups do
                local data = player.PlayerData[groups[i]]
                local grade = filter[data.name]

                if grade and grade <= data.grade.level then
                    return data.name, data.grade.level
                end
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]

                for j = 1, #groups do
                    local data = player.PlayerData[groups[j]]

                    if data.name == group then
                        return data.name, data.grade.level
                    end
                end
            end
        end
    end
end

GetIdentifier = function(source)
    local player = QBCore.Functions.GetPlayer(source)
    return player.PlayerData.citizenid
end

GetName = function(source)
    local player = QBCore.Functions.GetPlayer(source)
    return player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
end

RegisterUsableItem = function(item, cb)
    QBCore.Functions.CreateUseableItem(item, cb)
end

HasItem = function(source, item)
    local player = GetPlayer(source)
    local item = player.Functions.GetItemByName(item)
    if GetResourceState('ox_inventory') == 'started' then
        return item?.count or 0
    else
        return item?.amount or 0
    end
end

AddItem = function(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    return player.Functions.AddItem(item, count, slot, metadata)
end

AddWeapon = function(source, weapon, ammo)
    local player = GetPlayer(source)
    return player.Functions.AddItem(weapon, 1, nil, nil)
end

RemoveItem = function(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    player.Functions.RemoveItem(item, count, slot, metadata)
end

AddMoney = function(source, type, amount)
    if type == 'money' then type = 'cash' end
    local player = GetPlayer(source)
    player.Functions.AddMoney(type, amount)
end

RemoveMoney = function(source, type, amount)
    if type == 'money' then type = 'cash' end
    local player = GetPlayer(source)
    player.Functions.RemoveMoney(type, amount)
end

GetPlayerAccountFunds = function(source, type)
    if type == 'money' then type = 'cash' end
    local player = GetPlayer(source)
    return player.PlayerData.money[type]
end

ToggleDuty = function(source, _job, _grade)
    local player = GetPlayer(source)
    if player.PlayerData.job.onduty then
        player.Functions.SetJobDuty(false)
        TriggerClientEvent('wasabi_ambulance:notify', source, Strings.off_duty, Strings.off_duty_desc, 'error')
    else
        player.Functions.SetJobDuty(true)
        TriggerClientEvent('wasabi_ambulance:notify', source, Strings.on_duty, Strings.on_duty_desc, 'success')
    end
end
