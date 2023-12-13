local Vehicles = {}
local lsMenuIsShowed = false
local isInLSMarker = false
local myCar = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_lscustom:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)
end)

RegisterNetEvent('esx_lscustom:installMod')
AddEventHandler('esx_lscustom:installMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'car_repair', 0.2)
	TriggerServerEvent('esx_lscustom:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('esx_lscustom:rechargevehicle')
AddEventHandler('esx_lscustom:rechargevehicle', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	if not isInLSMarker then
		ESX.ShowNotification('Anda sedang tidak berada dibengkel!', 'error')
	end

	if vehicle and Config.Electric[GetEntityModel(vehicle)] and isInLSMarker then
		if not (DecorExistOn(vehicle, "recharge") and DecorGetInt(vehicle, "recharge") == 1) then
			DecorSetInt(vehicle, "recharge", 1)
			SetVehicleEngineOn(vehicle, false, true, true)
			SetVehicleUndriveable(vehicle, true)
			FreezeEntityPosition(vehicle, true)
			SetVehicleDoorOpen(vehicle, 4, false)
			ESX.ShowNotification('Sedang mengisi baterai, silahkan tunggu!')

			ESX.SetTimeout(180000, function()
				if DoesEntityExist(vehicle) then
					DecorSetInt(vehicle, "recharge", 0)
					SetVehicleEngineOn(vehicle, false, false, false)
					SetVehicleUndriveable(vehicle, false)
					FreezeEntityPosition(vehicle, false)
					SetFuel(vehicle, 100)
					SetVehicleDoorsShut(vehicle, false)
					PlayVehicleDoorOpenSound(vehicle, 0)
					ESX.ShowNotification('Berhasil mengisi baterai, kendaraan dapat diambil!')
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_lscustom:cancelInstallMod')
AddEventHandler('esx_lscustom:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if (GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId()) then
		vehicle = GetPlayersLastVehicle(PlayerPedId())
	end
	if not (myCar.nitroStorage) then
		DecorRemove(vehicle, 'nitroStorage')
		DecorRemove(vehicle, 'nitroFuel')
	end
	if not (myCar.modTurbo) then
		ToggleVehicleMod(vehicle,  18, false)
	end
	if not (myCar.modXenon) then
		ToggleVehicleMod(vehicle,  22, false)
	end
	if not (myCar.windowTint) then
		SetVehicleWindowTint(vehicle, 0)
	end

	ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

RegisterNetEvent('esx_lscustom:forceOpen')
AddEventHandler('esx_lscustom:forceOpen', function()
	lsMenuIsShowed = true
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	FreezeEntityPosition(vehicle, true)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	ESX.UI.Menu.CloseAll()
	GetAction({value = 'main'}, true)
end)

function OpenLSMenu(elems, menuName, menuTitle, parent, forced)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName, {
		title    = menuTitle,
		align    = 'top-right',
		elements = elems
	}, function(data, menu)
		local isRimMod, found = false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end

		for k,v in pairs(LSCConfig.Menus) do

			if k == data.current.modType or isRimMod then
				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label), 'error')
					TriggerEvent('esx_lscustom:installMod')
				else
					local vehiclePrice = 0

					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end

					if isRimMod then
						price = math.floor(vehiclePrice * data.current.price / 100)
						TriggerServerEvent('esx_lscustom:buyMod', price, forced)
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
						TriggerServerEvent('esx_lscustom:buyMod', price, forced)
					elseif v.modType == 59 then
						price = math.floor(vehiclePrice * v.price[math.floor(data.current.modNum / 2500)] / 100)
						TriggerServerEvent('esx_lscustom:buyMod', price, forced)
					elseif v.modType == 17 then
						price = math.floor(vehiclePrice * v.price[1] / 100)
						TriggerServerEvent('esx_lscustom:buyMod', price, forced)
					else
						price = math.floor(vehiclePrice * v.price / 100)
						TriggerServerEvent('esx_lscustom:buyMod', price, forced)
					end
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current, forced)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('esx_lscustom:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function UpdateMods(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	if data.modType then
		local props = {}
		
		if data.wheelType then
			props['wheels'] = data.wheelType
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'neonColor' then
			if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
				props['neonEnabled'] = { false, false, false, false }
			else
				props['neonEnabled'] = { true, true, true, true }
			end
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'tyreSmokeColor' then
			props['modSmokeEnabled'] = true
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'modExtras' then
			local extras = {}
			for k,v in pairs(myCar.extras) do
				extras[k] = v
			end
			extras[data.modNum[1].extraid] = data.modNum[1].extrastate
			props['extras'] = extras
		end

		props[data.modType] = data.modNum
		if data.modType == 'modFrontWheels' then
			props['modBackWheels'] = data.modNum
		end
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
end

function GetAction(data, forced)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)

	if data.value == 'modSpeakers' or
		data.value == 'modTrunk' or
		data.value == 'modHydrolic' or
		data.value == 'modEngineBlock' or
		data.value == 'modAirFilter' or
		data.value == 'modStruts' or
		data.value == 'modTank' then
		SetVehicleDoorOpen(vehicle, 4, false)
		SetVehicleDoorOpen(vehicle, 5, false)
	elseif data.value == 'modDoorSpeaker' then
		SetVehicleDoorOpen(vehicle, 0, false)
		SetVehicleDoorOpen(vehicle, 1, false)
		SetVehicleDoorOpen(vehicle, 2, false)
		SetVehicleDoorOpen(vehicle, 3, false)
	else
		SetVehicleDoorsShut(vehicle, false)
	end

	local vehiclePrice = 0
	for i=1, #Vehicles, 1 do
		if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
			vehiclePrice = Vehicles[i].price
			break
		end
	end

	for k,v in pairs(LSCConfig.Menus) do

		if data.value == k then

			menuName  = k
			menuTitle = v.label
			parent    = v.parent

			if v.modType then
				
				if v.modType == 22 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
				elseif v.modType ~= 65 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end

				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 22 then -- NEON
					local _label = ''
					if currentMods.modXenon then
						_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						price = math.floor(vehiclePrice * v.price / 100)
						_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local neons = GetNeons()
					price = math.floor(vehiclePrice * v.price / 100)
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b }
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = math.floor(vehiclePrice * v.price / 100)
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}

					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)

					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
						end
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					SetVehicleModKit(vehicle, 0)
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price[j+1] / 100)
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				elseif v.modType == 65 then
					for i=1,14,1 do
						local _label = ''
						if DoesExtraExist(vehicle,i) then
							_label = 'Extra ' .. i .. ' - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price / 100) .. ' OFF </span>'
							table.insert(elements, {label = _label, modType = 'modExtras', modNum = {{extraid = i, extrastate = false}}})
							_label = 'Extra ' .. i .. ' - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price / 100) .. ' ON </span>'
							table.insert(elements, {label = _label, modType = 'modExtras', modNum = {{extraid = i, extrastate = true}}})
						end
					end
				elseif v.modType == 59 then
					if not IsVehicleElectric(vehicle) and IsToggleModOn(vehicle, 18) then
						local _storage = ''
						for j = 2500, 7500, 2500 do
							if DecorExistOn(vehicle, 'nitroStorage') and DecorGetInt(vehicle, 'nitroStorage') == j then
								_storage = 'Nitro Storage ' .. j .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								_storage = 'Nitro Storage '  .. j .. ' - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[math.floor(j / 2500)] / 100) .. ' </span>'
							end
							table.insert(elements, {label = _storage, modType = k, modNum = j})
						end
					end
				elseif v.modType == 48 then -- Livery
					local _label = ''
					local modCount = tonumber(GetNumVehicleMods(vehicle, 48) or 0) + tonumber(GetVehicleLiveryCount(vehicle) or 0)
					for j = 1, modCount, 1 do
						if j == currentMods[k] then
							_label = _U('stickers') .. ' ' .. j .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = _U('stickers') .. ' ' .. j .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				else
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					end
				end
			else
				if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #LSCConfig.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = LSCConfig.Colors[i].label, value = 'color1', color = LSCConfig.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = LSCConfig.Colors[i].label, value = 'color2', color = LSCConfig.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = LSCConfig.Colors[i].label, value = 'pearlescentColor', color = LSCConfig.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = LSCConfig.Colors[i].label, value = 'wheelColor', color = LSCConfig.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then

							if l ~= 'nitroStorage' or l == 'nitroStorage' and not IsVehicleElectric(vehicle) and IsToggleModOn(vehicle, 18) then
								table.insert(elements, {label = w, value = l})
							end
						end
					end
				end
			end
			break
		end
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	OpenLSMenu(elements, menuName, menuTitle, parent, forced)
end

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		local letsleep = 5000
		local playerPed = PlayerPedId()

		if ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			if IsPedInAnyVehicle(playerPed, false) then
				letsleep = 1000
				local coords = GetEntityCoords(PlayerPedId())
				local currentZone, zone, lastZone

				for k,v in pairs(LSCConfig.Zones) do
					if #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x and not lsMenuIsShowed then
						letsleep = 0
						isInLSMarker  = true
						break
					else
						isInLSMarker  = false
					end
				end

				if not lsMenuIsShowed and isInLSMarker then
					ESX.ShowHelpNotification('[E] Akses Tablet LSCustom')
				end

				if IsControlJustReleased(0, 38) and not lsMenuIsShowed and isInLSMarker then
					if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and ESX.PlayerData.job.grade > 0) then
					lsMenuIsShowed = true

					local vehicle = GetVehiclePedIsIn(playerPed, false)
					FreezeEntityPosition(vehicle, true)

					myCar = ESX.Game.GetVehicleProperties(vehicle)

					ESX.UI.Menu.CloseAll()
					GetAction({value = 'main'}, false)
					end
				end

				if isInLSMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
				end

				if not isInLSMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
				end
			end
		end

		Citizen.Wait(letsleep)
	end
end)

-- Prevent Free Tunning Bug
Citizen.CreateThread(function()
	while true do
		local letsleep = 1000

		if lsMenuIsShowed then
			letsleep = 0
			DisableControlAction(2, 288, true)
			DisableControlAction(2, 289, true)
			DisableControlAction(2, 170, true)
			DisableControlAction(2, 167, true)
			DisableControlAction(2, 168, true)
			DisableControlAction(2, 23, true)
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end

		Citizen.Wait(letsleep)
	end
end)