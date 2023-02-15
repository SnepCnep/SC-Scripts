local isstartted = false
local locked = true
local sleep = 2000
local protect = "Pizzagamer!23"
local geld = 0
local isTaken                   = 0
local copblip
local deliveryblip

ESX = exports["es_extended"]:getSharedObject()

local cooldownnotify = true
local timee = 5
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		if not cooldownnotify then
			timee = timee - 1
			if timee <= 0 then
                timee = 5
                    cooldownnotify = true
			end
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
 PlayerData = xPlayer
end)
 
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
 PlayerData.job = job
end)
-- # Start missie
Citizen.CreateThread(function()
        while true do
			Citizen.Wait(sleep)
        	if InMarker1() then
                sleep = 1
                DrawMarker(2,Config.startpoint , 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.25, 0.25, 0.25, 255, 255, 255, 50, true, true, 2, nil, nil, false)
                ESX.TriggerServerCallback('esx_carthief:isActive', function(isActive)
                        if isActive == 0 then
				ESX.TriggerServerCallback('esx_carthief:anycops', function(anycops)
				if anycops >= Config.minimaalagent then
                if cooldownnotify and InMarker4() then
                    cooldownnotify = false
                    exports['okokNotify']:Alert("AutoDiefstal", 'Klik op (E) om een autodiefstal te starten', 1500, 'info')
				end
                if IsControlJustPressed(0, 38) and InMarker4() then
                    if isstartted then
                        exports['okokNotify']:Alert("AutoDiefstal", 'Jij hebt al een autodiefstal gestart!', 2500, 'error')
					else
                    	exports['okokNotify']:Alert("AutoDiefstal", 'Jij hebt autodiefstal gestart, ga naar de locatie op de map!', 2500, 'success')
						SpawnAuto()
					end
				end
                else
				if cooldownnotify and InMarker4() then
                    cooldownnotify = false
                exports['okokNotify']:Alert("AutoDiefstal", "Er zijn niet genoeg agent er zijn minimaal ("..Config.minimaalagent..") nodig!", 2500, 'error')
				end
				end
				end)
                else
				if cooldownnotify then
                    cooldownnotify = false
                    exports['okokNotify']:Alert("AutoDiefstal", 'Klik op (E) om een autodiefstal te starten', 1500, 'info')
				end
				end
				end)
                else
                sleep = 1000
            end
        end
    end)
