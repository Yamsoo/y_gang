TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local coffremara = RageUI.CreateMenu("~b~Stockage", Config.pastouche)
local PutMenu_mara = RageUI.CreateSubMenu(coffremara,"~b~Inventaire", Config.pastouche)
local GetMenu_mara = RageUI.CreateSubMenu(coffremara,"~b~Coffre", Config.pastouche)

local open = false

coffremara:DisplayGlare(false)
coffremara.Closed = function()
    open = false
end

all_items = {}

function KeyboardInput_mara(TextEntry, ExampleText, MaxStringLenght)

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

    
function coffremarafct()  
    if open then 
		open = false
		RageUI.Visible(coffremara, false)
		return
	else
		open = true 
		RageUI.Visible(coffremara, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(coffremara, function()
            RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getStockmara()
            end
            },GetMenu_mara)

            RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getInventorymara()
            end
            },PutMenu_mara)

            if Config.maravendeur then 

                RageUI.Separator('~b~↓ Armes ↓')


                for k,v in pairs(Config.armetahmara) do  
                RageUI.Button("~r~"..v.nom, nil, {RightLabel = v.prixmara .. " ~g~$"}, true, {onSelected = function()
                    TriggerServerEvent('yamsoo:achatmara', v.nomarmemara, v.prixmara)
                end
                })
            end
        end
            

        end)

        RageUI.IsVisible(GetMenu_mara, function()
            
            for k,v in pairs(all_items) do

                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput_mara("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("yamsmara:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~r~Vous n'en avez pas assez sur vous")
                    end
                    getStockmara()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu_mara, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, nil, {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput_mara("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    TriggerServerEvent("yamsmara:putStockItems",v.item, count)
                    getInventorymara()
                end});
            end 

       end)


        Wait(0)
    end
 end)
 end
 end



function getInventorymara()
    ESX.TriggerServerCallback('yamsmara:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockmara()
    ESX.TriggerServerCallback('yamsmara:getStockItems', function(inventory)               
                
        all_items = inventory
        
    end)
end

local position = {
	{x = 1436.44, y = -1489.14, z = 66.62}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'marabunta' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'marabunta' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
            DrawMarker(22, 1436.44, -1489.14, 66.62, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 3, 49, 255, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour accéder au ~b~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffremarafct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipmara then
Citizen.CreateThread(function()
        local maramap = AddBlipForCoord(1436.44, -1489.14, 66.62)
    
        SetBlipSprite(maramap, 310)
        SetBlipColour(maramap, 3)
        SetBlipScale(maramap, 0.80)
        SetBlipAsShortRange(maramap, true)
        
        local maramapradius = AddBlipForRadius(1436.44, -1489.14, 66.62, 900.0)

        SetBlipSprite(maramapradius,1)
        SetBlipColour(maramapradius,3)
        SetBlipAlpha(maramapradius,75)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Marabunta")
        EndTextCommandSetBlipName(maramap)

end)
end


