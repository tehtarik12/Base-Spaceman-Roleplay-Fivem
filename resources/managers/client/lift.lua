------- Add appartments and their positions here

appartements = {
	{
		appts = {
			{name = "[Lantai 3] Helipad", x = -774.0527, y = -1207.451, z = 50.13403, h = 323.1496},
			{name = "[Lantai G] Lobby", x = -797.8154, y = -1250.387, z = 6.324585, h = 51.02362},
		}
	},
	{
		appts = {
			{name = "[Lantai G] Lobby", x = -797.8154, y = -1250.387, z = 6.324585, h = 51.02362},
			{name = "[Lantai 3] Helipad", x = -774.0527, y = -1207.451, z = 50.13403, h = 323.1496},
		}
	}
}




local nameTimer = 0
local nameOnScreen = false
local nameText = ""

function ShowHelp(text)
	Citizen.InvokeNative(0x8509B634FBE7DA11, "STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayHelp(0, false, 1, 0)
end

function DrawSub(text)
	SetTextFont(1)
	SetTextScale(0.7, 0.7)
	SetTextColour(255, 255, 255, 255)
	SetTextWrap(0.2,  0.8)
	SetTextCentre(1)
	SetTextOutline(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.8, 0.9)
end

function Teleport(x, y, z, h)
	local e = GetPlayerPed(-1)
	DoScreenFadeOut(800)
	while not IsScreenFadedOut() do
		Wait(10)
	end
	SetEntityCoordsNoOffset(e, x + 0.0, y + 0.0, z + 1.5, 0, 0, 1)
	SetEntityHeading(e, h + 0.0)
	Wait(500)
	DoScreenFadeIn(800)
	while not IsScreenFadedIn() do
		Wait(10)
	end
end

function ShowName(name)
	nameText = name
	nameTimer = GetGameTimer() + 5000
	nameOnScreen = true
end

AddEventHandler("oktPkFzUb", function(apid, id)
	Teleport(appartements[apid].appts[id].x, appartements[apid].appts[id].y, appartements[apid].appts[id].z, appartements[apid].appts[id].h)
	ShowName(appartements[apid].appts[id].name)
end)



Citizen.CreateThread(function()
	while true do
		local letsleep = 2000
		local pedPos = GetEntityCoords(PlayerPedId(), 0)

        if IsPedOnFoot(PlayerPedId()) then
            for id=1, #appartements do
                local appts = appartements[id].appts
                for appt=1, #appts do
                    local dist_in = #(vector3(appts[appt].x + 0.0, appts[appt].y + 0.0, appts[appt].z + 0.5) - pedPos)
                    if dist_in < 8 then
                        letsleep = 0
                        if dist_in <= 1.3 then
                            ShowHelp("Press ~INPUT_VEH_HORN~ to select floor.")
                            if IsControlJustReleased(0, 86) then
                                if #appartements[id].appts == 1 then
                                    Teleport(appartements[id].appts[1].x, appartements[id].appts[1].y, appartements[id].appts[1].z, appartements[id].appts[1].h)
                                    ShowName(appartements[id].appts[1].name)
                                else
                                    ShowMenu(id, appartements[id].appts)
                                end
                            end
                        end
                        DrawMarker(20, appts[appt].x + 0.0, appts[appt].y + 0.0, appts[appt].z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 160, 255, 90, 0, 0, 2, 0, 0, 0, 0)
                    end
                end
            end

            if nameOnScreen then
                if GetGameTimer() < nameTimer then
                    DrawSub(nameText)
                else
					CloseMenu()
                    nameOnScreen = false
                end
            end
        end

        Citizen.Wait(letsleep)
	end
end)

