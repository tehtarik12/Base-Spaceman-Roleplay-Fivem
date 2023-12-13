function StartPayCheck()
	CreateThread(function()
		while true do
			Wait(Config.PaycheckInterval)
			local xPlayers = ESX.GetExtendedPlayers()
			for _, xPlayer in pairs(xPlayers) do
				local job     = xPlayer.job.grade_name
				local salary  = xPlayer.job.grade_salary

				if salary > 0 then
					if job == 'unemployed' then -- unemployed
						xPlayer.addAccountMoney('bank', salary)
						xPlayer.showNotification(_U('received_help', salary))
					elseif Config.EnableSocietyPayouts then -- possibly a society
						TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
							if society ~= nil then -- verified society
								TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
									if account.money >= salary then -- does the society money to pay its employees?
										xPlayer.addAccountMoney('bank', salary)
										account.removeMoney(salary)

										xPlayer.showNotification(_U('received_salary', salary))
									else
										xPlayer.showNotification(_U('company_nomoney'))
									end
								end)
							else -- not a society
								xPlayer.addAccountMoney('bank', salary)
								xPlayer.showNotification(_U('received_salary', salary))
							end
						end)
					else -- generic job
						xPlayer.addAccountMoney('bank', salary)
						xPlayer.showNotification(_U('received_salary', salary))
					end
				end
			end
		end
	end)
end