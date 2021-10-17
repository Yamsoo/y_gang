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
local garagvagos = RageUI.CreateMenu('~y~Garage', Config.pastouche)
garagvagos.Display.Header = true 
garagvagos.Closed = function()
  open = false
end


function garagevagos()
     if open then 
         open = false
         RageUI.Visible(garagvagos, false)
         return
     else
         open = true 
         RageUI.Visible(garagvagos, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(garagvagos,function() 

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
                      voituredesvagos(v.modele)
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
	{x = 324.36, y = -2039.0, z = 20.7}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vagos' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vagos' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 3.0 then
            wait = 0
            DrawMarker(22, 324.36, -2039.0, 20.7, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~y~E~w~] pour accéder au ~y~Garage", 1) 
                if IsControlJustPressed(1,51) then
                  garagevagos()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


function voituredesvagos(car)
  local car = GetHashKey(car)

  RequestModel(car)
  while not HasModelLoaded(car) do
      RequestModel(car)
      Citizen.Wait(0)
  end

  local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
  local vehicle = CreateVehicle(car, 324.36, -2039.0, 20.7, 320.08, true, false)
  SetEntityAsMissionEntity(vehicle, true, true)
  local plaque = "VAGOS"..math.random(1,9000)
  SetVehicleNumberPlateText(vehicle, plaque) 
  SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
  SetVehicleCustomPrimaryColour(vehicle, 255, 255, 3)
  SetVehicleCustomSecondaryColour(vehicle, 255, 255, 3)
end