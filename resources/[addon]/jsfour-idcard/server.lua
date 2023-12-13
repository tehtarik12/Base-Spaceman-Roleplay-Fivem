-- Open ID card
function IDCard(source, type, target, data)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'ktp' then
		local array = {
			user = {
				firstname = xPlayer.get('firstName'),
				lastname = xPlayer.get('lastName'),
				dateofbirth = xPlayer.get('dateofbirth'),
				sex = xPlayer.get('sex'),
				height = xPlayer.get('height'),
			},
			licenses = {}
		}
		TriggerClientEvent('jsfour-idcard:open', target, array, type)
		if type == 'badge' and source ~= target then
			TriggerClientEvent('jsfour-idcard:showBadge', source)
		end
	elseif type == 'badge' and data then
		local array = {
			user = {
				firstname = data.firstname,
				lastname = data.lastname,
				gradename = data.gradename,
				dateofbirth = data.dateofbirth,
				sex = data.sex,
				height = data.height,
			},
			licenses = {}
		}
		TriggerClientEvent('jsfour-idcard:open', target, array, type)
		if source ~= target then
			TriggerClientEvent('jsfour-idcard:showBadge', source)
		end
	elseif type ~= 'ktp' then
		TriggerEvent('esx_license:getLicenses', source, function(licenses)
			local array = {
				user = {
					firstname = xPlayer.get('firstName'),
					lastname = xPlayer.get('lastName'),
					dateofbirth = xPlayer.get('dateofbirth'),
					sex = xPlayer.get('sex'),
					height = xPlayer.get('height'),
				},
				licenses = licenses
			}
			TriggerClientEvent('jsfour-idcard:open', target, array, type)
		end)
	else
		TriggerClientEvent('esx:showNotification', source, {type = 'error', text = "Anda tidak memiliki jenis lisensi itu.."})
	end
end
exports('IDCard', IDCard)

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(type, target, data)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem(type).count >= 1 then
		IDCard(source, type, target, data)
	else
		TriggerClientEvent('esx:showNotification', source, {type = 'error', text = "Anda tidak memiliki jenis lisensi itu.."})
	end
end)

ESX.RegisterUsableItem('ktp', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	IDCard(source, 'ktp', source)
end)

ESX.RegisterUsableItem('sim', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	IDCard(source, 'sim', source)
end)

ESX.RegisterUsableItem('license', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	IDCard(source, 'license', source)
end)

ESX.RegisterUsableItem('badge', function(source, item, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = xPlayer.getPlayerSlot(data.slot, 'badge')

	if items and items.metadata and items.metadata.serial then
		IDCard(source, 'badge', source, items.metadata.serial)
	end
end)