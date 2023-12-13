local playersProcessingCannabis = {}
local outofbound = true
local alive = true

-- RegisterServerEvent('esx_drugs:sellDrug')
-- AddEventHandler('esx_drugs:sellDrug', function(itemName, amount)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local price = Config.DrugDealerItems[itemName]
-- 	local xItem = xPlayer.getInventoryItem(itemName)

-- 	if not price then
-- 		print(('esx_drugs: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
-- 		return
-- 	end

-- 	if xItem.count < amount then
-- 		xPlayer.showNotification(_U('dealer_notenough'))
-- 		return
-- 	end

-- 	price = ESX.Math.Round(price * amount)

-- 	if Config.GiveBlack then
-- 		xPlayer.addAccountMoney('black_money', price)
-- 	else
-- 		xPlayer.addMoney(price)
-- 	end

-- 	xPlayer.removeInventoryItem(xItem.name, amount)
-- 	xPlayer.showNotification(_U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
-- end)

-- ESX.RegisterServerCallback('esx_drugs:buyLicense', function(source, cb, licenseName)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local license = Config.LicensePrices[licenseName]

-- 	if license then
-- 		if xPlayer.getMoney() >= license.price then
-- 			xPlayer.removeMoney(license.price)

-- 			TriggerEvent('esx_license:addLicense', source, licenseName, function()
-- 				cb(true)
-- 			end)
-- 		else
-- 			cb(false)
-- 		end
-- 	else
-- 		print(('esx_drugs: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
-- 		cb(false)
-- 	end
-- end)

RegisterServerEvent('esx_drugs:pickedUpCannabis')
AddEventHandler('esx_drugs:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local jumlah = 1
	if xPlayer.canCarryItem('kecubungmentah', jumlah) then
		xPlayer.addInventoryItem('kecubungmentah', jumlah)
		local fortisLogsTable = {
			["identifier"] = GetPlayerName(source),
			["jumlah"] = jumlah,
			["barang"] = "Kecubung",
		}
		exports["fortislogs"]:addLog("Cabut Barang Haram", fortisLogsTable) 
	else
		xPlayer.showNotification(_U('weed_inventoryfull'))
	end
end)

RegisterServerEvent('esx_drugs:pickedUpCannabis2')
AddEventHandler('esx_drugs:pickedUpCannabis2', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local jumlah = 1
	if xPlayer.canCarryItem('micinmentah', jumlah) then
		xPlayer.addInventoryItem('micinmentah', jumlah)
		local fortisLogsTable = {
			["identifier"] = GetPlayerName(source),
			["jumlah"] = jumlah,
			["barang"] = "Micin",
		}
		exports["fortislogs"]:addLog("Cabut Barang Haram", fortisLogsTable) 
	else
		xPlayer.showNotification(_U('micin_inventoryfull'))
	end
end)

ESX.RegisterServerCallback('esx_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local jumlah = 1
	cb(xPlayer.canCarryItem(item, jumlah))
end)

-- RegisterServerEvent('esx_drugs:outofbound')
-- AddEventHandler('esx_drugs:outofbound', function()
-- 	outofbound = true
-- end)

-- ESX.RegisterServerCallback('esx_drugs:cannabis_count', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local xCannabis = xPlayer.getInventoryItem('kecubungmentah').count
-- 	cb(xCannabis)
-- end)

-- RegisterServerEvent('esx_drugs:processCannabis')
-- AddEventHandler('esx_drugs:processCannabis', function()
--   if not playersProcessingCannabis[source] then
-- 		local source = source
-- 		local xPlayer = ESX.GetPlayerFromId(source)
-- 		local xCannabis = xPlayer.getInventoryItem('kecubungmentah')
-- 		local can = true
-- 		outofbound = false
--     if xCannabis.count >= 3 then
--       while outofbound == false and can do
-- 				if playersProcessingCannabis[source] == nil then
-- 					playersProcessingCannabis[source] = ESX.SetTimeout(Config.Delays.WeedProcessing , function()
--             if xCannabis.count >= 3 then
--               if xPlayer.canSwapItem('kecubungmentah', 3, 'kecubungjadi', 1) then
--                 xPlayer.removeInventoryItem('kecubungmentah', 3)
--                 xPlayer.addInventoryItem('kecubungjadi', 1)
-- 								xPlayer.showNotification(_U('weed_processed'))
-- 							else
-- 								can = false
-- 								xPlayer.showNotification(_U('weed_processingfull'))
-- 								TriggerEvent('esx_drugs:cancelProcessing')
-- 							end
-- 						else						
-- 							can = false
-- 							xPlayer.showNotification(_U('weed_processingenough'))
-- 							TriggerEvent('esx_drugs:cancelProcessing')
-- 						end

-- 						playersProcessingCannabis[source] = nil
-- 					end)
-- 				else
-- 					Wait(Config.Delays.WeedProcessing)
-- 				end	
-- 			end
-- 		else
-- 			xPlayer.showNotification(_U('weed_processingenough'))
-- 			TriggerEvent('esx_drugs:cancelProcessing')
-- 		end	
			
-- 	else
-- 		print(('esx_drugs: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
-- 	end
-- end)

-- function CancelProcessing(playerId)
-- 	if playersProcessingCannabis[playerId] then
-- 		ESX.ClearTimeout(playersProcessingCannabis[playerId])
-- 		playersProcessingCannabis[playerId] = nil
-- 	end
-- end

-- RegisterServerEvent('esx_drugs:cancelProcessing')
-- AddEventHandler('esx_drugs:cancelProcessing', function()
-- 	CancelProcessing(source)
-- end)

-- AddEventHandler('esx:playerDropped', function(playerId, reason)
-- 	CancelProcessing(playerId)
-- end)

-- RegisterServerEvent('esx:onPlayerDeath')
-- AddEventHandler('esx:onPlayerDeath', function(data)
-- 	CancelProcessing(source)
-- end)
