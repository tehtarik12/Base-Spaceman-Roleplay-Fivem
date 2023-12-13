shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_script {
    '@ox_lib/init.lua',
    '@vinzz/imports.lua',
}

client_scripts {
    'config.lua',
    'client/**/*.lua',
}

server_scripts {
    'config.lua',
    'server.lua'
}