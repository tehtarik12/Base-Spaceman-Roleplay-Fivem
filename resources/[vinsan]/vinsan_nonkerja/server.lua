RegisterNetEvent("vinsan_jobs:getItem")
AddEventHandler("vinsan_jobs:getItem", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = false
    if state == 'jeruk' or state == 'ubi' or state == 'padi' or state == 'batukasar' or state == 'batangkayu' or state == 'minyakmentah' or state == 'kapas' then allowed = true end

    if allowed then
        if xPlayer.canCarryItem(state, 1) then
            xPlayer.addInventoryItem(state, 1)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Mengambil** '.. state ..' ** Sebanyak ** 1x **', 'disnaker')
        else
            TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
        end
    end
end)

RegisterNetEvent("vinsan_jobs:processItem")
AddEventHandler("vinsan_jobs:processItem", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = false

    if state == 'jeruk' then 
        allowed = 'paketanjeruk'
    elseif state == 'ubi' then
        allowed = 'paketanubi'
    elseif state == 'padi' then
        allowed = 'beras'
    elseif state == 'batukasar' then
        allowed = 'batuhalus'
    elseif state == 'batangkayu' then
        allowed = 'prosesbatangkayu'
    -- elseif state == 'dagingmentah' then
    --     allowed = 'dagingpotong'
    elseif state == 'minyakmentah' then
        allowed = 'prosesminyakmentah'
    elseif state == 'kapas' then
        allowed = 'katun'
    end
    if allowed ~= false then
        if xPlayer.canCarryItem(state, 2) then
            if xPlayer.getInventoryItem(state).count >= 1 then
                xPlayer.removeInventoryItem(state, 1)
                xPlayer.addInventoryItem(allowed, 2)
                ESX.SendDiscord(GetPlayerName(source), 'Telah Memproses** '.. state ..' ** Menjadi **' .. allowed .. ' 2x**', 'disnaker')
            else
                TriggerClientEvent('esx:showNotification', source, cfg.translation['noitems'])
            end
        else
            TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
        end
    end
end)

RegisterNetEvent("vinsan_jobs:processItem2")
AddEventHandler("vinsan_jobs:processItem2", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = false

    if state == 'batuhalus' then
        allowed = 'MINER'
    elseif state == 'prosesbatangkayu' then
        allowed = 'paketanpapan'
    elseif state == 'katun' then
        allowed = 'paketanpakaian'
    -- elseif state == 'dagingpotong' then
    --     allowed = 'paketandaging'
    elseif state == 'prosesminyakmentah' then
        allowed = 'paketanminyak'
    end
    if allowed ~= false then
        if xPlayer.canCarryItem(state, 1) then
        if xPlayer.getInventoryItem(state).count >= 1 then
            xPlayer.removeInventoryItem(state, 1)

            if allowed == 'MINER' then
                xPlayer.addInventoryItem('tembaga', 9)
                xPlayer.addInventoryItem('besi', 6)
                xPlayer.addInventoryItem('emas', 3)

                if math.random(10) >= 7 then
                    xPlayer.addInventoryItem('berlian', 1)
                end
                ESX.SendDiscord(GetPlayerName(source), 'Telah Mengambil **9x Tembaga, 6x Besi, 3x Emas, dan Berlian**', 'disnaker')
            else
                xPlayer.addInventoryItem(allowed, 3)
                ESX.SendDiscord(GetPlayerName(source), 'Telah Memproses** '.. state ..' ** Menjadi **' .. allowed .. ' 3x**', 'disnaker')
            end
        else
            TriggerClientEvent('esx:showNotification', source, cfg.translation['noitems'])
        end
    else 
        TriggerClientEvent('esx:showNotification', source, cfg.translation['limit'])
    end
    end
end)

