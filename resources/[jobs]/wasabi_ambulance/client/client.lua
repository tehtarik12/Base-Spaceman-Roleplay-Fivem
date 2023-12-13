-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

isDead, disableKeys, inMenu, stretcher, stretcherMoving, medbagCoords, isBusy, Authorized = nil, nil, nil, nil, nil, nil, nil, nil
local injury
plyRequests = {}

CreateThread(function()
    while not PlayerData?.job do Wait(500) end
    if Config?.policeCanTreat?.enabled and HasGroup(Config.policeCanTreat.jobs) then
        Authorized = true
    end
    if Config.UseRadialMenu then
        AddRadialItems()
    end
    if Config.targetSystem then
        local data = {
            targetType = 'Model',
            models = {Config.BagProp},
            options = {
                {
                    event = 'wasabi_ambulance:pickupBag',
                    icon = 'fas fa-hand-paper',
                    label = Strings.pickup_bag_target,
                    canInteract = function()
                        return isPlayerDead() == false
                    end
                },
                {
                    event = 'wasabi_ambulance:interactBag',
                    icon = 'fas fa-briefcase',
                    label = Strings.interact_bag_target,
                    canInteract = function()
                        return isPlayerDead() == false
                    end
                },
            },
            job = 'all',
            distance = 1.5
        }
        TriggerEvent('wasabi_ambulance:addTarget', data)
        local data2 = {
            targetType = 'Player',
            options = {
                {
                    event = 'wasabi_ambulance:diagnosePatient',
                    icon = 'fas fa-stethoscope',
                    label = Strings.diagnose_patient,
                    job = Config.ambulanceJob,
                    canInteract = function()
                        return isPlayerDead() == false
                    end
                },
                {
                    event = 'wasabi_ambulance:reviveTarget',
                    icon = 'fas fa-medkit',
                    label = Strings.revive_patient,
                    job = Config.ambulanceJob,
                    canInteract = function()
                        return isPlayerDead() == false
                    end
                },
                {
                    event = 'wasabi_ambulance:healTarget',
                    icon = 'fas fa-bandage',
                    label = Strings.heal_patient,
                    job = Config.ambulanceJob,
                    canInteract = function()
                        return isPlayerDead() == false
                    end
                },
                {
                    event = 'wasabi_ambulance:useSedative',
                    icon = 'fas fa-syringe',
                    label = Strings.sedate_patient,
                    job = Config.ambulanceJob,
                    canInteract = function()
                        return isPlayerDead() == false
                    end
                }
            },
            distance = 1.5
        }
        TriggerEvent('wasabi_ambulance:addTarget', data2)
    end
end)

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer()
	Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

RegisterNetEvent('wasabi_ambulance:playerLoaded', function()
    while not PlayerLoaded and not PlayerData?.job do Wait(500) end
    local player = PlayerId()
    SetEntityMaxHealth(cache.ped, 200.0)
    SetEntityHealth(cache.ped, 200.0)
    SetPlayerHealthRechargeMultiplier(player, 0.0)
    SetPlayerHealthRechargeLimit(player, 0.0)
    if Config.AntiCombatLog.enabled then
        local dead = lib.callback.await('wasabi_ambulance:checkDeath', 300)
        if dead then
            Wait(3000)
            SetEntityHealth(cache.ped, 0.0)
            if Config.AntiCombatLog.notification.enabled then
                TriggerEvent('wasabi_ambulance:notify', Config.AntiCombatLog.notification.title, Config.AntiCombatLog.notification.desc, 'error', 'skull-crossbones')
            end
        end
    end
    while not PlayerData?.job do Wait(500) end
    if HasGroup(Config.ambulanceJob) then
        TriggerServerEvent('wasabi_ambulance:requestSync')
    end
end)

RegisterNetEvent('wasabi_ambulance:setJob', function(job)
    Authorized = false
    if Config?.policeCanTreat?.enabled then
        if HasGroup(Config.policeCanTreat.jobs) then
            Authorized = true
        end
    end
    if job == Config.ambulanceJob then
        TriggerServerEvent('wasabi_ambulance:requestSync')
    end
    if Config.UseRadialMenu then
        AddRadialItems()
    end
end)

if Config.lowHealthAlert.enabled then
    CreateThread(function()
        local notified
        while true do
            Wait(1500)
            local health = GetEntityHealth(cache.ped)
            if health ~= 0 and health < Config.lowHealthAlert.health and not notified then
                TriggerEvent('wasabi_ambulance:notify', Config.lowHealthAlert.notification.title, Config.lowHealthAlert.notification.description, 'error')
                notified = true
            elseif notified and health >= Config.lowHealthAlert.health then
                notified = nil
            end
        end
    end)
