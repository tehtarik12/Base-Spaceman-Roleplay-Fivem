_ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) _ESX = obj end)

-- Allowed to reset during server restart
-- You can use this number to calculate a vehicle spawn location index if you have multiple
-- eg: 3 spawnlocations = index % 3 + 1
local _UnimpoundedVehicleCount = 1;

RegisterServerEvent('HRP:Impound:ImpoundVehicle')
RegisterServerEvent('HRP:Impound:GetImpoundedVehicles')
RegisterServerEvent('HRP:Impound:GetVehicles')
RegisterServerEvent('HRP:Impound:UnimpoundVehicle')
RegisterServerEvent('HRP:Impound:UnlockVehicle')

AddEventHandler('HRP:Impound:ImpoundVehicle', function (form)
	_source = source;
	exports.oxmysql:execute('INSERT INTO `h_impounded_vehicles` VALUES (@plate, @officer, @mechanic, @releasedate, @fee, @reason, @notes, CONCAT(@vehicle), @identifier, @hold_o, @hold_m)', {
		['@plate'] 			= form.plate,
		['@officer']     	= form.officer,
		['@mechanic']       = form.mechanic,
		['@releasedate']	= form.releasedate,
		['@fee']			= form.fee,
		['@reason']			= form.reason,
		['@notes']			= form.notes,
		['@vehicle']		= form.vehicle,
		['@identifier']		= form.identifier,
		['@hold_o']			= form.hold_o,
		['@hold_m']			= form.hold_m
	}, function(rowsChanged)
		if not rowsChanged then
			TriggerClientEvent('esx:showNotification', _source, 'Could not impound')
		else
			exports.oxmysql:execute('UPDATE owned_vehicles SET `stored` = @stored, `garage` = @garage , `last_garage` = @last_garage WHERE `plate` = @plate', {
				['@plate']  = form.plate,
				['@stored'] = '2',
				['@garage'] = 'Samsat',
				['@last_garage'] = 'Samsat' 
			})
			TriggerClientEvent('esx:showNotification', _source, 'Vehicle Impounded')
		end
	end)
end)

RegisterNetEvent('luke_garages:ChangeStored', function(plate)
    local plate = ESX.Math.Trim(plate)
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `stored` = @stored, `garage` = @garage , `sita` = @sita WHERE `plate` = @plate', {
        ['@garage'] = 'none',
        ['@stored'] = 0,
		['@sita'] = 0,
        ['@plate'] = plate
    })
end)

AddEventHandler('HRP:Impound:GetImpoundedVehicles', function (identifier)
	_source = source;
	exports.oxmysql:execute('SELECT * FROM `h_impounded_vehicles` WHERE `identifier` = @identifier ORDER BY `releasedate`', {
		['@identifier'] = identifier,
	}, function (impoundedVehicles)
		TriggerClientEvent('HRP:Impound:SetImpoundedVehicles', _source, impoundedVehicles)
	end)
end)

AddEventHandler('HRP:Impound:UnimpoundVehicle', function (plate)
	_source = source;
	xPlayer = _ESX.GetPlayerFromId(_source)

	_UnimpoundedVehicleCount = _UnimpoundedVehicleCount + 1;

	Citizen.Trace('HRP: Unimpounding Vehicle with plate: ' .. plate);

	local veh = exports.oxmysql:executeSync('SELECT * FROM `h_impounded_vehicles` WHERE `plate` = @plate', {['@plate'] = plate})

	if(veh == nil) then
		TriggerClientEvent("HRP:Impound:CannotUnimpound", _source)
		return
	end

	if (xPlayer.getMoney() < veh[1].fee) then
		TriggerClientEvent("HRP:Impound:CannotUnimpound", _source)
	else
		xPlayer.removeMoney(round(veh[1].fee));

		exports.oxmysql:execute('DELETE FROM `h_impounded_vehicles` WHERE `plate` = @plate', {
			['@plate'] = plate,
		}, function (rows)
			TriggerClientEvent('HRP:Impound:VehicleUnimpounded', _source, veh[1], _UnimpoundedVehicleCount)
			exports.oxmysql:execute('UPDATE owned_vehicles SET `stored` = @stored WHERE `plate` = @plate AND `garage` = @garage AND `last_garage` = @last_garage', {
				['@plate'] = plate,
				['@stored'] = '1',
				['@garage'] = 'legion',
				['@last_garage'] = 'legion' 
			})
		end)
	end
end)

AddEventHandler('HRP:Impound:GetVehicles', function ()
	_source = source;

	exports.oxmysql:execute('SELECT * FROM `h_impounded_vehicles`', nil, function (vehicles)
		TriggerClientEvent('HRP:Impound:SetImpoundedVehicles', _source, vehicles);
	end);
end)

AddEventHandler('HRP:Impound:UnlockVehicle', function (plate)
	exports.oxmysql:execute('UPDATE `h_impounded_vehicles` SET `hold_m` = false, `hold_o` = false WHERE `plate` = @plate', {
		['@plate'] = plate
	})
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Stupid extra shit because fuck all of this
-------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('HRP:esx:GetCharacter')
AddEventHandler('HRP:esx:GetCharacter', function (identifier)
	local _source = source
	exports.oxmysql:execute('SELECT * FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] 		= identifier,
	}, function(users)
		TriggerClientEvent('HRP:esx:SetCharacter', _source, users[1]);
	end)
end)

RegisterServerEvent('HRP:esx:GetVehicleAndOwner')
AddEventHandler('HRP:esx:GetVehicleAndOwner', function (plate)
	local _source = source
	if (Config.NoPlateColumn == false) then
		exports.oxmysql:execute('SELECT * FROM `owned_vehicles` LEFT JOIN `users` ON users.identifier = owned_vehicles.owner WHERE `plate` = rtrim(@plate)', {
			['@plate'] 		= plate,
		}, function(vehicleAndOwner)
			TriggerClientEvent('HRP:esx:SetVehicleAndOwner', _source, vehicleAndOwner[1]);
		end)
	else
		exports.oxmysql:execute('SELECT * FROM `owned_vehicles` LEFT JOIN `users` ON users.identifier = owned_vehicles.owner', {}, function (result)
			for i=1, #result, 1 do
				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate:gsub("%s+", "") == plate:gsub("%s+", "") then
					vehicleAndOwner = result[i];
					vehicleAndOwner.plate = vehicleProps.plate;
					TriggerClientEvent('HRP:esx:SetVehicleAndOwner', _source, vehicleAndOwner);
					break;
				end
			end
		end)
	end
end)


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end