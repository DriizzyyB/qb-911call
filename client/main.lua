local function send911Call(location, message)
    TriggerServerEvent('qb-911call:server:send911Call', location, message)
end

RegisterCommand('911', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local location = {
        x = playerCoords.x,
        y = playerCoords.y,
        z = playerCoords.z
    }
    local message = table.concat(args, ' ')

    if message == '' then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {'[911]', 'You need to provide a message.'}
        })
        return
    end

    send911Call(location, message)

    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {'[911]', 'Your call has been sent.'}
    })
end, false)

-- Handle Phone Calls
RegisterNetEvent('qb-phone:client:CallContact')
AddEventHandler('qb-phone:client:CallContact', function(contactName, callNumber)
    if callNumber == '911' then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local location = {
            x = playerCoords.x,
            y = playerCoords.y,
            z = playerCoords.z
        }
        local message = "Phone Call to 911"

        send911Call(location, message)

        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {'[911]', 'Your call has been sent.'}
        })
    end
end)
