local IsDead = false
local IsAnimated = false
local inzonestatus = false

AddEventHandler('esx_basicneeds:resetStatus', function()
	-- TriggerEvent('esx_status:set', 'stress', 250000)
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)


RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	-- TriggerEvent('esx_status:set', 'stress', 250000)
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

RegisterNetEvent("inZone")
AddEventHandler("inZone",function(state)
  inzonestatus = state
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
	if not inzonestatus then
		status.remove(100)
		end
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
	if not inzonestatus then
		status.remove(100)
		end
	end)

	-- TriggerEvent('esx_status:registerStatus', 'stress', 500000, '#0C98F1', function(status)
	-- 	return Config.Visible
	-- end, function(status)
	-- 	status.add(35)
	-- end)

	--[[TriggerEvent('esx_status:registerStatus', 'health', 200, '#FFFF00', function(status) -- #CFAD0F -- Amarelo
		return Config.Visible
	end, function(status)
		status.set(GetEntityHealth(PlayerPedId()))
	end)]]--

	TriggerEvent('esx_status:registerStatus', 'armour', 100, '#0099FF', function(status) -- #0C98F1 -- Azul
		return Config.Visible
	end, function(status)
		status.set(GetPedArmour(PlayerPedId()))
	end)
end)

local canRun, blurryvision, blurrycooldown, stress, phase = true, false, false, 0, 0
AddEventHandler('esx_status:onTick', function(data)
	local playerPed  = PlayerPedId()
	local prevHealth = GetEntityHealth(playerPed)
	local health     = prevHealth
	
	for k, v in pairs(data) do
		if v.name == 'hunger' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'thirst' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'stress' then
			stress = v.val
		end
	end

	-- if stress == 1000000 and phase ~= 3 then
	-- 	TriggerEvent('kcmcity_stance:DefaultWalkStyle', true, 'drunk3')
	-- 	canRun = false
	-- 	blurryvision = 30000
	-- 	phase = 3
	-- elseif (stress >= 750000 and stress < 1000000) and phase ~= 2 then
	-- 	TriggerEvent('kcmcity_stance:DefaultWalkStyle', false, nil)
	-- 	canRun = false
	-- 	blurryvision = 45000
	-- 	phase = 2
	-- elseif (stress >= 500000 and stress < 750000) and phase ~= 1 then
	-- 	TriggerEvent('kcmcity_stance:DefaultWalkStyle', false, nil)
	-- 	canRun = true
	-- 	blurryvision = 60000
	-- 	phase = 1
	-- elseif stress < 500000 and phase ~= 0 then
	-- 	TriggerEvent('kcmcity_stance:DefaultWalkStyle', false, nil)
	-- 	canRun = true
	-- 	blurryvision = false
	-- 	phase = 0
	-- end
	
	if health ~= prevHealth then SetEntityHealth(playerPed, health) end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local letsleep = 1500
-- 		if stress >= 500000 then
-- 			local ped = PlayerPedId()
-- 			letsleep = 0

-- 			if canRun == false then
-- 				SetPedMoveRateOverride(ped, 0.0)
-- 			end

-- 			if blurryvision ~= false and blurrycooldown == false then
-- 				blurrycooldown = true
-- 				DoBlurry()
-- 			end
-- 		end

-- 		Wait(letsleep)
-- 	end
-- end)

function DoBlurry()
	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
	Wait(750)

	Wait(blurryvision)
	blurrycooldown = false
end

