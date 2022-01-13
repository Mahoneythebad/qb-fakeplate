local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("screwdriverset", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-fakeplate:removeplate", source)
    end
end)

QBCore.Functions.CreateUseableItem("license_plate", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-fakeplate:placeplate", source)
    end
end)
