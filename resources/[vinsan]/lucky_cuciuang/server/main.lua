local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WhiteningMoney(source,percent)
	local source = source
		SetTimeout(3000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')
			local _percent		= Config.Percentage
			local izin = false
			
			if xPlayer.job.name == 'fama' or xPlayer.job.name == 'famb' or xPlayer.job.name == 'famc' or xPlayer.job.name == 'famd' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'famf' or xPlayer.job.name == 'famg' then
				izin = true
			end
			
			if izin == true then
			if blackMoney.money < Config.Slice then
				TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Nocash') .. Config.Slice)
			else
				local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
				-- local washedMoney = math.floor(Config.Slice / 100 * (_percent + bonus))
				local washedMoney = 8500

				xPlayer.removeAccountMoney('black_money', Config.Slice)
				xPlayer.addMoney(washedMoney)
				WhiteningMoney(source,_percent)
				
				-- TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))
			end
			end
		end
	end)
end

RegisterServerEvent('esx_blanchisseur:washMoney')
AddEventHandler('esx_blanchisseur:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')
	local _percent		= Config.Percentage
	local izin = false

	if xPlayer.job.name == 'fama' or xPlayer.job.name == 'famb' or xPlayer.job.name == 'famc' or xPlayer.job.name == 'famd' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'famf' or xPlayer.job.name == 'famg' then
		izin = true
	end

	if izin == true then
	if amount > 0 and account.money >= amount then
		
		local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
		local washedMoney = 8500
		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)
		
		local fortisLogsTable = {
			["identifier"] = xPlayer,
			["totalduitnya"] = account,
			["cuciberapa"] = washedMoney,
		}
		exports["fortislogs"]:addLog("Cuci Uang", fortisLogsTable) 
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))
		
	else
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('invalid_amount'))
	end
	end

end)

RegisterServerEvent('esx_blanchisseur:startWhitening')
AddEventHandler('esx_blanchisseur:startWhitening', function(percent)
	--local validate = exports.luke_auth:validasi(source, token, 'esx_blanchisseur:startWhitening')
	--if validate then
		PlayersWashing[source] = true
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Whitening'))
		WhiteningMoney(source,percent)
	--end
end)

RegisterServerEvent('esx_blanchisseur:Nothere')
AddEventHandler('esx_blanchisseur:Nothere', function()
	PlayersWashing[source] = false
	TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Nothere'))
end)


RegisterServerEvent('esx_blanchisseur:stopWhitening')
AddEventHandler('esx_blanchisseur:stopWhitening', function()
	PlayersWashing[source] = false
end)
