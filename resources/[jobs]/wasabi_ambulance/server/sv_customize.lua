-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

QS = nil
if Config.Inventory == 'qs' then
    TriggerEvent('qs-core:getSharedObject', function(library)
        QS = library
    end)
end

RegisterNetEvent('wasabi_ambulance:removeItemsOnDeath', function()
    if Framework == 'qb' then
        local Player = GetPlayer(source)
        Player.Functions.ClearInventory()
        MySQL.Async.execute('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), Player.PlayerData.citizenid })
        return
    elseif Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() > 0 then
            xPlayer.removeMoney(xPlayer.getMoney())
        end
        if xPlayer.getAccount('black_money').money > 0 then
            xPlayer.removeAccountMoney('black_money', xPlayer.getAccount('black_money').money)
        end
    end
    if Config.Inventory == 'qs' then
        local qPlayer = QS.GetPlayerFromId(source)
        qPlayer.ClearInventoryItems()
        qPlayer.ClearInventoryWeapons()
        TriggerClientEvent('wasabi_ambulance:weaponRemove', source)
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:ClearInventory(source)
    elseif Config.Inventory == 'mf' then
        exports['mf-inventory']:clearInventory(xPlayer.identifier)
        exports['mf-inventory']:clearLoadout(xPlayer.identifier)
        TriggerClientEvent('wasabi_ambulance:weaponRemove', source)
    else
        local xPlayer = ESX.GetPlayerFromId(source)

        for i = 1, #xPlayer.inventory, 1 do
            if xPlayer.inventory[i].count > 0 then
                xPlayer.removeInventoryItem(xPlayer.inventory[i].name, xPlayer.inventory[i].count)
            end
        end
    end
end)

if Config.Anticheat and Framework == 'esx' then
    RegisterNetEvent('esx_ambulancejob:revive', function()
        TriggerEvent('wasabi_ambulance:punishPlayer', source, 'esx_ambulancejob:revive triggered')
    end)
end

RegisterNetEvent('wasabi_ambulance:punishPlayer', function(reason)
    KickPlayer(source, string.format('You got kicked!\n\nAuthor: %s\nReason: %s\n\nYou think this punishment was not fair?\nContact our support at discord.gg/', GetCurrentResourceName(), reason))

    --[[
        EASYADMIN EXAMPLE
        TriggerEvent('EasyAdmin:addBan', source, reason, 31556926, GetCurrentResourceName())
    --]]
end)


if Config.CompleteDeath.enabled and Framework == 'esx' then
    resetDeathCount = function(xPlayer)
        MySQL.query('UPDATE users SET deaths = @deaths, disabled = @disabled WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@deaths'] = 0,
            ['@disabled'] = 0
            }, function(result)
        end)
    end

    viewDeathCount = function(xPlayer)
        MySQL.query('SELECT deaths FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            local deathCount = result[1].deaths

            TriggerClientEvent('wasabi_ambulance:notify', xPlayer.source, 'DEATHCOUNT', string.format('Your current deathcount: %s', deathCount), 'inform', 'ban')
        end)
    end

    RegisterNetEvent('wasabi_ambulance:deathCount', function(prot)
        local xPlayer = ESX.GetPlayerFromId(source)

        if prot then
            TriggerEvent('wasabi_ambulance:punishPlayer', xPlayer.source, 'wasabi_ambulance:deathCount triggered')
            return
        end

        MySQL.query('SELECT deaths FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            local deathCount = result[1].deaths + 1
            local disable = 0 -- 0 = false / 1 = true

            if deathCount >= Config.CompleteDeath.maxDeaths then
                disable = 1
            end

            MySQL.query('UPDATE users SET deaths = @deaths, disabled = @disabled WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier,
                ['@deaths'] = deathCount,
                ['@disabled'] = disable
                }, function(result)
                    if disable == 1 then
                        xPlayer.kick(string.format('You got kicked!\n\nAuthor: %s\nReason: You reached the max deathcount\nDeathcount: %s/%s\n\nYour character is now disabled.', GetCurrentResourceName(), deathCount, Config.CompleteDeath.maxDeaths))
                    end
            end)
        end)
    end)

    ESX.RegisterCommand('viewdeathcount', 'user', function(xPlayer, args, showError)
        viewDeathCount(xPlayer)
    end, false, {help = Strings.viewdeathcount_command_help})

    ESX.RegisterCommand('resetdeathcount', 'admin', function(xPlayer, args, showError)
        resetDeathCount(args.playerId)
    end, true, {help = Strings.resetdeathcount_command_help, validate = true, arguments = {
        {name = 'playerId', help = Strings.resetdeathcount_command_arg, type = 'player'}
    }})
