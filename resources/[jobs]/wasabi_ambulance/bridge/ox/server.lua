-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if GetResourceState('ox_core') ~= 'started' or not Ox then return end
Framework = 'ox'

GetPlayer = function(source)
    return Ox.GetPlayer(source)
end

HasGroup = function(source, filter)
    local player = GetPlayer(source)
    ---@diagnostic disable-next-line: missing-parameter
    return player.hasGroup(filter)
end

RegisterUsableItem = function(item, cb)
    ---@diagnostic disable-next-line: redefined-local
    exports(item, function(event, item, inventory, slot, data)
        if event ~= 'usedItem' then return end
        cb(item, inventory, slot, data)
    end)
end

AddItem = function(source, item, count, slot, metadata)
    return exports.ox_inventory:AddItem(source, item, count, metadata, slot)
end

RemoveItem = function(source, item, count, slot, metadata)
    return exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
end

AddMoney = function(source, type, amount)
    if type == 'money' then
        return exports.pefcl:addCash(source, amount)
    end

    exports.pefcl:addBankBalance(source, { amount = amount })
end

RemoveMoney = function(source, type, amount)
    if type == 'money' then
        return exports.pefcl:removeCash(source, amount)
    end

    exports.pefcl:removeBankBalance(source, { amount = amount })
end