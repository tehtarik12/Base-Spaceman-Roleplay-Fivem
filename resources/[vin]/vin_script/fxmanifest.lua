shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

shared_scripts {
  '@vinzz/imports.lua',
  '@ox_lib/init.lua',
}

client_scripts {
  '@vinzz/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/**/*.lua',
}

server_scripts {
  '@vinzz/locale.lua',
  'locales/en.lua',
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/**/*.lua',
}

--data_file 'POPSCHED_FILE' 'popcycle.dat'