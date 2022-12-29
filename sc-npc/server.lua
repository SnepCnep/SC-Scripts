ESX = exports["es_extended"]:getSharedObject() -- Es_extended 1.18+

RegisterCommand("nonpc-uit", function(source)
    local src = source
    if IsPlayerAceAllowed(source, "sc.npccontroll") then
            TriggerClientEvent('sc:nonpc-uit', src)
		else
			TriggerClientEvent('okokNotify:Alert', src, "SC NONPC", "Onjuisten permissions", 2000, 'error')
    end
end)

RegisterCommand("nonpc-aan", function(source)
    local src = source
    if IsPlayerAceAllowed(source, "sc.npccontroll") then
            TriggerClientEvent('sc:nonpc-aan', src)
		else
			TriggerClientEvent('okokNotify:Alert', src, "SC NONPC", "Onjuisten permissions", 2000, 'error')
    end
end)