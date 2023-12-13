bMenuOpen = false 
local aATM = false
local isLoggedIn = false
local PlayerJob = {}
local PlayerGang = {}
local tamt = nil
local damt = nil
local wamt = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
    SendNUIMessage({type = "refresh_accounts"})
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    SendNUIMessage({type = "refresh_accounts"})
end)

RegisterNetEvent("gb-banking:atmVar")
AddEventHandler("gb-banking:atmVar", function()
   aATM = true
end)

function ToggleUI()
    ESX.TriggerServerCallback('gb-banking:namecheck', function(name)  

    bMenuOpen = not bMenuOpen

    if (not bMenuOpen) then
        SetNuiFocus(false, false)
    else
        ESX.TriggerServerCallback("gb-banking:GetBankData", function(data, transactions)
            local PlayerBanks = json.encode(data)


            SetNuiFocus(true, true)
            SendNUIMessage({type = 'OpenUI', accounts = PlayerBanks, transactions = json.encode(transactions), name = name})
        end)
    end
    end)
end

RegisterNUICallback("CloseATM", function()
    ToggleUI()
end)

RegisterNUICallback("DepositCash", function(data, cb)
    if (not data or not data.account or not data.amount) then
        return
    end

    if (tonumber(data.amount) <= 0) then
        return
    end

    if aATM then
      TriggerEvent("gb-banking:Notify", "error", "You cannot deposit at an ATM!")
    else
      TriggerServerEvent('gb-banking:DepositMoney', data.account, data.amount, (data.comment ~= nil and data.comment or ""))
      aATM = false
    end
end)

RegisterNUICallback("WithdrawCash", function(data, cb)
    if (not data or not data.account or not data.amount) then
        return
    end

    if(tonumber(data.amount) <= 0) then
        return
    end
    wamt = tonumber(data.amount)
    if aATM then
     if wamt >= 10000 then
      TriggerEvent("gb-banking:Notify", "error", "You cannot withdraw more then 10000 at an ATM!")
     else
      TriggerServerEvent("gb-banking:Withdraw", data.account, data.amount, (data.comment ~= nil and data.comment or ""))
     end
    else
      TriggerServerEvent("gb-banking:Withdraw", data.account, data.amount, (data.comment ~= nil and data.comment or ""))
    end
end)

RegisterNUICallback("TransferCash", function(data, cb)
    if (not data or not data.account or not data.amount or not data.target) then
        return
    end

    if(tonumber(data.amount) <= 0) then
        return
    end

    if(tonumber(data.target) <= 0) then
        return
    end
    tamt = tonumber(data.amount)
    if aATM then
     if tamt >= 10000 then
      TriggerEvent("gb-banking:Notify", "error", "You cannot transfer more then 10000 at an ATM!")
     else
      TriggerServerEvent("gb-banking:Transfer", data.target, data.account, data.amount, (data.comment ~= nil and data.comment or ""))
      aATM = false
     end
    else
      TriggerServerEvent("gb-banking:Transfer", data.target, data.account, data.amount, (data.comment ~= nil and data.comment or ""))
      aATM = false
    end
end)



--// Net Events \\--
RegisterNetEvent("gb-banking:Notify")
AddEventHandler("gb-banking:Notify", function(type, msg)
    if (bMenuOpen) then
        SendNUIMessage({type = 'notification', msg_type = type, message = msg})
    end
end)

RegisterNetEvent("gb-banking:UpdateTransactions")
AddEventHandler("gb-banking:UpdateTransactions", function(transactions)
    if (bMenuOpen) then

        SendNUIMessage({type = 'update_transactions', transactions = json.encode(transactions)})

        ESX.TriggerServerCallback("gb-banking:GetBankData", function(data, transactions)
            local PlayerBanks = json.encode(data)
            SendNUIMessage({type = "refresh_balances", accounts = PlayerBanks })
        end)
    end
end)
