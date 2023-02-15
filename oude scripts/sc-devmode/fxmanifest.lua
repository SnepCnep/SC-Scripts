fx_version 'adamant'

game 'gta5'

description 'SC GangJobs | SnepCnep'
lua54 'yes'
version '1'
author '𝓢𝓷𝓮𝓹𝓒𝓷𝓮𝓹#0074'

shared_script '@es_extended/imports.lua'

server_scripts {
	'config.lua',
    'server/*lua'
}

client_scripts {
    'client/*lua',
	'config.lua'
}

dependencies {
	'es_extended'
}
