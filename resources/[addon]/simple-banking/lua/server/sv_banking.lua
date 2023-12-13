ESX.RegisterServerCallback("gb-banking:GetBankData", function(source, cb)
    local src = source
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end

    local PlayerMoney = xPlayer.getAccount('bank').money or 0 

    local TransactionHistory = {}
    local TransactionRan = false
    local tbl = {}
    tbl[1] = {
        type = "personal",
        amount = PlayerMoney
    }

    local job = xPlayer.getJob()

    
    if (job.name and job.grade_name) then
        if(SimpleBanking.Config["business_ranks"][string.lower(job.grade_name)] or SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)] and SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)][string.lower(job.grade_label)]) then
            local result =  MySQL.query.await('SELECT * FROM society WHERE name= ?', {job.name})
            local data = result[1]

            if data ~= nil then
                tbl[#tbl + 1] = {
                    type = "business",
                    name = job.label,
                    amount = format_int(data.money) or 0
                }
            end
        end
    end


    local result = MySQL.query.await("SELECT * FROM transactions WHERE `identifier` = @identifier AND DATE(date) > (NOW() - INTERVAL "..SimpleBanking.Config["Days_Transaction_History"].." DAY)", {
    ['@identifier'] = xPlayer.getIdentifier()})

    if result ~= nil then
        for k, v in pairs(result) do
            table.insert(TransactionHistory, {identifier = v.identifier, trans_id = v.trans_id, account = v.account, amount = v.amount, trans_type = v.trans_type, receiver = v.receiver, comment = v.comment, date = v.date})
        end
        TransactionRan = true
    end


    repeat
        Wait(0)
    until 
        TransactionRan
    cb(tbl, TransactionHistory)
end)

ESX.RegisterServerCallback('gb-banking:namecheck', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.name)
end)
