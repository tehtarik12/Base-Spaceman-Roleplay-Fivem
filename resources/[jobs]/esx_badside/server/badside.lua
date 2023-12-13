Citizen.CreateThread(function()
    for k,v in pairs(ConfigBadside.FraksiZones) do
        TriggerEvent('esx_society:registerSociety', k, k, 'society_'..k, {type = 'public'})
    end
end)

RegisterNetEvent('esx_badside:CraftCompany')
AddEventHandler('esx_badside:CraftCompany', function(index)
    local xPlayer = ESX.GetPlayerFromId(source)
	local ishandcuffed = false

    if xPlayer and ConfigBadside.Company[xPlayer.job.name] and ConfigBadside.Company[xPlayer.job.name].menu[index] then
        local table = ConfigBadside.Company[xPlayer.job.name].menu[index]
        local allowed = true

        for k,v in pairs(table.bahan) do
            if xPlayer.getInventoryItem(k)["count"] < v then
                allowed = false
                break
            end
        end

        if allowed then
            for k,v in pairs(table.bahan) do
                if xPlayer.getInventoryItem(k)["count"] < v then
                    xPlayer.removeInventoryItem(k, v)
                end
            end

            xPlayer.addInventoryItem(table.value, table.give)
        else
            xPlayer.showNotification('Kekurangan Bahan!')
        end
    end
end)