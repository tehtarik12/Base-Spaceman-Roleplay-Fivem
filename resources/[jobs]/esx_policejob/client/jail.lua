-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
--		   	Created By: qalle-fivem AKA qalle		      --
--			 Protected By: ATG-Github AKA ATG			  --
-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local jailTime = 0

RegisterNetEvent("kcmcity_whitelistjob:UpdateJail")
AddEventHandler("kcmcity_whitelistjob:UpdateJail", function(time)
	jailTime = time

	if jailTime == 0 then
		UnJail()
	end
end)

RegisterNetEvent("kcmcity_whitelistjob:jailPlayer")
AddEventHandler("kcmcity_whitelistjob:jailPlayer", function(newJailTime)
	jailTime = newJailTime

	Cutscene()
end)

RegisterNetEvent("kcmcity_whitelistjob:StartJail")
AddEventHandler("kcmcity_whitelistjob:StartJail", function(LoginTimer)
	jailTime = LoginTimer
	local JailPosition = Config.JailPositions["Cell" .. math.random(1,3)]
	ESX.Game.Teleport(PlayerPedId(), {x = JailPosition["x"], y = JailPosition["y"], z = JailPosition["z"]}, function()
		SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"])
	end)

	ESX.ShowNotification("Last time you went to sleep you were jailed, because of that you are now put back!")

	InJail()
end)

function UnJail()
	jailTime = 0

	local JailPosition = Config.JailPositions["Boiling Broke"]
	ESX.Game.Teleport(PlayerPedId(), {x = JailPosition["x"], y = JailPosition["y"], z = JailPosition["z"]}, function()
		SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"])
	end)

	--[[ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end) ]]

	ESX.ShowNotification("You are released, stay calm outside! Good Luck!")
end

function InJail()
	Citizen.CreateThread(function()
		while jailTime > 0 do
			local JailPosition = Config.JailPositions["Cell1"]
			local playerCoords = GetEntityCoords(PlayerPedId())
			jailTime = jailTime - 1


			if #(playerCoords - vector3(JailPosition["x"], JailPosition["y"], JailPosition["z"])) > 100.0 then
				ESX.Game.Teleport(PlayerPedId(), {x = JailPosition["x"], y = JailPosition["y"], z = JailPosition["z"]}, function()
					SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"])
				end)
			end

			ESX.ShowNotification("You have " .. jailTime .. " minutes left in jail!")

			if jailTime == 0 then
				UnJail()
				TriggerServerEvent("kcmcity_whitelistjob:updateJailTime", 0)
				break
			else
				TriggerServerEvent("kcmcity_whitelistjob:updateJailTime", jailTime)
			end

			Citizen.Wait(60000)
		end
	end)
end

function Cutscene()
	local PlayerPed = PlayerPedId()
	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	local JailPosition = Config.JailPositions["Cell" .. math.random(1,3)]

	FreezeEntityPosition(PlayerPed, true)

	DoScreenFadeOut(100)

	Citizen.Wait(250)

	TriggerEvent('skinchanger:getSkin', function(skin)
		if `GetEntityModel(PlayerPedId())` == `mp_m_freemode_01` then
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 5, ['torso_2'] = 0,
				['arms'] = 5,
				['pants_1'] = 3, ['pants_2'] = 7,
				['shoes_1'] = 5, ['shoes_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		elseif `GetEntityModel(PlayerPedId())` == `mp_f_freemode_01` then
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 2, ['torso_2'] = 0,
				['arms'] = 2,
				['pants_1'] = 3, ['pants_2'] = 15,
				['shoes_1'] = 5, ['shoes_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)

	ESX.Game.Teleport(PlayerPed, {x = PlayerPosition["x"], y = PlayerPosition["y"], z = PlayerPosition["z"] - 1, heading = PlayerPosition["h"]}, function()
		SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
		SetEntityHeading(PlayerPed, PlayerPosition["h"])

		Cam()
	end)
	ExecuteCommand('e mugshot')
	Citizen.Wait(1000)
	DoScreenFadeIn(100)
	Citizen.Wait(10000)
	DoScreenFadeOut(250)

	ESX.Game.Teleport(PlayerPed, {x = JailPosition["x"], y = JailPosition["y"], z = JailPosition["z"]}, function()
		SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	end)

	Citizen.Wait(1000)
	DoScreenFadeIn(250)

	TriggerEvent('InteractSound_CL:PlayOnOne', 'cell', 0.7)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPed, false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])

	InJail()
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.JailPositions["Boiling Broke"]["x"], Config.JailPositions["Boiling Broke"]["y"], Config.JailPositions["Boiling Broke"]["z"])

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Penjara Federal')
    EndTextCommandSetBlipName(blip)
end)