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
local accueilvagoss = RageUI.CreateMenu('~y~Vagos', Config.pastouche) 
local sousacceil = RageUI.CreateSubMenu(accueilvagoss, '~y~Accueil', Config.pastouche)
accueilvagoss.Display.Header = true 
accueilvagoss.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function accvagos() 
    if open then 
		open = false
		RageUI.Visible(accueilvagoss, false)
		return
	else
		open = true 
		RageUI.Visible(accueilvagoss, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(accueilvagoss, function()

        RageUI.Button("Appellé un Vagos", nil, {RightLabel = "→"}, not codesCooldown52 , {
            onSelected = function()
            codesCooldown52 = true 
        TriggerServerEvent('accueil:vagos')
        ESX.ShowNotification('~g~Votre message a bien été envoyé aux membre des Vagos.')
        Citizen.SetTimeout(120000, function() codesCooldown52 = false end)
       end 
    })

    RageUI.Button("Informations Recrutement", nil, {RightLabel = "→"}, true , {
        onSelected = function()
          end
    }, sousacceil)  



    end)

    RageUI.IsVisible(sousacceil, function()

        RageUI.Separator('~y~Informations Recrutement Vagos')
        RageUI.Separator('↓')
        RageUI.Separator('~y~Recrutement ~g~ON')
        RageUI.Separator('~y~Plus d\'info sur notre Site')
        

    end)
   
         
			
		Wait(0)
	   end
	end)
 end
end


local posacvagos = {
	{x = 306.95, y = -2007.11, z = 20.50}  
}

Citizen.CreateThread(function()
    while true do

      local wait = 500

        for k in pairs(posacvagos) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posacvagos[k].x, posacvagos[k].y, posacvagos[k].z) 

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur [~y~E~w~] pour parler à un ~y~Vagos", 1) 
                if IsControlJustPressed(1,51) then
                    accvagos()
            end
    end
    Citizen.Wait(wait)
    end
end
end)

-- Peds   
  
local npcvagos = {
	{hash="g_m_y_mexgoon_01", x = 306.95, y = -2007.11, z = 20.50, a = 50.86},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npcvagos) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		pedvagos = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
		SetBlockingOfNonTemporaryEvents(pedvagos, true)
		FreezeEntityPosition(pedvagos, true)
		SetEntityInvincible(pedvagos, true)
	end
 end)  