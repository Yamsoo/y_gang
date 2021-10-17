TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local coffremeca = RageUI.CreateMenu("~p~Stockage", Config.pastouche)
local PutMenu = RageUI.CreateSubMenu(coffremeca,"~p~Inventaire", Config.pastouche)
local GetMenu = RageUI.CreateSubMenu(coffremeca,"~p~Coffre", Config.pastouche)

local open = false

coffremeca:DisplayGlare(false)
coffremeca.Closed = function()
    open = false
end

all_items = {}

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

    
function coffreballas() 
    if open then 
		open = false
		RageUI.Visible(coffremeca, false)
		return
	else
		open = true 
		RageUI.Visible(coffremeca, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(coffremeca, function()
            RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getStockbls()
            end
            },GetMenu)

            RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getInventorybls()
            end
            },PutMenu)

            if Config.blsvendeur then 

                RageUI.Separator('~p~↓ Armes ↓')


                for k,v in pairs(Config.armetahballas) do  
                RageUI.Button("~r~"..v.nom, nil, {RightLabel = v.prixballas .. " ~g~$"}, true, {onSelected = function()
                    TriggerServerEvent('yamsoo:achatballas', v.nomarmeballas, v.prixballas)
                end
                })
            end
            end
            

        end)

        RageUI.IsVisible(GetMenu, function()
            
            for k,v in pairs(all_items) do

                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("yamsbal:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~r~Vous n'en avez pas assez sur vous")
                    end
                    getStockbls()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    TriggerServerEvent("yamsbal:putStockItems",v.item, count)
                    getInventorybls()
                end});
            end 

       end)


        Wait(0)
    end
 end)
 end
 end



function getInventorybls()
    ESX.TriggerServerCallback('yamsbal:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockbls()
    ESX.TriggerServerCallback('yamsbal:getStockItems', function(inventory)               
                
        all_items = inventory
        
    end)
end

local position = {
	{x = 106.22, y = -1981.43, z = 20.96}  
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
            DrawMarker(22, 106.22, -1981.43, 20.96, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 175, 3, 255, 255, true, true, p19, true)  

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~p~E~w~] pour accéder au ~p~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffreballas()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipballas then
Citizen.CreateThread(function()
        local ballasmap = AddBlipForCoord(97.04, -1933.24, 20.8)
    
        SetBlipSprite(ballasmap, 310)
        SetBlipColour(ballasmap, 27)
        SetBlipScale(ballasmap, 0.80)
        SetBlipAsShortRange(ballasmap, true)
        
        local ballasmapradius = AddBlipForRadius(97.04, -1933.24, 20.8, 900.0)

        SetBlipSprite(ballasmapradius,1)
        SetBlipColour(ballasmapradius,27)
        SetBlipAlpha(ballasmapradius,75)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Ballas")
        EndTextCommandSetBlipName(ballasmap)

end)
end


