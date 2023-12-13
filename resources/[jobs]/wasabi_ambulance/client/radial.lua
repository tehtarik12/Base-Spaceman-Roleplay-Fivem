-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if not Config.UseRadialMenu then return end
lib.registerRadial({ -- EMS menu
	id = 'ems_menu',
	items = {
		{
			label = 'Diagnose',
			icon = 'stethoscope',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:diagnosePatient')
			end
		},
		{
			label = 'Revive',
			icon = 'heartbeat',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:reviveTarget')
			end
		},
		{
			label = 'Heal',
			icon = 'band-aid',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:healTarget')
			end
		},
		{
			label = 'Sedate',
			icon = 'suitcase-medical',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:useSedative')
			end
		},
		{
			label = 'In/Out Vehicle',
			icon = 'door-open',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:placeInVehicle')
			end
		},
		{
			label = 'Bill Patient',
			icon = 'file-invoice-dollar',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:billPatient')
			end
		},
		{
			label = 'Dispatch',
			icon = 'user-injured',
			onSelect = function()
				TriggerEvent('wasabi_ambulance:dispatchMenu')
			end
		},
	}
})