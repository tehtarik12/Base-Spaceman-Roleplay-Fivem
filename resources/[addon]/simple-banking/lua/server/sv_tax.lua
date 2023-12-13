--[[local Vehicles = {}

function CalculateTax(value, type)
    if not value then return end
    if not type then return end
    local data = GetTaxByType(type)
    local tax = (value / 100 * data)
    return tax
end

function GetTaxByType(type)
    if not type then return end
    local callback = MySQL.Sync.fetchAll("SELECT * FROM city WHERE type = ?", {type})
    local data = callback[1].amount
    return data
end


AddEventHandler('onResourceStart', function(resource)
	Wait(10000)
	if resource == GetCurrentResourceName() then
		mysqlgetVeh()
	end
end)

function mysqlgetVeh()
    MySQL.Async.fetchAll('SELECT * FROM `vs_vipcars`, `vs_aircrafts`, `vs_boats`, `vs_cars`', {}, function(_vehicles)
        for k,v in pairs(_vehicles) do
            if v.price > 0 then Vehicles[v.name] = v.price end
        end
    end)
end
--]]

-- Execute task every monday at 18:30
--[[function WeeklyTax(d, h, m)
    --if d == 1 then
        local timeStart = os.time()
        MySQL.Async.fetchAll('SELECT * FROM users', {}, function(result)
            --MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {}, function(ownedveh)
                for k,v in ipairs(result) do
                    local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
                    local totalmoney, totalvehicleprice, totalpajak, playername
                    if xPlayer then
                        totalmoney = xPlayer.getAccount('bank').money + xPlayer.getAccount('money').money
                        totalvehicleprice = 0
                        playername = xPlayer.getName()

                        --[[
                        for index,val in pairs(ownedveh) do
                            if val.owner == v.identifier and Vehicles[val.name] then
                                totalvehicleprice = totalvehicleprice + Vehicles[val.name]
                            end
                        end
                        --
                    else
                        local playerAccounts = json.decode(v.accounts)
                        totalmoney = playerAccounts.bank + playerAccounts.money
                        totalvehicleprice = 0
                        playername = v.firstname .. ' ' .. v.lastname
                        
                        --[[
                        for index,val in pairs(ownedveh) do
                            if val.owner == v.identifier and Vehicles[val.name] then
                                totalvehicleprice = totalvehicleprice + Vehicles[val.name]
                            end
                        end
                        --
                    end
                    totalpajak = ESX.Math.Round((totalmoney + totalvehicleprice) / 100 * 5) -- 2% Pajak dari total uang dan total harga kendaraan

                    if totalpajak > 0 then
                        local notes = os.date("Notes: Pajak Bulan %c \nTotal Kekayaan Uang: $"..totalmoney.." \nTotal Kekayaan Kepemilikan Kendaraan: $"..totalvehicleprice.." \nTotal Pajak: $"..totalpajak)
                        MySQL.Async.insert('INSERT INTO okokBilling (receiver_identifier, receiver_name, author_identifier, author_name, society, society_name, item, invoice_value, status, notes, sent_date, limit_pay_date) VALUES (@receiver_identifier, @receiver_name, @author_identifier, @author_name, @society, @society_name, @item, @invoice_value, @status, @notes, CURRENT_TIMESTAMP(), DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL @limit_pay_date DAY))', {
                            ['@receiver_identifier'] = v.identifier,
                            ['@receiver_name'] = playername,
                            ['@author_identifier'] = 'PEMERINTAH',
                            ['@author_name'] = 'Pemerintah Kota Mabar Santuy',
                            ['@society'] = 'society_pemerintah',
                            ['@society_name'] = 'Pemerintah',
                            ['@item'] = 'Pajak Kota Mabar Santuy',
                            ['@invoice_value'] = totalpajak,
                            ['@status'] = "unpaid",
                            ['@notes'] = notes,
                            ['@limit_pay_date'] = 7
                        })
                    end
                end
                local elapsedTime = os.time() - timeStart
                print(('[BANKING] [^2INFO^7] Paying pajak cron job took %s seconds'):format(elapsedTime))
            --end)
        end)
    --end
end]]

--RegisterCommand('pajaktesting', WeeklyTax)

--TriggerEvent('cron:runAt', 18, 30, WeeklyTax)