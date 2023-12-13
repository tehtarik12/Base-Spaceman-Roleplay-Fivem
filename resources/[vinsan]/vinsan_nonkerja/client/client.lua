isBusy = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
	for k,v in pairs(cfg.blip) do
		if v.process then
			local blip = AddBlipForCoord(v.process)
			AddTextEntry('blip', v.processname)
			SetBlipSprite(blip, 365)
			SetBlipColour(blip, 5)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.8)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('blip')
			EndTextCommandSetBlipName(blip)
		end
		if v.process2 then
			local blip = AddBlipForCoord(v.process2)
			AddTextEntry('blip', v.processname2)
			SetBlipSprite(blip, 374)
			SetBlipColour(blip, 3)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.5)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('blip')
			EndTextCommandSetBlipName(blip)
		end
		if v.blip then
			local blip = AddBlipForCoord(v.blip)
			AddTextEntry('blip', v.blipname)
			SetBlipSprite(blip, 171)
			SetBlipColour(blip, 2)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.5)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('blip')
			EndTextCommandSetBlipName(blip)
		end
		if k == 'sell' then
			for k2,v2 in pairs(v.selllocation) do
				exports['ped_spawner']:addPed('a_f_m_fatbla_01', v2[1], v2[2], 'female', false, nil, v2[3])
				exports.qtarget:AddBoxZone(k2, v2[1], 2.0, 2.0, {
					name=k2,
					heading=v2[2],
					debugPoly=false,
					minZ=v2[1].z - 2.0,
					maxZ=v2[1].z + 2.0,
					}, {
					options = {
						{
							event = "vinsan_nonkerja:Sell",
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

AddEventHandler('vinsan_nonkerja:Sell', function(data)
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
			Duration = 30000,        -- Duration of the progress
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
					TriggerServerEvent("vinsan_jobs:Sell", data.index)
				end
				ClearPedTasks(PlayerPedId())
			end
		})
	end
end)

AddEventHandler('vinsan_nonkerja:farmer', function(item)
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
		Label = "Mengemas Barang",
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
				TriggerServerEvent("vinsan_jobs:processItem", item)
			end
			ClearPedTasks(PlayerPedId())
		end
	})
end)

-- CreateThread(function()
-- 	while true do
--         cas = 1000
-- 		local playerPed = PlayerPedId()
--         local Coords = GetEntityCoords(PlayerPedId())
--         local pos = (cfg.blip['farmer'].process)
-- 		local dist = #(Coords - pos)
--         if dist < 5 and not isBusy then
--             cas = 5
--             ShowFloatingHelpNotification(cfg.translation['farmer'], pos)
--             if IsControlJustPressed(0, 38) and dist < 3 then
-- 				lib.registerContext({
-- 					id = 'farmerproccesing',
-- 					title = 'Farmer proccesing',
-- 					options = {
-- 						['Mengemas Jeruk'] = {
-- 							event = 'vinsan_nonkerja:farmer',
-- 							args = 'jeruk'
-- 						},
-- 						['Mengemas Padi'] = {
-- 							event = 'vinsan_nonkerja:farmer',
-- 							args = 'padi'
-- 						},
-- 						['Mengemas Ubi'] = {
-- 							event = 'vinsan_nonkerja:farmer',
-- 							args = 'ubi'
-- 						}
-- 					}
-- 				})
-- 				lib.showContext('farmerproccesing')
--                 Wait(250)
--             end
--         end
--         Wait(cas)
-- 	end
-- end)

CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
		local pos = (cfg.blip['stone'].process)
		local pos2 = (cfg.blip['stone'].process2)
		local dist = #(Coords - pos)
		local dist2 = #(Coords - pos2)
        if dist < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['stone'], pos)
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
					Label = "Memproses Batu Kasar",
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
                            TriggerServerEvent("vinsan_jobs:processItem", 'batukasar')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
            end
        end
		if dist2 < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['stone'], pos2)
            if IsControlJustPressed(0, 38) and dist2 < 3 then
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
					Label = "Memproses Batu Halus",
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
                            TriggerServerEvent("vinsan_jobs:processItem2", 'batuhalus')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
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
		local pos = (cfg.blip['tree'].process)
		local pos2 = (cfg.blip['tree'].process2)
		local dist = #(Coords - pos)
		local dist2 = #(Coords - pos2)
        if dist < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['tree'], pos)
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
					Label = "Memproses Batang Kayu",
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
                            TriggerServerEvent("vinsan_jobs:processItem", 'batangkayu')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
            end
        end
		if dist2 < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['tree'], pos2)
            if IsControlJustPressed(0, 38) and dist2 < 3 then
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
					Label = "Mengemas Papan",
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
                            TriggerServerEvent("vinsan_jobs:processItem2", 'prosesbatangkayu')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
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
		local pos = (cfg.blip['tailor'].process)
		local pos2 = (cfg.blip['tailor'].process2)
		local dist = #(Coords - pos)
		local dist2 = #(Coords - pos2)
        if dist < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['tailor'], pos)
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
					Label = "Memproses Wol",
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
                            TriggerServerEvent("vinsan_jobs:processItem", 'kapas')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
            end
        end
		if dist2 < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['tailor2'], pos2)
            if IsControlJustPressed(0, 38) and dist2 < 3 then
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
					Label = "Memproses Katun",
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
                            TriggerServerEvent("vinsan_jobs:processItem2", 'katun')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
            end
        end
        Wait(cas)
	end
end)