end

if Framework == 'esx' then
    if not string.find(GetResourceState('essentialmode'), 'start') then
        -- ESX 1.2+
        ESX.RegisterCommand('reviveall', 'admin', function(xPlayer, args, showError)
            for _, xPlayer in ipairs(ESX.GetExtendedPlayers()) do
                if deadPlayers[xPlayer.source] then
                    TriggerClientEvent('wasabi_ambulance:revive', xPlayer.source)
                end
            end
        end, true, {help = Strings.reviveall_command_help})

        ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
            args.playerId.triggerEvent('wasabi_ambulance:revive')
            if xPlayer?.source and Config.ReviveLogs then
                TriggerEvent('wasabi_ambulance:logRevive', xPlayer.source, args.playerId.source)
            end
        end, true, {help = Strings.revive_command_help, validate = true, arguments = {
            {name = 'playerId', help = Strings.revive_command_arg, type = 'player'}
        }})

        if GetResourceMetadata('vinzz', 'version') >= '1.7.5' then
            ESX.RegisterCommand('revivearea', 'admin', function(xPlayer, args, showError)
                local coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
                local xPlayersNear = ESX.OneSync.GetPlayersInArea(vector3(coords.x, coords.y, coords.z), args.area or 10)
                for k, v in pairs(xPlayersNear) do
                    for _, xPlayers in ipairs(ESX.GetExtendedPlayers()) do
                        if deadPlayers[xPlayers.source] then
                            TriggerClientEvent('wasabi_ambulance:revive', xPlayers.source)
                            if xPlayer?.source and Config.ReviveLogs then
                                TriggerEvent('wasabi_ambulance:logRevive', xPlayer.source, xPlayers.source)
                            end
                        end
                    end
                end
            end, false, {help = Strings.revivearea_command_help, validate = false, arguments = {
                {name = 'area', help = Strings.revivearea_command_arg, type = 'number'}
            }})
        end
    else
        -- ESX 1.1
        TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
            if args[1] ~= nil then
                if GetPlayerName(tonumber(args[1])) ~= nil then
                    print('wasabi_ambulance: ' .. GetPlayerName(source) .. ' is reviving a player!')
                    TriggerClientEvent('wasabi_ambulance:revive', tonumber(args[1]))
                    if source and source ~= 0 and Config.ReviveLogs then
                        TriggerEvent('wasabi_ambulance:logRevive', source, tonumber(args[1]))
                    end
                end
            else
                TriggerClientEvent('wasabi_ambulance:revive', source)
                if source and source ~= 0 and Config.ReviveLogs then
                    TriggerEvent('wasabi_ambulance:logRevive', source)
                end
            end
        end, function(source, args, user)
            TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, 'Insufficient Permissions.')
        end, {help = 'Revive a nearby player', params = {{name = 'id'}}})
    end
elseif Framework == 'qb' then
    QBCore.Commands.Add('revive', 'Revive a player', {{name = 'id', help = 'Player ID'}}, false, function(source, args)
        local src = source
        if args[1] then
            local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if Player then
                TriggerClientEvent('wasabi_ambulance:revive', Player.PlayerData.source)
                if source and source ~= 0 and Config.ReviveLogs then
                    TriggerEvent('wasabi_ambulance:logRevive', source, Player.PlayerData.source)
                end
            end
        else
            TriggerClientEvent('wasabi_ambulance:revive', src)
        end
    end, 'admin')

    QBCore.Commands.Add('kill', 'Kill a player', {{name = 'id', help = 'Player ID'}}, false, function(source, args)
        local src = source
        if args[1] then
            local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if Player then
                TriggerClientEvent('wasabi_ambulance:killPlayer', Player.PlayerData.source)
            end
        else
            TriggerClientEvent('wasabi_ambulance:killPlayer', src)
        end
    end, 'admin')

    RegisterNetEvent('hospital:server:resetHungerThirst', function()
        local player = GetPlayer(source)
        if not player then return end
        player.Functions.SetMetaData('hunger', 100)
        player.Functions.SetMetaData('thirst', 100)
        TriggerClientEvent('hud:client:UpdateNeeds', source, 100, 100)
    end)
end

RevivePlayer = function(target)
    TriggerClientEvent('wasabi_ambulance:revive', target)
    if source and source ~= 0 and Config.ReviveLogs then
        TriggerEvent('wasabi_ambulance:logRevive', source, target)
    end
end
exports('RevivePlayer', RevivePlayer)
