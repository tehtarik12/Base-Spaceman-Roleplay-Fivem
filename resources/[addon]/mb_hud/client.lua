ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Citizen.Wait(1000)

    SendNUIMessage({
        type='display',
        idjob=Config.enableIdJob,
        watermark=Config.enableWaterMark,
    })

    ESX.PlayerData = xPlayer

    SendNUIMessage({
        type='setData',
        watermark=Config.watermarkText,
        id=GetPlayerServerId(PlayerId()),
        jobname=ESX.PlayerData.job.name,
        job=ESX.PlayerData.job.label,
        grade=ESX.PlayerData.job.grade_label
    })
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	SendNUIMessage({
        type='setData',
        watermark=Config.watermarkText,
        id=GetPlayerServerId(PlayerId()),
        jobname=ESX.PlayerData.job.name,
        job=ESX.PlayerData.job.label,
        grade=ESX.PlayerData.job.grade_label
    })
end)