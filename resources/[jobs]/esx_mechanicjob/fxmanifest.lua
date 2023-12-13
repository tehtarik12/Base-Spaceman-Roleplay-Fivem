shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Mechanic Job'

version '1.6.5'

shared_script '@vinzz/imports.lua'

client_scripts {
	'@vinzz/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@vinzz/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}