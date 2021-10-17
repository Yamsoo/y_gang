TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local coffrevagos = RageUI.CreateMenu("~y~Stockage", Config.pastouche)
local PutMenu_vagos = RageUI.CreateSubMenu(coffrevagos,"~y~Inventaire", Config.pastouche)
local GetMenu_vagos = RageUI.CreateSubMenu(coffrevagos,"~y~Coffre", Config.pastouche)

local open = false

coffrevagos:DisplayGlare(false)
coffrevagos.Closed = function()
    open = false
end

all_items = {}

function KeyboardInput_vagos(TextEntry, ExampleText, MaxStringLenght)

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

    
function coffrevagosfct()  
    if open then 
		open = false
		RageUI.Visible(coffrevagos, false)
		return
	else
		open = true 
		RageUI.Visible(coffrevagos, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(coffrevagos, function()
            RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getStockvagos()
            end
            },GetMenu_vagos)

            RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {onSelected = function()
                getInventoryvagos()
            end
            },PutMenu_vagos)

            if Config.vagvendeur then 

                RageUI.Separator('~y~↓ Armes ↓')


                for k,v in pairs(Config.armetahvagos) do  
                RageUI.Button("~r~"..v.nom, nil, {RightLabel = v.prixvagos .. " ~g~$"}, true, {onSelected = function()
                    TriggerServerEvent('yamsoo:achatvagos', v.nomarmevagos, v.prixvagos)
                end
                })
            end
            end

        end)

        RageUI.IsVisible(GetMenu_vagos, function()
            
            for k,v in pairs(all_items) do

                RageUI.Button(v.label, nil, {RightLabel = "~y~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput_vagos("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("yamsvagos:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~r~Vous n'en avez pas assez sur vous")
                    end
                    getStockvagos()
                end});
            end
            

        end)

        RageUI.IsVisible(armepose_vagos, function()
            
            OpenPutWeaponMenu() 

        end)

        RageUI.IsVisible(PutMenu_vagos, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, nil, {RightLabel = "~y~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput_vagos("Combien voulez vous en déposer",nil,4)
                    count = tonumber(count)
                    TriggerServerEvent("yamsvagos:putStockItems",v.item, count)
                    getInventoryvagos()
                end});
            end 

       end)


        Wait(0)
    end
 end)
 end
 end



function getInventoryvagos()
    ESX.TriggerServerCallback('yamsvagos:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockvagos()
    ESX.TriggerServerCallback('yamsvagos:getStockItems', function(inventory)               
                
        all_items = inventory
        
    end)
end

local position = {
	{x = 333.24, y = -2012.41, z = 22.4}  
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
            DrawMarker(22, 333.24, -2012.41, 22.4, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 3, 255, true, true, p19, true)  

        
            if dist <= 2.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~y~E~w~] pour accéder au ~y~Coffre", 1) 
                if IsControlJustPressed(1,51) then
                  coffrevagosfct() 
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


if Config.blipvagos then
Citizen.CreateThread(function()
        local vagosmap = AddBlipForCoord(333.24, -2012.41, 22.4)
    
        SetBlipSprite(vagosmap, 310)
        SetBlipColour(vagosmap, 46)
        SetBlipScale(vagosmap, 0.80)
        SetBlipAsShortRange(vagosmap, true)
        
        local vagosmapradius = AddBlipForRadius(333.24, -2012.41, 22.4, 900.0)

        SetBlipSprite(vagosmapradius,1)
        SetBlipColour(vagosmapradius,46)
        SetBlipAlpha(vagosmapradius,75)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Vagos")
        EndTextCommandSetBlipName(vagosmap)

end)
end

