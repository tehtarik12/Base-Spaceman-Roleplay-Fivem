-- Registering net events
local washing = false
RegisterNetEvent('esx_pun_carwash:clean')
AddEventHandler('esx_pun_carwash:clean', function()

    if not washing then 
    washing = true 
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local dirtLevel = GetVehicleDirtLevel(vehicle)
    local displayPrice = math.floor(dirtLevel * Config.Price)
    local timer = Config.Timer * 1000
    DecorSetInt(vehicle, "recharge", 1)
    SetVehicleEngineOn(vehicle, false, true, true)
    SetVehicleUndriveable(vehicle, true)
    FreezeEntityPosition(vehicle, true)
    SetVehicleDoorOpen(vehicle, 4, false)
    if lib.progressCircle({
        duration = 15000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = false,
            move = true,
            combat = true
        },
    }) then 
        washing = false
        DecorSetInt(vehicle, "recharge", 0)
        SetVehicleEngineOn(vehicle, false, false, false)
        SetVehicleUndriveable(vehicle, false)
        FreezeEntityPosition(vehicle, false)
        SetVehicleDoorsShut(vehicle, false)
        PlayVehicleDoorOpenSound(vehicle, 0)
        SetVehicleDirtLevel(vehicle, 0.0)
        FreezeEntityPosition(vehicle, false)
        ESX.ShowNotification( _U('cleaned_vehicle'))
  end
else 
    ESX.ShowNotification('Kamu Sedang Melakukan Pencucian kendaraan!', 'error')
end

end)

RegisterNetEvent('esx_pun_carwash:cancel')
AddEventHandler('esx_pun_carwash:cancel', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local dirtLevel = GetVehicleDirtLevel(vehicle)
    local displayPrice = math.floor(dirtLevel * Config.Price)
    ESX.ShowNotification(_U('not_enough_money'), 'error')
end)

-- Main thread
Citizen.CreateThread(function()
    while true do
        local letsleep = 5000
        local player = PlayerPedId()
        if GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player then
            letsleep = 1000
            for k, v in pairs(Config.Locations) do
                while #(GetEntityCoords(player) - vector3(v.location.x, v.location.y, v.location.z)) <= v.extents and GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player and GetEntitySpeed(player) <= 0.5 do
                    local pauseThread = 8
                    local dirtLevel = GetVehicleDirtLevel(GetVehiclePedIsIn(player, false))
                    pricePreFormat = math.floor(dirtLevel * Config.Price)
                    price = pricePreFormat - 0.01
                        ESX.ShowHelpNotification(_U('press_button') .. pricePreFormat)
                        if IsControlJustReleased(0, 350) and washing == false then
                            TriggerServerEvent('esx_pun_carwash:checkMoney', price)
                            pauseThread = Config.Timer * 1000
                        end
                    Citizen.Wait(pauseThread)
                end
            end
        end
        Citizen.Wait(letsleep)
    end
end)

-- Create blips
Citizen.CreateThread(function()
    if Config.ShowBlips == true then
        for k, v in pairs(Config.Locations) do
            local blip = AddBlipForCoord(v.location.x, v.location.y, v.location.z)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, Config.BlipColor)
            SetBlipDisplay(blip, Config.BlipDisplay)
            SetBlipScale(blip, Config.BlipScale)
            SetBlipSprite(blip, Config.BlipSprite)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('Car Wash')
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Create markers
Citizen.CreateThread(function()
    if Config.ShowMarkers == true then
        while true do
            local letsleep = 5000
            local player = PlayerPedId()

            if GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player then
                letsleep = 2500
                for k, v in pairs(Config.Locations) do
                    while #(vector3(v.location.x, v.location.y, v.location.z) - GetEntityCoords(player)) <= 10 and GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player do
                        -- Floating markers
                        if Config.MarkerType == 0 or (Config.MarkerType >= 2 and Config.MarkerType <= 7) or (Config.MarkerType >= 10 and Config.MarkerType <= 22) or Config.MarkerType == 24 or (Config.MarkerType >= 28 and Config.MarkerType <= 31) then
                            DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                        -- Slightly under the ground markers
                        elseif Config.MarkerType == 1 then
                            DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z - 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents / 10, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                        -- Slightly above the ground markers, fixed
                        elseif Config.MarkerType == 8 or Config.MarkerType == 9 or Config.MarkerType == 23 or Config.MarkerType == 25 then
                            DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, false, 2, nil, nil, false)
                        -- Slightly above the ground markers, rotating
                        elseif Config.MarkerType == 26 or Config.MarkerType == 27 then
                            DrawMarker(Config.MarkerType, v.location.x, v.location.y, v.location.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                        -- In case user specified an out-of-range marker value
                        else
                            DrawMarker(1, v.location.x, v.location.y, v.location.z - 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.extents, v.extents, v.extents / 10, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a, false, true, 2, nil, nil, false)
                        end
                        Citizen.Wait(7)
                    end
                end
            end

            Citizen.Wait(letsleep)
        end
    end
end)