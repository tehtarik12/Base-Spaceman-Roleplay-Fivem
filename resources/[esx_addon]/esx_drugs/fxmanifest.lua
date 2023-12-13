shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Drugs'

version '1.5.0'

shared_script '@vinzz/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@vinzz/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/br.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@vinzz/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/br.lua',
	'config.lua',
	'client/main.lua',
	'client/weed.lua',
	'client/micin.lua',
}

dependencies {
	'vinzz'
}
