local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local idVisable = true
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('vinsan_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 128),
		uptime = 'unknown',
		playTime = '00h 00m'
	})
end)

RegisterNetEvent('vinsan_scoreboard:updateConnectedPlayers')
AddEventHandler('vinsan_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('vinsan_scoreboard:updatePing')
AddEventHandler('vinsan_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('vinsan_scoreboard:toggleID')
AddEventHandler('vinsan_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, police, taxi, mechanic, pedagang, slaughterer, fueler, lumberjack, tailor, busdriver, cargo, fisherman, miner, petani, trucker, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do

		if num == 1 then
			table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 2
		elseif num == 2 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 3
		elseif num == 3 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 4
		elseif num == 4 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping))
			num = 1
		end

		players = players + 1

		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'taxi' then
			taxi = taxi + 1
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1
		elseif v.job == 'pedagang' then
			pedagang = pedagang + 1
		-- elseif v.job == 'slaughterer' then
		-- 	slaughterer = slaughterer + 1
		-- elseif v.job == 'fueler' then
		-- 	fueler = fueler + 1
		-- elseif v.job == 'lumberjack' then
		-- 	lumberjack = lumberjack + 1
		-- elseif v.job == 'tailor' then
		-- 	tailor = tailor + 1
		-- elseif v.job == 'busdriver' then
		-- 	busdriver = busdriver + 1
		-- elseif v.job == 'cargo' then
		-- 	cargo = cargo + 1
		-- elseif v.job == 'fisherman' then
		-- 	fisherman = fisherman + 1
		-- elseif v.job == 'miner' then
		-- 	miner = miner + 1
		-- elseif v.job == 'petani' then
		-- 	petani = petani + 1
		-- elseif v.job == 'trucker' then
		-- 	trucker = trucker + 1
		end
	end

	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})
	if ems > 3 then
		ems = '3+'
	end

	if police > 7 then
		police = '7+'
	end
	
	if mechanic > 3 then
		mechanic = '3+'
	end

	if pedagang > 3 then
		pedagang = '3+'
	end

	if slaughterer > 3 then
		slaughterer = '3+'
	end

	if fueler > 3 then
		fueler = '3+'
	end

	if lumberjack > 3 then
		lumberjack = '3+'
	end

	if tailor > 3 then
		tailor = '3+'
	end

	if busdriver > 3 then
		busdriver = '3+'
	end

	if cargo > 3 then
		cargo = '3+'
	end

	if fisherman > 3 then
		fisherman = '3+'
	end

	if miner > 3 then
		miner = '3+'
	end

	if petani > 3 then
		petani = '3+'
	end

	if trucker > 3 then
		trucker = '3+'
	end

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, taxi = taxi, mechanic = mechanic, pedagang = pedagang, slaughterer = slaughterer, fueler = fueler, lumberjack = lumberjack, tailor = tailor, busdriver = busdriver, cargo = cargo, fisherman = fisherman, miner = miner, petani = petani, trucker = trucker, player_count = players}
		
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['F5']) and IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)

		-- D-pad up on controllers works, too!
		--elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
		--	ToggleScoreBoard()
		--	Citizen.Wait(200)
		end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end

Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)

RegisterCommand('openScoreboard', ToggleScoreBoard)
RegisterKeyMapping('openScoreboard', '[UI] Scoreboard', 'keyboard', 'F5')