end

CreateThread(function()
	while true do
		local sleep = 1500
		if isDead or disableKeys then
            sleep = 0
			DisableAllControlActions(0)
            for k, data in pairs(Config.EnabledKeys) do
                EnableControlAction(0, data, true)
            end
		end
        Wait(sleep)
	end
end)

-- Spawn event
AddEventHandler('wasabi_ambulance:onPlayerSpawn', function()
    isDead = false
    local ped = cache.ped -- Players seem to be not loading cache.ped fast enough
    SetEntityMaxHealth(ped, 200.0)
    SetEntityHealth(ped, 200.0)
    if firstSpawn then
        firstSpawn = false
        while not PlayerLoaded do
            Wait(1000)
        end
        lib.requestAnimDict('get_up@directional@movement@from_knees@action', 100)
        TaskPlayAnim(ped, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
    else
        AnimpostfxStopAll()
        lib.requestAnimDict('get_up@directional@movement@from_knees@action', 100)
        TaskPlayAnim(ped, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
    end
    TriggerServerEvent('wasabi_ambulance:setDeathStatus', false)
    RemoveAnimDict('get_up@directional@movement@from_knees@action')
end)

-- Death Event
AddEventHandler('wasabi_ambulance:onPlayerDeath', function(data)
    if data.deathCause == 0 then
        local deathSource = lib.GetClosestPlayer(vec3(data.victimCoords.x, data.victimCoords.y, data.victimCoords.z), 3.0, false)
        if deathSource then
            local deathSource = GetPlayerPed(deathSource)
            local weapon = GetSelectedPedWeapon(deathSource)
            for k,v in pairs(DeathReasons) do
                for i=1, #v do
                    if v[i] == weapon then
                        injury = tostring(k)
                        break
                    end
                end
            end
            if injury == 'shot' then
                injury = 'beat'
            end
        end
    else
        for k,v in pairs(DeathReasons) do
            for i=1, #v do
                if v[i] == data.deathCause then
                    injury = tostring(k)
                    break
                end
            end
        end
    end

    if Config.MythicHospital then
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
    end
    if Config.CompleteDeath.enabled and Framework == 'esx' then
        TriggerServerEvent('wasabi_ambulance:deathCount')
    end
    TriggerServerEvent('wasabi_ambulance:injurySync', injury)
    if Config.DeathLogs then
        local killer = GetPedSourceOfDeath(cache.ped)
        local dCause = GetPedCauseOfDeath(cache.ped)
        local deathCause
        if IsEntityAPed(killer) and IsPedAPlayer(killer) then
            killer = NetworkGetPlayerIndexFromPed(killer)
        elseif IsEntityAVehicle(killer) and IsEntityAPed(GetPedInVehicleSeat(killer, -1)) and IsPedAPlayer(GetPedInVehicleSeat(killer, -1)) then
            killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(dCause, -1))
        end
        if (killer == PlayerId()) then
            deathCause = 'suicide'
        elseif (killer == nil or killer == 0) then
            deathCause = 'unknown'
        end
        if deathCause == 'suicide' or deathCause == 'unknown' then
            TriggerServerEvent('wasabi_ambulance:logDeath', dCause, nil)
        else
            TriggerServerEvent('wasabi_ambulance:logDeath', dCause, GetPlayerServerId(killer))
        end
    end
    OnPlayerDeath()
end)

--For qbcore
RegisterNetEvent('wasabi_ambulance:killPlayer', function()
    SetEntityHealth(cache.ped, 0.0)
end)

AddEventHandler('wasabi_ambulance:toggleDuty', function()
    local job, grade = HasGroup(Config.ambulanceJob)
    if not job then
        if Framework == 'esx' then
            job, grade = HasGroup('off'..Config.ambulanceJob)
        end
    end
    if not job then return end
    if Framework == 'qb' then
        PlayerData.job.onduty = not PlayerData.job.onduty
    end
    TriggerServerEvent('wasabi_ambulance:svToggleDuty', job, grade)
end)

AddEventHandler('wasabi_ambulance:accessStash', function()
    if not Framework == 'qb' then return end
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'ambulance_' .. QBCore.Functions.GetPlayerData().citizenid)
    TriggerEvent('inventory:client:SetCurrentStash', 'ambulance_' .. QBCore.Functions.GetPlayerData().citizenid)
end)

