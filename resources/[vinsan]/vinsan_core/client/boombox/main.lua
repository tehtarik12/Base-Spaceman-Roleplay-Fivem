xSound = exports['xsound']
local menuOpen = false
local adminMenuOpen = false
local wasOpen = false
local currentData = nil
DecorRegister('boomboxName', 3)

RegisterNetEvent("esx_boombox:place_boombox")
AddEventHandler("esx_boombox:place_boombox", function()
	local playerPed = PlayerPedId()

    if IsPedOnFoot(playerPed) then
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 1.0)
        startAnimation("anim@heists@money_grab@briefcase","put_down_case")
        Citizen.Wait(1000)
        ClearPedTasks(PlayerPedId())
        ESX.Game.SpawnObject("prop_boombox_01", objectCoords, function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
            local boomBoxName = GetPlayerServerId(PlayerId())
            DecorSetInt(obj, 'boomboxName', GetPlayerServerId(PlayerId()))
            TriggerServerEvent("esx_boombox:set_boombox", boomBoxName, objectCoords)
        end)
    end
end)

function OpenBoomboxMenu()
    menuOpen = true
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "boombox", {
        title   = _U("boombox_menu_title"),
        align   = 'bottom-right',
        elements = {
            {label = _U("get_boombox"), value = "get_boombox"},
            {label = _U("play_music"), value = "playBoombox"},
            {label = _U("volume_music"), value = "volume"},
            {label = _U("stop_music"), value = "stopBoombox"}
        }
    }, function(data, menu)
        local playerPed = PlayerPedId()
        local lCoords = GetEntityCoords(playerPed)
        if data.current.value == "get_boombox" then
            menuOpen = false
            menu.close()
            pickupBoomBox(lCoords)
        elseif data.current.value == "playBoombox" then
            playBoombox(lCoords)
        elseif data.current.value == "stopBoombox" then
            if xSound:soundExists(DecorGetInt(currentData, 'boomboxName')) then
                stopBoombox(lCoords)
                menuOpen = false
                menu.close()
            else
                ESX.ShowNotification(_U("not_found"))
                menu.close()
            end
        elseif data.current.value == "volume" then
            setVolumeBoombox(lCoords)
        end
    end, function(data, menu)
        menuOpen = false
        menu.close()
    end)
end

function pickupBoomBox(coords)
    if DoesEntityExist(currentData) then
        NetworkRequestControlOfEntity(currentData)
        startAnimation("anim@heists@narcotics@trash","pickup")
        Citizen.Wait(700)
        SetEntityAsMissionEntity(currentData,false,true)
        stopBoombox(coords)
        DeleteEntity(currentData)
        ESX.Game.DeleteObject(currentData)
        if not DoesEntityExist(currentData) then
            TriggerServerEvent("esx_boombox:remove_boombox", coords, DecorGetInt(currentData, 'boomboxName'))
            currentData = nil
        end
        Citizen.Wait(500)
        ClearPedTasks(PlayerPedId())
    else
        TriggerEvent("esx:showNotification", _U("no_boombox"))
    end
end

function setVolumeBoombox(coords)
    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "setVolumeBoombox",{
        title = _U("set_volume"),
    }, function(data, menu)
        local value = tonumber(data.value) / 100
        if value < 0 or value > 1 then
            ESX.ShowNotification(_U("sound_limit"))
        else
            TriggerServerEvent("esx_boombox:set_volume", DecorGetInt(currentData, 'boomboxName'), value)
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function playBoombox(coords)
    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "playBoombox",{
        title = _U("play_id"),
    }, function(data, menu)
        local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)
        local objCoords = GetEntityCoords(object)
        TriggerServerEvent("esx_boombox:play_music", DecorGetInt(object, 'boomboxName'), data.value, 1, objCoords)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function stopBoombox(coords)
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_boombox_01"), false, false, false)
    local objCoords = GetEntityCoords(object)
    local playerPed = PlayerPedId()
    local lCoords = GetEntityCoords(playerPed)
    local distance = #(coords - objCoords)
    if(distance < 50) then
        TriggerServerEvent("esx_boombox:stop_music", DecorGetInt(object, 'boomboxName'))
    else
        TriggerEvent("esx:showNotification", _U("boombox_tooFar"))
    end
end

AddEventHandler('esx_boombox:Accessmenu', function(data)
    if DoesEntityExist(data.entity) then
        currentData = data.entity
        OpenBoomboxMenu()
    else
        TriggerEvent("esx:showNotification", _U("not_found"))
    end
end)

exports.qtarget:AddTargetModel({`prop_boombox_01`}, {
	options = {
		{
			event = "esx_boombox:Accessmenu",
			icon = "fas fa-tools",
			label = "Access Boombox",
		},
	},
	distance = 2
})