ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('ooc', function(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'jangan biasakan OOC | /report jika ada pertanyaan', length = 10000})
end, false)

RegisterCommand('koma', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message emergency"><b>KOMA | {0}</b>: {1}</div>',
        args = { playerName , msg }
    })
end, false)



RegisterCommand('pengumuman', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local msg = rawCommand:sub(11)

	if xPlayer.getGroup() ~= 'user' then
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message ems"><b>PENGUMUMAN |</b> {0}</div>',
        args = { msg }
    })
end
end, false)

-- RegisterCommand('iklan', function(source, args, rawCommand)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
--     local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(6)
--     local name = getIdentity(source)
--     fal = name.firstname .. " " .. name.lastname
-- 	if xPlayer.getMoney() >= 100000 then
-- 		TriggerClientEvent('chat:addMessage', -1, {
-- 			template = '<div class="chat-message advert"><b>IKLAN | {0}</b>: {1}</div>',
-- 			args = { fal, msg }
-- 		})
-- 		xPlayer.removeMoney(100000)
-- 	else
-- 		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Tidak memiliki cukup uang', length = 2500})
-- 	end
-- end, false)

RegisterCommand('pol', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
	local job = xPlayer.job.name
	local jobGrade = xPlayer.job.grade_label

	if xPlayer.job.name == "police" then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message polisi"><b>POLISI | {0} {1} </b> : {2}</div>',
        args = { jobGrade, playerName, msg }
    })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bukan anggota polisi', length = 2500})
	end
end, false)


RegisterCommand('ems', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
    local job = xPlayer.job.name
	local jobGrade = xPlayer.job.grade_label

	if xPlayer.job.name == "ambulance" then
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message ems"><b>MEDIS | {0} {1} </b> : {2}</div>',
        args = { jobGrade, playerName, msg }
    })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bukan anggota medis', length = 2500})
	end
end, false)

RegisterCommand('mech', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
    local job = xPlayer.job.name
	local jobGrade = xPlayer.job.grade_label

	if xPlayer.job.name == "mechanic" then
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message taxi"><b>MEKANIK | {0} {1} </b> : {2}</div>',
        args = { jobGrade, playerName, msg }
    })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bukan mekanik', length = 2500})
	end
end, false)

RegisterCommand('ped', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
    local job = xPlayer.job.name
	local jobGrade = xPlayer.job.grade_label

	if xPlayer.job.name == "pedagang" then
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message ojek"><b>PEDAGANG | {0} {1} </b> : {2}</div>',
        args = { jobGrade, playerName, msg }
    })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bukan Pedagang', length = 2500})
	end
end, false)

RegisterCommand('report', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local length = string.len('report')
	local message = rawCommand:sub(length + 1)
	local xPlayers = ESX.GetPlayers()

	for k,v in pairs(xPlayers) do
	    local xTarget = ESX.GetPlayerFromId(v)
	    if xTarget.getGroup() == 'admin' or xTarget.getGroup() == 'superadmin' then
	        TriggerClientEvent('chat:addMessage', xTarget.source, {
                template = '<div class="chat-message ojek"><b>REPORT | {0} :  {1} </b> </div>',
                args = { '['..source..'] ' .. GetPlayerName(source), message }
            })
        end
    end

    TriggerClientEvent('chat:addMessage', source, {
		template = '<div class="chat-message ojek"><b>REPORT | {0} : {1}  </b> </div>',
		args = { '['..source..'] ' .. GetPlayerName(source), message }
	})
end)

RegisterCommand('cd', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()
    local job = xPlayer.job.name
	local jobGrade = xPlayer.job.grade_label

	if xPlayer.job.name == "cardealer" then
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message dealer"><b>MS Car Dealer | {0} {1} </b> : {2}</div>',
        args = { jobGrade, playerName, msg }
    })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bukan Car Dealer', length = 2500})
	end
end, false)

RegisterCommand('reply', function(source, args, rawCommand)
	local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
	local xPlayer = ESX.GetPlayerFromId(source)
	local length = string.len('reply '..args[1])
    local xPlayers = ESX.GetPlayers()
	local message = rawCommand:sub(length + 1)
	if xTarget and xPlayer and isAdmin(xPlayer) then
		TriggerClientEvent('chat:addMessage', xTarget.source, {
			template = '<div class="chat-message combat"><b>MEMBALAS REPORT | {0} :  {1} </b> </div>',
			args = { '['..source..'] ' .. GetPlayerName(source), message }
		})
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div class="chat-message combat"><b>MEMBALAS REPORT | {0} :  {1} </b> </div>',
			args = { '['..source..'] ' .. GetPlayerName(source), message }
		})
	end
	
	for k,v in pairs(xPlayers) do
        local xTargets = ESX.GetPlayerFromId(v)
        if xTargets.getGroup() == 'admin' or xTargets.getGroup() == 'superadmin' then
            TriggerClientEvent('chat:addMessage', xTarget.source, {
				template = '<div class="chat-message combat"><b>MEMBALAS REPORT | {0} :  {1} </b> </div>',
				args = { '['..source..'] ' .. GetPlayerName(source), message }
			})
        end
    end
end)

RegisterCommand('staff', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local length = string.len('report')
    local message = rawCommand:sub(length + 1)
    local playerName = xPlayer.getName()
    local xPlayers = ESX.GetPlayers()

    for k,v in pairs(xPlayers) do
        local xTarget = ESX.GetPlayerFromId(v)
        if xTarget.getGroup() == 'admin' or xTarget.getGroup() == 'superadmin' then
            TriggerClientEvent('chat:addMessage', xTarget.source, {
                template = '<div class="chat-message samsat"><b>CHAT STAFF | {0} :  {1} </b> </div>',
                args = { '['..source..'] ' .. GetPlayerName(source), message }
            })
        end
    end
end)

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

RegisterCommand('showjob', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are working as: ' .. job .. ' - ' .. jobgrade})  
end)

function isAdmin(xPlayer)
	if xPlayer.getGroup() ~= 'user' then 
		return true 
	end
	return false
end

 --AddEventHandler('chatMessage', function(source, name, message)
 --     if string.sub(message, 1, string.len("/")) ~= "/" then
 --         local name = getIdentity(source)
 --		TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
   --   end
   --   CancelEvent()
  --end)
  
  -- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  --    local name = getIdentity(source)
  --    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 



  --- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  ---    local name = getIdentity(source)
  ---    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 
--[[  TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:do', -1, source, name.firstname, table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
      local name = getIdentity(source)
	  table.remove(args, 2)
      TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, table.concat(args, " "))
  end)
  
  TriggerEvent('es:addCommand', 'me', function(source, args, user)
      local name = getIdentity(source)
	  table.remove(args, 2)
      TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  end)

 RegisterCommand('anontweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @Orang Asing:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)

RegisterCommand('twt', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i>Twitter | @{0}:<br> {1}</div>',
        args = { fal, msg }




RegisterCommand('pol', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(1, 1, 254, 0.6); border-radius: 3px;">POLISI | @{0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)





]]--



--[[

]]--

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
