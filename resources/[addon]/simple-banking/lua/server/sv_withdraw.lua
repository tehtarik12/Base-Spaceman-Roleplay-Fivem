RegisterServerEvent("gb-banking:Withdraw")
AddEventHandler("gb-banking:Withdraw", function(account, amount, comment)
    local src = source
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer or xPlayer == -1 then
        return
    end

    if not amount or tonumber(amount) <= 0 then
        TriggerClientEvent("gb-banking:Notify", source, "error", "Invalid amount!") 
        return
    end

    amount = tonumber(amount)

    if account == "personal" then
        if amount > xPlayer.getAccount('bank').money then
            TriggerClientEvent("gb-banking:Notify", source, "error", "Your bank doesn't have this much money!") 
            return
        end
        local withdraw = math.floor(amount)

        xPlayer.addMoney(withdraw)
        xPlayer.removeAccountMoney('bank', withdraw)
        ESX.SendDiscord(GetPlayerName(source), 'Telah Menarik Uang Sebesar **'.. withdraw ..'**', 'playerbanking')

        AddTransaction(src, "personal", -amount, "withdraw", "N/A", (comment ~= "" and comment or "Withdrew €"..format_int(amount)))
        RefreshTransactions(src)
    end

    if(account == "business") then
        local job = xPlayer.getJob()


        if not SimpleBanking.Config["business_ranks"][string.lower(job.grade_name)] and not SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)] then
            return
        end

        local low = string.lower(job.name)
        local grade = string.lower(job.grade_name)

        if (SimpleBanking.Config["business_ranks_overrides"][low] and not SimpleBanking.Config["business_ranks_overrides"][low][grade]) then

            return
        end

        local result = MySQL.query.await('SELECT * FROM society WHERE name = ?', {job.name})
        local data = result[1]

        if data then
            local sM = tonumber(data.money)
            if sM >= amount then
                TriggerEvent('gb-banking:society:WithdrawMoney',src, amount, data.name)

                AddTransaction(src, "business", -amount, "deposit", job.label, (comment ~= "" and comment or "Withdrew €"..format_int(amount).." from ".. job.label .."'s account."))
                xPlayer.addMoney(amount)
            else
                TriggerClientEvent("gb-banking:Notify", src, "error", "Not enough money current balance: €"..sM) 
            end
        end
    end

end)
