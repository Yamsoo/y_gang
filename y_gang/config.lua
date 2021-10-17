Config               = {}

  Config.spawnvoiture = {
    {nom = "Primo", modele = "primo"},
    {nom = "Manchez", modele = "manchez"},
    {nom = "Van", modele = "moonbeam2"},
  }



-- Esque les Gang peuvent vendre ou non les armes !
-- Config a faire directement dans leur dossier
-- et non ici.

Config.pastouche = " " -- Ne pas touché

-----------------------------------------------------------------
-------------------- Vagos ---------------------------------------
------------------------------------------------------------------
      
Config.blipvagos = true

Config.vagvendeur = true

Config.armetahvagos = {
  {nom = "Pistolet", prixvagos = 100, nomarmevagos = "weapon_pistol"},
  {nom = "Couteau", prixvagos = 50, nomarmevagos = "weapon_knife"},
}

--------------------------------------------------------------------------
------------------- Ballas ---------------------------------------------
--------------------------------------------------------------------------- 

Config.blipballas = true
      
Config.blsvendeur = true 

Config.armetahballas = {
  {nom = "Pistolet", prixballas = 100, nomarmeballas = "weapon_pistol"},
  {nom = "Couteau", prixballas = 50, nomarmeballas = "weapon_knife"},
}

-----------------------------------------------------------------
-------------------- Marabunta ----------------------------------
---------------------------------------------------------------

Config.blipmara = true

Config.maravendeur = true 

Config.armetahmara = {
  {nom = "Pistolet", prixmara = 16000, nomarmemara = "weapon_pistol"},
  {nom = "Couteau", prixmara = 50, nomarmemara = "weapon_knife"},
}

------------------------------------------------------------------
-------------------- families ------------------------------------
------------------------------------------------------------------

Config.blipfamilies = true

Config.familiesvendeur = true 

Config.armetahfamilies = {
  {nom = "Pistolet", prixfamilies = 100, nomarmefamilies = "weapon_pistol"},
  {nom = "Couteau", prixfamilies = 50, nomarmefamilies = "weapon_knife"},
}
