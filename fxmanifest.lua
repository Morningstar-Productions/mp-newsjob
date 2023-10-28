fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

name 'mp-newsjob'
description 'Enhanced News Job for QBCore'
author 'xViperAG'
version '2.1.5'

--modules { 'qbx_core:utils', 'qbx_core:playerdata' }
shared_scripts { '@ox_lib/init.lua', --[['@qbx_core/import.lua',]] 'config.lua' }

client_scripts { 'client/main.lua', 'client/camera.lua' }

server_script 'server/main.lua'

dependencies {
    -- 'futte-newspaper',
    'ox_lib',
    'ox_target',
    'ox_inventory'
}
