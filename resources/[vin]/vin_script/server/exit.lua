AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = GetPlayerIdentifier(source, 0)
    TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
end)