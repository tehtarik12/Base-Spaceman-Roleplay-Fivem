shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Society'

version '1.6.5'

shared_script '@vinzz/imports.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@vinzz/locale.lua',
    'locales/br.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/fi.lua',
    'locales/fr.lua',
    'locales/sv.lua',
    'locales/pl.lua',
    'locales/nl.lua',
    'locales/cs.lua',
    'locales/tr.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@vinzz/locale.lua',
    'locales/br.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/fi.lua',
    'locales/fr.lua',
    'locales/sv.lua',
    'locales/pl.lua',
    'locales/nl.lua',
    'locales/cs.lua',
    'locales/tr.lua',
    'config.lua',
    'client/main.lua'
}

dependencies {
    'vinzz',
    'cron',
    'esx_addonaccount'
}
