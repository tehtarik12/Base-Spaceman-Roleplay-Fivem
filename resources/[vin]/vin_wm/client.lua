AddEventHandler('onClientMapStart', function()
    Citizen.CreateThread(function()
        TriggerEvent('cover:display', true)
    end)
end)