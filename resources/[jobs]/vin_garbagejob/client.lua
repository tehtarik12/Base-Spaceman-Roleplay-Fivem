local truckplate = false
local truckcoords
local inTruck
local missionBlip = nil
local binCoords = false
local maxruns = 0
local runs = 0
local arrived 
local jobBlip
local submitBlip
ESX = nil
local submitCoords = vector3(-354.28,-1560.88,24.9)
local clockRoom = vector3(-321.70, -1545.94, 31.02)
local doingGarbage = false
local jobCompleted = false
local garbageHQBlip = 0
local truckTaken = false
local aracInfo 

local Dumpsters = {
    {x = 255.4526, y = -986.706, z = 29.145},
    {x = -8.73485, y = -1564.87, z = 29.290},
    {x = -0.76947, y = -1732.66, z = 29.302},
    {x = 157.0601, y = -1817.45, z = 28.096},
    {x = 358.8775, y = -1810.40, z = 28.994},
    {x = 485.1318, y = -1276.23, z = 29.600}
}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


Citizen.CreateThread(function()


            havingGarbageJob = true
            if garbageHQBlip == nil or garbageHQBlip == 0 then
                garbageHQBlip = AddBlipForCoord(clockRoom)
                SetBlipSprite(garbageHQBlip, 318)
                SetBlipDisplay(garbageHQBlip, 4)
                SetBlipScale(garbageHQBlip, 0.9)
                SetBlipColour(garbageHQBlip, 25)
                SetBlipAsShortRange(garbageHQBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Lokasi Sampah")
                EndTextCommandSetBlipName(garbageHQBlip)
            end   
end)


local copcusleep = 1200

Citizen.CreateThread(function() 
    local wait = 100
    while true do 
        Citizen.Wait(copcusleep)
        copoptimize = false
        if havingGarbageJob then
            local playerPed = GetPlayerPed(-1)
            local plyCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(plyCoords, clockRoom, true)
            local vehicleCoords = vector3(-323.53, -1523.58, 27.00)
            local heading = 269.7

            if distance < 20 then
                copoptimize = true
                DrawMarker(2, clockRoom, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                if distance < 1.5 then
                    ESX.ShowHelpNotification("Tekan E Untuk Ambil Sampah", true, true, 5000)
                    if IsControlJustReleased(1,46) then
                        if not truckTaken then 
                            if ESX.Game.IsSpawnPointClear(vehicleCoords, 5) then
                                truckTaken = true
                                inTruck = false
                                ESX.Game.SpawnVehicle("trash", vehicleCoords, heading , function(vehicle)
                                    aracInfo = vehicle
                                    truckplate = GetVehicleNumberPlateText(vehicle)
                                    truckcoords = GetEntityCoords(vehicle)
                                    TriggerServerEvent('garage:addKeys', truckplate)
                                    Citizen.CreateThread(function() 
                                        while not inTruck do 
                                            Citizen.Wait(5)
                                            DrawMarker(2, truckcoords + vector3(0.0,0.0,3.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                                            if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                                                local truck = GetVehiclePedIsIn(GetPlayerPed(-1),false)
                                                if truck == vehicle then
                                                    inTruck = true
                                                    Citizen.Wait(1000)
                                                    runs = 0
                                                    missionStart(vehicle)
                                                    TriggerEvent('ndrp_carkeys:carkeys', vehicle)
                                                end
                                            end
                                        end
                                    end)
                                end)
                            else
                                exports['mythic_notify']:SendAlert('inform', 'Truk Anda Sudah Penuh')
                            end
                        else
                            exports['mythic_notify']:SendAlert('inform', 'Anda Sudah Membeli Truk')
                        end
                    end
                end
            end
        end

        if copoptimize then 
            copcusleep = 7
        elseif not copoptimize then
            copcusleep = 1200
        end
    end
end)

function submit()
    Citizen.CreateThread(function()
        local pressed = false
        local wait = 100
        while true do
            Citizen.Wait(wait)
            local playerPed = GetPlayerPed(-1)
            local plyCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(plyCoords,submitCoords, true) 
            if distance < 20 then
                wait = 5
                if IsPedInAnyVehicle(playerPed) then
                    DrawMarker(2, submitCoords+vector3(0.0,0.0,2.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                    local truck = GetVehiclePedIsIn(playerPed, false)
                    local plate = GetVehicleNumberPlateText(truck)
                    if distance < 2.0 then
                        ESX.ShowHelpNotification(" Tekan E Untuk Mengambil Sampah", true, true, 5000)
                        if IsControlJustReleased(1,46) and not pressed then
                            truckTaken = false
                            pressed = true
                            RemoveBlip(submitBlip)
                            if plate == truckplate then
                                jobCompleted = true
                                -- exports["np-taskbar"]:taskBar(5000,"Çöp Dökülüyor")
                                TriggerServerEvent('copcu:esyaver',jobCompleted)
                                jobCompleted = false
                                ESX.Game.DeleteVehicle(truck)
                                for i=1,200,1 do 
                                    if DoesEntityExist(truck) then
                                        ESX.Game.DeleteVehicle(truck)
                                    else
                                        truckplate = false
                                        truckTaken = false
                                        return
                                    end
                                end
                                truckplate = false
                                Citizen.Wait(1000)
                                pressed = false  
                                return
                            else
                                exports['mythic_notify']:SendAlert('error', 'Ini bukan alat yang diberikan kepada Anda')
                                Citizen.Wait(1000)
                                pressed = false
                            end
                            Citizen.Wait(1000)
                            pressed = false
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end)
end

function missionStart(xtruck)
    local vehicle = xtruck
    maxruns  = math.random(6,10)
    findtrashbins(vehicle,0) 
end

local distance = 500

function findtrashbins(xtruck,pickup)
    doingGarbage = true
    local location = coordVec
    local vehicle = xtruck
    local playerPed = GetPlayerPed(-1)
    local boneindex = GetPedBoneIndex(playerPed, 57005)  
    runs = pickup

    if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
        RequestAnimDict("anim@heists@narcotics@trash")
    end
    while not HasAnimDictLoaded("anim@heists@narcotics@trash") do
        Citizen.Wait(0)
    end
    if runs < maxruns then
        for i = 0, #Dumpsters, 1 do 
            local random = math.random(1, #Dumpsters)
            local dumpCoords = vector3(Dumpsters[random].x, Dumpsters[random].y, Dumpsters[random].z)
            local playerCoord = GetEntityCoords(GetPlayerPed(-1))             
            if GetDistanceBetweenCoords(playerCoord,dumpCoords,true) > distance then
                distance = 500
                jobBlip = AddBlipForCoord(dumpCoords)
                SetBlipSprite(jobBlip, 420)
                SetBlipScale (jobBlip, 0.5)
                SetBlipColour(jobBlip, 25)
                while true do
                    Wait(5) 
                    local userDist = GetDistanceBetweenCoords(dumpCoords,GetEntityCoords(GetPlayerPed(-1)),true) 
                    if userDist < 20 then
                        DrawMarker(20, dumpCoords + vector3(0.0,0.0,2.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                        if userDist < 2 then
                            ESX.ShowHelpNotification("Tekan E untuk Ambil Sampah.", true, true, 5000)
                            if IsControlJustReleased(1,46) then
                                local geeky = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)
                                AttachEntityToEntity(geeky, playerPed, boneindex, 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
                                TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
                                RemoveBlip(jobBlip)
                                collectedtrash(geeky,vehicle,location,runs)
                                return
                            end
                        end
                    end
                end
                return
            end
            if i == #Dumpsters then
                distance = distance - 100
                findtrashbins(xtruck,pickup)
            end
        end
    else
        submit()
        doingGarbage = false
        exports['mythic_notify']:SendAlert('inform', 'Pekerjaan selesai sekarang kembali ke kantor',10000)
        submitBlip = AddBlipForCoord(submitCoords)
        SetBlipColour(submitBlip, 25)
    end
end

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if havingGarbageJob then
            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                if doingGarbage then
                    DisplayRadar(false)
                else
                    DisplayRadar(false)
                end
            end
        end
    end
end) ]]

local trashCollected = false

function collectedtrash(geeky,vehicle,location,pickup)
    local wait = 100
    local trashbag = geeky
    local pressed = false
    while true do
        Wait(wait)
        local trunkcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "platelight"))
        local tdistance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),trunkcoord)
        local runs = pickup
        if tdistance < 20 then
            wait = 5
            DrawMarker(20, trunkcoord + vector3(0.0,0.0,0.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if tdistance < 2 then
                ESX.ShowHelpNotification("Tekan E untuk buang sampah di belakang mobil", true, true, 5000)
                if IsControlJustReleased(1, 46) and not pressed then
                    pressed = true
                    local dropChance = math.random(10,20)
                    if dropChance > 1 then
                        local randomChance = math.random(1,100)
                        trashCollected  = true
                        --[[ local item = 'water'
                        if randomChance < 20 then
                            item = 'water'
                        elseif randomChance > 20 and randomChance < 40 then
                            item = 'water'
                        elseif randomChance > 40 and randomChance < 50 then
                            item = 'water'
                        elseif randomChance > 50 and randomChance < 52 then
                            item = 'water'
                        elseif randomChance > 52 and randomChance < 80 then
                            item = 'water'
                        elseif randomChance == 81 then  
                            item = 'water'
                        elseif randomChance > 81 and randomChance < 90 then
                            item = 'water'
                        elseif randomChance > 90 and randomChance < 95 then
                            item = 'water'
                        elseif randomChance > 95 and randomChance < 97 then
                            item = 'water'
                        else
                            item = 'water'
                        end ]]
                        --TriggerServerEvent('ndrp-garbage:reward',item,trashCollected)
                        trashCollected = false
                    end
                    ClearPedTasksImmediately(GetPlayerPed(-1))
					TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
                    Citizen.Wait(100)
                    DeleteObject(trashbag)
                    Citizen.Wait(3000)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    findtrashbins(vehicle,runs+1)
                    pressed = false
                    return
                end
            end
        end
    end
end