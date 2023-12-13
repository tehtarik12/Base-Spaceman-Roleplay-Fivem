function Draw3DTextLoker(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
    for k,v in pairs(Config.LockerBlips) do
		local blip = AddBlipForCoord(tonumber(v.mapBlip.x), tonumber(v.mapBlip.y), tonumber(v.mapBlip.z))
		SetBlipSprite(blip, v.mapBlip.sprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, v.mapBlip.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.name)
		EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
		local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local letSleep = 1000
		
		for k, v in pairs (Config.Lockers) do
			local locker_name = v.locker_name
            local locker_loc = v.location
			local locker_dist = GetDistanceBetweenCoords(playerCoords, locker_loc.x, locker_loc.y, locker_loc.z, 1)
			
			if locker_dist <= 2.0 then
				letSleep = 0
                Draw3DTextLoker(locker_loc.x, locker_loc.y, locker_loc.z, "[E] ".. locker_name)
				if IsControlJustReleased(0, 38) then
					ESX.TriggerServerCallback('pyrp_locker:checkLocker', function(checkLocker)
						LockerMenu(k, checkLocker, locker_name)
					end, k)
				end
			end			
		end

		Citizen.Wait(letSleep)	
	end	
end)

function LockerMenu(k, hasLocker, lockerName)
	local elements = {}
	
	if hasLocker then
		table.insert(elements, {label = 'Buka Gudang', value = 'open_locker'})
		table.insert(elements, {label = 'Berhenti Sewa', value = 'stop_renting'})
	end
	
	if not hasLocker then
		table.insert(elements, {label = 'Sewa Gudang : <span style="color: green;">$ID' .. ESX.Math.GroupDigits(Config.DailyRentPrice) .. '</span>', value = 'start_locker_daily'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'locker_menu', {
		title    = lockerName,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'start_locker_daily' then
			ConfirmLockerRent(k, lockerName)
			menu.close()
		elseif data.current.value == 'stop_renting' then
			StopLockerRent(k, lockerName)
			menu.close()
		elseif data.current.value == 'open_locker' then
            exports.ox_inventory:openInventory('stash', {id=k})
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ConfirmLockerRent(k, lockerName)
    local elements = {
        {label = 'Yes', value = 'buy_yes'},
        {label = 'No', value = 'buy_no'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_rent_locker', {
        title    = 'Kamu berminat untuk sewa ' .. lockerName .. '?',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'buy_yes' then
            menu.close()
			TriggerServerEvent('pyrp_locker:startRentingLocker', k, lockerName)
        elseif data.current.value == 'buy_no' then
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end) 
end

function StopLockerRent(k, lockerName)
    local elements = {
        {label = 'Yes', value = 'buy_yes'},
        {label = 'No', value = 'buy_no'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cancel_rent_locker', {
        title    = 'Kamu berminat untuk hentikan sewa ' .. lockerName .. '?',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'buy_yes' then
            menu.close()
			TriggerServerEvent('pyrp_locker:stopRentingLocker', k, lockerName)
        elseif data.current.value == 'buy_no' then
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)  
end