RegisterCommand("gethash", function(source, args)
	local ped = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(ped, false)
	local emodel = GetEntityModel(currentVehicle)
	local model = GetDisplayNameFromVehicleModel(emodel)
	if currentVehicle == 0 then
		print("Jij zit in geen auto")
	else
        print("Entity Model: ("..emodel..")")
       	print("Model: ("..model..")")
end
end)


RegisterCommand("gettunes", function()
	local ped = PlayerPedId()
    local thisauto = GetVehiclePedIsIn(ped, false)
	if thisauto == 0 then
            print("jij zit in geen auto")
            else
local engine = GetVehicleMod(thisauto, 11) + 1
local armour = GetVehicleMod(thisauto, 16) + 1
local Turbo = GetVehicleMod(thisauto, 18) + 1
print(engine)
print(armour)
print(Turbo)
	end
end)

RegisterCommand("allecars", function()
	local vehicles = GetAllVehicleModels()
	for _, allecars in pairs(vehicles) do
            print(allecars)
	end
end)
