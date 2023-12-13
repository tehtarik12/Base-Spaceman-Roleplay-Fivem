function AddTransaction(source, sAccount, iAmount, sType, sReceiver, sMessage, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local iTransactionID = math.random(1000, 100000)

    MySQL.insert("INSERT INTO `transactions` (`identifier`, `trans_id`, `account`, `amount`, `trans_type`, `receiver`, `comment`) VALUES(@identifier, @trans_id, @account, @amount, @trans_type, @receiver, @comment)", {
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@trans_id'] = iTransactionID,
        ['@account'] = sAccount,
        ['@amount'] = iAmount,
        ['@trans_type'] = sType,
        ['@receiver'] = sReceiver,
        ['@comment'] = sMessage
    }, function()
        RefreshTransactions(src)
    end)
end


function RefreshTransactions(source)
    local src = source
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end

    local result = MySQL.query.await("SELECT * FROM transactions WHERE identifier =  ? AND DATE(date) > (NOW() - INTERVAL "..SimpleBanking.Config["Days_Transaction_History"].." DAY)", {xPlayer.getIdentifier()})

    if result ~= nil then
        TriggerClientEvent("gb-banking:UpdateTransactions", src, result)
    end
end