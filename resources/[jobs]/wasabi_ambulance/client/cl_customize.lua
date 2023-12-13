-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

RegisterNetEvent('wasabi_ambulance:notify', function(title, desc, style, icon) -- Edit notifications here with custom notification system
    if icon then
        lib.notify({
            title = title,
            description = desc,
            duration = 3500,
            icon = icon,
            type = style
        })
    else
        lib.notify({
            title = title,
            description = desc,
            duration = 3500,
            type = style
        })
    end
end)

RegisterNetEvent('wasabi_ambulance:resetStatus', function() -- Set your own custom hunger/thirst reset logic?
	if Framework == 'esx' then
		TriggerEvent('esx_status:set', 'hunger', 500000)
		TriggerEvent('esx_status:set', 'thirst', 500000)
	elseif Framework == 'qb' then
		TriggerServerEvent('QBCore:Server:SetMetaData', 'hunger', 100)
		TriggerServerEvent('QBCore:Server:SetMetaData', 'thirst', 100)
	end
	if Config.MythicHospital then
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
    end
end)

ShowTextUI = function(msg)
    lib.showTextUI(msg) -- Replace this with your custom text UI function/event?
end

HideTextUI = function()
    lib.hideTextUI() -- Replace this with your custom text UI function/event?
end

addCarKeys = function(plate, model) -- Edit carlock function to implement custom carlock
    if Framework == 'qb' then
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
    else
        exports.wasabi_carlock:GiveKeys(plate) -- Leave like this if using wasabi_carlock
    end
end

SendDistressSignal = function() -- Edit distress signal to implement custom dispatch
	TriggerEvent('wasabi_ambulance:notify', Strings.distress_sent_title, Strings.distress_sent_desc, 'success')
	local ped = cache.ped
	local myPos = GetEntityCoords(ped)
	if Config.phoneDistress == 'gks' then
		local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
		ESX.TriggerServerCallback('gksphone:namenumber', function(Races)
			local name = Races[2].firstname .. ' ' .. Races[2].lastname
			TriggerServerEvent('gksphone:gkcs:jbmessage', name, Races[1].phone_number, 'Emergency aid notification', '', GPS, '["ambulance"]', false)
		end)
    elseif Config.phoneDistress == 'qs' then
        TriggerServerEvent('qs-smartphone:server:AddJobMessage', {
            type = 'message',
            message = 'Injured person.'
        })
        Wait(300)
        TriggerServerEvent('qs-smartphone:server:AddJobMessage', {
            type = 'location',
            message = json.encode({
                x = myPos.x,
                y = myPos.y,
            })
        })
    elseif Config.phoneDistress == 'd-p' then
        TriggerEvent('d-phone:client:message:senddispatch', 'Unconscious person', Config.ambulanceJob)
        TriggerEvent('d-notification', 'Service Message sended', 5000,  'success')
	else
		TriggerServerEvent('wasabi_ambulance:onPlayerDistress') -- To add your own dispatch, comment this line out and add into here
	end
end

-- Add target event
AddEventHandler('wasabi_ambulance:addTarget', function(d)
    if d.targetType == 'AddBoxZone' then
        exports.qtarget:AddBoxZone(d.identifier, d.coords, d.width, d.length, {
            name=d.identifier,
            heading=d.heading,
            debugPoly=false,
            minZ=d.minZ,
            maxZ=d.maxZ,
            useZ = true,
        }, {
            options = d.options,
            job = (d.job or false),
            distance = d.distance,
        })
    elseif d.targetType == 'Player' then
        exports.qtarget:Player({
            options = d.options,
            job = (d.job or false),
            distance = d.distance,
        })
    elseif d.targetType == 'Vehicle' then
        exports.qtarget:Vehicle({
            options = d.options,
            job = (d.job or false),
            distance = d.distance
        })
    elseif d.targetType == 'Model' then
        exports.qtarget:AddTargetModel(d.models, {
            options = d.options,
            job = (d.job or false),
            distance = d.distance,
        })
    end
end)

-- Remove target event
AddEventHandler('wasabi_ambulance:removeTarget', function(identifier)
    exports.qtarget:RemoveZone(identifier)
end)

AddEventHandler('wasabi_ambulance:changeClothes', function(data) -- Change with your own code here if you want?
    if Config.skinScript == 'custom' then
		-- Custom clothing code here?
	else
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			if data == 'civ_wear' then
				if Config.skinScript == 'appearance' then
						skin.sex = nil
						exports['fivem-appearance']:setPlayerAppearance(skin)
				else
				TriggerEvent('skinchanger:loadClothes', skin)
				end
			elseif skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, data.male)
			elseif skin.sex == 1 then
				TriggerEvent('skinchanger:loadClothes', skin, data.female)
			end
		end)
	end
end)

