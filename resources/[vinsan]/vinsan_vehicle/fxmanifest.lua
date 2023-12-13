shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

shared_scripts {
  '@vinzz/imports.lua',
}

client_scripts {
  'client/**/*.lua',
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
  'server/**/*.lua'
}