local NPC = true -- de script is default ( true )
local time = 0 -- dont chance this
local npclevel = 0.0 -- standaard ( 0.0 )
local npcleveltof = false -- standaard ( false )

RegisterNetEvent('sc:nonpc-uit')
AddEventHandler('sc:nonpc-uit', function()
            if NPC then
           		NPC = false
           		time = 1000
            	exports['okokNotify']:Alert("SC-NONPC", 'Staat nu UIT', 2500, 'success')
			else
				exports['okokNotify']:Alert("SC-NONPC", 'Stond al UIT', 2500, 'info')
			end
end)
RegisterNetEvent('sc:nonpc-aan')
AddEventHandler('sc:nonpc-aan', function()
            if NPC then
				exports['okokNotify']:Alert("SC-NONPC", 'Stond al AAN', 2500, 'info')
			else
				NPC = true
                time = 0
            	exports['okokNotify']:Alert("SC-NONPC", 'Staat nu AAN', 2500, 'success')
			end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(time) 
        if NPC then
			SetVehicleDensityMultiplierThisFrame(npclevel) -- set traffic density to 0
			SetPedDensityMultiplierThisFrame(npclevel) -- set npc/ai peds density to 0
			SetRandomVehicleDensityMultiplierThisFrame(npclevel) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
			SetParkedVehicleDensityMultiplierThisFrame(npclevel) -- set random parked vehicles (parked car scenarios) to 0
			SetScenarioPedDensityMultiplierThisFrame(npclevel, npclevel) -- set random npc/ai peds or scenario peds to 0
			SetGarbageTrucks(npcleveltof) -- Stop garbage trucks from randomly spawning
			SetRandomBoats(npcleveltof) -- Stop random boats from spawning in the water.
			SetCreateRandomCops(npcleveltof) -- disable random cops walking/driving around.
			SetCreateRandomCopsNotOnScenarios(npcleveltof) -- stop random cops (not in a scenario) from spawning.
			SetCreateRandomCopsOnScenarios(npcleveltof) -- stop random cops (in a scenario) from spawning.

			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
			RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
		end
	end
end)
