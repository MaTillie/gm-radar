local QBCore = exports['qb-core']:GetCoreObject()


RegisterCommand("testaddradar", function()    
    local playerCoords = GetEntityCoords(PlayerPedId())
end, false)


Citizen.CreateThread(function()
    Citizen.Wait(0)
        while true do      
            Citizen.Wait(0)
            local playerPed = GetPlayerPed(-1)
            local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
   
            for k=1, #Config.Radar,1 do
                local distance = GetDistanceBetweenCoords(playerX, playerY, playerZ, Config.Radar[k].x, Config.Radar[k].y, Config.Radar[k].z, true)
                if distance <= Config.Radar[k].radius then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    
                    if (GetPedInVehicleSeat(vehicle, -1) == playerPed) then
                        Vitesse = GetEntitySpeed(vehicle)                                                                 
                        v = Vitesse *3.6;
                        v = v + math.random(0,4);
                        v = math.floor(v)
                        if ((v-5)>Config.Radar[k].speedLimit)then                                                       
                            QBCore.Functions.Notify("Excès de vitesse, limite: "..Config.Radar[k].speedLimit .." constaté: "..v.." retenue :"..v-5)
                            local plate = QBCore.Functions.GetPlate(vehicle)
                            local maque = IsPedWearingHelmet(playerPed) -- Indique si le joueur est masqué ou non
                            -- faire un fichier de configuration pour gérer des véhicules "d'urgence" IsVehicleModel(vehicle, GetHashKey("ambulance"))
                            -- IsVehicleSirenOn(vehicle) indique que les sirène sont activée

                            Wait(3000)
                        else
                            ---QBCore.Functions.Notify("Zone à : "..Config.Radar[k].speedLimit .." constaté: "..v)   
                        end
                    end
                    Wait(1000)
                end    
            end            
        end
    
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PopProps()
end)

AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end
    PopProps()
end)
-- props radar ba_prop_battle_cameradrone v_ret_ml_fridge02
function PopProps()
    for k=1, #Config.Radar,1 do
        CreateObject(GetHashKey("ba_prop_battle_cameradrone"),Config.Radar[k].x, Config.Radar[k].y, Config.Radar[k].z,false,false,false)
    end
end    