local SpawnData = {}
local Preview = nil

local finesseCam1 = 1500
local finesseCam2 = 50
local pointCamCoords = 75
local pointCamCoords2 = 0
local cam1Time = 500
local cam2Time = 1000
local haveskin = false

-- Citizen.CreateThread(function()
--     for k,v in pairs(Config.DefaultSpawn) do
--         local blip = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)
--         SetBlipSprite(blip, v.sprite)
--         SetBlipColour(blip, 3)
--         SetBlipDisplay(blip, 2)
--         SetBlipScale(blip, 0.8)
--         SetBlipAsShortRange(blip, true)

--         BeginTextCommandSetBlipName("STRING")
--         AddTextComponentString(''..v.label)
--         EndTextCommandSetBlipName(blip)
--     end
-- end)

RegisterNetEvent("vinsan_core:SpawnSelector")
AddEventHandler("vinsan_core:SpawnSelector", function(firstspawn, ownedprop, jail, chaveskin)
    haveskin = chaveskin
    SpawnData = {}
    
    DoScreenFadeOut(0)

    if jail and jail > 0 then
        Citizen.Wait(2000)
        TriggerEvent('kcmcity_whitelistjob:StartJail', jail)
        DoScreenFadeIn(1000)
        return
    end

    ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
        if shouldDie then
            Citizen.Wait(2000)
            TriggerEvent('kcmcity_whitelistjob:RemoveItemsAfterRPDeath')
        else
            if firstspawn == true then
                local position = GetEntityCoords(PlayerPedId())
                SpawnData['last'] = {
                    coords = {x = position.x, y = position.y, z = position.z},
                    icon = 'fas fa-undo',
                    label = 'Last Position',
                }
            end
            for k,v in pairs(Config.DefaultSpawn) do
                SpawnData[string.lower(k)] = {
                    coords = v.coord,
                    icon = v.icon,
                    label = v.label,
                }
            end
            local houses = exports.bcs_housing:GetOwnedHomes()
            for k,v in pairs(houses) do
                SpawnData[string.lower(v.name)] = {
                    coords = v.entry,
                    icon = 'fas fa-house',
                    label = v.name,
                }
            end
            --[[
            if #ownedprop > 0 then
                TriggerEvent('esx_property:getProperties', function(data)
        
                    for k,v in pairs(ownedprop) do
                        for i=1, #data, 1 do
                            if data[i].name == v.name then
                                SpawnData[string.lower(v.name)] = {
                                    coords = {x = data[i].inside.x, y = data[i].inside.y, z = data[i].inside.z},
                                    icon = 'fas fa-home',
                                    label = v.name .. ' [Owned Property]',
                                    property = v.name
                                }
                            end
                        end
                    end
                end)
            end
            --]]
            SendNUIMessage({ setup = true, locations = SpawnData })

            SetEntityVisible(PlayerPedId(), false)
            SetEntityCoords(PlayerPedId(), 0.0, 0.0, -100.0)
            FreezeEntityPosition(PlayerPedId(), true)

            cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93, -1487.78, 520.75, 300.00, 0.00, 0.00, 100.00, false, 0)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 1, true, true)
            DoScreenFadeIn(1000)
            SendNUIMessage({ show = true })
            SetNuiFocus(true, true)
        end
    end)
end)

RegisterNUICallback("Preview", function(data)
    if Preview == data.location then return end
    Preview = data.location
    local Position = SpawnData[data.location].coords
    PreviewSpawn(Position)
end)

RegisterNUICallback("Spawn", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({show = false})
    local Spawn = SpawnData[data.spawn].coords
    --local Property = not SpawnData[data.spawn].property and false or SpawnData[data.spawn].property
    SpawnPlayer(Spawn--[[, Property--]])
    ExecuteCommand('reloadskin')
end)

function SpawnPlayer(Position--[[, Property--]])
    local Ped = PlayerPedId()

    TriggerEvent('esx:restoreLoadout')
    SetNuiFocus(false, false)
    --[[if Property then
        SetEntityVisible(PlayerPedId(), true)
        FreezeEntityPosition(Ped, false)
        SetEntityCoords(Ped, Position.x, Position.y, Position.z)
        TriggerEvent('instance:create', 'property', {property = Property, owner = ESX.GetPlayerData().identifier})

        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        SetCamActive(cam2, false)
        DestroyCam(cam2, true)
    else-]]
        ESX.Game.Teleport(Ped, {x = Position.x, y = Position.y, z = Position.z}, function()
            SetEntityVisible(PlayerPedId(), true)
            FreezeEntityPosition(Ped, false)
            SetEntityCoords(Ped, Position.x, Position.y, Position.z)

            RenderScriptCams(false, true, 500, true, true)
            SetCamActive(cam, false)
            DestroyCam(cam, true)
            SetCamActive(cam2, false)
            DestroyCam(cam2, true)
            if haveskin == false then
                TriggerEvent('esx_skin:openSaveableMenu')
            end
        end)
    --end
end

function PreviewSpawn(Position)
    local Ped = PlayerPedId()
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Position.x, Position.y, Position.z + finesseCam1, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam2, Position.x, Position.y, Position.z + pointCamCoords)
    SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
    if DoesCamExist(cam) then
        DestroyCam(cam, true)
    end
    Citizen.Wait(cam1Time)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Position.x, Position.y, Position.z + finesseCam2, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam, Position.x, Position.y, Position.z + pointCamCoords2)
    SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
    SetEntityCoords(Ped, Position.x, Position.y, Position.z)
end