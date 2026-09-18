local PlayerData = {}

local function SendDiscordLog(source, eventName, violationCount, isKicked)

    if not Config.DiscordWebhook or Config.DiscordWebhook == "" or Config.DiscordWebhook == "Put_here_Your_Discord_Webhook" then
        return
    end

    local playerName = GetPlayerName(source) or "Unknown"


    local playerPing = GetPlayerPing(source) or 0
    local identifiers = GetPlayerIdentifiers(source) or {}

    local steamId, license, discord, ip = "N/A", "N/A", "N/A", "N/A"

    for _, v in ipairs(identifiers) do
        if string.match(v, "steam:") then steamId = v
        elseif string.match(v, "license:") then license = v

        elseif string.match(v, "discord:") then discord = string.gsub(v, "discord:", "")

        elseif string.match(v, "ip:") then ip = string.gsub(v, "ip:", "") end
    end

    local actionText = isKicked and "KICKED FROM SERVER" or "LOGGED / WARNED"
    local embedColor = isKicked and 15158332 or 15105570

    local embed = {
        {
            ["color"] = embedColor,
            ["title"] = "🛡️ AFK AntiSpamTrigger Alert",
            ["description"] = "Player detected spamming network events!",
            ["fields"] = {
                { ["name"] = "Player Name", ["value"] = playerName, ["inline"] = true },
                { ["name"] = "Player ID", ["value"] = tostring(source), ["inline"] = true },
                { ["name"] = "Ping", ["value"] = playerPing .. " ms", ["inline"] = true },
                { ["name"] = "Triggered Event", ["value"] = "```" .. eventName .. "```", ["inline"] = false },
                { ["name"] = "Violations", ["value"] = violationCount .. " / " .. Config.WarningThreshold, ["inline"] = true },
                { ["name"] = "Action Taken", ["value"] = "**" .. actionText .. "**", ["inline"] = true },
                { ["name"] = "Identifiers", ["value"] = "Discord: <@" .. discord .. ">\nSteam: " .. steamId .. "\nLicense: " .. license .. "\nIP: " .. ip, ["inline"] = false }
            },
            ["footer"] = { ["text"] = "AFK_AntiSpamTrigger | System Logs" },
            ["timestamp"] = os.date("!Y-%m-%dT%H:%M:%SZ")
        }
    }

    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = "AFK AntiSpam", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

local function ProcessEventSecurity(src, eventName)
    if not src or src == 0 or Config.WhitelistedEvents[eventName] then
        return true
    end

    local playerId = tostring(src)

    local currentTime = os.clock()

    if not PlayerData[playerId] then

        PlayerData[playerId] = {

            globalHistory = {},
            eventHistory = {},
            violations = 0
        }
    end

    local pData = PlayerData[playerId]

    for i = #pData.globalHistory, 1, -1 do

        if currentTime - pData.globalHistory[i] > 1.0 then

            table.remove(pData.globalHistory, i)
        end
    end

    if not pData.eventHistory[eventName] then
        pData.eventHistory[eventName] = {}


    end

    for i = #pData.eventHistory[eventName], 1, -1 do
        if currentTime - pData.eventHistory[eventName][i] > 1.0 then
            table.remove(pData.eventHistory[eventName], i)
        end
    end

    table.insert(pData.globalHistory, currentTime)


    table.insert(pData.eventHistory[eventName], currentTime)

    local maxAllowedForThisEvent = Config.StrictEvents[eventName] or Config.MaxSingleEventPerSecond
    local isViolating = false

    if #pData.globalHistory > Config.MaxGlobalEventsPerSecond or #pData.eventHistory[eventName] > maxAllowedForThisEvent then
        isViolating = true
    end

    if isViolating then
        pData.violations = pData.violations + 1

        TriggerEvent('AFK_AntiSpamTrigger:onViolation', src, eventName, pData.violations)

        if pData.violations >= Config.WarningThreshold then
            local isKicked = (Config.PunishmentMode == "kick")
            


            SendDiscordLog(src, eventName, pData.violations, isKicked)
            TriggerEvent('AFK_AntiSpamTrigger:onSpammerDetected', src, eventName, pData.violations, isKicked)

            if isKicked then
                DropPlayer(src, "[AFK_AntiSpamTrigger] Network Event Flooding Detected.")

            end
        end

        return false
    end

    return true
end

AddEventHandler('netEvent', function(eventName, ...)

    local src = source

    if not ProcessEventSecurity(src, eventName) then

        CancelEvent()
    end
end)

AddEventHandler('playerDropped', function()

    local src = tostring(source)

    PlayerData[src] = nil
end)

function IsPlayerLimited(src)

    local id = tostring(src)
    
    return PlayerData[id] and PlayerData[id].violations >= Config.WarningThreshold or false
end
