function GetSociety(name)
    local result = MySQL.query.await('SELECT * FROM society WHERE name= ?', {name}) --exports['ghmattimysql']:execute("SELECT * FROM `society` WHERE `name` ='"..name.."' ")
    local data = result[1]

    return data
end


RegisterNetEvent('gb-banking:society:WithdrawMoney')
AddEventHandler('gb-banking:society:WithdrawMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.money)
    local amount = tonumber(a)
    local withdraw = sMoney - amount

    local setter = MySQL.query.await("UPDATE society SET money =  ? WHERE name = ?", {withdraw, n})
end)

RegisterServerEvent('gb-banking:society:DepositMoney')
AddEventHandler('gb-banking:society:DepositMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.money)
    local amount = tonumber(a)
    local deposit = sMoney + amount

    
    local setter = MySQL.query.await("UPDATE society SET money =  ? WHERE name = ?", {deposit, n})
end)