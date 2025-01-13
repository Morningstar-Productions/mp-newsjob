fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'mp-newsjob'
description 'Enhanced News Job for QBCore'
author 'xViperAG'
version '3.0.0'

shared_scripts { '@ox_lib/init.lua', '@qbx_core/modules/lib.lua' }
client_scripts { '@qbx_core/modules/playerdata.lua', 'client/main.lua', 'client/camera.lua' }
server_script 'server/main.lua'
files { 'config/*.lua' }

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory'
}
