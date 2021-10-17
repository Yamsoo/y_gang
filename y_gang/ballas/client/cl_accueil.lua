Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
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


--- MENU ---

local open = false 
local accueilballas = RageUI.CreateMenu('~p~Ballas', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilballas, '~p~Accueil', Config.pastouche)
accueilballas.Display.Header = true 
accueilballas.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accballas() 
    if open then 
		open = false
		RageUI.Visible(accueilballas, false)
		return
	else
		open = true 
		RageUI.Visible(accueilballas, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilballas, function()

        RageUI.Button("Appellé un Ballas", nil, {RightLabel = "→→"}, not codesCooldown5 , {
            onSelected = function()
            codesCooldown5 = true 
        TriggerServerEvent('accueil:ballas')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des Ballas.')
        Citizen.SetTimeout(120000, function() codesCooldown5 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~p~Informations Recrutement Ballas')
        RageUI.Separator('↓')
        RageUI.Separator('~p~Recrutement ~g~ON')
        RageUI.Separator('~p~Plus d\'info sur notre Site')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacballas = {
	{x = 77.89, y = -1926.94, z = 20.88}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacballas) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ballas' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'ballas' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacballas[k].x, posacballas[k].y, posacballas[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~p~E~w~] pour parler à un ~p~Ballas", 1) 
                if IsControlJustPressed(1,51) then
                    accballas()
            end
        end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcballas = {
	{hash="csb_ballasog", x = 77.89, y = -1926.94, z = 20.80, a = 326.12},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcballas) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedballas = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedballas, true)
		FreezeEntityPosition(pedballas, true)
		SetEntityInvincible(pedballas, true)
	end
 end)  