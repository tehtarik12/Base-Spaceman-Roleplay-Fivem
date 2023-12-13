local toggled = false
-- RegisterNetEvent("vinsan_vehkeys:ToggleLock")
function ToggleLock(entity)
    if (toggled) then return end
    toggled = true
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        toggled = false
    end)

    local vehInFront = GetVehicleInFront()
    local playerPed = PlayerPedId()
    if entity then vehInFront = entity end
    if (IsPedInAnyVehicle(playerPed, false)) then
        local seat, seatCount = GetSeatPedIsIn(playerPed)
        if (seat == -1 or seat == 0) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local lockState = not GetVehicleDoorsLockedForPlayer(vehicle, PlayerId())
            TriggerServerEvent('vinsan_vehkeys:CheckKey', vehicle, GetVehicleNumberPlateText(vehicle), lockState, GetVehicleClass(vehicle))
        end
    elseif (vehInFront ~= false) then
        local lockState = not GetVehicleDoorsLockedForPlayer(vehInFront, PlayerId())
        TriggerServerEvent('vinsan_vehkeys:CheckKey', vehInFront, GetVehicleNumberPlateText(vehInFront), lockState, GetVehicleClass(vehicle))
    end
end

RegisterNetEvent("vinsan_vehkeys:ToggleLockAction")
AddEventHandler("vinsan_vehkeys:ToggleLockAction", function(vehicle, state)
    local playerPed = PlayerPedId()

    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    if (not IsPedInAnyVehicle(playerPed, false)) then
        TaskPlayAnim(playerPed, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
    end
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'carlock', 0.3) 

    if (state) then 
        exports['alvin_core']:Notify('error', 'Vehicle Locked') 
        StartVehicleHorn(vehicle, 100, `NORMAL`, false)
    else
        exports['alvin_core']:Notify('success', 'Vehicle Unlocked') 
        StartVehicleHorn(vehicle, 100, `NORMAL`, false)
    end

    SetVehicleDoorsLockedForAllPlayers(vehicle, state)
end)

--[[exports['qtarget']:Player({
    options = {
        {
            icon = "fak fa-handcuffs",
            label = "Give Keys",
            action = function(entity)
                GiveKeys(GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
            end
        },
    },
    distance = 2.0
}) ]]

exports.qtarget:Vehicle({
    options = {
        {
            icon = "fas fa-sign-out-alt",
            label = "Lock/Unlock Vehicle",
            action = function(entity)
                ToggleLock(entity)
            end
        },
    },
    distance = 2.0
})

function GiveKeys(playerId)
    ESX.TriggerServerCallback('vinsan_vehkeys:UserKeys', function(keys)
        while (keys == nil) do Citizen.Wait(100) end
        if (#keys == 0) then
            exports.alvin_core:Notify('success', 'No keys found.')
            return
        end

        local elements = {}
        for _, v in pairs(keys) do
            table.insert(elements, {id = #elements+1, header = v, txt = ' ', event = 'vinsan_vehkeys:GiveKeys', args = { playerId = playerId, plate = v }})
        end
        exports['nh-context']:openMenu(elements)
    end)
end

AddEventHandler('vinsan_vehkeys:GiveKeys', function(data)
    TriggerServerEvent('vinsan_vehkeys:AddKey', data.playerId, data.plate)
end)

function GetSeatPedIsIn(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    for i=-2,maxSeats do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i, maxSeats end
    end
    return -2
end

function GetVehicleInFront()
    local playerPed = PlayerPedId()
	local myPos = GetEntityCoords(playerPed, 1)
	local frontOfPlayer = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 3.0, 0.0)
	local closeVehicle = GetEntityInDirection(myPos, frontOfPlayer, 2)
	local closeVehicleOnGround = GetEntityInDirectionOnGround(myPos, frontOfPlayer, 2)
    if DoesEntityExist(closeVehicle) then
        if (IsEntityAVehicle(closeVehicle)) then
            return closeVehicle
        end
    elseif DoesEntityExist(closeVehicleOnGround) then
        if (IsEntityAVehicle(closeVehicleOnGround)) then
            return closeVehicleOnGround
        end
	else
		return false
	end
end

function GetEntityInDirection(coordFrom, coordTo, flag)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, flag, PlayerPedId(), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end

function GetEntityInDirectionOnGround(coordFrom, coordTo, flag)
	local bool, groundZ = GetGroundZFor_3dCoord(coordTo.x, coordTo.y, coordTo.z, 0)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z - 0.7, coordTo.x, coordTo.y, groundZ, flag, PlayerPedId(), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end

RegisterCommand('togglelocks', function()
	ToggleLock()
end, false)
RegisterKeyMapping('togglelocks', '[VH] Vehicle Locks', 'keyboard', 'u')