--#Start & pak auto
function SpawnAuto()
    randomcar = math.random(1,#Config.autos)
	local vehiclehash = GetHashKey(Config.autos[randomcar])
	RequestModel(vehiclehash)
		while not HasModelLoaded(vehiclehash) do
		RequestModel(vehiclehash)
		Citizen.Wait(1)
		end
		car = CreateVehicle(vehiclehash, Config.Spawnpoint, true, false)
		SetEntityAsMissionEntity(car, true, true)
    	SetVehicleDoorsLockedForAllPlayers(car, true)
    	SetNewWaypoint(Config.Spawnpoint)
    	isstartted = true
        rverkoop = math.random(1,#Config.Verkoop)
		randomverkoop = Config.Verkoop[rverkoop]
end
-- #Maak auto open
Citizen.CreateThread(function()
        while true do
			Citizen.Wait(sleep)
        	if isstartted and InMarker2() and locked then
            	sleep = 1	
				DrawMarker(2,Config.Lockpick , 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.25, 0.25, 0.25, 255, 255, 255, 50, true, true, 2, nil, nil, false)
                if cooldownnotify and InMarker3() then
                    cooldownnotify = false
                    exports['okokNotify']:Alert("AutoDiefstal", 'Klik op (E) om het voertuig open te breken', 1500, 'info')
				end
                if IsControlJustPressed(0, 38) and InMarker3() then
					TriggerEvent('lockpicking:StartMinigame')
                    AddEventHandler('lockpicking:MinigameComplete', function(didWin)
                            if didWin then
                                Citizen.Wait(10)
                                SetVehicleDoorsLockedForAllPlayers(car, false)
                                Citizen.Wait(10)
                                TriggerServerEvent('esx_carthief:registerActivity', 1)
                                SetVehicleDoorsLockedForAllPlayers(car, false)
                                locked = false
                                SetNewWaypoint(randomverkoop)
                                Citizen.Wait(100)
								TriggerServerEvent('esx_carthief:registerActivity', 1)
								isTaken = 1
								isDelivered = 0
                                exports['okokNotify']:Alert("AutoDiefstal", 'gelukt, het voertuig is nu open!', 1000, 'success')
						end
					end)
				end
                else
                sleep = 1000
            end
        end
    end)
Citizen.CreateThread(function()
        while true do
            	local ped = PlayerPedId()
    			local currentVehicle = GetVehiclePedIsIn(ped, false)
			Citizen.Wait(sleep)
        		if isstartted and InMarker5() then
                sleep = 1
                DrawMarker(23,randomverkoop, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 5.0, 5.0, 2.5, 255, 255, 255, 50, false, true, 2, nil, nil, false)
				if cooldownnotify and InMarker4() then
                    cooldownnotify = false
                    exports['okokNotify']:Alert("AutoDiefstal", 'Klik op (E) om de auto te verkopen', 1000, 'info')
				end
                if IsControlJustPressed(0, 38) and currentVehicle == car and InMarker6() then
				DeleteVehicle(car)
				geld = math.random(Config.minigeld, Config.maxgeld)
				TriggerServerEvent('SC-AutoDiefstal:pay', geld, protect)
				locked = true
				isstartted = false
				TriggerServerEvent('esx_carthief:registerActivity', 0)
				exports['okokNotify']:Alert("AutoDiefstal", "gelukt jij hebt ("..geld..") zwart geld kregen. Maak dat je wegkomt!!!", 3000, 'success')
				geld = 0
				end
                else
                sleep = 1000
            end
        end
    end)
-- #Check Markers
function InMarker1()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(Config.startpoint, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance <= 20 then
			return true
	end
end
function InMarker2()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(Config.Lockpick, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance <= 10 then
			return true
	end
end
function InMarker3()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(Config.Lockpick, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance <= 0.5 then
			return true
	end
end
function InMarker4()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(Config.startpoint, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance <= 0.5 then
			return true
	end
end
function InMarker5()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(randomverkoop, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance <= 50 then
			return true
	end
end
function InMarker6()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(randomverkoop, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance <= 2.5 then
			return true
	end
end
-- extra's
function AbortDelivery()
	--Delete Car
	SetEntityAsNoLongerNeeded(car)
	DeleteEntity(car)

	--Remove delivery zone
	RemoveBlip(deliveryblip)

	--Register Activity
	TriggerServerEvent('esx_carthief:registerActivity', 0)

	--For delivery blip
	isTaken = 0

	--For delivery blip
	isDelivered = 1

	--Remove Last Cop Blips
	TriggerServerEvent('esx_carthief:stopalertcops')
end
Citizen.CreateThread(function()
  while true do
    Wait(1000)
		if isTaken == 1 and isDelivered == 0 and not (GetVehiclePedIsIn(GetPlayerPed(-1), false) == car) then
			exports['okokNotify']:Alert("AutoDiefstal", 'Ga terug in jou auto binnen ( 1 minute ).', 3000, 'info')
			Wait(50000)
			if isTaken == 1 and isDelivered == 0 and not (GetVehiclePedIsIn(GetPlayerPed(-1), false) == car) then
				exports['okokNotify']:Alert("AutoDiefstal", 'Ga terug in jou auto binnen ( 10 seconden ).', 3000, 'info')
				Wait(10000)
				exports['okokNotify']:Alert("AutoDiefstal", 'AutoDiefstal gefaalt.', 3000, 'info')
				AbortDelivery()
			end
		end
	end
end)
-- Send location
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(Config.BlipUpdateTime)
    if isTaken == 1 and IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local coords = GetEntityCoords(GetPlayerPed(-1))
      TriggerServerEvent('esx_carthief:alertcops', coords.x, coords.y, coords.z)
		elseif isTaken == 1 and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			TriggerServerEvent('esx_carthief:stopalertcops')
    end
  end
end)

RegisterNetEvent('esx_carthief:removecopblip')
AddEventHandler('esx_carthief:removecopblip', function()
		RemoveBlip(copblip)
end)

RegisterNetEvent('esx_carthief:setcopblip')
AddEventHandler('esx_carthief:setcopblip', function(cx,cy,cz)
		RemoveBlip(copblip)
    copblip = AddBlipForCoord(cx,cy,cz)
    SetBlipSprite(copblip , 161)
    SetBlipScale(copblipy , 2.0)
		SetBlipColour(copblip, 8)
		PulseBlip(copblip)
end)

RegisterNetEvent('esx_carthief:setcopnotification')
AddEventHandler('esx_carthief:setcopnotification', function()
	ESX.ShowNotification("Auto Diefstal gaande kijk op uw map voor meer informatie.")
end)
-- #blips
Citizen.CreateThread(function()
    info = AddBlipForCoord(Config.startpoint)
    SetBlipSprite(info, 229)
    SetBlipDisplay(info, 4)
    SetBlipScale(info, 1.0)
    SetBlipColour(info, 6)
    SetBlipAsShortRange(info, true)
    BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Auto Diefstal")
    EndTextCommandSetBlipName(info)
end)