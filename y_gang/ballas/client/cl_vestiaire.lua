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
local vestballas = RageUI.CreateMenu('~p~Vestaire', Config.pastouche)
vestballas.Display.Header = true 
vestballas.Closed = function()
  open = false
end

function vetahballas()
     if open then 
         open = false
         RageUI.Visible(vestballas, false)
         return
     else
         open = true 
         RageUI.Visible(vestballas, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(vestballas,function() 


              RageUI.Button("~h~Reprendre sa Tenue", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                  tenuecivilbalas()
                end
               }) 

                RageUI.Separator("↓ ~p~Tenues Ballas ~s~↓")

                RageUI.Button("Tenue ~p~Ballas", nil, {RightLabel = "→"}, true , {
                  onSelected = function()
                    vballas()
                  end
                 })


            end)
          Wait(0)
         end
      end)
   end
end



local position = {
	{x = 118.68, y = -1963.31, z = 18.42}  
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
            DrawMarker(22, 118.68, -1963.31, 18.42, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 175, 3, 255, 255, true, true, p19, true)  

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~p~E~w~] pour accéder au ~p~Véstiraire", 1) 
                if IsControlJustPressed(1,51) then
                  vetahballas()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)



function vballas()
  local model = GetEntityModel(GetPlayerPed(-1))
  TriggerEvent('skinchanger:getSkin', function(skin)
      if model == GetHashKey("mp_m_freemode_01") then

          clothesSkin = {
              ['bags_1'] = 0, ['bags_2'] = 0,
              ['tshirt_1'] = 15, ['tshirt_2'] = 2,
              ['torso_1'] = 1, ['torso_2'] = 6,
              ['arms'] = 0,
              ['pants_1'] = 64, ['pants_2'] = 7,
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
            ['torso_1'] = 1, ['torso_2'] = 6,
            ['arms'] = 0,
            ['pants_1'] = 64, ['pants_2'] = 7,
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
function tenuecivilbalas()
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
      TriggerEvent('skinchanger:loadSkin', skin)
  end)
end

-- 0.6 == 0.6000000000000001
