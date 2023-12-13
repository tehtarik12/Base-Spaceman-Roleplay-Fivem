local rob = false
local robbers = {}
ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('vin_robbery:berapalockpicknya', function(source, cb, item, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    cb(xPlayer.getInventoryItem(item)["count"] >= (count or 1))
end)

RegisterServerEvent('vin_robbery:terlalujauh')
AddEventHandler('vin_robbery:terlalujauh', function(currentStore)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('vin_robbery:matiinblip', xPlayers[i])
		end
	end

	if robbers[_source] then
		local xPlayers = ESX.GetPlayers()
		local xPlayer = nil

		for i=1, #xPlayers, 1 do
			xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], { type = 'error', text = _U('robbery_cancelled_at', Stores[currentStore].nameOfStore) })
				TriggerClientEvent('vin_robbery:matiinblip', xPlayers[i])
			end
		end

		TriggerClientEvent('vin_robbery:terlalujauh', _source)
		robbers[_source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('robbery_cancelled_at', Stores[currentStore].nameOfStore) })
	end
end)


RegisterServerEvent('vin_robbery:dimulaiskarang')
AddEventHandler('vin_robbery:dimulaiskarang', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local alertData = {
			title = "Store Robbery",
			coords = {x = GetEntityCoords(GetPlayerPed(1)).x, y = GetEntityCoords(GetPlayerPed(1)).y, z = GetEntityCoords(GetPlayerPed(1)).z},
			description = "A robbery started at the store!"
		}

	if Stores[currentStore] then
		local store = Stores[currentStore]

		if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lastRobbed)) })
			return
		end

		local cops = 0
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

		if not rob then
			if cops >= Config.PoliceNumberRequired then
				rob = true

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer then
						-- TriggerEvent('ivrp_outlawalert:storeRobbery', store.nameOfStore)
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], { type = 'error', text = _U('rob_in_prog', store.nameOfStore) })
						TriggerClientEvent('vin_robbery:ngaturblip', xPlayers[i], Stores[currentStore].position)
						TriggerClientEvent("qs-smartphone:client:addPoliceAlert", -1, alertData)
					end
				end

				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message error"><b>BERITA:</b> Telah Terjadi Perampokan Di '..store.nameOfStore..'</div>',
					args = { user, msg }
				})

				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('started_to_rob', store.nameOfStore) })
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('alarm_triggered') })
				
				TriggerClientEvent('vin_robbery:barusajadirobb', _source, currentStore)
				TriggerClientEvent('vin_robbery:waktudimulai', _source)
				
				Stores[currentStore].lastRobbed = os.time()
				robbers[_source] = currentStore

				SetTimeout(store.secondsRemaining * 1000, function()
					if robbers[_source] then
						rob = false
						if xPlayer then
							TriggerClientEvent('vin_robbery:robberyberhasil', _source, store.reward)

							if Config.GiveBlackMoney then
								xPlayer.addAccountMoney('black_money', store.reward)
							else
								xPlayer.addMoney(store.reward)
							end
							
							local xPlayers, xPlayer = ESX.GetPlayers(), nil
							for i=1, #xPlayers, 1 do
								xPlayer = ESX.GetPlayerFromId(xPlayers[i])

								if xPlayer.job.name == 'police' then
									TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], { type = 'error', text = _U('robbery_complete_at', store.nameOfStore) })
									TriggerClientEvent('vin_robbery:matiinblip', xPlayers[i])
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('min_police', Config.PoliceNumberRequired) })
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert',_source, { type = 'error', text = _U('robbery_already') })
		end
	end
end)


AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'lockpick' then
		TriggerClientEvent('lockpick:addcalc', source)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'lockpick' and item.count < 1 then
		TriggerClientEvent('lockpick:removecalc', source)
	end
end)

RegisterNetEvent('ons-lockpick:hapusitemnya')
AddEventHandler('ons-lockpick:hapusitemnya', function()
	local _source = source 
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('lockpick', 1)
end)

RegisterNetEvent('vin_robbery:opennuinya')
AddEventHandler('vin_robbery:opennuinya', function()
	TriggerClientEvent('lockpick:openlockpick', source)
end)