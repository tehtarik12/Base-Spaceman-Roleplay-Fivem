-- RegisterNetEvent("vinsan_drug:getItem")
-- AddEventHandler("vinsan_drug:getItem", function(state)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local allowed = false
--     if state == 'kecubungmentah'   then allowed = true end

--     if allowed then
--         if xPlayer.canCarryItem(state, 3) then
--             xPlayer.addInventoryItem(state, 3)
--         else
--             TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
--             ESX.SendDiscord(GetPlayerName(source), 'Telah Mengambil** '.. state ..' ** Sebanyak ** 3x **', 'drug')
--         end
--     end
-- end)

-- RegisterNetEvent("vinsan_drug:getItem2")
-- AddEventHandler("vinsan_drug:getItem2", function(state)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local allowed = false
--     if state == 'micinmentah'  then allowed = true end

--     if allowed then
--         if xPlayer.canCarryItem(state, 1) then
--             xPlayer.addInventoryItem(state, 1)
--         else
--             TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
--             ESX.SendDiscord(GetPlayerName(source), 'Telah Mengambil** '.. state ..' ** Sebanyak ** 1x **', 'drug')
--         end
--     end
-- end)


RegisterNetEvent("vinsan_drug:processItem")
AddEventHandler("vinsan_drug:processItem", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = false
	local izin = false
	local jumlah = 2
	local jumlah2 = 1

	if xPlayer.job.name == 'fama' or xPlayer.job.name == 'famb' or xPlayer.job.name == 'famc' or xPlayer.job.name == 'famd' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'famf' or xPlayer.job.name == 'famg' then
		izin = true
	end
	
    if state == 'kecubungmentah' then 
        allowed = 'kecubungjadi'
    end
    if allowed ~= false then
		if izin == true then
        if xPlayer.canCarryItem(state, 2) then
            if xPlayer.getInventoryItem(state).count >= jumlah then
                xPlayer.removeInventoryItem(state, jumlah)
                xPlayer.addInventoryItem(allowed, jumlah2)
				local fortisLogsTable = {
					["identifier"] = GetPlayerName(source),
					["item"] = "Kecubung",
					["jumlah"] = jumlah2,
				}
				exports["fortislogs"]:addLog("Proses Barham", fortisLogsTable) 
			else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['noitems'])
            end
        else
            TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
        end
    end
	end
end)

RegisterNetEvent("vinsan_drug:processItem2")
AddEventHandler("vinsan_drug:processItem2", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = false
	local izin = false
	local jumlah = 2
	local jumlah2 = 1

	if xPlayer.job.name == 'fama' or xPlayer.job.name == 'famb' or xPlayer.job.name == 'famc' or xPlayer.job.name == 'famd' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'famf' or xPlayer.job.name == 'famg' then
		izin = true
	end
    if state == 'micinmentah' then
        allowed = 'micinjadi'
    end
    if allowed ~= false then
		if izin == true then
			if xPlayer.canCarryItem(state, 1)then
				if xPlayer.getInventoryItem(state).count >= jumlah then
					xPlayer.removeInventoryItem(state, jumlah)
					xPlayer.addInventoryItem(allowed, jumlah2)
					local fortisLogsTable = {
						["identifier"] = GetPlayerName(source),
						["item"] = "MICIN",
						["jumlah"] = jumlah2,
					}
					exports["fortislogs"]:addLog("Proses Barham", fortisLogsTable) 
				else
					TriggerClientEvent('esx:showNotification', source, cfg.translation['noitems'])
				end
			else
				TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
			end
		else
			exports['mythic_notify']:SendAlert('error', 'Ini bukan alat yang diberikan kepada Anda')
		end
	end
end)



RegisterNetEvent("vinsan_drug:Sell")
AddEventHandler("vinsan_drug:Sell", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local jumlah = 2
	local izin = false
	
	if xPlayer.job.name == 'fama' or xPlayer.job.name == 'famb' or xPlayer.job.name == 'famc' or xPlayer.job.name == 'famd' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'famf' or xPlayer.job.name == 'famg' then
		izin = true
	end
	
	if izin == true then
	
    if state ~= 'Kecubung' and state ~= 'MICIN' then
        local count = xPlayer.getInventoryItem(state).count
        if count >= 1 then
            xPlayer.removeInventoryItem(state, jumlah)
            xPlayer.addAccountMoney(cfg.price[state] * jumlah)
        end
    elseif state == 'Kecubung' then 
        local count = xPlayer.getInventoryItem('kecubungjadi').count
        if count > 1 then
            xPlayer.removeInventoryItem('kecubungjadi', jumlah)
            xPlayer.addAccountMoney('black_money', cfg.price['kecubungjadi'])
			local fortisLogsTable = {
				["identifier"] = GetPlayerName(source),
				["item"] = "Kecubung",
				["jumlah"] = jumlah,
			}
			exports["fortislogs"]:addLog("Barang Haram", fortisLogsTable) 
        end
    elseif state == 'MICIN' then
        local count = xPlayer.getInventoryItem('micinjadi').count
        if count > 1 then
            xPlayer.removeInventoryItem('micinjadi', jumlah)
            xPlayer.addAccountMoney('black_money', cfg.price['micinjadi'])
			local fortisLogsTable = {
				["identifier"] = GetPlayerName(source),
				["item"] = "Micin",
				["jumlah"] = jumlah,
			}
			exports["fortislogs"]:addLog("Barang Haram", fortisLogsTable) 
        end
    end
	end
end)