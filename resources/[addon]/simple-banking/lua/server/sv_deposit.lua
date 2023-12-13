
RegisterNetEvent('gb-banking:DepositMoney')
AddEventHandler('gb-banking:DepositMoney', function(account, amount, comment)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if comment == '' then
        comment = nil
    end

    if not amount or tonumber(amount) <= 0 then
        TriggerClientEvent("gb-banking:Notify", source, "error", "Invalid Amount!") 
        return
    end

    local amount = tonumber(amount)
    if amount > xPlayer.getMoney() then
        TriggerClientEvent("gb-banking:Notify", source, "error", "You can't afford this!") 
        return
    end

    if account == "personal"  then
        local amt = math.floor(amount)

        xPlayer.removeMoney(amt)
        Wait(500)
        xPlayer.addAccountMoney('bank', amt)
        RefreshTransactions(src)
        ESX.SendDiscord(GetPlayerName(src), 'Telah Mendeposit Uang Sebesar **'.. amt ..'** Ke Bank', 'playerbanking')
        AddTransaction(src, "personal", amount, "deposit", "N/A", (comment ~= "" and comment or "Deposited $"..format_int(amount).." cash."))
        return
    end
    if account == "business"  then
        local job = xPlayer.getJob()
        local job_grade = job.grade_name

        if (not SimpleBanking.Config["business_ranks"][string.lower(job_grade)] and not SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)]) then
            return
        end

        local low = string.lower(job.name)
        local grade = string.lower(job_grade)

        if (SimpleBanking.Config["business_ranks_overrides"][low] and not SimpleBanking.Config["business_ranks_overrides"][low][grade]) then
            return
        end


        local result = MySQL.query.await('SELECT * FROM society WHERE name= ?', {job})
        local data = result[1]

        if data then
            local deposit = math.floor(amount)

            xPlayer.removeMoney(deposit)
            TriggerEvent('gb-banking:society:DepositMoney', src, deposit, data.name)
            AddTransaction(src, "business", amount, "deposit", job.label, (comment ~= "" and comment or "Deposited $"..format_int(amount).." cash into ".. job.label .."'s business account."))        end
    end
    
end)
