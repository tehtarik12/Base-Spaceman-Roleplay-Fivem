fx_version 'adamant'

game 'gta5'

description 'ESX Addon Account'

version '1.6.5'

server_scripts {
	'@vinzz/imports.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/classes/addonaccount.lua',
	'server/main.lua'
}

dependency 'vinzz'
