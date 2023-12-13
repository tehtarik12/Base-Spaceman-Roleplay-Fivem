Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)

			if dist < Config.Distance and not v.isRendered then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				v.ped = ped
				v.isRendered = true
			end
			
			if dist >= Config.Distance and v.isRendered then
				if Config.Fade then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(v.ped, i, false)
					end
				end
				DeletePed(v.ped)
				v.ped = nil
				v.isRendered = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local letSleep = 1000
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			if v.text and v.spawnedPed then
				letSleep = 0
				if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(v.spawnedPed)) < 5.0 then
					DrawText3DProp(GetEntityCoords(v.spawnedPed), v.text)
				end
			end
		end

		Wait(letSleep)
	end
end)

function nearPed(model, coords, heading, gender, animDict, animName, scenario)
	local genderNum = 0
--AddEventHandler('nearPed', function(model, coords, heading, gender, animDict, animName)
	-- Request the models of the peds from the server, so they can be ready to spawn.
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(1)
	end
	
	-- Convert plain language genders into what fivem uses for ped types.
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end	

	--Check if someones coordinate grabber thingy needs to subract 1 from Z or not.
	if Config.MinusOne then 
		local x, y, z = table.unpack(coords)
		ped = CreatePed(genderNum, GetHashKey(model), x, y, z - 1, heading, false, true)
		
	else
		ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	end
	
	SetEntityAlpha(ped, 0, false)
	
	if Config.Frozen then
		FreezeEntityPosition(ped, true) --Don't let the ped move.
	end
	
	if Config.Invincible then
		SetEntityInvincible(ped, true) --Don't let the ped die.
	end

	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(ped, true) --Don't let the ped react to his surroundings.
	end
	
	--Add an animation to the ped, if one exists.
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) -- begins peds animation
	end
	
	if Config.Fade then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(ped, i, false)
		end
	end

	return ped
end

function addPed(model, coords, heading, gender, isRendered, ped, text)
	table.insert(Config.PedList, {
		model = model, --The model name. See above for the URL of the list.
		coords = coords, --HAIR ON HAWICK AVE
		heading = heading, --Must be a float value. This means it needs a decimal and a number after the decimal.
		gender = gender, --Use male or female
	    isRendered = isRendered,
        ped = ped,
		text = text,
	})
end
exports("addPed", addPed)

function DrawText3DProp(coords, text)
	SetDrawOrigin(coords)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(0.0, 0.0)
	DrawRect(0.0, 0.0125, 0.015 + text:gsub('~.-~', ''):len() / 370, 0.03, 25, 25, 25, 180)
	ClearDrawOrigin()
end