local CurrentActionData, handcuffTimer, dragStatus, blipsCops = {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false
local LastStation, LastPart, LastPartNum, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

Citizen.CreateThread(function()
	exports.qtarget:Player({
		options = {
			{
				event = "rheein_policejob:TargetAction",
				type = 'search',
				icon = "fas fa-heart",
				label = "Search [POL]",
				job = 'police',
			},
			{
				event = "rheein_policejob:TargetAction",
				type = 'handcuff',
				icon = "fas fa-first-aid",
				label = "Handcuff [POL]",
				job = {
					["police"] = 0,
					["fama"] = 0,
					["famb"] = 0,
					["famc"] = 0,
					["famd"] = 0,
					["fame"] = 0,
					["famf"] = 0,
					["famg"] = 0,
				}
			},
			--[[{
				event = "rheein_policejob:TargetAction",
				type = 'drag',
				icon = "fas fa-medkit",
				label = "Drag [POL]",
				job = {
					["police"] = 0,
					["fama"] = 0,
					["famb"] = 0,
					["famc"] = 0,
					["famd"] = 0,
					["fame"] = 0,
					["famf"] = 0,
				}
			},]]--
			{
				event = "rheein_policejob:TargetAction",
				type = 'put_in_vehicle',
				icon = "fas fa-car-side",
				label = "Memasukkan kedalam kendaraan [POL]",
				job = {
					["police"] = 0,
					["fama"] = 0,
					["famb"] = 0,
					["famc"] = 0,
					["famd"] = 0,
					["fame"] = 0,
					["famf"] = 0,
					["famg"] = 0,
				}
			},
			{
				event = "rheein_policejob:TargetAction",
				type = 'fine',
				icon = "fas fa-car-side",
				label = "Fine [POL]",
				job = 'police',
			},

			{
				event = "rheein_policejob:TargetAction",
				type = 'comserv',
				icon = "fas fa-car-side",
				label = "Community Service [POL]",
				job = 'police',
			},

			{
				event = "rheein_policejob:TargetAction",
				type = 'jail',
				icon = "fas fa-car-side",
				label = "Jail Player [POL]",
				job = 'police',
			},


		},
		distance = 2
	})

	exports.qtarget:Vehicle({
		options = {
			{
				event = "rheein_policejob:TargetAction",
				type = 'out_the_vehicle',
				icon = "fas fa-sign-out-alt",
				label = "Mengeluarkan dari kendaraan [POL]",
				job = {
					["police"] = 0,
					["lawless"] = 0,
					["rendezyous"] = 0,
					["cdm"] = 0,
					["famd"] = 0,
					["fame"] = 0,
					["famg"] = 0,
				}
			},
			{
				event = "rheein_policejob:TargetAction",
				type = 'vehicle_infos',
				icon = "fas fa-sign-out-alt",
				label = "Vehicle Lookup [POL]",
				job = 'police',
			},
			{
				event = "rheein_policejob:TargetAction",
				type = 'hijack_vehicle',
				icon = "fas fa-sign-out-alt",
				label = "Hijack Vehicle [POL]",
				job = 'police',
			},
			{
				event = "rheein_policejob:TargetAction",
				type = 'impound',
				icon = "fas fa-sign-out-alt",
				label = "Impound Vehicle [POL]",
				job = 'police',
			},
			{
				event = "rheein_policejob:TargetAction",
				type = 'samsat',
				icon = "fas fa-sign-out-alt",
				label = "Sita Kendaraan [POL]",
				job = 'police',
			},
		},
		distance = 2
	})
end)

AddEventHandler('rheein_policejob:TargetAction', function(data)
	local ped = data.entity
	local type = data.type
	local playerPed = PlayerPedId()
	local targetserverid = 0

	for k,player in ipairs(GetActivePlayers()) do
		local tped = GetPlayerPed(player)

		if DoesEntityExist(tped) and (tped ~= playerPed and ped == tped) then
			targetserverid = GetPlayerServerId(player)
			break
		end
	end

	if type == 'search' then
		OpenBodySearchMenu(targetserverid)
	elseif type == 'handcuff' then
		TriggerServerEvent('esx_policejob:handcuff', targetserverid)
	elseif type == 'drag' then
		TriggerServerEvent('esx_policejob:drag', targetserverid)
	elseif type == 'put_in_vehicle' then
		TriggerServerEvent('vinsan_jobs:putInVehicle', targetserverid)
	elseif type == 'jail' then
		OpenJailMenu(targetserverid)
	elseif type == 'comserv' then
		OpenComserv(targetserverid)
	elseif type == 'out_the_vehicle' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent('vinsan_jobs:OutVehicle', GetPlayerServerId(closestPlayer))
		end
	elseif type == 'fine' then
		OpenFineMenu(targetserverid)
	elseif type == 'vehicle_infos' then
		local vehicleData = ESX.Game.GetVehicleProperties(ped)
		OpenVehicleInfosMenu(vehicleData)
	elseif type == 'hijack_vehicle' then
		TriggerEvent('esx_mechanicjob:onHijack', ped)
	elseif type == 'impound' then
		TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
		Citizen.Wait(10000)
		ClearPedTasks(playerPed)
		ImpoundVehicle(ped)
	elseif type == 'samsat' then 
		TriggerEvent('lucky_samsat:ShowImpoundMenu')
	end
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function OpenComserv(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comserv_choose_time_menu',{
		title = "Community Service Action (amount)"
	},function(data2, menu2)
		local jailTime = tonumber(data2.value)

		if jailTime == nil then
			ESX.ShowNotification("The time needs to be in number!")
		else
			menu2.close()

			TriggerServerEvent('qb-communityservice:sendToCommunityService', player, jailTime)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end


function OpenArmoryMenuPOLISI(station)
	local elements = {
		{label = 'Akses Brangkas Polisi', value = 'policestorage'},
		{label = 'Akses Barang Bukti', value = 'evidancestorage'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = _U('armory'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'policestorage' then
			exports.ox_inventory:openInventory('stash', {id = 'society_police', owner = CurrentActionData.station})
		elseif data.current.value == 'evidancestorage' then
			exports.ox_inventory:openInventory('stash', {id = 'police_evidance', owner = CurrentActionData.station})

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end


function OpenJailMenu(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_time_menu',{
		title = "Jail Time (minutes)"
	},function(data2, menu2)
		local jailTime = tonumber(data2.value)

		if jailTime == nil then
			ESX.ShowNotification("The time needs to be in minutes!")
		else
			menu2.close()

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',{
				title = "Jail Reason"
			},function(data3, menu3)
				local reason = data3.value

				if reason == nil then
					ESX.ShowNotification("You need to put something here!")
				else
					menu3.close()
					TriggerServerEvent("kcmcity_whitelistjob:jailPlayer", player, jailTime, reason)
				end

			end, function(data3, menu3)
				menu3.close()
			end)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end

function OpenBodySearchMenu(player)
	if Config.OxInventory then
		exports.ox_inventory:openInventory('player', player)
		return ESX.UI.Menu.CloseAll()
	end
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'top-right',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = _U('fine'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendBill', player, 'society_police', _U('fine_total', data.current.fineLabel), data.current.amount)
			else
				TriggerServerEvent('esx_billing:sendBill', player, '', _U('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = _U('plate', retrivedInfo.plate)}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = _U('owner_unknown')})
				else
					table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = _U('vehicle_info'),
					align    = 'top-right',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if not retrivedInfo.owner then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'top-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if job.name == 'police' then
		Wait(1000)
		TriggerServerEvent('esx_policejob:forceBlip')
	end
end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'WeaponsArmories' then
		CurrentAction     = 'menu_weaponarmory'
		CurrentActionMsg  = '[ALT] to open weapon armory'
		CurrentActionData = {station = station}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(cop, ishandcuffed, sourcejob)
	local playerPed = PlayerPedId()
	local copPed = GetPlayerPed(GetPlayerFromServerId(cop))

	if ishandcuffed then
		RequestAnimDict('mp_arrest_paired')

		while not HasAnimDictLoaded('mp_arrest_paired') do
			Citizen.Wait(10)
		end
	
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'cuff', 0.2)
		AttachEntityToEntity(playerPed, copPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
		TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)
	
		Citizen.Wait(1250)
		DetachEntity(playerPed, true, false)
	else
		local playerheading = GetEntityHeading(copPed)
		local playerlocation = GetEntityForwardVector(copPed)
		local playerCoords = GetEntityCoords(copPed)
		local x, y, z   = table.unpack(playerCoords + playerlocation * 1.0)
		SetEntityCoords(playerPed, x, y, z - 1.0)
		SetEntityHeading(playerPed, playerheading)
		Citizen.Wait(250)
		RequestAnimDict('mp_arresting')

		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(10)
		end
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'uncuff', 0.2)
		TaskPlayAnim(playerPed, 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Citizen.Wait(5500)
		ClearPedTasks(playerPed)
	end

	if ishandcuffed then
		local dict = sourcejob ~= 'police' and 'anim@move_m@prisoner_cuffed' or 'mp_arresting'
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, dict, 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)

		if sourcejob ~= 'police' then
			DecorSetBool(playerPed, 'zipped', true)
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			zipped = true
			StartHandcuffTimerPOLISI()
		end
		isHandcuffed = true
	else
		if sourcejob ~= 'police' then
			DecorRemove(playerPed, 'zipped')
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end
			zipped = false
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		isHandcuffed = false
	end
end)

RegisterNetEvent('esx_policejob:handcuffAnim')
AddEventHandler('esx_policejob:handcuffAnim', function(target, ishandcuffed)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	if ishandcuffed then
		RequestAnimDict('mp_arrest_paired')

		while not HasAnimDictLoaded('mp_arrest_paired') do
			Citizen.Wait(10)
		end

		TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)
		Citizen.Wait(3000)
		ClearPedTasks(playerPed)
	else
		RequestAnimDict('mp_arresting')

		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(10)
		end
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Citizen.Wait(5500)
		ClearPedTasks(playerPed)
	end
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

CreateThread(function()
	local wasDragged

	while true do
		local letsleep = 1000
		local playerPed = PlayerPedId()

		if dragStatus.isDragged then
			letsleep = 0
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			letsleep = 0
			wasDragged = false
			DetachEntity(playerPed, true, false)
		end

		Citizen.Wait(letsleep)
	end
end)

-- Handcuff
CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 243, true)  -- Disable radioa
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Wait(500)
		end
	end
end)

-- Create blips
CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(''.._U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			permission_level = identity['permission_level']
		}
	else
		return nil
	end
end

-- Draw markers and more
CreateThread(function()
	while true do
		Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do

			if ESX.PlayerData.job.grade > 9 then
				for i=1, #v.Armories, 1 do
					local distance = #(playerCoords - v.Armories[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Armories, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
						end
					end
				end
			end

				for i=1, #v.WeaponsArmories, 1 do
					local distance = #(playerCoords - v.WeaponsArmories[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.WeaponsArmories, v.WeaponsArmories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'WeaponsArmories', i
						end
					end
				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job.grade >= 15 then
					for i=1, #v.BossActions, 1 do
						local distance = #(playerCoords - v.BossActions[i])

						if distance < Config.DrawDistance then
							DrawMarker(Config.MarkerType.BossActions, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false

							if distance < Config.MarkerSize.x then
								isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
							end
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Wait(500)
			end
		else
			Wait(500)
		end
	end
end)

-- Key Controls
CreateThread(function()
	while true do
		Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

				if CurrentAction == 'menu_armory' then
					OpenArmoryMenuPOLISI(CurrentActionData.station)
				elseif CurrentAction == 'menu_weaponarmory' then 
					ESX.ShowNotification('Gunakan ALT Untuk Membuka!')
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						menu.close()

						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				end

				CurrentAction = nil
			end
		end -- CurrentAction end
	end
end)

RegisterNetEvent('esx_policejob:updateBlip')
AddEventHandler('esx_policejob:updateBlip', function()
    for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
    blipsCops = {}
    if Config.EnableESXService and not playerInService then
        return
    end
    if not Config.EnableJobBlip then
        return
    end
    if PlayerData.job and PlayerData.job.name == 'police' then
        ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(connectedPlayers)
            for k,v in pairs(connectedPlayers) do
                local id         = GetPlayerFromServerId(v.source)
                local name         = v.name
                local grade = v.job.grade_label

                local name2 = '' .. grade.. ' - ' .. name
                if v.job.name == 'police' then
                    if GetPlayerPed(id) ~= PlayerPedId() then
                        createBlip(id, name2)
                    end
                end
            end
        end)
    end
end)


AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'police')
		end

	end
end)

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
end