RegisterNetEvent('esx_basicneeds:onUse')
AddEventHandler('esx_basicneeds:onUse', function(type, add, name)
	if type == 'hunger' then
		TriggerServerEvent('esx_depencies:removeFood', name)
		exports.rprogress:Custom({
			Type = 'linear',
			Async = true,
			canCancel = true,       -- Allow cancelling
			x = 0.5,                -- Position on x-axis
			y = 0.9,                -- Position on y-axis
			From = 0,               -- Percentage to start from
			To = 100,               -- Percentage to end
			Duration = 2500,        -- Duration of the progress
			Radius = 60,            -- Radius of the dial
			Stroke = 10,            -- Thickness of the progress dial
			Cap = 'butt',           -- or 'round'
			Padding = 0,            -- Padding between the progress dial and the background dial
			MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
			Rotation = 0,           -- 2D rotation of the dial in degrees
			Width = 300,            -- Width of bar in px if Type = 'linear'
			Height = 40,            -- Height of bar in px if Type = 'linear'
			ShowTimer = true,       -- Shows the timer countdown within the radial dial
			ShowProgress = true,   -- Shows the progress % within the radial dial    
			Easing = "easeLinear",
			Label = "Makan",
			LabelPosition = "right",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			Animation = {
				animationDictionary = "mp_player_inteat@burger", -- https://alexguirre.github.io/animations-list/
				animationName = "mp_player_int_eat_burger_fp",
			},
			DisableControls = {
				Mouse = false,
				Player = false,
				Vehicle = true
			},
			onComplete = function(cancelled)
				if not cancelled then
					TriggerEvent('esx_status:add', type, add)
				end
				ClearPedTasks(PlayerPedId())
			end
		})
	elseif type == 'thirst' then
		TriggerServerEvent('esx_depencies:removeFood', name)
		exports.rprogress:Custom({
			Type = 'linear',
			Async = true,
			canCancel = true,       -- Allow cancelling
			x = 0.5,                -- Position on x-axis
			y = 0.9,                -- Position on y-axis
			From = 0,               -- Percentage to start from
			To = 100,               -- Percentage to end
			Duration = 2500,        -- Duration of the progress
			Radius = 60,            -- Radius of the dial
			Stroke = 10,            -- Thickness of the progress dial
			Cap = 'butt',           -- or 'round'
			Padding = 0,            -- Padding between the progress dial and the background dial
			MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
			Rotation = 0,           -- 2D rotation of the dial in degrees
			Width = 300,            -- Width of bar in px if Type = 'linear'
			Height = 40,            -- Height of bar in px if Type = 'linear'
			ShowTimer = true,       -- Shows the timer countdown within the radial dial
			ShowProgress = true,   -- Shows the progress % within the radial dial    
			Easing = "easeLinear",
			Label = "Minum",
			LabelPosition = "right",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			Animation = {
				animationDictionary = "mp_player_inteat@burger", -- https://alexguirre.github.io/animations-list/
				animationName = "mp_player_int_eat_burger_fp",
			},
			DisableControls = {
				Mouse = false,
				Player = false,
				Vehicle = true
			},
			onComplete = function(cancelled)
				if not cancelled then
					TriggerEvent('esx_status:add', type, add)
				end
				ClearPedTasks(PlayerPedId())
			end
		})
	-- elseif type == 'stress' then 
	-- 	TriggerServerEvent('esx_depencies:removeFood', name)
	-- 	exports.rprogress:Custom({
	-- 		Async = true,
	-- 		canCancel = true,       -- Allow cancelling
	-- 		x = 0.5,                -- Position on x-axis
	-- 		y = 0.5,                -- Position on y-axis
	-- 		From = 0,               -- Percentage to start from
	-- 		To = 100,               -- Percentage to end
	-- 		Duration = 2500,        -- Duration of the progress
	-- 		Radius = 60,            -- Radius of the dial
	-- 		Stroke = 10,            -- Thickness of the progress dial
	-- 		Cap = 'butt',           -- or 'round'
	-- 		Padding = 0,            -- Padding between the progress dial and the background dial
	-- 		MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
	-- 		Rotation = 0,           -- 2D rotation of the dial in degrees
	-- 		Width = 300,            -- Width of bar in px if Type = 'linear'
	-- 		Height = 40,            -- Height of bar in px if Type = 'linear'
	-- 		ShowTimer = true,       -- Shows the timer countdown within the radial dial
	-- 		ShowProgress = true,   -- Shows the progress % within the radial dial    
	-- 		Easing = "easeLinear",
	-- 		Label = "Minum",
	-- 		LabelPosition = "right",
	-- 		Color = "rgba(255, 255, 255, 1.0)",
	-- 		BGColor = "rgba(0, 0, 0, 0.4)",
	-- 		Animation = {
	-- 			animationDictionary = "mp_player_inteat@burger", -- https://alexguirre.github.io/animations-list/
	-- 			animationName = "mp_player_int_eat_burger_fp",
	-- 		},
	-- 		DisableControls = {
	-- 			Mouse = false,
	-- 			Player = false,
	-- 			Vehicle = true
	-- 		},
	-- 		onComplete = function(cancelled)
	-- 			if not cancelled then
	-- 				TriggerEvent('esx_status:remove', type, add)
	-- 			end
	-- 			ClearPedTasks(PlayerPedId())
	-- 		end
	-- 	})
	end
end)