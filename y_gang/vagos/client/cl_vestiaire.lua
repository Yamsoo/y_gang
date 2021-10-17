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
local vestvagoss = RageUI.CreateMenu('~y~Vestaire', Config.pastouche)
vestvagoss.Display.Header = true 
vestvagoss.Closed = function()
  open = false
end

function vetahvagos()
     if open then 
         open = false
         RageUI.Visible(vestvagoss, false)
         return
     else
         open = true 
         RageUI.Visible(vestvagoss, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(vestvagoss,function() 


              RageUI.Button("~h~Reprendre sa Tenue", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                  tenuecivilvagos()
                end
               }) 

                RageUI.Separator("↓ ~y~Tenues Vagos ~s~↓")

                RageUI.Button("Tenue ~y~Vagos", nil, {RightLabel = "→"}, true , {
                  onSelected = function()
                    vvagos()
                  end
                 })


            end)
          Wait(0)
         end
      end)
   end
end



local position = {
	{x =341.35, y = -2021.99, z = 25.59}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vagos' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vagos' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22,341.35, -2021.99, 25.59, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~y~E~w~] pour accéder au ~y~Véstiraire", 1) 
                if IsControlJustPressed(1,51) then
                  vetahvagos()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)



function vvagos()
  local model = GetEntityModel(GetPlayerPed(-1))
  TriggerEvent('skinchanger:getSkin', function(skin)
      if model == GetHashKey("mp_m_freemode_01") then

          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 15, ['tshirt_2'] = 2,
            ['torso_1'] = 1, ['torso_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 5, ['pants_2'] = 8,
            ['shoes_1'] = 6, ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['bproof_1'] = 0,
            ['chain_1'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
          }
      else
        clothesSkin = {
          ['bags_1'] = 0, ['bags_2'] = 0,
          ['tshirt_1'] = 15, ['tshirt_2'] = 2,
          ['torso_1'] = 1, ['torso_2'] = 0,
          ['arms'] = 0,
          ['pants_1'] = 5, ['pants_2'] = 8,
          ['shoes_1'] = 6, ['shoes_2'] = 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['bproof_1'] = 0,
          ['chain_1'] = 0,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          }
      end
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
  end)
end

-- Reload perso
function tenuecivilvagos()
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
      TriggerEvent('skinchanger:loadSkin', skin)
  end)
end
