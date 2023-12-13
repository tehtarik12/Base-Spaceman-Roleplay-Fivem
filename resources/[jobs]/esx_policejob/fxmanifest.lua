shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Police Job'

version '1.6.5'

shared_script '@vinzz/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@vinzz/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@vinzz/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/*.lua'
}