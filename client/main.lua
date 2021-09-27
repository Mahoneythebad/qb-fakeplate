QBCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)


RegisterNetEvent("qb-fakeplate:getplate")
AddEventHandler("qb-fakeplate:getplate", function()
    local nvehicle = QBCore.Functions.GetClosestVehicle()
    local vehicle = GetVehicleNumberPlateText(nvehicle)
    print(vehicle)
end)



function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        
        Citizen.Wait(1)
    end
end

 function checknearby()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    local vehicleplate =  GetVehicleNumberPlateText(vehicle)
    local nearbyv = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local putDist = GetDistanceBetweenCoords(pos, nearbyv)
    loadAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, 12000, 0, 0, false, false, false)    
        Skillbar.Start({
        duration = math.random(900, 1000),
        pos = math.random(20, 30),
        width = math.random(15, 20),
    },function()
        local info = {
        vehicleplate
        }
        
        TriggerServerEvent('QBCore:Server:AddItem', "license_plate", 1, false, info)
        QBCore.Functions.Notify("License Plate Stolen,  Plate : ".. vehicleplate , "success", 2500)
        ClearPedTasksImmediately(PlayerPedId())
        SetVehicleNumberPlateText(vehicle, "")
    end)
end

function replaceplate()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    local vehicleplate =  GetVehicleNumberPlateText(vehicle)
    local nearbyv = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local putDist = GetDistanceBetweenCoords(pos, nearbyv)
    loadAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, 12000, 0, 0, false, false, false)    
        Skillbar.Start({
        duration = math.random(700, 1000),
        pos = math.random(15, 30),
        width = math.random(15, 20),
    },function()
        SetVehicleNumberPlateText(vehicle, vehicleplate1)
        TriggerServerEvent('QBCore:Server:RemoveItem', "license_plate", 1)
        ClearPedTasksImmediately(PlayerPedId())
    end)
end
RegisterNetEvent("qb-fakeplate:removeplate")
AddEventHandler("qb-fakeplate:removeplate", function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    QBCore.Functions.TriggerCallback('vehiclekeys:CheckOwnership', function(result)
        if not result then -- if not player owned
            vehicleplate1 =  GetVehicleNumberPlateText(vehicle)
            local test = 0
            local nearbyv = GetEntityCoords(vehicle)
            local pos = GetEntityCoords(PlayerPedId()) 
            local putDist = GetDistanceBetweenCoords(pos, nearbyv)
            if putDist <= 3 then
            checknearby()
            QBCore.Functions.Notify("No Vehicle Nearby" , "error", 2500)
            end
        else
            QBCore.Functions.Notify("Nope!" , "error", 2500)
        end
    end, vehicle)
end)



RegisterNetEvent("qb-fakeplate:placeplate")
AddEventHandler("qb-fakeplate:placeplate", function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local vehicleplate =  GetVehicleNumberPlateText(vehicle)
    local nearbyv = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local putDist = GetDistanceBetweenCoords(pos, nearbyv)
    if putDist <= 3 then
    replaceplate()
    else
        QBCore.Functions.Notify("No Vehicle Nearby" , "error", 2500)
    end
end)

