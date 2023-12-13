local image1 = 'https://i.imgur.com/tbuCPrK.png'
local appid = '1009815913433939968' 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2500)
        local player = PlayerId()
        local name = GetPlayerName(player)
        local id = GetPlayerServerId(player)
        SetRichPresence("#SMRP | " .. #GetActivePlayers() .. "/128")
        SetDiscordAppId(appid)
        SetDiscordRichPresenceAsset(image1)
        SetDiscordRichPresenceAssetText("Spaceman Roleplay")
        SetDiscordRichPresenceAssetSmall(image1)
        SetDiscordRichPresenceAssetSmallText(" "..name)
        
        SetDiscordRichPresenceAction(0, "Discord", "discord.io/mabarsantuyRP")

        Citizen.Wait(60000)
    end
end)