-- CreateThread(function()
-- 	while true do
--         cas = 1000
-- 		local playerPed = PlayerPedId()
--         local Coords = GetEntityCoords(PlayerPedId())
-- 		local pos = (cfg.blip['cow'].process)
-- 		local pos2 = (cfg.blip['cow'].process2)
-- 		local dist = #(Coords - pos)
-- 		local dist2 = #(Coords - pos2)
--         if dist < 5 and not isBusy then
--             cas = 5
--             ShowFloatingHelpNotification(cfg.translation['cow'], pos)
--             if IsControlJustPressed(0, 38) and dist < 3 then
--                 isBusy = true
--                 exports.rprogress:Custom({
-- 					Async = true,
-- 					canCancel = false,       -- Allow cancelling
-- 					x = 0.5,                -- Position on x-axis
-- 					y = 0.5,                -- Position on y-axis
-- 					From = 0,               -- Percentage to start from
-- 					To = 100,               -- Percentage to end
-- 					Duration = 5000,        -- Duration of the progress
-- 					Radius = 60,            -- Radius of the dial
-- 					Stroke = 10,            -- Thickness of the progress dial
-- 					Cap = 'butt',           -- or 'round'
-- 					Padding = 0,            -- Padding between the progress dial and the background dial
-- 					MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
-- 					Rotation = 0,           -- 2D rotation of the dial in degrees
-- 					Width = 300,            -- Width of bar in px if Type = 'linear'
-- 					Height = 40,            -- Height of bar in px if Type = 'linear'
-- 					ShowTimer = true,       -- Shows the timer countdown within the radial dial
-- 					ShowProgress = true,   -- Shows the progress % within the radial dial    
-- 					Easing = "easeLinear",
-- 					Label = "Memproses Daging Mentah",
-- 					LabelPosition = "right",
-- 					Color = "rgba(255, 255, 255, 1.0)",
-- 					BGColor = "rgba(0, 0, 0, 0.4)",
-- 					Animation = {
-- 						scenario = "WORLD_HUMAN_CLIPBOARD",
-- 					},
-- 					DisableControls = {
-- 						Mouse = false,
-- 						Player = true,
-- 						Vehicle = true
-- 					},
-- 					onComplete = function(cancelled)
--                         isBusy = false
-- 						if not cancelled then
--                             TriggerServerEvent("vinsan_jobs:processItem", 'dagingmentah')
-- 						end
-- 						ClearPedTasks(PlayerPedId())
-- 					end
-- 				})
--                 Wait(250)
--             end
--         end
-- 		if dist2 < 5 and not isBusy then
--             cas = 5
--             ShowFloatingHelpNotification(cfg.translation['cow2'], pos2)
--             if IsControlJustPressed(0, 38) and dist2 < 3 then
--                 isBusy = true
--                 exports.rprogress:Custom({
-- 					Async = true,
-- 					canCancel = false,       -- Allow cancelling
-- 					x = 0.5,                -- Position on x-axis
-- 					y = 0.5,                -- Position on y-axis
-- 					From = 0,               -- Percentage to start from
-- 					To = 100,               -- Percentage to end
-- 					Duration = 5000,        -- Duration of the progress
-- 					Radius = 60,            -- Radius of the dial
-- 					Stroke = 10,            -- Thickness of the progress dial
-- 					Cap = 'butt',           -- or 'round'
-- 					Padding = 0,            -- Padding between the progress dial and the background dial
-- 					MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
-- 					Rotation = 0,           -- 2D rotation of the dial in degrees
-- 					Width = 300,            -- Width of bar in px if Type = 'linear'
-- 					Height = 40,            -- Height of bar in px if Type = 'linear'
-- 					ShowTimer = true,       -- Shows the timer countdown within the radial dial
-- 					ShowProgress = true,   -- Shows the progress % within the radial dial    
-- 					Easing = "easeLinear",
-- 					Label = "Mengemas Daging",
-- 					LabelPosition = "right",
-- 					Color = "rgba(255, 255, 255, 1.0)",
-- 					BGColor = "rgba(0, 0, 0, 0.4)",
-- 					Animation = {
-- 						scenario = "WORLD_HUMAN_CLIPBOARD",
-- 					},
-- 					DisableControls = {
-- 						Mouse = false,
-- 						Player = true,
-- 						Vehicle = true
-- 					},
-- 					onComplete = function(cancelled)
--                         isBusy = false
-- 						if not cancelled then
--                             TriggerServerEvent("vinsan_jobs:processItem2", 'dagingpotong')
-- 						end
-- 						ClearPedTasks(PlayerPedId())
-- 					end
-- 				})
--                 Wait(250)
--             end
--         end
--         Wait(cas)
-- 	end
-- end)

CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
		local pos = (cfg.blip['oil'].process)
		local pos2 = (cfg.blip['oil'].process2)
		local dist = #(Coords - pos)
		local dist2 = #(Coords - pos2)
        if dist < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['oil'], pos)
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
					Label = "Memproses Minyak Mentah",
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
                            TriggerServerEvent("vinsan_jobs:processItem", 'minyakmentah')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
            end
        end
		if dist2 < 5 and not isBusy then
            cas = 5
            ShowFloatingHelpNotification(cfg.translation['oil'], pos2)
            if IsControlJustPressed(0, 38) and dist2 < 3 then
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
					Label = "Mengemas Minyak Olahan",
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
                            TriggerServerEvent("vinsan_jobs:processItem2", 'prosesminyakmentah')
						end
						ClearPedTasks(PlayerPedId())
					end
				})
                Wait(250)
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