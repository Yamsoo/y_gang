fx_version 'adamant'
game 'gta5'


client_scripts {
    "src2/RMenu.lua",
    "src2/menu/RageUI.lua",
    "src2/menu/Menu.lua",
    "src2/menu/MenuController.lua",
    "src2/components/*.lua",
    "src2/menu/elements/*.lua",
    "src2/menu/items/*.lua",
    "src2/menu/panels/*.lua",
    "src2/menu/panels/*.lua",
    "src2/menu/windows/*.lua"
}

client_scripts {

    -- Ballas
    'ballas/client/*.lua',

    -- Families
    'families/client/*.lua',

    -- Vagos
    'vagos/client/*.lua',

    -- Mara
    'mara/client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    -- Ballas
    'ballas/server/*.lua',

    -- Families
    'families/server/*.lua', 

    -- Vagos
    'vagos/server/*.lua',     

    -- Mara
    'mara/server/*.lua'    
}

shared_scripts {
    'config.lua'
}
