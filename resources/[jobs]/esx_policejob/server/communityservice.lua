local serviced = {}

-- unjail after time served
RegisterServerEvent('qb-communityservice:finishCommunityService')
AddEventHandler('qb-communityservice:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('qb-communityservice:endCommunityServiceCommand')
AddEventHandler('qb-communityservice:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

RegisterServerEvent('qb-communityservice:completeService')
AddEventHandler('qb-communityservice:completeService', function()
	local identifier = ESX.GetPlayerFromId(source).identifier

	if serviced[identifier] then
		serviced[identifier] = serviced[identifier] - 1
	end
end)

RegisterServerEvent('qb-communityservice:extendService')
AddEventHandler('qb-communityservice:extendService', function()
	local identifier = ESX.GetPlayerFromId(source).identifier

	if serviced[identifier] then
		serviced[identifier] = serviced[identifier] + Config.ServiceExtensionOnEscape
	end
end)

RegisterServerEvent('qb-communityservice:sendToCommunityService')
AddEventHandler('qb-communityservice:sendToCommunityService', function(target, actions_count)
	local xPlayer = ESX.GetPlayerFromId(target)

	if not serviced[xPlayer.identifier] then
		serviced[xPlayer.identifier] = actions_count
	end

	local time = os.date('%H:%M')
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div class="chat-message police"><i class="fas fa-bullhorn"></i><b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
		args = { "Berita Comserv" , _U('comserv_msg', xPlayer.getName(), actions_count), time }
	})
	TriggerClientEvent('qb-communityservice:inCommunityService', target, actions_count)
end)


RegisterServerEvent('qb-communityservice:checkIfSentenced')
AddEventHandler('qb-communityservice:checkIfSentenced', function()
	local identifier = ESX.GetPlayerFromId(source).identifier

	if serviced[identifier] then
		TriggerClientEvent('qb-communityservice:inCommunityService', source, serviced[identifier])
	end
end)

function releaseFromCommunityService(target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if serviced[xPlayer.identifier] then
		serviced[xPlayer.identifier] = nil
		local time = os.date('%H:%M')
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message police"><i class="fas fa-bullhorn"></i><b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { "Berita Comserv" , _U('comserv_finished', xPlayer.getName()), time }
		})
		TriggerClientEvent('qb-communityservice:finishCommunityService', target)
	end
end