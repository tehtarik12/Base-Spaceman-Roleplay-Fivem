shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'Luke - https://www.github.com/lukewastakenn'

version '2.7.2'

dependencies { 
    '/server:5104',
    '/gameBuild:1868',
    '/onesync',
}

shared_scripts {
    '@vinzz/imports.lua',
    '@ox_lib/init.lua',
    'locale.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    'client/vehicle_names.lua',
    'client/client.lua',
    'client/vehicle_functions.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/version_check.lua',
    'server/server.lua'
}
