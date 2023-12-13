RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    SetPedHelmet(PlayerPedId(), false)
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        local playerVeh = GetVehiclePedIsUsing(PlayerPedId())
        if PlayerVeh ~= 0 then SetPedConfigFlag(PlayerPedId(), 35, false) end
    end	
end)