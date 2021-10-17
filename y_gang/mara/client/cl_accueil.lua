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
local accueilmaraaa = RageUI.CreateMenu('~b~Marabunta', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilmaraaa, '~b~Accueil', Config.pastouche)
accueilmaraaa.Display.Header = true 
accueilmaraaa.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accmara() 
    if open then 
		open = false
		RageUI.Visible(accueilmaraaa, false)
		return
	else
		open = true 
		RageUI.Visible(accueilmaraaa, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilmaraaa, function()

        RageUI.Button("Appellé un Marabunta", nil, {RightLabel = "→→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:marabunta')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des Marabuntas.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~b~Informations Recrutement Marabunta')
        RageUI.Separator('↓')
        RageUI.Separator('~b~Recrutement ~g~ON')
        RageUI.Separator('~b~Plus d\'info sur notre Site')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacmara = {
	{x = 1450.03, y = -1505.58, z = 63.77}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacmara) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacmara[k].x, posacmara[k].y, posacmara[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~b~E~w~] pour parler à un ~b~Mara", 1) 
                if IsControlJustPressed(1,51) then
                    accmara()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcmara = {
	{hash="g_m_y_salvagoon_01", x = 1450.03, y = -1505.58, z = 63.77, a = 180.82},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcmara) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedmara = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedmara, true)
		FreezeEntityPosition(pedmara, true)
		SetEntityInvincible(pedmara, true)
	end
 end)  