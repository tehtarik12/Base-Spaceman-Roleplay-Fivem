isBusy = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- CreateThread(function()
-- 	for k,v in pairs(Config) do
-- 		local blip = AddBlipForCoord(Config.Blip.Coords)
-- 		local blip2 = AddBlipForCoord(Config.Blip.Coords2)


-- 		SetBlipSprite (blip, Config.Blip.Sprite)
-- 		SetBlipDisplay(blip, Config.Blip.Display)
-- 		SetBlipScale  (blip, 0.8)
-- 		SetBlipColour (blip, Config.Blip.Colour)
-- 		SetBlipAsShortRange(blip, true)

-- 		SetBlipSprite (blip2, Config.Blip.Sprite)
-- 		SetBlipDisplay(blip2, Config.Blip.Display)
-- 		SetBlipScale  (blip2, 0.8)
-- 		SetBlipColour (blip2, Config.Blip.Colour)
-- 		SetBlipAsShortRange(blip2, true)

-- 		BeginTextCommandSetBlipName('STRING')
-- 		AddTextComponentSubstringPlayerName('Ladang Micin')
-- 		EndTextCommandSetBlipName(blip)

-- 		BeginTextCommandSetBlipName('STRING')
-- 		AddTextComponentSubstringPlayerName('Ladang Kecubung')
-- 		EndTextCommandSetBlipName(blip2)

-- 	end
-- end)


CreateThread(function()
	for k,v in pairs(cfg.blip) do
		if k == 'sell' then
			for k2,v2 in pairs(v.selllocation) do
				exports['ped_spawner']:addPed('a_m_m_beach_01', v2[1], v2[2], 'male', false, nil, v2[3])
				exports.qtarget:AddBoxZone(k2, v2[1], 2.0, 2.0, {
					name=k2,
					heading=v2[2],
					debugPoly=false,
					minZ=v2[1].z - 2.0,
					maxZ=v2[1].z + 2.0,
					}, {
					options = {
						{
							event = "vinsan_drug:Sell",
							index = k2,
							icon = "fas fa-dumbbell",
							label = v2[3],
						},
					},
					distance = 3.5
				})
			end
		end
	end
end)

AddEventHandler('vinsan_drug:Sell', function(data)
	if not isBusy then
		isBusy = true
		exports.rprogress:Custom({
			Type = 'linear',
			Async = true,
			canCancel = true,       -- Allow cancelling
			x = 0.5,                -- Position on x-axis
			y = 0.9,                -- Position on y-axis
			From = 0,               -- Percentage to start from
			To = 100,               -- Percentage to end
			Duration = 1000,        -- Duration of the progress
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
			Label = "Menjual Barang",
			LabelPosition = "right",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			Animation = {
				scenario = "WORLD_HUMAN_CLIPBOARD",
			},
			DisableControls = {
				Mouse = false,
				Player = true,
				Vehicle = true
			},
			onComplete = function(cancelled)
				isBusy = false
				if not cancelled then
					TriggerServerEvent("vinsan_drug:Sell", data.index)
				end
				ClearPedTasks(PlayerPedId())
			end
		})
	end
end)



CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
		local pos = (cfg.blip['Kecubung'].process)
		-- local pos2 = (cfg.blip['W'].process2)
		local dist = #(Coords - pos)
		-- local dist2 = #(Coords - pos2)
        if dist < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['Kecubung'], pos)
            if IsControlJustPressed(0, 38) and dist < 3 then
                isBusy = true
                exports.rprogress:Custom({
					Type = 'linear',
					Async = true,
					canCancel = false,       -- Allow cancelling
					x = 0.5,                -- Position on x-axis
					y = 0.9,                -- Position on y-axis
					From = 0,               -- Percentage to start from
					To = 100,               -- Percentage to end
					Duration = 5000,        -- Duration of the progress
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
					Label = "Memproses Kecubung",
					LabelPosition = "right",
					Color = "rgba(255, 255, 255, 1.0)",
					BGColor = "rgba(0, 0, 0, 0.4)",
					Animation = {
						scenario = "world_human_gardener_plant",
					},
					DisableControls = {
						Mouse = false,
						Player = true,
						Vehicle = true
					},
					onComplete = function(cancelled)
                        
						if not cancelled then
                            TriggerServerEvent("vinsan_drug:processItem", 'kecubungmentah')
						end
						
						ClearPedTasks(PlayerPedId())
						Wait(550)
						isBusy = false
					end
				})
                Wait(2000)
            end
        end
        Wait(cas)
	end
end)

CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
		local pos = (cfg.blip['Micin'].process)
		-- local pos2 = (cfg.blip['W'].process2)
		local dist = #(Coords - pos)
		-- local dist2 = #(Coords - pos2)
        if dist < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['Micin'], pos)
            if IsControlJustPressed(0, 38) and dist < 3 then
                isBusy = true
                exports.rprogress:Custom({
					Type = 'linear',
					Async = true,
					canCancel = false,       -- Allow cancelling
					x = 0.5,                -- Position on x-axis
					y = 0.9,                -- Position on y-axis
					From = 0,               -- Percentage to start from
					To = 100,               -- Percentage to end
					Duration = 5000,        -- Duration of the progress
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
					Label = "Memproses Micin",
					LabelPosition = "right",
					Color = "rgba(255, 255, 255, 1.0)",
					BGColor = "rgba(0, 0, 0, 0.4)",
					Animation = {
						scenario = "WORLD_HUMAN_CLIPBOARD",
					},
					DisableControls = {
						Mouse = false,
						Player = true,
						Vehicle = true
					},
					onComplete = function(cancelled)
						if not cancelled then
                            TriggerServerEvent("vinsan_drug:processItem2", 'micinmentah')
						end
						ClearPedTasks(PlayerPedId())
						Wait(1000)
						isBusy = false
					end
				})
                Wait(1000)
            end
        end
        Wait(cas)
	end
end)





ShowFloatingHelpNotification = function(msg, pos)
    AddTextEntry('text', msg)
    SetFloatingHelpTextWorldPosition(1, pos.x, pos.y, pos.z)
    SetFloatingHelpTextStyle(2, 1, 25, -1, 3, 0)
    BeginTextCommandDisplayHelp('text')
    EndTextCommandDisplayHelp(2, false, false, -1)
end