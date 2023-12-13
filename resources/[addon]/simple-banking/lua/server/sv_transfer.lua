
RegisterServerEvent('gb-banking:Transfer')
AddEventHandler('gb-banking:Transfer', function(target, account, amount, comment)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    target = target ~= nil and tonumber(target) or nil
    if not target or target <= 0 or target == src then
        return
    end

    target = tonumber(target)
    amount = tonumber(amount)
    local targetPly = ESX.GetPlayerFromId(target)

    if not targetPly or targetPly == -1 then
        return
    end

    if (target == src) then
        return
    end

    if (not amount or amount <= 0) then
        return
    end

    if (account == "personal") then
        local balance = xPlayer.getAccount('bank').money

        if amount > balance then
            return
        end

        xPlayer.removeAccountMoney('bank', amount)
        targetPly.addAccountMoney('bank', math.floor(amount))
        ESX.SendDiscord(GetPlayerName(src), 'Telah Mentransfer Uang Sebesar **'.. amount ..'** Ke' .. GetPlayerName(target), 'playerbanking')

        AddTransaction(src, "personal", -amount, "transfer", targetPly.getName(), "Transfered $" .. format_int(amount) .. " to " .. targetPly.getName())
        AddTransaction(targetPly.source, "personal", amount, "transfer", xPlayer.getName(), "Received $" .. format_int(amount) .. " from " ..xPlayer.getName())
    end

    if (account == "business") then
        local job = xPlayer.getJob()

        if (not SimpleBanking.Config["business_ranks"][string.lower(job.grade_name)] and not SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)]) then
            return
        end

        local low = string.lower(job.name)
        local grade = string.lower(job.grade_name)

        if (SimpleBanking.Config["business_ranks_overrides"][low] and not SimpleBanking.Config["business_ranks_overrides"][low][grade]) then
            return
        end

        local result = MySQL.query.await('SELECT * FROM society WHERE name= ?', {job.name})
        local data = result[1]
        if data then
            local society = data.name

            TriggerEvent('gb-banking:society:WithdrawMoney', src, amount, society)
            Wait(50)
            targetPly.addAccountMoney('cash', amount)
            AddTransaction(src, "personal", -amount, "transfer", targetPly.getName(), "Transfered $" .. format_int(amount) .. " to " .. targetPly.getName() .. " from " .. job.label .. "'s account")
        end
    end
end)
