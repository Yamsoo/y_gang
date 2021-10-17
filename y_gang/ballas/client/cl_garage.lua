Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --

local open = false 
local garageballlas = RageUI.CreateMenu('~p~Garage', Config.pastouche)
garageballlas.Display.Header = true 
garageballlas.Closed = function()
  open = false
end


function garageballas()
     if open then 
         open = false
         RageUI.Visible(garageballlas, false)
         return
     else
         open = true 
         RageUI.Visible(garageballlas, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(garageballlas,function() 

              RageUI.Button("~h~Ranger Votre véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                  end
                 end
             })

              RageUI.Separator("~h~↓ Véhicules ↓")

                for k,v in pairs(Config.spawnvoiture) do
                RageUI.Button(v.nom, nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      Citizen.Wait(1)  
                      voituredesballas(v.modele)
                      RageUI.CloseAll()
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end



local position = {
	{x = 87.21, y = -1968.89, z = 20.75}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ballas' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'ballas' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, 87.21, -1968.89, 20.75, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 175, 3, 255, 255, true, true, p19, true)  

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~p~E~w~] pour accéder au ~p~Garage", 1) 
                if IsControlJustPressed(1,51) then
                  garageballas()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


function voituredesballas(car)
  local car = GetHashKey(car)

  RequestModel(car)
  while not HasModelLoaded(car) do
      RequestModel(car)
      Citizen.Wait(0)
  end

  local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
  local vehicle = CreateVehicle(car, 87.21, -1968.89, 20.75, 320.98, true, false)
  SetEntityAsMissionEntity(vehicle, true, true)
  local plaque = "BALLAS"..math.random(1,9000)
  SetVehicleNumberPlateText(vehicle, plaque) 
  SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
  SetVehicleCustomPrimaryColour(vehicle, 128, 0, 128)
  SetVehicleCustomSecondaryColour(vehicle, 128, 0, 128)
end