local notified = false
local lastNotified = 0

local banks = {
	{name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", id=108, x=-351.534, y=-49.529, z=49.042}, 
	{name="Bank", id=108, x=241.610, y=225.120, z=106.286},
	{name="Bank", id=108, x=1175.064, y=2706.643, z=38.094}
}	


RegisterNetEvent("gb-banking:ExtNotify")
AddEventHandler("gb-banking:ExtNotify", function(msg)
	if (not msg or msg == "") then return end
	
	ESX.ShowNotification(msg)
end)

--[[ Show Things ]]--
Citizen.CreateThread(function()
	for k,v in ipairs(banks) do
	  local blip = AddBlipForCoord(v.x, v.y, v.z)
	  SetBlipSprite(blip, v.id)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 0.8)
	  SetBlipColour (blip, 2)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(''..tostring(v.name))
	  EndTextCommandSetBlipName(blip)
	end
end)


RegisterNetEvent('gb-banking:bank:openUI')
AddEventHandler('gb-banking:bank:openUI', function() -- this one bank from target models
	if not bMenuOpen then
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
			Label = "Mengakses Bank",
			LabelPosition = "right",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			Animation = {
				animationDictionary = "amb@prop_human_atm@male@enter", -- https://alexguirre.github.io/animations-list/
				animationName = "enter",
			},
			DisableControls = {
				Mouse = true,
				Player = true,
				Vehicle = true
			},
			onComplete = function(cancelled)
				if not cancelled then
					ToggleUI()
				end
				ClearPedTasks(PlayerPedId())
			end
		})
	end
end)

RegisterNetEvent('gb-banking:atm:openUI')
AddEventHandler('gb-banking:atm:openUI', function() -- this opens ATM
	if not bMenuOpen then
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
			Label = "Mengakses ATM",
			LabelPosition = "right",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			Animation = {
				animationDictionary = "amb@prop_human_atm@male@enter", -- https://alexguirre.github.io/animations-list/
				animationName = "enter",
			},
			DisableControls = {
				Mouse = true,
				Player = true,
				Vehicle = true
			},
			onComplete = function(cancelled)
				if not cancelled then
					ToggleUI()
				end
				ClearPedTasks(PlayerPedId())
			end
		})	 
	end
end)

local ATMS = {
    -1364697528, --red
   -1126237515, --blue
   -870868698, --blue
   506770882, --green
   150237004, --green
   -239124254, --green
}


exports['qtarget']:AddTargetModel(ATMS, {
    options = {
            {
                event = "gb-banking:atm:openUI",
                icon = "fas fa-money-check",
                label = "Access ATM",
            },
        },
        distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank1", vector3(149.07, -1041.16, 29.54), 1.5, 4.5, {
	name = "Bank1",
	heading = 160,
	debugPoly = false,
	minZ = 28,
	maxZ = 30.5,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank2", vector3(-1212.98, -331.53, 38.24), 1.5, 4.5, {
	name = "Bank2",
	heading = 206,
	debugPoly = false,
	minZ = 37,
	maxZ = 39,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank3", vector3(-2962.16, 482.17, 15.7), 1.5, 4.5, {
	name = "Bank3",
	heading = 269,
	debugPoly = false,
	minZ = 15,
	maxZ = 18,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank4", vector3(-112.29, 6469.38, 31.63), 1.5, 4.5, {
	name = "Bank4",
	heading = 316,
	debugPoly = false,
	minZ = 31,
	maxZ = 33,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank5", vector3(313.56, -279.7, 54.8), 1.5, 4.5, {
	name = "Bank5",
	heading = 160,
	debugPoly = false,
	minZ = 53,
	maxZ = 55,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank6", vector3(-351.51, -49.8, 49.04), 1.5, 4.5, {
	name = "Bank6",
	heading = 160,
	debugPoly = false,
	minZ = 49,
	maxZ = 50,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("Bank7", vector3(1175.92, 2707.86, 38.09), 1.5, 4.5, {
	name = "Bank7",
	heading = 359.73,
	debugPoly = false,
	minZ = 37,
	maxZ = 39,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})

exports['qtarget']:AddBoxZone("BigBank", vector3(242.41, 225.03, 106.29), 1.5, 4.5, {
	name = "BigBank",
	heading = 342.44,
	debugPoly = false,
	minZ = 105,
	maxZ = 108,
	}, {
		options = {
			{
            	event = "gb-banking:bank:openUI",
				icon = "fas fa-piggy-bank",
				label = "Bankmenu",
			},
		},
		distance = 2.5
})