-- I am monster thread
CreateThread(function()
    while not PlayerLoaded do Wait(500) end
    for k,v in pairs(Config.Locations) do
        if v.Blip.Enabled then
            CreateBlip(v.Blip.Coords, v.Blip.Sprite, v.Blip.Color, v.Blip.String, v.Blip.Scale, false)
        end
        if v?.clockInAndOut?.enabled then
            if v.clockInAndOut.target.enabled then
                local data = {
                    targetType = 'AddBoxZone',
                    identifier = k..'_toggleduty',
                    coords = v.clockInAndOut.target.coords,
                    heading = v.clockInAndOut.target.heading,
                    width = v.clockInAndOut.target.width,
                    length = v.clockInAndOut.target.length,
                    minZ = v.clockInAndOut.target.minZ,
                    maxZ = v.clockInAndOut.target.maxZ,
                    job = Config.ambulanceJob,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_ambulance:toggleDuty',
                            icon = 'fa-solid fa-business-time',
                            label = v.clockInAndOut.target.label,
                            canInteract = function()
                                return isPlayerDead() == false
                            end
                        }
                    }
                }
                TriggerEvent('wasabi_ambulance:addTarget', data)
            else
                CreateThread(function()
                    local textUI
                    while true do
                        local sleep = 1500
                        local hasJob
                        local jobName, jobGrade = HasGroup(Config.ambulanceJob)
                        if jobName then
                            hasJob = jobName
                        elseif Framework == 'esx' then
                            jobName, jobGrade = HasGroup('off'..Config.ambulanceJob)
                            if jobName then hasJob = jobName end
                        end
                        if hasJob then
                            local coords = GetEntityCoords(cache.ped)
                            local dist = #(coords - v.clockInAndOut.coords)
                            if dist <= v.clockInAndOut.distance then
                                if not textUI then
                                    lib.showTextUI(v.clockInAndOut.label)
                                    textUI = true
                                end
                                sleep = 0
                                if IsControlJustReleased(0, 38) then
                                    if Framework == 'qb' then
                                        PlayerData.job.onduty = not PlayerData.job.onduty
                                    end
                                    TriggerServerEvent('wasabi_ambulance:svToggleDuty', jobName, jobGrade)
                                end
                            elseif textUI then
                                lib.hideTextUI()
                                textUI = nil
                            end
                        end
                        Wait(sleep)
                    end
                end)
            end
        end
        if v?.PersonalLocker?.enabled and (Framework == 'qb' or Config.Inventory == 'qs') then
            if v.PersonalLocker.target.enabled then
                local data = {
                    targetType = 'AddBoxZone',
                    identifier = k..'_openStash',
                    coords = v.PersonalLocker.target.coords,
                    heading = v.PersonalLocker.target.heading,
                    width = v.PersonalLocker.target.width,
                    length = v.PersonalLocker.target.length,
                    minZ = v.PersonalLocker.target.minZ,
                    maxZ = v.PersonalLocker.target.maxZ,
                    job = Config.ambulanceJob,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_ambulance:accessStash',
                            icon = 'fa-solid fa-box-open',
                            label = v.PersonalLocker.target.label,
                            canInteract = function()
                                return isPlayerDead() == false
                            end
                        }
                    }
                }
                TriggerEvent('wasabi_ambulance:addTarget', data)
            else
                CreateThread(function()
                    local textUI
                    while true do
                        local sleep = 1500
                        local hasJob
                        if HasGroup(Config.ambulanceJob) then
                            local coords = GetEntityCoords(cache.ped)
                            local dist = #(coords - v.PersonalLocker.coords)
                            if dist <= v.PersonalLocker.distance then
                                if not textUI then
                                    lib.showTextUI(v.PersonalLocker.label)
                                    textUI = true
                                end
                                sleep = 0
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent('wasabi_ambulance:accessStash')
                                end
                            elseif textUI then
                                lib.hideTextUI()
                                textUI = nil
                            end
                        end
                        Wait(sleep)
                    end
                end)
            end
        end
        if v.BossMenu.Enabled then
            if v.BossMenu?.Target?.enabled then
                local data = {
                    targetType = 'AddBoxZone',
                    identifier = k..'_emsboss',
                    coords = v.BossMenu.Target.coords,
                    heading = v.BossMenu.Target.heading,
                    width = v.BossMenu.Target.width,
                    length = v.BossMenu.Target.length,
                    minZ = v.BossMenu.Target.minZ,
                    maxZ = v.BossMenu.Target.maxZ,
                    job = Config.ambulanceJob,
                    distance = 2.0,
                    options = {
                        {
                            name = k..'ems_boss',
                            event = 'wasabi_ambulance:openBossMenu',
                            icon = 'fa-solid fa-suitcase-medical',
                            distance = 2.0,
                            label = v.BossMenu.Target.label,
                            job = Config.ambulanceJob,
                            canInteract = function()
                                return isPlayerDead() == false
                            end
                        }
                    }
                }
                TriggerEvent('wasabi_ambulance:addTarget', data)
            else
                CreateThread(function()
                    local textUI
                    while true do
                        local sleep = 1500
                        local hasJob, _grade = HasGroup(Config.ambulanceJob)
                        if v?.clockInAndOut?.enabled and Framework =='qb' then
                            if not PlayerData.job.onduty then hasJob = nil end
                        end
                        if hasJob then
                            local coords = GetEntityCoords(cache.ped)
                            local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(v.BossMenu.Coords.x, v.BossMenu.Coords.y, v.BossMenu.Coords.z))
                            if dist <= v.BossMenu.Distance then
                                if not textUI then
                                    ShowTextUI(v.BossMenu.Label)
                                    textUI = true
                                end
                                sleep = 0
                                if IsControlJustReleased(0, 38) then
                                    OpenBossMenu(Config.ambulanceJob)
                                end
                            else
                                if textUI then
                                    HideTextUI()
                                    textUI = nil
                                end
                            end
                        end
                        Wait(sleep)
                    end
                end)
            end
        end
        if v.CheckIn.Enabled then
            CreateThread(function()
                local ped, pedSpawned
                local textUI
                while true do
                    local sleep = 1500
                    local playerPed = cache.ped
                    local coords = GetEntityCoords(playerPed)
                    local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(v.CheckIn.Coords.x, v.CheckIn.Coords.y, v.CheckIn.Coords.z))
                    if dist <= 30 and not pedSpawned then
                        lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                        lib.requestModel(v.CheckIn.Ped, 100)
                        ped = CreatePed(28, v.CheckIn.Ped, v.CheckIn.Coords.x, v.CheckIn.Coords.y, v.CheckIn.Coords.z, v.CheckIn.Heading, false, false)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                        pedSpawned = true
                    elseif dist <= v.CheckIn.Distance then
                        if not textUI then
                            ShowTextUI(v.CheckIn.Label)
                            textUI = true
                        end
                        sleep = 0
                        if IsControlJustReleased(0, v.CheckIn.HotKey) then
                            textUI = nil
                            HideTextUI()
                            local cb = lib.callback.await('wasabi_ambulance:tryRevive', 100, v.CheckIn.Cost, v.CheckIn.MaxOnDuty, v.CheckIn.PayAccount)
                            if cb == 'success' then
                                TriggerEvent('wasabi_ambulance:notify', Strings.checkin_hospital, Strings.checkin_hospital_desc, 'success')
                                if Config?.wasabi_crutch?.crutchOnCheckIn?.enabled then
	                            TriggerServerEvent('wasabi_crutch:giveCrutch', cache.serverId, Config.wasabi_crutch.crutchOnCheckIn.duration)
                                end
                            elseif cb == 'max' then
                                TriggerEvent('wasabi_ambulance:notify', Strings.max_ems, Strings.max_ems_desc, 'error')
                            else
                                TriggerEvent('wasabi_ambulance:notify', Strings.not_enough_funds, Strings.not_enough_funds_desc, 'error')
                            end
                        end
                    elseif dist >= (v.CheckIn.Distance + 1) and textUI then
                        HideTextUI()
                        textUI = nil
                    elseif dist >= 31 and pedSpawned then
                        local model = GetEntityModel(ped)
                        SetModelAsNoLongerNeeded(model)
                        DeletePed(ped)
                        SetPedAsNoLongerNeeded(ped)
                        RemoveAnimDict('mini@strip_club@idles@bouncer@base')
                        pedSpawned = nil
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.Cloakroom.Enabled then
            CreateThread(function()
                local textUI
                while true do
                    local sleep = 1500
                    local hasJob, _grade = HasGroup(Config.ambulanceJob)
                    if v?.clockInAndOut?.enabled and Framework =='qb' then
                        if not PlayerData.job.onduty then hasJob = nil end
                    end
                    if hasJob then
                        local ped = cache.ped
                        local coords = GetEntityCoords(ped)
                        local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(v.Cloakroom.Coords.x, v.Cloakroom.Coords.y, v.Cloakroom.Coords.z))
                        if dist <= v.Cloakroom.Range then
                            if not textUI then
                                ShowTextUI(v.Cloakroom.Label)
                                textUI = true
                            end
                            sleep = 0
                            if IsControlJustReleased(0, v.Cloakroom.HotKey) then
                                openOutfits(k)
                            end
                        else
                            if textUI then
                                HideTextUI()
                                textUI = nil
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.MedicalSupplies.Enabled then
            if Config.targetSystem then
                local data = {
                    targetType = 'AddBoxZone',
                    identifier = k..'_medsup',
                    coords = v.MedicalSupplies.Coords,
                    heading = v.MedicalSupplies.Heading,
                    width = 1.0,
                    length = 1.0,
                    minZ = v.MedicalSupplies.Coords.z-1.5,
                    maxZ = v.MedicalSupplies.Coords.z+1.5,
                    job = Config.ambulanceJob,
                    distance = 1.5,
                    options = {
                        {
                            name = k..'_medsup',
                            type = 'client',
                            job = Config.ambulanceJob,
                            distance = 1.5,
                            event = 'wasabi_ambulance:medicalSuppliesMenu',
                            icon = 'fa-solid fa-suitcase-medical',
                            label = Strings.request_supplies_target,
                            hospital = k,
                            canInteract = function()
                                return isPlayerDead() == false
                            end
                        }
                    }
                }
                TriggerEvent('wasabi_ambulance:addTarget', data)
            end
            CreateThread(function() 
                local ped, pedSpawned, textUI
                while true do
                    local sleep = 1500
                    local playerPed = cache.ped
                    local hasJob, _grade = HasGroup(Config.ambulanceJob)
                    if v?.clockInAndOut?.enabled and Framework =='qb' then
                        if not PlayerData.job.onduty then hasJob = nil end
                    end
                    local coords = GetEntityCoords(playerPed)
                    local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(v.MedicalSupplies.Coords.x, v.MedicalSupplies.Coords.y, v.MedicalSupplies.Coords.z))
                    if dist <= 30 and not pedSpawned then
                        lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                        lib.requestModel(v.MedicalSupplies.Ped, 100)
                        ped = CreatePed(28, v.MedicalSupplies.Ped, v.MedicalSupplies.Coords.x, v.MedicalSupplies.Coords.y, v.MedicalSupplies.Coords.z, v.MedicalSupplies.Heading, false, false)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                        pedSpawned = true
                    elseif dist <= 2.5 and not Config.targetSystem then
                        if not textUI and hasJob then
                            ShowTextUI(Strings.open_shop_ui)
                            textUI = true
                        end
                        sleep = 0
                        if IsControlJustReleased(0, 38) and hasJob then
                            medicalSuppliesMenu(k)
                            sleep = 1500
                        end
                    elseif dist >= 2.6 and not Config.targetSystem and textUI then
                        HideTextUI()
                        textUI = false
                    elseif dist >= 31 and pedSpawned then
                        local model = GetEntityModel(ped)
                        SetModelAsNoLongerNeeded(model)
                        DeletePed(ped)
                        SetPedAsNoLongerNeeded(ped)
                        RemoveAnimDict('mini@strip_club@idles@bouncer@base')
                        pedSpawned = false
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.Vehicles.Enabled then
            CreateThread(function()
                local zone = v.Vehicles.Zone
                local textUI
                while true do
                    local sleep = 1500
                    local hasJob, _grade = HasGroup(Config.ambulanceJob)
                    if hasJob and Framework == 'qb' then
                        if not PlayerData.job.onduty then hasJob = nil end
                    end
                    if hasJob then
                        local playerPed = cache.ped
                        local coords = GetEntityCoords(playerPed)
                        local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(zone.coords.x, zone.coords.y, zone.coords.z))
                        local dist2 = #(vector3(coords.x, coords.y, coords.z) - vector3(v.Vehicles.Spawn.air.coords.x, v.Vehicles.Spawn.air.coords.y, v.Vehicles.Spawn.air.coords.z))
                        if dist < zone.range + 1 and not inMenu and not IsPedInAnyVehicle(playerPed, false) then
                            sleep = 0
                            if not textUI then
                                ShowTextUI(zone.label)
                                textUI = true
                            end
                            if IsControlJustReleased(0, 38) then
                                textUI = nil
                                HideTextUI()
                                openVehicleMenu(k)
                                sleep = 1500
                            end
                        elseif dist < zone.range + 1 and not inMenu and IsPedInAnyVehicle(playerPed, false) then
                            sleep = 0
                            if not textUI then
                                textUI = true
                                ShowTextUI(zone.return_label)
                            end
                            if IsControlJustReleased(0, 38) then
                                textUI = nil
                                HideTextUI()
                                if DoesEntityExist(cache.vehicle) then
                                    DoScreenFadeOut(800)
                                    while not IsScreenFadedOut() do Wait(100) end
                                    SetEntityAsMissionEntity(cache.vehicle, true, true)
                                    if Config.AdvancedParking then
                                        exports['AdvancedParking']:DeleteVehicleOnServer(cache.vehicle, nil, nil)
                                    else
                                        DeleteVehicle(cache.vehicle)
                                    end
                                    DoScreenFadeIn(800)
                                end
                            end
                        elseif dist2 < 10 and IsPedInAnyVehicle(playerPed, false) then
                            sleep = 0
                            if not textUI then
                                textUI = true
                                ShowTextUI(zone.return_label)
                            end
                            if IsControlJustReleased(0, 38) then
                                textUI = nil
                                HideTextUI()
                                if DoesEntityExist(cache.vehicle) then
                                    DoScreenFadeOut(800)
                                    while not IsScreenFadedOut() do Wait(100) end
                                    SetEntityAsMissionEntity(cache.vehicle, true, true)
                                    if Config.AdvancedParking then
                                        exports['AdvancedParking']:DeleteVehicleOnServer(cache.vehicle, nil, nil)
                                    else
                                        DeleteVehicle(cache.vehicle)
                                    end
                                    SetEntityCoordsNoOffset(playerPed, zone.coords.x, zone.coords.y, zone.coords.z, false, false, false, true)
                                    DoScreenFadeIn(800)
                                end
                            end
                        else
                            if textUI then
                                textUI = nil
                                HideTextUI()
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
    end
