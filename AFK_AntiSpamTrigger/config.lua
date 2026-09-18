Config = {}

Config.DiscordWebhook = "Put_here_Your_Discord_Webhook"

-- Mode Options: "log" (ONLY DISCORD LOG) or "kick" (LOG TO DISCORD + KICK PLAYER)
Config.PunishmentMode = "kick"

Config.MaxGlobalEventsPerSecond = 15

Config.MaxSingleEventPerSecond = 5

Config.WarningThreshold = 3

Config.StrictEvents = {
    ['esx:giveInventoryItem'] = 2,
    ['Your Trigger Event'] = 2,

}

Config.WhitelistedEvents = {
    ['playerConnecting'] = true,
    ['Your Trigger Event Whitelist'] = true,

}