-- Death screen related editables
startDeathTimer = function()
	if not Config.DisableDeathAnimation then
		SetGameplayCamRelativeHeading(-360)
	end
	local earlySpawnTimer = math.floor(Config.RespawnTimer / 1000)
	local bleedoutTimer = math.floor(Config.BleedoutTimer / 1000)
	CreateThread(function()
		while earlySpawnTimer > 0 and isDead do
			Wait(1000)
			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end
		while bleedoutTimer > 0 and isDead do
			Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)
	CreateThread(function()
		local text, timeHeld
		while earlySpawnTimer > 0 and isDead do
			Wait()
			text = (Strings.respawn_available_in):format(secondsToClock(earlySpawnTimer))
			DrawGenericTextThisFrame()
			SetTextEntry('STRING')
			AddTextComponentString(text)
			DrawText(Config.MessagePosition.respawn.x or 0.5, Config.MessagePosition.respawn.y or 0.8)
		end
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait()
			text = (Strings.respawn_bleedout_in):format(secondsToClock(bleedoutTimer)) .. Strings.respawn_bleedout_prompt
			if IsControlPressed(0, 38) and timeHeld > 60 then
				StartRPDeath()
				break
			end
			if IsControlPressed(0, 38) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end
			DrawGenericTextThisFrame()
			SetTextEntry('STRING')
			AddTextComponentString(text)
			DrawText(Config.MessagePosition.bleedout.x or 0.5, Config.MessagePosition.bleedout.y or 0.8)
		end
		if bleedoutTimer < 1 and isDead then
			StartRPDeath()
		end
	end)
end

startDistressSignal = function()
	CreateThread(function()
		local timer = Config.BleedoutTimer
		while timer > 0 and isDead do
			Wait()
			timer = timer - 30
			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(Strings.distress_send)
			EndTextCommandDisplayText(Config.MessagePosition.distress.x or 0.175, Config.MessagePosition.distress.y or 0.805)
			if IsControlJustReleased(0, 47) then --Old 47
				SendDistressSignal()
				break
			end
		end
	end)
end

OnPlayerDeath = function()
	if not isDead then
		isDead = true
		if Framework == 'esx' then ESX.UI.Menu.CloseAll() end
		TriggerServerEvent('wasabi_ambulance:setDeathStatus', true)
		Wait(2500)
		startDeathTimer()
		TriggerEvent('esx-radio:onRadioDrop')
		startDistressSignal()
		startDeathAnimation(false)
		AnimpostfxPlay('DeathFailOut', 0, true)
	else
		startDeathAnimation(true)
		AnimpostfxPlay('DeathFailOut', 0, true)
	end
end

-- Job menu edits?
openJobMenu = function()
	if not HasGroup(Config.ambulanceJob) then return end
	if isPlayerDead() then return end
    if not IsOnDuty() then return end
	Options = {
		{
			title = Strings.dispatch,
			description = Strings.dispatch_desc,
			icon = 'truck-medical',
			arrow = true,
			event = 'wasabi_ambulance:dispatchMenu',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.diagnose_patient,
			description = Strings.diagnose_patient_desc,
			icon = 'stethoscope',
			arrow = false,
			event = 'wasabi_ambulance:diagnosePatient',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.revive_patient,
			description = Strings.revive_patient_desc,
			icon = 'kit-medical',
			arrow = false,
			event = 'wasabi_ambulance:reviveTarget',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.heal_patient,
			description = Strings.heal_patient_desc,
			icon = 'bandage',
			arrow = false,
			event = 'wasabi_ambulance:healTarget',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.sedate_patient,
			description = Strings.sedate_patient_desc,
			icon = 'syringe',
			arrow = false,
			event = 'wasabi_ambulance:useSedative',
			disabled = isPlayerDead() == true
		},
		{
			title = Strings.place_patient,
			description = Strings.place_patient_desc,
			icon = 'car',
			arrow = false,
			event = 'wasabi_ambulance:placeInVehicle',
			disabled = isPlayerDead() == true
		}
	}
	if Config?.wasabi_crutch?.crutchInJobMenu then
		Options[#Options + 1] = {
			title = Strings.menu_crutch,
			description = Strings.menu_crutch_desc,
			icon = 'crutch',
			arrow = false,
			event = 'wasabi_ambulance:crutchMenu',
			disabled = isPlayerDead() == true
		}
	end
	if Config?.wasabi_crutch?.chairInJobMenu then
		Options[#Options + 1] = {
			title = Strings.menu_chair,
			description = Strings.menu_chair_desc,
			icon = 'wheelchair',
			arrow = false,
			event = 'wasabi_ambulance:chairMenu',
			disabled = isPlayerDead() == true
		}
	end
	if Config.billingSystem then
		Options[#Options + 1] = {
			title = Strings.bill_patient,
			description = Strings.bill_patient_desc,
			icon = 'file-invoice',
			arrow = false,
			event = 'wasabi_ambulance:billPatient',
			disabled = isPlayerDead() == true
		}
	end
	if Config.MobileMenu.enabled then
		OpenMobileMenu('ems_job_menu', Strings.JobMenuTitle, Options)
	else
		lib.registerContext({
			id = 'ems_job_menu',
			title = Strings.JobMenuTitle,
			options = Options
		})
		lib.showContext('ems_job_menu')
	end
end