local isSentenced = false
local communityServiceFinished = false
local actionsRemaining = 0
local availableActions = {}
local disable_actions = false

--[[ ]]--
local vassoumodel = "prop_tool_broom"
local vassour_net = nil
local spatulamodel = "bkr_prop_coke_spatula_04"
local spatula_net = nil
-----------------------

--TriggerServerEvent('qb-communityservice:checkIfSentenced')

function FillActionTable(last_action)
	while #availableActions < 5 do
		local service_does_not_exist = true
		local random_selection = Config.ServiceLocations[math.random(1,#Config.ServiceLocations)]

		for i = 1, #availableActions do
			if random_selection.coords.x == availableActions[i].coords.x and random_selection.coords.y == availableActions[i].coords.y and random_selection.coords.z == availableActions[i].coords.z then
				service_does_not_exist = false
			end
		end

		if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
			service_does_not_exist = false
		end

		if service_does_not_exist then
			table.insert(availableActions, random_selection)
		end
	end
end


RegisterNetEvent('qb-communityservice:inCommunityService')
AddEventHandler('qb-communityservice:inCommunityService', function(actions_remaining)
	local playerPed = PlayerPedId()

	if isSentenced then
		return
	end

	actionsRemaining = actions_remaining

	FillActionTable()
	ApplyPrisonerSkin()
	ESX.Game.Teleport(playerPed, Config.ServiceLocation)
	isSentenced = true
	communityServiceFinished = false

	while actionsRemaining > 0 and communityServiceFinished ~= true do
		Citizen.Wait(20000)

		if #(GetEntityCoords(playerPed) - vector3(Config.ServiceLocation.x, Config.ServiceLocation.y, Config.ServiceLocation.z)) > 50 then
			ESX.Game.Teleport(playerPed, Config.ServiceLocation)
			ESX.ShowNotification(_U('escape_attempt'))
			TriggerServerEvent('qb-communityservice:extendService')
			actionsRemaining = actionsRemaining + Config.ServiceExtensionOnEscape
		end
	end

	TriggerServerEvent('qb-communityservice:finishCommunityService')
	ESX.Game.Teleport(playerPed, Config.ReleaseLocation)
	--[[ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end) ]]
	isSentenced = false
end)

RegisterNetEvent('qb-communityservice:finishCommunityService')
AddEventHandler('qb-communityservice:finishCommunityService', function(source)
	communityServiceFinished = true
	isSentenced = false
	actionsRemaining = 0
end)

Round = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local player = PlayerPedId()
		local pCoords    = GetEntityCoords(player)
		if actionsRemaining > 0 and isSentenced then
			draw2dText( _U('remaining_msg', Round(actionsRemaining)), { 0.175, 0.955 } )
			DrawAvailableActions()

			for i = 1, #availableActions do
				local distance = #(pCoords - availableActions[i].coords)

				if distance < 1.5 then
					ESX.ShowHelpNotification(_U('press_to_start'))

					if IsControlJustReleased(1, 38) then
						local tmp_action = availableActions[i]
						RemoveAction(tmp_action)
						FillActionTable(tmp_action)
						disable_actions = true

						TriggerServerEvent('qb-communityservice:completeService')
						actionsRemaining = actionsRemaining - 1

						if tmp_action.type == "cleaning" then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local vassouspawn = CreateObject(GetHashKey(vassoumodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(vassouspawn)
							TaskStartScenarioInPlace(PlayerPedId(), "world_human_janitor", 0, false)
							AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
							vassour_net = netid
							Wait(10000)
							disable_actions = false
							DetachEntity(NetToObj(vassour_net), 1, 1)
							DeleteEntity(NetToObj(vassour_net))
							ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 2.0, 0)
							vassour_net = nil
							ClearPedTasks(player)
						end

						if tmp_action.type == "gardening" then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local spatulaspawn = CreateObject(GetHashKey(spatulamodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(spatulaspawn)
							TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
							AttachEntityToEntity(spatulaspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,190.0,190.0,-50.0,1,1,0,1,0,1)
							spatula_net = netid
							Wait(10000)
							disable_actions = false
							DetachEntity(NetToObj(spatula_net), 1, 1)
							DeleteEntity(NetToObj(spatula_net))
							ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 2.0, 0)
							spatula_net = nil
							ClearPedTasks(PlayerPedId())
						end
					end
				end
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

function RemoveAction(action)
	local action_pos = -1

	for i=1, #availableActions do
		if action.coords.x == availableActions[i].coords.x and action.coords.y == availableActions[i].coords.y and action.coords.z == availableActions[i].coords.z then
			action_pos = i
		end
	end

	if action_pos ~= -1 then
		table.remove(availableActions, action_pos)
	end
end

function DrawAvailableActions()
	for i = 1, #availableActions do
		DrawMarker(21, availableActions[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 204, 100, false, true, 2, true, false, false, false)
	end
end

function ApplyPrisonerSkin()
	local playerPed = PlayerPedId()
	if DoesEntityExist(playerPed) then
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].female)
			end
		end)
		SetPedArmour(playerPed, 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
	end
end

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end