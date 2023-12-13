-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if GetResourceState('vinzz') ~= 'started' then return end
ESX = exports['vinzz']:getSharedObject()
Framework = 'esx'

GetPlayer = function(source)
    return ESX.GetPlayerFromId(source)
end

GetPlayers = function()
    return ESX.GetExtendedPlayers()
end

KickPlayer = function(source, reason)
    local player = GetPlayer(source)
    return player.kick(reason)
end

HasGroup = function(source, filter)
    local player = GetPlayer(source)
    if not player then return false, false end
    local type = type(filter)

    if type == 'string' then
        if player.job.name == filter then
            return player.job.name, player.job.grade
        end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            local grade = filter[player.job.name]

            if grade and grade <= player.job.grade then
                return player.job.name, player.job.grade
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                if player.job.name == filter[i] then
                    return player.job.name, player.job.grade
                end
            end
        end
    end
end

GetIdentifier = function(source)
    local player = GetPlayer(source)
    return player.identifier
end

GetName = function(source)
    local player = GetPlayer(source)
    return player.getName()
end

RegisterUsableItem = function(item, cb)
    ESX.RegisterUsableItem(item, cb)
end

HasItem = function(source, item)
    local player = GetPlayer(source)
    local item = player.getInventoryItem(item)
    if item ~= nil then
        return item.count
    else
        return 0
    end
end

AddItem = function(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    return player.addInventoryItem(item, count, metadata, slot)
end

AddWeapon = function(source, weapon, ammo)
    local player = GetPlayer(source)
    player.addWeapon(data.itemId, ammo)
end

RemoveItem = function(source, item, count, slot, metadata)
    local player = GetPlayer(source)
    player.removeInventoryItem(item, count, metadata, slot)
end

AddMoney = function(source, type, amount)
    local player = GetPlayer(source)
    player.addAccountMoney(type, amount)
end

RemoveMoney = function(source, type, amount)
    local player = GetPlayer(source)
    player.removeAccountMoney(type, amount)
end

GetPlayerAccountFunds = function(source, type)
    if type == 'cash' then type = 'money' end
    local player = GetPlayer(source)
    return player.getAccount(type).money
end

ToggleDuty = function(source, job, grade)
    local player = GetPlayer(source)
    if job:sub(0, 3) == 'off' then
        local onDuty = string.gsub(job, 'off', '')
        player.setJob(onDuty, grade)
        TriggerClientEvent('wasabi_ambulance:notify', source, Strings.on_duty, Strings.on_duty_desc, 'success')
    else
        player.setJob('off'..job, grade)
        TriggerClientEvent('wasabi_ambulance:notify', source, Strings.off_duty, Strings.off_duty_desc, 'error')
    end
end
