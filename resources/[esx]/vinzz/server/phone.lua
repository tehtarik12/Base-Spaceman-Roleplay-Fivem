AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	if not xPlayer then
		xPlayer = ESX.GetPlayerFromId(playerId)
	end

	local firstName, lastName
	if xPlayer.firstName then firstName = xPlayer.firstName else xPlayer.get('firstName') end
	if xPlayer.lastName then lastName = xPlayer.lastName else xPlayer.get('lastName') end

	--[[exports.npwd:newPlayer({
		source = playerId,
		identifier = xPlayer.identifier,
		firstname = firstName,
		lastname = lastName,
	}) ]]
end)

AddEventHandler('esx:playerLogout', function(playerId)
	exports.npwd:unloadPlayer(playerId)
end)

AddEventHandler('onServerResourceStart', function(resource)
	if resource == 'npwd' then
		local xPlayers = ESX.GetExtendedPlayers()

		if next(xPlayers) then
			Wait(100)
			local isTable = type(xPlayers[1]) == 'table'

			for i=1, #xPlayers do
				-- Fallback to `GetPlayerFromId` if playerdata was not already returned
				local xPlayer = isTable and xPlayers[i] or ESX.GetPlayerFromId(xPlayers[i])

				local firstName, lastName
				if xPlayer.firstName then firstName = xPlayer.firstName else xPlayer.get('firstName') end
				if xPlayer.lastName then lastName = xPlayer.lastName else xPlayer.get('lastName') end

			--[[	exports.npwd:newPlayer({
					source = xPlayer.source,
					identifier = xPlayer.identifier,
					firstname = firstName,
					lastname = lastName,
				}) ]]
			end
		end
	end
end)