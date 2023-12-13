RegisterCommand('transfervehicle', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(args[1])
	--local count = exports.ox_inventory:Search(xPlayer.source, 'slots', 'car_contract')

	--if count > 0 then 
		if xTarget then
			local plate1 = args[2]
			local plate2 = args[3]
			local plate3 = args[4]
			local plate4 = args[5]
			if plate1 ~= nil then plate01 = plate1 else plate01 = "" end
			if plate2 ~= nil then plate02 = plate2 else plate02 = "" end
			if plate3 ~= nil then plate03 = plate3 else plate03 = "" end
			if plate4 ~= nil then plate04 = plate4 else plate04 = "" end
			local plate = (plate01 .. " " .. plate02 .. " " .. plate03 .. " " .. plate04)

			MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `owner` = @owner AND `plate` = @plate', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = plate,
			}, function(result)
				if result[1] then
					if xPlayer.identifier == result[1].owner and xPlayer.getGroup() ~= 'superadmin' then
						MySQL.Async.execute("UPDATE owned_vehicles SET `owner` = @owner WHERE `plate` = @plate", {['@owner'] = xTarget.identifier, ['@plate'] = plate})
						xPlayer.showNotification('Berhasil memberikan kendaraan kepada: '.. xTarget.getName())
						--exports.ox_inventory:RemoveItem(xPlayer.source, 'car_contract', '1')
						ESX.SendDiscord(GetPlayerName(source), 'Telah Memberikan Kendaraan Dengan Plat**'.. plate ..'** Kepada'.. GetPlayerName(args[1]), 'transfervehicle')

						TriggerClientEvent('esx:showNotification', -1, xPlayer.getName().. ' MEMBERIKAN KENDARAAN DENGAN PLAT: '..plate.. ' KEPADA '.. xTarget.getName())
					else
						xPlayer.showNotification('Kendaraan tersebut bukan milik anda!')
					end
				else
					xPlayer.showNotification('Tidak dapat menemukan kendaraan dengan plat tersebut!')
				end
			end)
		else
			xPlayer.showNotification('Tidak dapat menemukan pemain dengan ID tersebut!')
		end
end)