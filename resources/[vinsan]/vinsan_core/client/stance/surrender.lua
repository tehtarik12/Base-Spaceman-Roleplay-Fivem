local surrender = false
function loadAnimDict(dict)
    while ( not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

RegisterCommand('k', function()
    local ped = PlayerPedId()
	if not IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3) then 
        loadAnimDict("random@arrests")
		loadAnimDict("random@arrests@busted")
		if IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then 
			TaskPlayAnim(ped, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait(3000)
            TaskPlayAnim(ped, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
        else
            TaskPlayAnim(ped, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait(4000)
            TaskPlayAnim(ped, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait(500)
			TaskPlayAnim(ped, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			Wait(1000)
			TaskPlayAnim(ped, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(PlayerPedId(), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		else
			Citizen.Wait(1000)
		end
	end
end)