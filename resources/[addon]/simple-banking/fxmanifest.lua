shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
games { 'gta5' }

shared_scripts {
    '@vinzz/imports.lua',
    'lua/shared/sh_*.lua',
}

client_scripts {
    'lua/client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'lua/server/*.lua',
}

server_exports {
    'AddTransaction',
 --   'GetTaxByType',
 --   'CalculateTax',
}

ui_page 'html/index.html'

files {
	'html/index.html',
    'html/app.js',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/css/*.css'
}
