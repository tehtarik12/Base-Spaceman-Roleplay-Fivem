local display = false
RegisterCommand("fps", function(source, args)
    SetDisplay(not display)
end)

RegisterNUICallback("close", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("button1", function() -- high
end)

RegisterNUICallback("button2", function() --med
end)

RegisterNUICallback("button3", function() --low
     local ped = PlayerPedId()
    SetTimecycleModifier('yell_tunnel_nodirect')
    ClearAllBrokenGlass()
    ClearAllHelpMessages()
    LeaderboardsReadClearAll()
    ClearBrief()
    ClearGpsFlags()
    ClearPrints()
    ClearSmallPrints()
    ClearReplayStats()
    LeaderboardsClearCacheData()
    ClearFocus()
    ClearHdArea()
    ClearPedBloodDamage(ped)
    ClearPedWetness(ped)
    ClearPedEnvDirt(ped)
    ResetPedVisibleDamage(ped)
    DisableScreenblurFade()
end)
RegisterNUICallback("button4", function() -- reset
    SetTimecycleModifier()
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
end)
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end
