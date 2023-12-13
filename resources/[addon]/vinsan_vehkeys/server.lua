ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Keys = {}

ESX.RegisterCommand('givekey', 'user', function(xPlayer, args, showError)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))
    local plate = GetVehicleNumberPlateText(vehicle)
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")

    if not Keys[plate] then return end

	if Keys[plate].owner == xPlayer.identifier then
        local target = args.target
        if not target then return end
        local xTarget = ESX.GetPlayerFromId(target.source)
        local targetveh = GetVehiclePedIsIn(GetPlayerPed(target.source))

        if targetveh == vehicle then
            Keys[plate][xTarget.identifier] = true
            TriggerClientEvent('alvin_core:Notify', target.source, '', 'You have retrieved keys for vehicle: ' .. plate)
        end
    else
        TriggerClientEvent('alvin_core:Notify', xPlayer.source, 'error', 'You are not the owner.')
    end
end, true, {help = 'command for giving vehicle keys', validate = true, arguments = {
	{name = 'target', help = 'Target', type = 'player'}
}})

RegisterServerEvent("vinsan_vehkeys:CheckKey")
AddEventHandler("vinsan_vehkeys:CheckKey", function(vehicle, plate, lockState, vehicleClass)
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
    local xPlayer = ESX.GetPlayerFromId(source)

    if (Keys[plate] == nil) then
        TriggerClientEvent('alvin_core:Notify', source, 'error', 'You don\'t have the keys to this vehicle.')
        return
    end

    if (Keys[plate][xPlayer.identifier] ~= nil) then
        TriggerClientEvent("vinsan_vehkeys:ToggleLockAction", source, vehicle, lockState)
        return
    else
        TriggerClientEvent('alvin_core:Notify', source, 'error', 'You don\'t have the keys to this vehicle.')
        return
    end
end)

RegisterServerEvent("vinsan_vehkeys:AddKey")
AddEventHandler("vinsan_vehkeys:AddKey", function(targetId, plate, playerId)
    if ((source == nil or source == '') and playerId ~= nil) then source = playerId end
    local xPlayer = ESX.GetPlayerFromId(source)
    if (not source and Keys[plate][xPlayer.identifier] == nil and Keys[plate].owner ~= xPlayer.identifier) then return end
    if plate == nil then return end
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
    local xTarget = ESX.GetPlayerFromId(targetId)

    if (Keys[plate] == nil) then
        Keys[plate] = {}
        Keys[plate].owner = xTarget.identifier
    end

    Keys[plate][xTarget.identifier] = true

    if (not source) then TriggerClientEvent('alvin_core:Notify', source, '', 'You have given keys.') end
    TriggerClientEvent('alvin_core:Notify', targetId, '', 'You have retrieved keys for vehicle: ' .. plate)
end)

-- RegisterServerEvent("vinsan_vehkeys:RemoveKey")
AddEventHandler("vinsan_vehkeys:RemoveKey", function(targetId, plate)
    local xPlayer = ESX.GetPlayerFromId(targetId)
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")

    if (Keys[plate] ~= nil and Keys[plate].owner == xPlayer.identifier) then
        Keys[plate] = nil
        TriggerClientEvent('alvin_core:Notify', targetId, 'error', 'Your keys have been removed.')
    end
end)

AddEventHandler("vinsan_vehkeys:ClearKey", function(plate)
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")

    if (Keys[plate] ~= nil) then
        Keys[plate] = nil
    end
end)

ESX.RegisterServerCallback('vinsan_vehkeys:UserKeys', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local list = {}
    for k, v in pairs(Keys) do
        if (v.owner == xPlayer.identifier) then table.insert(list, k) end
    end
	cb(list)
end)
