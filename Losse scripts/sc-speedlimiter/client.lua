local sleep = 1000
local som1 = 0
local som2 = 0
local som3 = 0
local som4 = 0
local modtunes = 0

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(sleep)
    local ped = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(ped, false)
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))


for _, auto in pairs(Config.SpeedLimit) do
    if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() and model == auto.naam then
local engine = GetVehicleMod(currentVehicle, 11) + 1
local armour = GetVehicleMod(currentVehicle, 16) + 1
local turbo = GetVehicleMod(currentVehicle, 18) + 1
	local som1 = engine * auto.Engine
	local som2 = armour * auto.Armour
	local som3 = turbo * auto.Turbo
	local som4 = som1 + som3
	local modtunes = som4 + som2 
				sleep = 500
local speedmax = modtunes + auto.speed
local speedd = speedmax  / Config.km
        		SetVehicleMaxSpeed(currentVehicle, speedd)
                    else
                    sleep = 1000
			end
    	end
	end
end)