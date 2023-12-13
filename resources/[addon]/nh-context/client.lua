local Promise, ActiveMenu = nil, false

RegisterNUICallback("dataPost", function(data, cb)
    local id = tonumber(data.id) + 1 or nil
    local rData = ActiveMenu[id]
    if rData then
        if Promise ~= nil then
            Promise:resolve(rData.args)
            Promise = nil
        end
        if rData.event and Promise == nil then
            if not rData.server then
                TriggerEvent(rData.event, rData.args)
            else
                TriggerServerEvent(rData.event, rData.args)
            end
        end
    end
    CloseMenu()
    cb("ok")
end)

RegisterNUICallback("cancel", function(data, cb)
    if Promise ~= nil then
        Promise:resolve(nil)
        Promise = nil
    end
    CloseMenu()
    cb("ok")
end)

CreateMenu = function(data)
    if not data then return end
    while ActiveMenu do Wait(0) end
    ActiveMenu = data
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
    SetNuiFocus(true, true)
end

ContextMenu = function(data)
    if not data or Promise ~= nil then return end
    while ActiveMenu do Wait(0) end
    
    Promise = promise.new()
    
    ActiveMenu = data
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
    
    return Citizen.Await(Promise)
end

CloseMenu = function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "CLOSE_MENU",
    })
    ActiveMenu = false
end

CancelMenu = function()
    SendNUIMessage({
        action = "CANCEL_MENU",
    })
end

exports("openMenu", CreateMenu)
exports("ContextMenu", ContextMenu)
exports("CancelMenu", CancelMenu)

RegisterCommand('togglecontext', function()
    if ActiveMenu then SetNuiFocus(true, true) end
end, false)
RegisterKeyMapping("togglecontext", "[UI] contextmenu", "keyboard", "LALT")
TriggerEvent('chat:removeSuggestion', '/togglecontext')

RegisterNetEvent("nh-context:createMenu", function(data)
    if not data then return end
    while ActiveMenu do Wait(0) end
    CreateMenu(data)
end)

RegisterNetEvent("nh-context:cancelMenu", CancelMenu)