end)

RegisterNetEvent('wasabi_ambulance:useBandage', function()
    local HasItem = lib.callback.await('wasabi_ambulance:itemCheck', 100, Config.Bandages.item)
    if not HasItem or HasItem < 1 then return end
    if lib.progressBar({
        duration = Config.Bandages.duration,
        label = Strings.healing_self_prog,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'missheistdockssetup1clipboard@idle_a',
            clip = 'idle_a'
        },
    }) then
        TriggerServerEvent('wasabi_ambulance:useBandage', cache.serverId)
        local health = GetEntityHealth(cache.ped)
        health = (Config.Bandages.hpRegen * 2) + health
        if health > 200 then health = 200 end
        SetEntityHealth(cache.ped, health + 0.0)
        if Config.MythicHospital then
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            TriggerEvent('mythic_hospital:client:ResetLimbs')
        end
    else
        TriggerEvent('wasabi_ambulance:notify', Strings.action_cancelled, Strings.action_cancelled_desc, 'error')
    end
end)

RegisterNetEvent('wasabi_ambulance:syncRequests', function(_plyRequests, quiet)
    local hasJob, _grade = HasGroup(Config.ambulanceJob)
    if v?.clockInAndOut?.enabled and Framework =='qb' then
        if not PlayerData.job.onduty then hasJob = nil end
    end
    if hasJob then
        plyRequests = _plyRequests
        if not quiet then
            TriggerEvent('wasabi_ambulance:notify', Strings.assistance_title, Strings.assistance_desc, 'error', 'suitcase-medical')
        end
    end
end)

