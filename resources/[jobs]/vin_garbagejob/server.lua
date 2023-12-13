ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

--[[ RegisterNetEvent('ndrp-garbage:pay')
AddEventHandler('ndrp-garbage:pay', function(jobStatus)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if jobStatus then
        if xPlayer ~= nil then
            local randomMoney = math.random(600,800)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerEvent('garbagePay:logs',_source,xPlayer.getName(),randomMoney)
        end
    else
        print("Probably a cheater: ",xPlayer.getName())
    end
end)
 ]]
RegisterServerEvent("copcu:esyaver")
AddEventHandler("copcu:esyaver", function()
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('kaca', 45)
    xPlayer.addInventoryItem('scrap', 40)
    xPlayer.addInventoryItem('plastik', 35)

end)  

RegisterNetEvent('ndrp-garbage:reward')
AddEventHandler('ndrp-garbage:reward', function(item,rewardStatus)
    print("in server side")
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if rewardStatus then
        if xPlayer ~= nil then
                xPlayer.addInventoryItem(item,1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You found ' ..item})
                TriggerEvent('garbageRew:logs',_source,xPlayer.getName(),item)
        end
    else
        print("Probably a cheater: ",xPlayer.getName())
    end
end)