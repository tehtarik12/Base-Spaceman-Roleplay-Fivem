RegisterCommand('rockstar_save', function()
	if IsRecording() then
		StartRecording(0)
		StopRecordingAndSaveClip()
		ESX.ShowNotification('Success saving clip!')
	else
		ESX.ShowNotification('You are not recording!', 'error')
	end
end)

RegisterCommand('rockstar_discard', function()
	if IsRecording() then
		StopRecordingAndDiscardClip()
		ESX.ShowNotification('Success discarding clip!')
	else
		ESX.ShowNotification('You are not recording!', 'error')
	end
end)

RegisterCommand('rockstar_start', function()
	if not IsRecording() then
		StartRecording(1)
		ESX.ShowNotification('Success start recording!')
	else
		ESX.ShowNotification('You have already recording!', 'error')
	end
end)

RegisterCommand('rekam', function()
	if not IsRecording() then
		StartRecording(1)
		ESX.ShowNotification('Success start recording!')
	else
		StartRecording(0)
		StopRecordingAndSaveClip()
		ESX.ShowNotification('Success saving clip!')
	end
end)

RegisterCommand('rockstar_editor', function()
	NetworkSessionLeaveSinglePlayer()
	ActivateRockstarEditor()
end)

RegisterKeyMapping('rockstar_save', '[UT] Save Rockstar record', 'keyboard', '')
RegisterKeyMapping('rockstar_discard', '[UT] Discard Rockstar record', 'keyboard', '')
RegisterKeyMapping('rockstar_start', '[UT] Start Rockstar record', 'keyboard', '')
RegisterKeyMapping('rockstar_editor', '[UT] Open Rockstar editor', 'keyboard', '')