RegisterNetEvent('wasabi_ambulance:weaponRemove', function()
    RemoveAllPedWeapons(cache.ped, true)
end)

if Framework == 'esx' then
    RegisterNetEvent('esx_ambulancejob:revive', function()
        if Config.Anticheat then
            TriggerServerEvent('wasabi_ambulance:punishPlayer', 'esx_ambulancejob:revive triggered')
        else
            TriggerEvent('wasabi_ambulance:revive')
        end
    end)
end

RegisterNetEvent('wasabi_ambulance:revivePlayer', function()
    if isDead then
        local ped = cache.ped
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        local Injury = injury
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(50)
        end
        TriggerServerEvent('wasabi_ambulance:setDeathStatus', false)
        isDead = false
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
        ClearPedBloodDamage(ped)
        if Config.MythicHospital then
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            TriggerEvent('mythic_hospital:client:ResetLimbs')
        end
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(800)
        AnimpostfxStopAll()
        if Framework == 'esx' then
            TriggerServerEvent('esx:onPlayerSpawn')
            TriggerEvent('esx:onPlayerSpawn')
        elseif Framework == 'qb' then
            TriggerServerEvent('hospital:server:resetHungerThirst') -- qb-ambulancejob compatibility
            TriggerEvent('wasabi_ambulance:onPlayerSpawn')
        end
        ClearPedTasks(ped)
        if not Injury then
            SetEntityHealth(ped, 200.0)
        else
            ApplyDamageToPed(ped, Config.ReviveHealth[Injury])
        end
    end 
end)

