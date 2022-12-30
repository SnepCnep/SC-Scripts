ESX = exports["es_extended"]:getSharedObject() -- Es_extended 1.18+
--
-- -- Gemaakt door 𝓢𝓷𝓮𝓹𝓒𝓷𝓮𝓹#0074 | script nakken ben je de lul =) 
--

Citizen.CreateThread(function()
print('Instelleren van belangerijke content (Er kan mogelijk een lagspike komen)')
        Citizen.Wait(2500)    
print('Gelukt, u kunt nu gebruik maken van de AllWipe')
end)

local cooldownmenu = true
local cooldown = true
local time = 5
local timee = 3
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if cooldownmenu then
		else
			time = time - 1
			if time <= 0 then
                time = 5
                    cooldownmenu = true
			end
		end
		if cooldown then
		else
			timee = timee - 1
			if timee <= 0 then
                timee = 3
                    cooldown = true
			end
		end
	end
end)


-- clearallmenu register
RegisterNetEvent('sc:clearallmenu-open')
AddEventHandler('sc:clearallmenu-open', function()
        if cooldownmenu then
            clearallmenu()
            cooldownmenu = false
		else
			exports['okokNotify']:Alert("SC ClearAll", "Wacht tot de cooldown weg is.", 1500, 'error')
		end
end)


-- clearallmenu
local toDelete = {}
function clearallmenu()  

    local Elements = {
        {label = "<----| SC ClearAll |---->", name = "niks"},
        {label = "Auto's", name = "cars"},
        {label = "Auto's | Not in vehicle", name = "carsdo"},
        {label = "Objecten", name = "props"},
        {label = "Peds", name = "peds"},
		{label = "All", name = "all"},
        {label = "<----| SC AllWipe |---->", name = "niks"},
      }
    

      ESX.UI.Menu.Open("default", GetCurrentResourceName(), "clearallmenu", {
        title = "SC ClearAll", 
        align    = 'top-right',
        elements = Elements
      }, function(data,menu)
           if cooldown then
                    cooldown = false
                local protect = 1243 -- nou hacker dit is het wachtwoord success    = ) 
        	if data.current.name == "niks" then
                	print("SC-ALlWipe ( Gemaakt door SnepCnep )") -- dit doet niks dit is er zodat er geen errors komen 

            elseif data.current.name == "cars" then
				TriggerServerEvent('SC-wipesyteem', "cars", protect)
                    print("Jij delete alle voeruigen")

            elseif data.current.name == "carsdo" then
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end

            elseif data.current.name == "props" then
				TriggerServerEvent('SC-wipesyteem', "props", protect)
                    print("Jij delete alle props")

			elseif data.current.name == 'peds' then
				TriggerServerEvent('SC-wipesyteem', "peds", protect)
                    print("Jij delete alle peds")

            elseif data.current.name == 'all' then
				TriggerServerEvent('SC-wipesyteem-all', protect)
                    print("Jij delete alles")
        end
				else
		exports['okokNotify']:Alert("SC ClearAll", "Wacht tot de cooldown weg is.", 1500, 'error')
				end
      end, function(data, menu) 
        menu.close()
      end)
    end




--- function nog iets
local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end


function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
