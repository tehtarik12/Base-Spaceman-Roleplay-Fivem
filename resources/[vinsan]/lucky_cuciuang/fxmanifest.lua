shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Blanchimment d\'argent'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}