RegisterNetEvent('wasabi_ambulance:revive',function()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    TriggerServerEvent('wasabi_ambulance:setDeathStatus', false)
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Wait(50)
    end
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    ClearPedBloodDamage(ped)
    isDead = false
    if Config.MythicHospital then
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
    end
    DoScreenFadeIn(800)
    AnimpostfxStopAll()
    if Framework == 'esx' then
        TriggerServerEvent('esx:onPlayerSpawn')
        TriggerEvent('esx:onPlayerSpawn')
    elseif Framework == 'qb' then
        TriggerServerEvent('hospital:server:resetHungerThirst') -- qb-ambulancejob compatibility
        TriggerEvent('wasabi_ambulance:onPlayerSpawn')
    end
end)

RegisterNetEvent('wasabi_ambulance:heal', function(full, quiet)
    local ped = cache.ped
    local maxHealth = 200
    if not full then
        local health = GetEntityHealth(ped)
        local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
        SetEntityHealth(ped, newHealth + 0.0)
    else
        SetEntityHealth(ped, maxHealth + 0.0)
        if Framework == 'qb' then
            TriggerServerEvent('hospital:server:resetHungerThirst')
        end
    end
    if Config.MythicHospital then
        TriggerEvent('mythic_hospital:client:RemoveBleed')
        TriggerEvent('mythic_hospital:client:ResetLimbs')
    end
    if not quiet then
        TriggerEvent('wasabi_ambulance:notify', Strings.player_successful_heal, Strings.player_healed_desc, 'success')
    end
end)

