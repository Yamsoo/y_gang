TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local coffref4l = RageUI.CreateMenu("~g~Stockage", Config.pastouche)
local PutMenu_f4l = RageUI.CreateSubMenu(coffref4l,"~g~Inventaire", Config.pastouche)
local GetMenu_f4l = RageUI.CreateSubMenu(coffref4l,"~g~Coffre", Config.pastouche)

local open = false

coffref4l:DisplayGlare(false)
coffref4l.Closed = function()
    open = false
end

all_items = {}

function KeyboardInput_f4l(TextEntry, ExampleText, MaxStringLenght)

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

    
function coffref4lfct()  
    if open then 
		open = false
		RageUI.Visible(coffref4l, false)
		return
	else
		open = true 
		RageUI.Visible(coffref4l, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(coffref4l, function()
            RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getStockf4l()
            end
            },GetMenu_f4l)

            RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getInventoryf4l()
            end
            },PutMenu_f4l)


            if Config.familiesvendeur then 

                RageUI.Separator('~g~↓ Armes ↓')


                for k,v in pairs(Config.armetahfamilies) do  
                RageUI.Button("~r~"..v.nom, nil, {RightLabel = v.prixfamilies .. " ~g~$"}, true, {onSelected = function()
                    TriggerServerEvent('yamsoo:achatfamiilies', v.nomarmefamilies, v.prixfamilies)
                end
                })
            end
            end
            

        end)

        RageUI.IsVisible(GetMenu_f4l, function()
            
            for k,v in pairs(all_items) do

                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput_f4l("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("yamsf4l:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~r~Vous n'en avez pas assez sur vous")
                    end
                    getStockf4l()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu_f4l, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput_f4l("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    TriggerServerEvent("yamsf4l:putStockItems",v.item, count)
                    getInventoryf4l()
                end});
            end 

       end)


        Wait(0)
    end
 end)
 end
 end



function getInventoryf4l()
    ESX.TriggerServerCallback('yamsf4l:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockf4l()
    ESX.TriggerServerCallback('yamsf4l:getStockItems', function(inventory)               
                
        all_items = inventory
        
    end)
end

local position = {
	{x = -136.24, y = -1610.82, z = 35.03}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'families' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'families' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, -136.24, -1610.82, 35.03, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 3, 255, 53, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~g~E~w~] pour accéder au ~g~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffref4lfct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipfamilies then
Citizen.CreateThread(function()
        local f4lmap = AddBlipForCoord(-136.24, -1610.82, 35.03)
    
        SetBlipSprite(f4lmap, 310)
        SetBlipColour(f4lmap, 2)
        SetBlipScale(f4lmap, 0.80)
        SetBlipAsShortRange(f4lmap, true)
        
        local f4lmapradius = AddBlipForRadius(-136.24, -1610.82, 35.03, 900.0)

        SetBlipSprite(f4lmapradius,1)
        SetBlipColour(f4lmapradius,2)
        SetBlipAlpha(f4lmapradius,75)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Families")
        EndTextCommandSetBlipName(f4lmap)

end)
end


