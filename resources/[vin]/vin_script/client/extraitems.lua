RegisterNetEvent('vinsan_core:bulletproof')
AddEventHandler('vinsan_core:bulletproof', function(type)
	local playerPed = PlayerPedId()
    local inventory = exports.ox_inventory:Search('count', {'rompi', 'armor', 'gummy', 'micinjadi', 'kecubungjadi'})
    if inventory[type] > 0 then 
        if type == 'rompi'then
			TriggerServerEvent('vinsan_core:removeItem', type)
            exports.rprogress:Custom({
                Type = 'linear',
                Async = true,
                canCancel = true,       -- Allow cancelling
                x = 0.5,                -- Position on x-axis
                y = 0.9,                -- Position on y-axis
                From = 0,               -- Percentage to start from
                To = 100,               -- Percentage to end
                Duration = 4000,        -- Duration of the progress
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
                Label = "Menggunakan Rompi",
                LabelPosition = "Right",
                Color = "rgba(255, 255, 255, 1.0)",
                BGColor = "rgba(0, 0, 0, 0.4)",
                Animation = {
                    animationDictionary = "missmic4", -- https://alexguirre.github.io/animations-list/
                    animationName = "michael_tux_fidget",
                },
                DisableControls = {
                    Mouse = false,
                    Player = false,
                    Vehicle = true
                },
                onComplete = function(cancelled)
                    if not cancelled then
                        AddArmourToPed(playerPed, 90)
						kantongsibuk = false
                    end
                    ClearPedTasks(PlayerPedId())
                end
            })    
            elseif type == 'armor' then
                TriggerServerEvent('vinsan_core:removeItem', type)
                exports.rprogress:Custom({
                    Type = 'linear',
                    Async = true,
                    canCancel = true,       -- Allow cancelling
                    x = 0.5,                -- Position on x-axis
                    y = 0.9,                -- Position on y-axis
                    From = 0,               -- Percentage to start from
                    To = 100,               -- Percentage to end
                    Duration = 4000,        -- Duration of the progress
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
                    Label = "Menggunakan Armor",
                    LabelPosition = "bottom",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
                    Animation = {
                        animationDictionary = "missmic4", -- https://alexguirre.github.io/animations-list/
                        animationName = "michael_tux_fidget",
                    },
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = true
                    },
                    onComplete = function(cancelled)
                        if not cancelled then
                            AddArmourToPed(playerPed, 100)
                        end
                        ClearPedTasks(PlayerPedId())
                    end
                })
				elseif type == 'kecubungjadi' then
                TriggerServerEvent('vinsan_core:removeItem', type)
                exports.rprogress:Custom({
                    Type = 'linear',
                    Async = true,
                    canCancel = true,       -- Allow cancelling
                    x = 0.5,                -- Position on x-axis
                    y = 0.9,                -- Position on y-axis
                    From = 0,               -- Percentage to start from
                    To = 100,               -- Percentage to end
                    Duration = 1500,        -- Duration of the progress
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
                    Label = "Menggunakan Kecubung",
                    LabelPosition = "bottom",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
                    Animation = {
                        animationDictionary = "missmic4", -- https://alexguirre.github.io/animations-list/
                        animationName = "michael_tux_fidget",
                    },
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = true
                    },
                    onComplete = function(cancelled)
                        if not cancelled then
                            AddArmourToPed(playerPed, 5)
                        end
                        ClearPedTasks(PlayerPedId())
                    end
                })
				elseif type == 'micinjadi' then
                TriggerServerEvent('vinsan_core:removeItem', type)
                exports.rprogress:Custom({
                    Type = 'linear',
                    Async = true,
                    canCancel = true,       -- Allow cancelling
                    x = 0.5,                -- Position on x-axis
                    y = 0.9,                -- Position on y-axis
                    From = 0,               -- Percentage to start from
                    To = 100,               -- Percentage to end
                    Duration = 10000,        -- Duration of the progress
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
                    Label = "Menggunakan Armor",
                    LabelPosition = "bottom",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
                    Animation = {
                        animationDictionary = "missmic4", -- https://alexguirre.github.io/animations-list/
                        animationName = "michael_tux_fidget",
                    },
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = true
                    },
                    onComplete = function(cancelled)
                        if not cancelled then
                        end
                        ClearPedTasks(PlayerPedId())
                    end
                })
            end
         end
    end)

RegisterNetEvent('vin-script:onMicin')
AddEventHandler('vin-script:onMicin', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end    
    exports['mythic_notify']:DoHudText('success', 'You took some coke!')
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
	SetTimecycleModifier("spectator5")
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
	SetPedIsDrunk(playerPed, true)
	Citizen.Wait(20000)
    SetTimecycleModifierStrength(0.0)
	ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
	SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
	SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    Citizen.Wait(60000)
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
end)