RegisterNetEvent("veendam-bring-target")
AddEventHandler("veendam-bring-target", function(tgtId)
   		TriggerServerEvent('txAdmin:menu:tpToPlayer', tgtId)
end)
RegisterNetEvent("veendam-goto-target")
AddEventHandler("veendam-goto-target", function(tgtId)
   		TriggerServerEvent('txAdmin:menu:summonPlayer', tgtId)
end)