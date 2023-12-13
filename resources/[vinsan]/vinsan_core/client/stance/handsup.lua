local hasHandsUp = false

RegisterCommand('handsup', function()
    local playerPed = PlayerPedId()
    if IsEntityPlayingAnim(PlayerPedId(), 'dead', 'dead_a', 3) then return end
    if hasHandsUp then
        ClearPedTasks(playerPed)
        hasHandsUp = false
    else
        if not IsPedSwimming(playerPed) and not IsPedShooting(playerPed) and not IsPedArmed(playerPed, 4) and not IsPedClimbing(playerPed) and not IsPedCuffed(playerPed) and not IsPedDiving(playerPed) and not IsPedFalling(playerPed) and not IsPedJumping(playerPed) and not IsPedJumpingOutOfVehicle(playerPed) and IsPedOnFoot(playerPed) and not IsPedRunning(playerPed) and not IsPedUsingAnyScenario(playerPed) and not IsPedInParachuteFreeFall(playerPed) and not IsEntityDead(playerPed) then
            --SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)

            RequestAnimDict("random@mugging3")
            while not HasAnimDictLoaded("random@mugging3") do
                Citizen.Wait(5)
            end

            if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedSwimming(PlayerPedId()) and not IsPedShooting(PlayerPedId()) and not IsPedClimbing(PlayerPedId()) and not IsPedCuffed(PlayerPedId()) and not IsPedDiving(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedJumping(PlayerPedId()) and not IsPedJumpingOutOfVehicle(PlayerPedId()) and IsPedOnFoot(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInParachuteFreeFall(PlayerPedId()) then
                TaskPlayAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", 2.0, 2.0, -1, 50, 0, false, false, false)
            end
            hasHandsUp = true
        end
    end
end)

RegisterKeyMapping('handsup', '[SC] Handsup', 'keyboard', 'X')