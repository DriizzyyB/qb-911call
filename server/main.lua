QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-911call:server:send911Call')
AddEventHandler('qb-911call:server:send911Call', function(location, message)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local characterName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname

    -- Debugging: Print the details being sent to ps-dispatch
    print("Sending 911 Call to ps-dispatch")
    print("Location: " .. json.encode(location))
    print("Message: " .. message)
    print("Character Name: " .. characterName)

    -- Trigger the ps-dispatch event to create a new call
    TriggerEvent('ps-dispatch:server:notify', {
        dispatchCode = '911',
        dispatchMessage = message,
        firstName = Player.PlayerData.charinfo.firstname,
        lastName = Player.PlayerData.charinfo.lastname,
        location = location,
        job = 'police',
        caller = characterName,
        priority = 1,
        isEmergency = true,
        time = os.date('%Y-%m-%d %H:%M:%S')
    })
    
    TriggerClientEvent('QBCore:Notify', src, 'Your 911 call has been recorded.', 'success')
end)
