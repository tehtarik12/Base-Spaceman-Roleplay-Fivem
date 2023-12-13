-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
--		   	Created By: qalle-fivem AKA qalle		      --
--			 Protected By: ATG-Github AKA ATG			  --
-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --

local JailTimer = {}

function checkIfLegit(source, target)
	-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
	--				Let's grab our data...					  --
	-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
	local src, tgt = source, target;
	if src ~= nil and tgt ~= nil then
		local xSrc, xTgt = ESX.GetPlayerFromId(src), ESX.GetPlayerFromId(tgt);
		if xSrc ~= nil and xTgt ~= nil then
			local srcIdent, tgtIdent = xSrc.identifier, xTgt.identifier;
			local srcJob = xSrc.job.name;
			local tgtJob = xTgt.job.name;
			local srcGroup = xSrc.getGroup();
			-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
			--				Let's define legitimacy...			      --
			-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
			local legit = {
				["legit"] = true,
				["reason"] = "No flags found."
			};
			-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
			--				Let's test for legitimacy!			      --
			-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
			if srcJob ~= "police" then
				if srcGroup ~= "admin" and srcGroup ~= "superadmin" then
					legit = {
						["legit"] = false,
						["reason"] = "Source does not have the police job, and is not staff."
					}
					return legit
				end
			end
			-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
			--		     If we've made it here, it's legit!           --
			-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
			return legit
		else
			legit = {
				["legit"] = false,
				["reason"] = "xSrc or xTgt == nil."
			}
			return legit
		end
	else
		legit = {
			["legit"] = false,
			["reason"] = "Source or Target == nil."
		}
		return legit
	end
end

RegisterServerEvent("kcmcity_whitelistjob:jailPlayer")
AddEventHandler("kcmcity_whitelistjob:jailPlayer", function(t, jT, jR)
	local src, tgt = source, t;
	local jailTime, jailReason = jT, jR;

	local xTarget = ESX.GetPlayerFromId(tgt)

	local legit = checkIfLegit(src, tgt);
	if legit["legit"] == true then
		JailPlayer(tgt, jailTime)
		local time = os.date('%H:%M')
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message police"><i class="fas fa-bullhorn"></i><b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { "Berita Penjara" , xTarget.getName() .. " telah dipenjara selama: " .. jailTime .. " bulan." .. " Dengan alasan: " .. jailReason .. ".", time }
		})
	end
end)

RegisterServerEvent("kcmcity_whitelistjob:updateJailTime")
AddEventHandler("kcmcity_whitelistjob:updateJailTime", function(newJailTime)
	local xPlayer = ESX.GetPlayerFromId(source)
	JailTimer[source] = newJailTime

	if newJailTime == 0 then
		EditJailTime(source, newJailTime, nil)
		JailTimer[source] = nil
		local time = os.date('%H:%M')
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message police"><i class="fas fa-bullhorn"></i><b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { "Berita Penjara" , xPlayer.getName() .. " Telah bebas dari penjara.", time }
		})
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if JailTimer[playerId] then
		EditJailTime(nil, JailTimer[playerId], xPlayer.identifier)
		JailTimer[playerId] = nil
	end
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("kcmcity_whitelistjob:jailPlayer", jailPlayer, jailTime)

	JailTimer[jailPlayer] = jailTime
	EditJailTime(jailPlayer, jailTime, nil)
end

function EditJailTime(source, jailTime, savedidentifier)
	local xPlayer, Identifier

	if source ~= nil and savedidentifier == nil then
		xPlayer = ESX.GetPlayerFromId(source)
		Identifier = xPlayer.identifier
	elseif source == nil and savedidentifier ~= nil then
		Identifier = savedidentifier
	end

	exports.oxmysql:execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

RegisterCommand('unjail', function(source, args, rawcommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

	if xPlayer and xPlayer.job.name == 'police' and tPlayer and JailTimer[tPlayer.source] and JailTimer[tPlayer.source] >= 0 then
		EditJailTime(tPlayer.source, 0, nil)
		JailTimer[tPlayer.source] = nil
		TriggerClientEvent('kcmcity_whitelistjob:UpdateJail', tPlayer.source, 0)
	end
end)

RegisterCommand('editjail', function(source, args, rawcommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(args[1])

	if xPlayer and xPlayer.getGroup() ~= 'user' and tPlayer and JailTimer[tPlayer.source] and JailTimer[tPlayer.source] > 0 and type(args[2]) == 'number' and args[2] > 0 then
		EditJailTime(tPlayer.source, args[2], nil)
		JailTimer[tPlayer.source] = args[2]
		TriggerClientEvent('kcmcity_whitelistjob:UpdateJail', tPlayer.source, args[2])
	end
end)