RegisterNetEvent('wasabi_ambulance:sedate', function()
    local ped = cache.ped
    TriggerEvent('wasabi_ambulance:notify', Strings.assistance_title, Strings.assistance_desc, 'success', 'syringe')
    ClearPedTasks(ped)
    lib.requestAnimDict(Config.DeathAnimation.anim, 100)
    disableKeys = true
    TaskPlayAnim(ped, Config.DeathAnimation.anim, Config.DeathAnimation.lib, 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    Wait(Config.EMSItems.sedate.duration)
    FreezeEntityPosition(ped, false)
    disableKeys = false
    ClearPedTasks(ped)
    RemoveAnimDict(Config.DeathAnimation.anim)
end)

RegisterNetEvent('wasabi_ambulance:intoVehicle', function()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    if IsPedInAnyVehicle(ped) then
        coords = GetOffsetFromEntityInWorldCoords(ped, -2.0, 1.0, 0.0)
        SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    else
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 6.0) then
            local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 6.0, 0, 71)
            if DoesEntityExist(vehicle) then
                local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
                for i=maxSeats - 1, 0, -1 do
                    if IsVehicleSeatFree(vehicle, i) then
                        freeSeat = i
                        break
                    end
                end
                if freeSeat then
                    TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
                end
            end
        end
    end
end)

RegisterNetEvent('wasabi_ambulance:syncObj', function(netObj)
    local obj = NetToObj(netObj)
    deleteObj(obj)
end)

RegisterNetEvent('wasabi_ambulance:useSedative', function()
    useSedative()
end)

RegisterNetEvent('wasabi_ambulance:useMedbag', function()
    useMedbag()
end)

RegisterNetEvent('wasabi_ambulance:treatPatient', function(injury)
    treatPatient(injury)
end)

AddEventHandler('wasabi_ambulance:buyItem', function(data)
    TriggerServerEvent('wasabi_ambulance:restock', data)
end)

RegisterNetEvent('wasabi_ambulance:placeOnStretcher', function()
    placeOnStretcher()
end)

AddEventHandler('wasabi_ambulance:openBossMenu', function()
    OpenBossMenu()
end)

AddEventHandler('wasabi_ambulance:spawnVehicle', function(data)
    inMenu = false
    local model = data.model
    local category = Config.Locations[data.hospital].Vehicles.Options[data.model].category
    local spawnLoc = Config.Locations[data.hospital].Vehicles.Spawn[category]
    if not IsModelInCdimage(GetHashKey(model)) then
        print('Vehicle model not found: '..model)
    else
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(100)
        end
        lib.requestModel(model, 100)
        local vehicle = CreateVehicle(GetHashKey(model), spawnLoc.coords.x, spawnLoc.coords.y, spawnLoc.coords.z, spawnLoc.heading, 1, 0)
        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
        if Config.customCarlock then
            local plate = GetVehicleNumberPlateText(vehicle)
            addCarKeys(plate, model)
        end
        SetModelAsNoLongerNeeded(model)
        DoScreenFadeIn(800)
    end
end)