RegisterNetEvent("vinsan_jobs:Sell")
AddEventHandler("vinsan_jobs:Sell", function(state)
    local xPlayer = ESX.GetPlayerFromId(source)

    if state ~= 'MINER' and state ~= 'FARMER' and  state ~= 'DAGING' and state ~= 'SAMPAH'then
        local count = xPlayer.getInventoryItem(state).count
        if count >= 1 then
            xPlayer.removeInventoryItem(state, count)
            xPlayer.addMoney(cfg.price[state] * count)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price[state] ..' ** Sebanyak **' .. count .. '**', 'disnaker')
        end
    elseif state == 'MINER' then
        local count = xPlayer.getInventoryItem('tembaga').count
        local count2 = xPlayer.getInventoryItem('besi').count
        local count3 = xPlayer.getInventoryItem('emas').count
        local count4 = xPlayer.getInventoryItem('berlian').count
        if count >= 1 then
            xPlayer.removeInventoryItem('tembaga', count)
            xPlayer.addMoney(cfg.price['tembaga'] * count)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['tembaga'] ..' ** Sebanyak **' .. count .. '**', 'disnaker')
        end
        if count2 >= 1 then
            xPlayer.removeInventoryItem('besi', count2)
            xPlayer.addMoney(cfg.price['besi'] * count2)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['besi'] ..' ** Sebanyak **' .. count2 .. '**', 'disnaker')
        end
        if count3 >= 1 then
            xPlayer.removeInventoryItem('emas', count3)
            xPlayer.addMoney(cfg.price['emas'] * count3)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['emas'] ..' ** Sebanyak **' .. count3 .. '**', 'disnaker')
        end
        if count4 >= 1 then
            xPlayer.removeInventoryItem('berlian', count4)
            xPlayer.addMoney(cfg.price['berlian'] * count4)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['berlian'] ..' ** Sebanyak **' .. count4 .. '**', 'disnaker')
        end
    elseif state == 'SAMPAH' then
        local count = xPlayer.getInventoryItem('scrap').count
        local count2 = xPlayer.getInventoryItem('plastik').count
        local count3 = xPlayer.getInventoryItem('kaca').count
        if count >= 1 then
            xPlayer.removeInventoryItem('scrap', count)
            xPlayer.addMoney(cfg.price['scrap'] * count)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual Scrap ** '.. cfg.price['scrap'] ..' ** Sebanyak **' .. count .. '**', 'disnaker')
        end
        if count2 >= 1 then
            xPlayer.removeInventoryItem('plastik', count2)
            xPlayer.addMoney(cfg.price['plastik'] * count2)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual Plastik** '.. cfg.price['besi'] ..' ** Sebanyak **' .. count2 .. '**', 'disnaker')
        end
        if count3 >= 1 then
            xPlayer.removeInventoryItem('kaca', count3)
            xPlayer.addMoney(cfg.price['kaca'] * count3)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual Kaca** '.. cfg.price['kaca'] ..' ** Sebanyak **' .. count3 .. '**', 'disnaker')
        end
    elseif state == 'FARMER' then
        local count = xPlayer.getInventoryItem('paketanjeruk').count
        local count2 = xPlayer.getInventoryItem('paketanubi').count
        local count3 = xPlayer.getInventoryItem('paketanpandan').count
        if count >= 1 then
            xPlayer.removeInventoryItem('paketanjeruk', count)
            xPlayer.addMoney(cfg.price['paketanjeruk'] * count)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['paketanjeruk'] ..' ** Sebanyak **' .. count .. '**', 'disnaker')
        end
        if count2 >= 1 then
            xPlayer.removeInventoryItem('paketanubi', count2)
            xPlayer.addMoney(cfg.price['paketanubi'] * count2)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['paketanubi'] ..' ** Sebanyak **' .. count2 .. '**', 'disnaker')
        end
        if count3 >= 1 then
            xPlayer.removeInventoryItem('paketanpandan', count3)
            xPlayer.addMoney(cfg.price['paketanpandan'] * count3)
            ESX.SendDiscord(GetPlayerName(source), 'Telah Menjual** '.. cfg.price['paketanpandan'] ..' ** Sebanyak **' .. count3 .. '**', 'disnaker')
        end
    end
end)