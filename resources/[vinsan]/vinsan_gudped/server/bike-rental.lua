RegisterServerEvent("esx:bike:lowmoney")
AddEventHandler("esx:bike:lowmoney", function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(price)
end)