AddEventHandler('wasabi_ambulance:crutchMenu', function()
    exports.wasabi_crutch:OpenCrutchMenu()
end)

AddEventHandler('wasabi_ambulance:chairMenu', function()
    exports.wasabi_crutch:OpenChairMenu()
end)

AddEventHandler('wasabi_ambulance:billPatient', function()
    if HasGroup(Config.ambulanceJob) then
        local coords = GetEntityCoords(cache.ped)
        local player = lib.getClosestPlayer(vec3(coords.x, coords.y, coords.z), 2.0, false)
        if not player then
            TriggerEvent('wasabi_ambulance:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
        else
            local targetId = GetPlayerServerId(player)
            if Config.billingSystem == 'okok' then
                TriggerEvent('okokBilling:ToggleCreateInvoice')
            else
                local input = lib.inputDialog(Strings.bill_patient, {Strings.amount})
                if not input then return end
                local amount = math.floor(tonumber(input[1]))
                if amount < 1 then
                    TriggerEvent('wasabi_ambulance:notify', Strings.invalid_entry, Strings.invalid_entry_desc, 'error')
                elseif Config.billingSystem == 'pefcl' then
                    TriggerServerEvent('wasabi_ambulance:billPlayer', targetId, amount)
                elseif Config.billingSystem == 'qb' then
                    TriggerServerEvent('wasabi_ambulance:qbBill', targetId, amount, Config.ambulanceJob)
                    local gender = Strings.mr
                    if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
                        gender = Strings.mrs
                    end
                    local charinfo = QBCore.Functions.GetPlayerData().charinfo
                    TriggerServerEvent('qb-phone:server:sendNewMail', {
                        sender = jobLabel,
                        subject = Strings.debt_collection,
                        message = (Strings.db_email):format(gender, charinfo.lastname, amount),
                        button = {}
                    })
                elseif Config.billingSystem == 'esx' then
                    TriggerServerEvent('esx_billing:sendBill', targetId, 'society_ambulance', 'EMS', amount)
                else
                    print('No proper billing system selected in configuration!') -- Replace this with your own billing
                end
            end
        end
    end
end)

AddEventHandler('wasabi_ambulance:medicalSuppliesMenu', function(data)
    medicalSuppliesMenu(data.hospital)
end)

AddEventHandler('wasabi_ambulance:gItem', function(data)
    gItem(data)
end)

AddEventHandler('wasabi_ambulance:interactBag', function()
    interactBag()
end)

AddEventHandler('wasabi_ambulance:pickupBag', function()
    pickupBag()
end)

AddEventHandler('wasabi_ambulance:placeInVehicle', function()
    placeInVehicle()
end)

AddEventHandler('wasabi_ambulance:dispatchMenu', function()
    openDispatchMenu()
end)

AddEventHandler('wasabi_ambulance:setRoute', function(data)
    setRoute(data)
end)

AddEventHandler('wasabi_ambulance:diagnosePatient', function()
    diagnosePatient()
end)

AddEventHandler('wasabi_ambulance:loadStretcher', function()
    loadStretcher()
end)

RegisterNetEvent('wasabi_ambulance:useStretcher')
AddEventHandler('wasabi_ambulance:useStretcher', function()
    useStretcher()
end)

AddEventHandler('wasabi_ambulance:pickupStretcher', function()
    pickupStretcher()
end)

AddEventHandler('wasabi_ambulance:moveStretcher', function()
    moveStretcher()
end)

RegisterNetEvent('wasabi_ambulance:reviveTarget')
AddEventHandler('wasabi_ambulance:reviveTarget', function()
    reviveTarget()
end)

RegisterNetEvent('wasabi_ambulance:healTarget')
AddEventHandler('wasabi_ambulance:healTarget', function()
    healTarget()
end)

RegisterCommand('emsJobMenu', function()
    openJobMenu()
end)

AddEventHandler('wasabi_ambulance:emsJobMenu', function()
    openJobMenu()
end)

TriggerEvent('chat:removeSuggestion', '/emsJobMenu')

RegisterKeyMapping('emsJobMenu', Strings.key_map_text, 'keyboard', Config.jobMenu)
