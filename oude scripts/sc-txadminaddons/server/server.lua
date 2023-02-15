ESX = exports["es_extended"]:getSharedObject()
local id = "Niet gevonden"
AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    local id = eventData.target
    local reason = eventData.reason

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="bubble-message"<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(72,153,219,0.65); border-radius: 5px;">^2^*[SC Panel]:^r</span> ^3[{0}]</span>^r is op vakantie gestuurd voor <span style="color: orange;">{1}</span></div>',
        args = { id, reason }
    })
 	sendToDiscord(Config.Banslogs, 121212, "Verbannen","Stafflid: "..id.. " verbant een speler voor: "..reason)
end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    local id = eventData.target
    local admin = eventData.author
    local reason = eventData.reason

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="bubble-message"<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(72,153,219,0.65); border-radius: 5px;">^2^*[SC Admin]:^r</span> ^3[{0}]</span>^r is gewaarschuwd door ^2{1}</span>^r voor ^r^3{2}</span></div>',
        args = { id, admin, reason }
    })
        sendToDiscord(Config.Warnlogs, 121212, "waarschuwd","Stafflid: "..admin.. "\nwarned: "..id.. " \n voor: "..reason)
end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    local id = eventData.target
    local admin = eventData.author
    local reason = eventData.reason

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="bubble-message"<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(72,153,219,0.65); border-radius: 5px;">^2^*[SC Admin]:^r</span> ^3[{0}]</span>^r is gekicked door ^2{1}</span>^r voor ^r^3{2}</span></div>',
        args = { id, admin, reason }
    })
 sendToDiscord(Config.Kicklogs, 121212, "kickte","Stafflid: "..admin.. "\nkickt: "..id.. " \n voor: "..reason)
end)

-- Kledingmenu
RegisterCommand("kledingmenu", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	if IsPlayerAceAllowed(source, "SC.kledingmenu") then
            if args[1] == nil then
            TriggerClientEvent('esx_skin:openSaveableMenu', src)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft u zelf in staffskin gezet.", 2000, 'success')
        else
            TriggerClientEvent('esx_skin:openSaveableMenu', args[1])
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft iemand in staffskin gezet.", 2000, 'success')
        end
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)

local frozenPlayers = {}

local function isPlayerFrozen(targetId)
  return frozenPlayers[targetId] or false
end
local function isPlayerunFrozen(targetId)
  return frozenPlayers[targetId] or true
end
-- Freeze
RegisterCommand("freeze", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local newFrozenStatus = not isPlayerFrozen(targetId)
	if IsPlayerAceAllowed(source, "SC.freeze") then
        if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        else
    TriggerClientEvent("txAdmin:menu:freezePlayer", args[1], newFrozenStatus)
        end
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)
-- Unfreeze
RegisterCommand("unfreeze", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local newunFrozenStatus = not isPlayerunFrozen(targetId)
	if IsPlayerAceAllowed(source, "SC.freeze") then
        if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN id opgegeven!", 2500, 'error')
        else
    TriggerClientEvent("txAdmin:menu:freezePlayer", args[1], newunFrozenStatus)
        end
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)
-- Tpm
RegisterCommand("tpm", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	if IsPlayerAceAllowed(source, "SC.tpm") then
            TriggerClientEvent('txAdmin:menu:tpToWaypoint', src)
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U bent geteleport naar u waypoint.", 2000, 'success')
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)

-- Goto
RegisterCommand("goto", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	if IsPlayerAceAllowed(source, "SC.goto") then
		if args[1] == nil then
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "Je vergeet een id optegeven", 2000, 'success')
                    else
			 tgtId = args[1]
            TriggerClientEvent('veendam-goto-target',tgtId ,src)
			SetEntityCoords(GetPlayerPed(source),GetEntityCoords(GetPlayerPed(tgtId)))
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "je bent getpt naar. (" ..args[1]..")", 2000, 'success')
                    end
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)
-- Bring
RegisterCommand("bring", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local naam = xPlayer.getName()
	if IsPlayerAceAllowed(source, "SC.bring") then
		if args[1] == nil then
             TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "Je vergeet een id optegeven", 2000, 'success')
                    else
			 tgtId = args[1]
            TriggerClientEvent('veendam-bring-target',tgtId ,src)
			SetEntityCoords(GetPlayerPed(tgtId),GetEntityCoords(GetPlayerPed(source)))
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "je bent getpt naar. (" ..args[1]..")", 2000, 'success')
                    end
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)
-- duty
local indienst = true

