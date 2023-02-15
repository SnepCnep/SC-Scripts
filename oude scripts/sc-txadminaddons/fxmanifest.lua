fx_version 'adamant'

game 'gta5'
lua54 'yes'
description 'Athene Manager'
author '𝓢𝓷𝓮𝓹𝓒𝓷𝓮𝓹#0074'

shared_script '@es_extended/imports.lua'

server_scripts {
	'server/*.lua',
	'config.lua'
}

client_scripts {
	'client/*.lua',
    'config.lua'
}
