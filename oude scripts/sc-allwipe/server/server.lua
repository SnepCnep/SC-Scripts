ESX = exports["es_extended"]:getSharedObject()
-- ^^ nieuwe esx
--ESX = nil TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- ^^ oude esx



--
-- -- Gemaakt door 𝓢𝓷𝓮𝓹𝓒𝓷𝓮𝓹#0074 =) 
--

RegisterCommand("clearallmenu", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
if (source > 0) then
    if IsPlayerAceAllowed(source, "sc.npccontroll") then
            TriggerClientEvent('sc:clearallmenu-open', src)
	else
			TriggerClientEvent('okokNotify:Alert', src, "SC ClearAll", "Onjuisten permissions.", 2000, 'error')
    end
else
	print("SC - Dit command kan niet via de console worden uitgevoerd")
end
end)

local allow = false
RegisterServerEvent('SC-wipesyteem')
AddEventHandler('SC-wipesyteem', function(sort, protect)
	local toDelete = {}
        if protect == 1243 then
            allow = true
		else
            allow = false
            DropPlayer(source, "SC-Protect - U probeert AllWipe activeren")
		end
        if allow then
			if sort == "cars" then
				toDelete = GetAllVehicles()
                TriggerClientEvent("txAdmin:receiveAnnounce", -1, "Alle CARS zijn verwijdert", "SC Allwipe")
			elseif sort == "peds" then
				toDelete = GetAllPeds()
                TriggerClientEvent("txAdmin:receiveAnnounce", -1, "Alle PEDS zijn verwijdert", "SC Allwipe")
			elseif sort == "props" then
				toDelete = GetAllObjects()
                TriggerClientEvent("txAdmin:receiveAnnounce", -1, "Alle PROPS zijn verwijdert", "SC Allwipe")
			end
	for _,entity in pairs(toDelete) do
		DeleteEntity(entity)
                allow = false
	end
            end
end)

RegisterServerEvent('SC-wipesyteem-all')
AddEventHandler('SC-wipesyteem-all', function(protect)
local toDelete1 = GetAllVehicles()
local toDelete2 = GetAllPeds()
local toDelete3 = GetAllObjects()
        if protect == 1243 then
            allow = true
		else
            allow = false
            DropPlayer(source, "SC-Protect - U probeert AllWipe activeren")
		end
        if allow then
			TriggerClientEvent("txAdmin:receiveAnnounce", -1, "Alle (cars/props/peds) zijn verwijdert", "SC Allwipe")
	for _,entity1 in pairs(toDelete1) do
		DeleteEntity(entity1)
		allow = false
	end
	for _,entity2 in pairs(toDelete2) do
		DeleteEntity(entity2)
		allow = false
	end
	for _,entity3 in pairs(toDelete3) do
		DeleteEntity(entity3)
       	allow = false
	end
            end
end)
