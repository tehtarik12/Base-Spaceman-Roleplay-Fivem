-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

description 'Wasabi ESX/QBCore Ambulance Job Replacement'
author 'wasabirobby#5110'
version '1.6.4'

shared_scripts { '@ox_lib/init.lua', 'configuration/config.lua', 'configuration/strings.lua' }

server_scripts { 'bridge/**/server.lua', '@mysql-async/lib/MySQL.lua', 'configuration/logs.lua', 'server/*.lua' }

client_scripts { 'bridge/**/client.lua', 'death_reasons.lua', 'client/*.lua' }

dependencies { 'ox_lib' }

provides { 'esx_ambulancejob', 'qb-ambulancejob' }

escrow_ignore {
  'bridge/**/*.lua',
  'configuration/**/*.lua',
  'death_reasons.lua',
  'client/client.lua',
  'client/cl_customize.lua',
  'client/radial.lua',
  'server/sv_customize.lua'
}

dependency '/assetpacks'