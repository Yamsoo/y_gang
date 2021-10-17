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
local accueilf4lll = RageUI.CreateMenu('~g~Families', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilf4lll, '~g~Accueil', Config.pastouche)
accueilf4lll.Display.Header = true 
accueilf4lll.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accf4l() 
    if open then 
		open = false
		RageUI.Visible(accueilf4lll, false)
		return
	else
		open = true 
		RageUI.Visible(accueilf4lll, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilf4lll, function()

        RageUI.Button("Appellé un Families", nil, {RightLabel = "→→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:families')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des Families.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~g~Informations Recrutement Families')
        RageUI.Separator('↓')
        RageUI.Separator('~g~Recrutement ~g~ON')
        RageUI.Separator('~g~Plus d\'info sur notre Site')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacfamilies = {
	{x = -133.27, y = -1563.91, z = 34.20}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacfamilies) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacfamilies[k].x, posacfamilies[k].y, posacfamilies[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~g~E~w~] pour parler à un ~g~Families", 1) 
                if IsControlJustPressed(1,51) then
                    accf4l()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcnpcfamilies = {
	{hash="g_m_y_famca_01", x = -133.27, y = -1563.91, z = 34.18, a = 54.84},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcnpcfamilies) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pednpcfamilies = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pednpcfamilies, true)
		FreezeEntityPosition(pednpcfamilies, true)
		SetEntityInvincible(pednpcfamilies, true)
	end
 end)  