RegisterCommand("staffdienst", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local naam = xPlayer.getName()
	local jobnaam = xPlayer.getJob().name
	local jobgrade = xPlayer.getJob().grade
	if IsPlayerAceAllowed(source, "SC.duty") then
		if indienst then
			indienst = false
        	sendToDiscord(Config.Staffinuitdienst, 5763719, "In DIENST","Stafflid: **"..naam.. "** \nIs nu indienst gegaan.")
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "Jij bent nu INDIENST.", 2000, 'info')
			if jobnaam == "police" then
				xPlayer.setJob("offpolice", jobgrade)
			elseif jobnaam == "kmar" then
				xPlayer.setJob("offkmar", jobgrade)
			elseif jobnaam == "ambulance" then
				xPlayer.setJob("offambulance", jobgrade)
			elseif jobnaam == "mechanic" then
				xPlayer.setJob("offmechanic", jobgrade)
		end
		else
			indienst = true
			sendToDiscord(Config.Staffinuitdienst, 15548997, "Uit DIENST","Stafflid: **"..naam.. "** \nIs nu indienst gegaan.")
			TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "Jij bent nu UITIENST.", 2000, 'info')
			if jobnaam == "offpolice" then
				xPlayer.setJob("police", jobgrade)
			elseif jobnaam == "offkmar" then
				xPlayer.setJob("kmar", jobgrade)
			elseif jobnaam == "offambulance" then
				xPlayer.setJob("ambulance", jobgrade)
			elseif jobnaam == "offmechanic" then
				xPlayer.setJob("mechanic", jobgrade)
		end
		end
	else
		TriggerClientEvent('okokNotify:Alert', src, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)
-- SEE je broekzakken
RegisterCommand("inventory", function(source, args)
	if IsPlayerAceAllowed(source, "SC.seeinv") then
    if args[1] then 
        local target = tonumber(args[1])
        if args[1]:lower() == "me" then 
            target = tonumber(source)
        end
        if target ~= nil and GetPlayerName(target) ~= nil then
            local xTarget = ESX.GetPlayerFromId(target)

            local inventory = xTarget.getInventory(false)
            local inventoryText = ""
            for i = 1, #inventory do
                if inventory[i].count > 0 then
                    inventoryText = inventoryText .. inventory[i].label .. ": " .. inventory[i].count .. "<br>"
                end
            end

            local msg = "<b>Naam:</b> " .. GetPlayerName(target) .. " ( " .. target .. " )<br><b>Inventory:</b><br>" .. inventoryText

            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 10, 10, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0}:<br> ' .. msg .. '</div>',
                args = { "Inventory " .. target }
            })
        else
            TriggerClientEvent("esx:showNotification", source, "Speler niet gevonden")
        end
    else
        TriggerClientEvent("esx:showNotification", source, "Geen speler ID opgegeven")
    end
	else
		TriggerClientEvent('okokNotify:Alert', source, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)

RegisterCommand("loadout", function(source, args)
	if IsPlayerAceAllowed(source, "SC.seeload") then
    if args[1] then 
        local target = tonumber(args[1])
        if args[1]:lower() == "me" then 
            target = tonumber(source)
        end
        if target ~= nil and GetPlayerName(target) ~= nil then
            local xTarget = ESX.GetPlayerFromId(target)

            local loadout = xTarget.getLoadout()
            local loadoutText = ""
            for i = 1, #loadout do
                loadoutText = loadoutText .. loadout[i].label .. ": " .. loadout[i].ammo .. "<br>"
            end

            local msg = "<b>Naam:</b> " .. GetPlayerName(target) .. " ( " .. target .. " )<br><b>Loadout:</b><br>" .. loadoutText

            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 10, 10, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0}:<br> ' .. msg .. '</div>',
                args = { "Loadout " .. target }
            })
        else
            TriggerClientEvent("esx:showNotification", source, "Speler niet gevonden")
        end
    else
        TriggerClientEvent("esx:showNotification", source, "Geen speler ID opgegeven")
    end
	else
		TriggerClientEvent('okokNotify:Alert', source, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)

RegisterCommand("informatie", function(source, args)
	if IsPlayerAceAllowed(source, "SC.seeinfo") then
    if args[1] then 
        local target = tonumber(args[1])
        if args[1]:lower() == "me" then 
            target = tonumber(source)
        end
        if target ~= nil and GetPlayerName(target) ~= nil then
            local xTarget = ESX.GetPlayerFromId(target)

            local accounts = xTarget.getAccounts()
            local accountsText = ""
            for i = 1, #accounts do
                accountsText = accountsText .. accounts[i].label .. ": " .. accounts[i].money .. "<br>"
            end

            local job = xTarget.getJob()
            local job_label = job.label or "unemployed"
            local job_grade_label = job.grade_label or "unemployed"
            local job_salary = ESX.Math.GroupDigits(job.grade_salary) or 0.0

            local msg = "<b>Naam:</b> " .. GetPlayerName(target) .. " ( " .. target .. " )<br><b>Baan:</b> " .. job_label .. " ( " .. job_grade_label .. " )<br><b>Salary:</b> " .. job_salary .. "<br><b>Accounts:</b><br>" .. accountsText

            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 10, 10, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0}:<br> ' .. msg .. '</div>',
                args = { "Info " .. target }
            })
        else
            TriggerClientEvent("esx:showNotification", source, "Speler niet gevonden")
        end
    else
        TriggerClientEvent("esx:showNotification", source, "Geen speler ID opgegeven")
    end
	else
		TriggerClientEvent('okokNotify:Alert', source, "[ SC-Admin ]", "U heeft GEEN permissions.", 2000, 'error')
	end
end)
































-- LOGS
function sendToDiscord(webhook, color, name, message)
  local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "SC-Admin",
            },
        }
    }
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end