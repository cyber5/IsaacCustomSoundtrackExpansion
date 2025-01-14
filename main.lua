local custommusiccollection = RegisterMod("Antibirth OST for Tainted Characters", 1)

local json = require("json")
local modSaveData = {}

--use one of Music Mod Callback or Repentogon, but not both
--TODO: make the error messages red
if MMC == nil and REPENTOGON == nil then
	Isaac.ConsoleOutput("Error: Antibirth OST for Tainted Characters (expanded version) requires either Music Mod Callback or Repentogon.\n")
	return
elseif REPENTOGON and MMC then --TODO: maybe lift this restriction after further testing
	Isaac.ConsoleOutput("Error: Antibirth OST for Tainted Characters (expanded version) is not built to use both Music Mod Callback and Repentogon.\n")
	return
end

local usingRGON = false
if REPENTOGON and not MMC then
	usingRGON = true
	Isaac.ConsoleOutput("Antibirth OST for Tainted Characters (expanded version) loaded with Repentogon.\n")
else
	Isaac.ConsoleOutput("Antibirth OST for Tainted Characters (expanded version) loaded with Music Mod Callback.\n")
end

local musicmgr = nil
if MMC then
	musicmgr = MMC.Manager()
else
	musicmgr = MusicManager()
end

function custommusiccollection:CreateCallback(func, ...)
	if usingRGON then
		local tracks = {...}
		if #tracks == 0 then
			custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY, func)
		else
			for i=1,#tracks do
				local v = tracks[i]
				tracks[i] = tonumber(v)
				custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY, func, tracks[i])
			end
		end
	elseif MMC then
		MMC.AddMusicCallback(custommusiccollection, func, ...)
	end
end

local function MusicCancelValue()
	if usingRGON then
		return false
	else
		return 0
	end
end

--TODO: play devil deal sound in Dark Room in Challenge 45 (only accessible via debug console)
--TODO: play special music in death certificate area in Challenge 45
--TODO: increase volume of Devil Room Alt

--Config settings
function custommusiccollection:ResetSave()
	modSaveData = {
		ultragreediertheme = true,
		darkroomdescensum = true,
		bluewombdevoid = true,
		wombnativitate = true,
		uterogreedviscera = true,
		cathedralsacris = true,
		catacombsgreedregeneratione = true,
		depthsgreeddepressoloco = true,
		sheolgreedinfernum = true,
		shopfloorgreedtheme = true,
		postbossgreedspiritum = true,
		satanfightsatan666 = true,
		devilwavegreedambush = true,
		angelfighttheme = true,
		blackmarketroomtheme = true,
		genesisroomtheme = true,
		iamerrorroomtheme = true,
		lateshoproomtheme = true,
		latedevilroomtheme = true,
		bossrushtaintedspeedup = true,
		megasatantaintedspeedup = true,
		uterotaintedtsunami = true,
		drosstainted = 2,
		ashpittainted = 2,
		gehennatainted = 2,
		mortistainted = 2,
		ascenttainteddescent = true,
		hometaintedintro = true,
		darkhometaintednauseous = true,
		deathcertificatedescenttwisted = true,
		dogmafighttaintedmashup = true,
		beastfighttaintedapocalypse = true,
		mineshaftambienttaintednaught = true,
		mineshaftescapetaintedturn = true,
		blendedcoopsoundtrack = true,
		deletethisenhancement = true,
		
		savedcustomsettings = {},
		settingsmode = 1 --custom
		
		--future potential requests:
		--megasatantainted = 2, -- play Flagbearer during tainted Mega Satan
		--devilwavegreedtainted = 2, --play The Turn during tainted devil wave
		--boss2taintedflagbearer = true, --play Tandava for tainted alt boss
		--gameovertaintedunderscore = true, --play tainted Planetarium theme for tainted game over
	}
end

function custommusiccollection:FillInMissingSaveData()
	if modSaveData["ultragreediertheme"] == nil then modSaveData["ultragreediertheme"] = true end
	if modSaveData["darkroomdescensum"] == nil then modSaveData["darkroomdescensum"] = true end
	if modSaveData["bluewombdevoid"] == nil then modSaveData["bluewombdevoid"] = true end
	if modSaveData["wombnativitate"] == nil then modSaveData["wombnativitate"] = true end
	if modSaveData["uterogreedviscera"] == nil then modSaveData["uterogreedviscera"] = true end
	if modSaveData["cathedralsacris"] == nil then modSaveData["cathedralsacris"] = true end
	if modSaveData["catacombsgreedregeneratione"] == nil then modSaveData["catacombsgreedregeneratione"] = true end
	if modSaveData["depthsgreeddepressoloco"] == nil then modSaveData["depthsgreeddepressoloco"] = true end
	if modSaveData["sheolgreedinfernum"] == nil then modSaveData["sheolgreedinfernum"] = true end
	if modSaveData["shopfloorgreedtheme"] == nil then modSaveData["shopfloorgreedtheme"] = true end
	if modSaveData["postbossgreedspiritum"] == nil then modSaveData["postbossgreedspiritum"] = true end
	if modSaveData["satanfightsatan666"] == nil then modSaveData["satanfightsatan666"] = true end
	if modSaveData["devilwavegreedambush"] == nil then modSaveData["devilwavegreedambush"] = true end
	if modSaveData["angelfighttheme"] == nil then modSaveData["angelfighttheme"] = true end
	if modSaveData["blackmarketroomtheme"] == nil then modSaveData["blackmarketroomtheme"] = true end
	if modSaveData["genesisroomtheme"] == nil then modSaveData["genesisroomtheme"] = true end
	if modSaveData["iamerrorroomtheme"] == nil then modSaveData["iamerrorroomtheme"] = true end
	if modSaveData["lateshoproomtheme"] == nil then modSaveData["lateshoproomtheme"] = true end
	if modSaveData["latedevilroomtheme"] == nil then modSaveData["latedevilroomtheme"] = true end
	if modSaveData["bossrushtaintedspeedup"] == nil then modSaveData["bossrushtaintedspeedup"] = true end
	if modSaveData["megasatantaintedspeedup"] == nil then modSaveData["megasatantaintedspeedup"] = true end
	if modSaveData["uterotaintedtsunami"] == nil then modSaveData["uterotaintedtsunami"] = true end
	if modSaveData["drosstainted"] == nil then modSaveData["drosstainted"] = 2 end
	if modSaveData["ashpittainted"] == nil then modSaveData["ashpittainted"] = 2 end
	if modSaveData["gehennatainted"] == nil then modSaveData["gehennatainted"] = 2 end
	if modSaveData["mortistainted"] == nil then modSaveData["mortistainted"] = 2 end
	if modSaveData["ascenttainteddescent"] == nil then modSaveData["ascenttainteddescent"] = true end
	if modSaveData["hometaintedintro"] == nil then modSaveData["hometaintedintro"] = true end
	if modSaveData["darkhometaintednauseous"] == nil then modSaveData["darkhometaintednauseous"] = true end
	if modSaveData["deathcertificatedescenttwisted"] == nil then modSaveData["deathcertificatedescenttwisted"] = true end
	if modSaveData["dogmafighttaintedmashup"] == nil then modSaveData["dogmafighttaintedmashup"] = true end
	if modSaveData["beastfighttaintedapocalypse"] == nil then modSaveData["beastfighttaintedapocalypse"] = true end
	if modSaveData["mineshaftambienttaintednaught"] == nil then modSaveData["mineshaftambienttaintednaught"] = true end
	if modSaveData["mineshaftescapetaintedturn"] == nil then modSaveData["mineshaftescapetaintedturn"] = true end
	if modSaveData["blendedcoopsoundtrack"] == nil then modSaveData["blendedcoopsoundtrack"] = true end
	if modSaveData["deletethisenhancement"] == nil then modSaveData["deletethisenhancement"] = true end
	
	if modSaveData["savedcustomsettings"] == nil then modSaveData["savedcustomsettings"] = {} end
	if modSaveData["settingsmode"] == nil then modSaveData["settingsmode"] = 1 end
end

function custommusiccollection:SaveCustomOptions()
	for k, v in pairs(modSaveData) do
		if k ~= "savedcustomsettings" and k ~= "settingsmode" then
			modSaveData["savedcustomsettings"][k] = v
		end
	end
end

function custommusiccollection:LoadCustomOptions()
	for k, v in pairs(modSaveData["savedcustomsettings"]) do
		if k ~= "savedcustomsettings" and k ~= "settingsmode" then
			modSaveData[k] = v
		end
	end
	modSaveData["savedcustomsettings"] = {}
end

function custommusiccollection:SetOptionsToPreset(mode)
	--Simple: mode = false
	--Expanded: mode = true
	modSaveData["ultragreediertheme"] = mode
	modSaveData["darkroomdescensum"] = mode
	modSaveData["bluewombdevoid"] = mode
	modSaveData["wombnativitate"] = mode
	modSaveData["uterogreedviscera"] = mode
	modSaveData["cathedralsacris"] = mode
	modSaveData["catacombsgreedregeneratione"] = mode
	modSaveData["depthsgreeddepressoloco"] = mode
	modSaveData["sheolgreedinfernum"] = mode
	modSaveData["shopfloorgreedtheme"] = mode
	modSaveData["postbossgreedspiritum"] = mode
	modSaveData["satanfightsatan666"] = mode
	modSaveData["devilwavegreedambush"] = mode
	modSaveData["angelfighttheme"] = mode
	modSaveData["blackmarketroomtheme"] = mode
	modSaveData["genesisroomtheme"] = mode
	modSaveData["iamerrorroomtheme"] = mode
	modSaveData["lateshoproomtheme"] = mode
	modSaveData["latedevilroomtheme"] = mode
	modSaveData["bossrushtaintedspeedup"] = mode
	modSaveData["megasatantaintedspeedup"] = mode
	modSaveData["uterotaintedtsunami"] = mode
	modSaveData["ascenttainteddescent"] = mode
	modSaveData["hometaintedintro"] = mode
	modSaveData["darkhometaintednauseous"] = mode
	modSaveData["deathcertificatedescenttwisted"] = mode
	modSaveData["dogmafighttaintedmashup"] = mode
	modSaveData["beastfighttaintedapocalypse"] = mode
	modSaveData["mineshaftambienttaintednaught"] = mode
	modSaveData["mineshaftescapetaintedturn"] = mode
	modSaveData["blendedcoopsoundtrack"] = mode
	modSaveData["deletethisenhancement"] = mode
	
	if mode then
		modSaveData["drosstainted"] = 2
		modSaveData["ashpittainted"] = 2
		modSaveData["gehennatainted"] = 2
		modSaveData["mortistainted"] = 2
	else
		modSaveData["drosstainted"] = 0
		modSaveData["ashpittainted"] = 0
		modSaveData["gehennatainted"] = 0
		modSaveData["mortistainted"] = 0
	end
end

function custommusiccollection:SaveToFile()
	custommusiccollection:SaveData(json.encode(modSaveData))
end
custommusiccollection:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, custommusiccollection.SaveToFile)

function custommusiccollection:LoadFromFile()
	local success = pcall(function()
		if custommusiccollection:HasData() then
			local dat = custommusiccollection:LoadData()
			modSaveData = json.decode(dat)
			custommusiccollection:FillInMissingSaveData()
		else
			custommusiccollection.ResetSave()
		end
	end)
	if not success then
		custommusiccollection.ResetSave()
	end
end

local SMCM = nil
if ModConfigMenu then
    SMCM = require("scripts.modconfig")
end

-- Mod Config Menu Code
function custommusiccollection:SetUpMenu()
	
	custommusiccollection:LoadFromFile()
	if ModConfigMenu then
		local category = "Tainted Antibirth"
		
		--refresh menu when mode is changed
        local existingmenu = SMCM.GetCategoryIDByName(category)
		if existingmenu ~= nil then
           SMCM.MenuData[existingmenu].Subcategories[1].Options = {}
        end
		
		SMCM.UpdateCategory(category, {
            Info = "Customize the changes to the soundtrack made by the expanded version of Antibirth OST for Tainted Characters"
        })
		SMCM.AddText(category, "Soundtrack Mode")
		SMCM.AddSetting(category, {
			Type = SMCM.OptionType.NUMBER,
			Default = 1,
			CurrentSetting = function()
				return modSaveData["settingsmode"]
			end,
			Minimum = 0,
			Maximum = 2,
			Display = function()
				if modSaveData["settingsmode"] == 2 then
					return "Expanded"
				elseif modSaveData["settingsmode"] == 1 then
					return "Custom"
				else
					return "Simple"
				end
			end,
			OnChange = function(value)
				local previousvalue = modSaveData["settingsmode"]
				modSaveData["settingsmode"] = value
				
				if modSaveData["settingsmode"] == 2 then
					if previousvalue == 1 then
						custommusiccollection:SaveCustomOptions()
					end
					custommusiccollection:SetOptionsToPreset(true)
				elseif modSaveData["settingsmode"] == 1 then
					custommusiccollection:LoadCustomOptions()
				else
					if previousvalue == 1 then
						custommusiccollection:SaveCustomOptions()
					end
					custommusiccollection:SetOptionsToPreset(false)
				end
				
				custommusiccollection:SaveToFile()
				custommusiccollection:SetUpMenu()
			end,
			Info = {
				"Simple turns all toggleable changes off. Expanded turns all toggleable changes on. Select Custom to set each setting individually."
			}
		})
		if modSaveData["settingsmode"] == 1 then
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Dark Room Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["darkroomdescensum"]
				end,
				Display = function()
					if modSaveData["darkroomdescensum"] then
						return "Descensum"
					else
						return "Devoid"
					end
				end,
				OnChange = function(value)
					modSaveData["darkroomdescensum"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Dark Room music for non-Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Blue Womb Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["bluewombdevoid"]
				end,
				Display = function()
					if modSaveData["bluewombdevoid"] then
						return "Devoid"
					else
						return "Nativitate"
					end
				end,
				OnChange = function(value)
					modSaveData["bluewombdevoid"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Blue Womb music for non-Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Womb Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["wombnativitate"]
				end,
				Display = function()
					if modSaveData["wombnativitate"] then
						return "Nativitate"
					else
						return "Viscera"
					end
				end,
				OnChange = function(value)
					modSaveData["wombnativitate"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Womb music for non-Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Utero Theme (Greed)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["uterogreedviscera"]
				end,
				Display = function()
					if modSaveData["uterogreedviscera"] then
						return "Viscera"
					else
						return "Caesarian"
					end
				end,
				OnChange = function(value)
					modSaveData["uterogreedviscera"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Utero music for non-Tainted characters in Greed Mode."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Catacombs Theme (Greed)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["catacombsgreedregeneratione"]
				end,
				Display = function()
					if modSaveData["catacombsgreedregeneratione"] then
						return "Regeneratione"
					else
						return "Capiticus Calvaria"
					end
				end,
				OnChange = function(value)
					modSaveData["catacombsgreedregeneratione"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Catacombs music for non-Tainted characters in Greed Mode."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Depths Theme (Greed)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["depthsgreeddepressoloco"]
				end,
				Display = function()
					if modSaveData["depthsgreeddepressoloco"] then
						return "Depresso Loco"
					else
						return "Abyss"
					end
				end,
				OnChange = function(value)
					modSaveData["depthsgreeddepressoloco"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Depths music for non-Tainted characters in Greed Mode."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Sheol Theme (Greed)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["sheolgreedinfernum"]
				end,
				Display = function()
					if modSaveData["sheolgreedinfernum"] then
						return "Infernum"
					else
						return "Duress"
					end
				end,
				OnChange = function(value)
					modSaveData["sheolgreedinfernum"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Sheol music for non-Tainted characters in Greed Mode."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Post-Boss Theme (Greed)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["postbossgreedspiritum"]
				end,
				Display = function()
					if modSaveData["postbossgreedspiritum"] then
						return "Spiritum"
					else
						return "The Calm"
					end
				end,
				OnChange = function(value)
					modSaveData["postbossgreedspiritum"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the post-boss music for non-Tainted characters in Greed Mode."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Challenge Theme for Devil Wave")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["devilwavegreedambush"]
				end,
				Display = function()
					if modSaveData["devilwavegreedambush"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["devilwavegreedambush"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Play the Challenge fight music for devil waves in Greed Mode."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Shop Floor (Greed) Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["shopfloorgreedtheme"]
				end,
				Display = function()
					if modSaveData["shopfloorgreedtheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["shopfloorgreedtheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets whether the Shop floor in Greed Mode has its own unique stage music."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Utero Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["uterotaintedtsunami"]
				end,
				Display = function()
					if modSaveData["uterotaintedtsunami"] then
						return "Tsunami"
					else
						return "Dystension"
					end
				end,
				OnChange = function(value)
					modSaveData["uterotaintedtsunami"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Utero music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Dross Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.NUMBER,
				Default = 2,
				CurrentSetting = function()
					return modSaveData["drosstainted"]
				end,
				Minimum = 0,
				Maximum = 2,
				Display = function()
					if modSaveData["drosstainted"] == 2 then
						return "Torrent"
					elseif modSaveData["drosstainted"] == 1 then
						return "Hallowed Ground"
					else
						return "Night Soil"
					end
				end,
				OnChange = function(value)
					modSaveData["drosstainted"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Dross music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Ashpit Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.NUMBER,
				Default = 2,
				CurrentSetting = function()
					return modSaveData["ashpittainted"]
				end,
				Minimum = 0,
				Maximum = 2,
				Display = function()
					if modSaveData["ashpittainted"] == 2 then
						return "Chum"
					elseif modSaveData["ashpittainted"] == 1 then
						return "Fault Lines"
					else
						return "Absentia"
					end
				end,
				OnChange = function(value)
					modSaveData["ashpittainted"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Ashpit music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Gehenna Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.NUMBER,
				Default = 2,
				CurrentSetting = function()
					return modSaveData["gehennatainted"]
				end,
				Minimum = 0,
				Maximum = 2,
				Display = function()
					if modSaveData["gehennatainted"] == 2 then
						return "Red Tide"
					elseif modSaveData["gehennatainted"] == 1 then
						return "Machine in the Walls"
					else
						return "Morning Star"
					end
				end,
				OnChange = function(value)
					modSaveData["gehennatainted"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Gehenna music for Tainted characters."
				}
			})
			if LastJudgement then
				SMCM.AddSpace(category)
				SMCM.AddText(category, "Mortis Theme (Tainted)")
				SMCM.AddSetting(category, {
					Type = SMCM.OptionType.NUMBER,
					Default = 2,
					CurrentSetting = function()
						return modSaveData["mortistainted"]
					end,
					Minimum = 0,
					Maximum = 2,
					Display = function()
						if modSaveData["mortistainted"] == 2 then
							return "Malpractice"
						elseif modSaveData["mortistainted"] == 1 then
							return "Drowning"
						else
							return "Formaldehyde"
						end
					end,
					OnChange = function(value)
						modSaveData["mortistainted"] = value
						custommusiccollection:SaveToFile()
					end,
					Info = {
						"Sets the Mortis music for Tainted characters."
					}
				})
			end
			SMCM.AddSpace(category)
			SMCM.AddText(category, "The Ascent Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["ascenttainteddescent"]
				end,
				Display = function()
					if modSaveData["ascenttainteddescent"] then
						return "Descent"
					else
						return "Genesis Reversed"
					end
				end,
				OnChange = function(value)
					modSaveData["ascenttainteddescent"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Ascent music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Home Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["hometaintedintro"]
				end,
				Display = function()
					if modSaveData["hometaintedintro"] then
						return "Intro (Cinematic)"
					else
						return "Echoes of Mom"
					end
				end,
				OnChange = function(value)
					modSaveData["hometaintedintro"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Home music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Dark Home Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["darkhometaintednauseous"]
				end,
				Display = function()
					if modSaveData["darkhometaintednauseous"] then
						return "I'm Nauseous Too"
					else
						return "Echoes Twisted"
					end
				end,
				OnChange = function(value)
					modSaveData["darkhometaintednauseous"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Dark Home music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Death Certificate Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["deathcertificatedescenttwisted"]
				end,
				Display = function()
					if modSaveData["deathcertificatedescenttwisted"] then
						return "Descent Twisted"
					else
						return "Echoes Reverse"
					end
				end,
				OnChange = function(value)
					modSaveData["deathcertificatedescenttwisted"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Death Certificate music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Cathedral Heavy Layer")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["cathedralsacris"]
				end,
				Display = function()
					if modSaveData["cathedralsacris"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["cathedralsacris"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"For non-Tainted characters, in the Cathedral, play a heavy music layer in rooms containing bosses."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Black Market Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["blackmarketroomtheme"]
				end,
				Display = function()
					if modSaveData["blackmarketroomtheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["blackmarketroomtheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Play unique music in Black Market rooms."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Genesis Room Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["genesisroomtheme"]
				end,
				Display = function()
					if modSaveData["genesisroomtheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["genesisroomtheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Play unique music in Genesis rooms."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "I AM ERROR Room Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["iamerrorroomtheme"]
				end,
				Display = function()
					if modSaveData["iamerrorroomtheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["iamerrorroomtheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Play unique music in I AM ERROR rooms."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Late Shop Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["lateshoproomtheme"]
				end,
				Display = function()
					if modSaveData["lateshoproomtheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["lateshoproomtheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"For non-Tainted characters, play the unused layer of Murmur of the Harvestman in Shops past Chapter 3."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Late Devil Room Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["latedevilroomtheme"]
				end,
				Display = function()
					if modSaveData["latedevilroomtheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["latedevilroomtheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"For non-Tainted characters, play the unused layer of Anima Vendit in Devil Rooms past Chapter 4."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Mineshaft Ambient Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["mineshaftambienttaintednaught"]
				end,
				Display = function()
					if modSaveData["mineshaftambienttaintednaught"] then
						return "Want For Naught (Part 1)"
					else
						return "Vast Empty Chasm"
					end
				end,
				OnChange = function(value)
					modSaveData["mineshaftambienttaintednaught"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Mineshaft Ambient music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Mineshaft Escape Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["mineshaftescapetaintedturn"]
				end,
				Display = function()
					if modSaveData["mineshaftescapetaintedturn"] then
						return "The Turn"
					else
						return "Want For Naught (Part 2)"
					end
				end,
				OnChange = function(value)
					modSaveData["mineshaftescapetaintedturn"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Mineshaft Escape music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Satan Fight Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["satanfightsatan666"]
				end,
				Display = function()
					if modSaveData["satanfightsatan666"] then
						return "Satan 666"
					else
						return "Hericide"
					end
				end,
				OnChange = function(value)
					modSaveData["satanfightsatan666"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Satan fight music for non-Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Ultra Greedier Theme")
			SMCM.AddSetting(category, { 
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["ultragreediertheme"]
				end,
				Display = function()
					if modSaveData["ultragreediertheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["ultragreediertheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets whether unique boss music will play during the Ultra Greedier battle."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Angel Fight Theme")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["angelfighttheme"]
				end,
				Display = function()
					if modSaveData["angelfighttheme"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["angelfighttheme"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets whether unique boss music will play during Angel battles."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Boss Rush Tainted Speedup")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["bossrushtaintedspeedup"]
				end,
				Display = function()
					if modSaveData["bossrushtaintedspeedup"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["bossrushtaintedspeedup"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"For Tainted characters, play A Baleful Circus 10% faster during Boss Rush."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Mega Satan Tainted Speedup")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["megasatantaintedspeedup"]
				end,
				Display = function()
					if modSaveData["megasatantaintedspeedup"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["megasatantaintedspeedup"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"For Tainted characters, play Spectrum of Sin 10% faster during the Mega Satan fight."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Dogma Fight Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["dogmafighttaintedmashup"]
				end,
				Display = function()
					if modSaveData["dogmafighttaintedmashup"] then
						return "Your Worst Nightmare"
					else
						return "Living In The Light"
					end
				end,
				OnChange = function(value)
					modSaveData["dogmafighttaintedmashup"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Dogma fight music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "The Beast Fight Theme (Tainted)")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["beastfighttaintedapocalypse"]
				end,
				Display = function()
					if modSaveData["beastfighttaintedapocalypse"] then
						return "My Innermost Apocalypse [Metal cover]"
					else
						return "Revelations 13-1"
					end
				end,
				OnChange = function(value)
					modSaveData["beastfighttaintedapocalypse"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Sets the Beast fight music for Tainted characters."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "Blended Co-op Soundtrack")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["blendedcoopsoundtrack"]
				end,
				Display = function()
					if modSaveData["blendedcoopsoundtrack"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["blendedcoopsoundtrack"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"Blend the two soundtracks when at least one non-Tainted character and at least one Tainted character are present during co-op."
				}
			})
			SMCM.AddSpace(category)
			SMCM.AddText(category, "DELETE THIS Enhancement")
			SMCM.AddSetting(category, {
				Type = SMCM.OptionType.BOOLEAN,
				Default = true,
				CurrentSetting = function()
					return modSaveData["deletethisenhancement"]
				end,
				Display = function()
					if modSaveData["deletethisenhancement"] then
						return "On"
					else
						return "Off"
					end
				end,
				OnChange = function(value)
					modSaveData["deletethisenhancement"] = value
					custommusiccollection:SaveToFile()
				end,
				Info = {
					"During the DELETE THIS challenge, use music from both soundtracks, and play random music for bosses, special rooms, and jingles."
				}
			})
		end
	end
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, custommusiccollection.SetUpMenu)

local function GetEffectiveLevelStage()
	if StageAPI and StageAPI.Loaded and StageAPI.CurrentStage and StageAPI.InNewStage() then
		local currentstage = StageAPI.GetCurrentStage()
		return currentstage.LevelgenStage.Stage
	else
		return Game():GetLevel():GetStage()
	end
end

local function GetEffectiveStageType()
	if StageAPI and StageAPI.Loaded and StageAPI.CurrentStage and StageAPI.InNewStage() then
		local currentstage = StageAPI.GetCurrentStage()
		return currentstage.LevelgenStage.StageType
	else
		return Game():GetLevel():GetStageType()
	end
end

if not BossMusicForSacrificeRoomAngelsFlag then

	local function angelBossMusic()
		local game = Game()
		local stage_type = GetEffectiveStageType()
		local room = game:GetRoom()
		if stage_type == StageType.STAGETYPE_REPENTANCE or stage_type == StageType.STAGETYPE_REPENTANCE_B then
			return Music.MUSIC_BOSS3
		else
			local roomdesc = Game():GetLevel():GetCurrentRoomDesc()
			local roomdescflags = roomdesc.Flags
			if (roomdescflags & RoomDescriptor.FLAG_ALT_BOSS_MUSIC) == 0 then
				return Music.MUSIC_BOSS
			else
				return Music.MUSIC_BOSS2
			end
		end
	end
	
	--TODO: do not play Angel fight music during the ascent
	--TODO: check The Emperor? card during Ascent
	--TODO: play Mom Boss music in Boss Over Twisted (fix this after restoring the MMC to mimic vanilla)
	
	local function angelBossDeathJingle()
		local game = Game()
		local stage_type = GetEffectiveStageType()
		local room = game:GetRoom()
		if stage_type == StageType.STAGETYPE_REPENTANCE or stage_type == StageType.STAGETYPE_REPENTANCE_B then
			return Music.MUSIC_JINGLE_BOSS_OVER3
		else
			local roomdesc = Game():GetLevel():GetCurrentRoomDesc()
			local roomdescflags = roomdesc.Flags
			if (roomdescflags & RoomDescriptor.FLAG_ALT_BOSS_MUSIC) == 0 then
				return Music.MUSIC_JINGLE_BOSS_OVER
			else
				return Music.MUSIC_JINGLE_BOSS_OVER2
			end
		end
	end
	
	angelfightsacrificeroom = false
	function custommusiccollection:ResetAngelFightSacrificeRoom()
		angelfightsacrificeroom = false
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.ResetAngelFightSacrificeRoom)

	function custommusiccollection:StartAngelFight()
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		
		if roomtype == RoomType.ROOM_SACRIFICE then
			angelfightsacrificeroom = true
			musicmgr:Crossfade(angelBossMusic())
		end
	end
	
	function custommusiccollection:EndAngelFight()
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		
		if roomtype == RoomType.ROOM_SACRIFICE and Isaac.CountBosses() <= 1 then
			musicmgr:Crossfade(angelBossDeathJingle())
			musicmgr:Queue(Music.MUSIC_BOSS_OVER)
		end
	end

	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NPC_INIT, custommusiccollection.StartAngelFight, EntityType.ENTITY_URIEL)
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NPC_INIT, custommusiccollection.StartAngelFight, EntityType.ENTITY_GABRIEL)

	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, custommusiccollection.EndAngelFight, EntityType.ENTITY_URIEL)
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, custommusiccollection.EndAngelFight, EntityType.ENTITY_GABRIEL)
	
	if StageAPI and StageAPI.Loaded then
		function custommusiccollection:PerformSacrificeRoomBossOverForStageAPI(musicID, roomType, musicRNG)
			local room = Game():GetRoom()
			local roomtype = room:GetType() --TODO: don't we already have the roomtype?
			
			if roomtype == RoomType.ROOM_SACRIFICE and angelfightsacrificeroom then
				--NOTE: angel over jingle is set so that stage api can't override it
				if Isaac.CountBosses() > 0 then
					if modSaveData["angelfighttheme"] then
						return NormalOrTainted(Music.MUSIC_ANGEL_BOSS)
					else
						return NormalOrTainted(angelBossMusic())
					end
				else
					return NormalOrTainted(Music.MUSIC_BOSS_OVER) --TODO: should probably change this to look at the custom stage's assigned boss over music
				end
			end
		end
		
		local tpriority = 0
		StageAPI.AddCallback(custommusiccollection.Name, StageAPI.Enum.Callbacks.POST_SELECT_STAGE_MUSIC, tpriority, custommusiccollection.PerformSacrificeRoomBossOverForStageAPI)
	end
	
end

local hushalivebossroom = false
if not DontInterruptBlueWombFlag then
	
	function custommusiccollection:CheckHushAliveBossRoom()
		hushalivebossroom = false
		if GetEffectiveLevelStage() == LevelStage.STAGE4_3 then
			local room = Game():GetRoom()
			local roomtype = room:GetType()
			if roomtype == RoomType.ROOM_BOSS and room:GetBossID() == 63 then
				if Isaac.CountBosses() > 0 then
					hushalivebossroom = true
				end
			end
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.CheckHushAliveBossRoom)
	
	DontInterruptBlueWombFlag = true
	function custommusiccollection:PerformDontInterruptBlueWomb(trackId)
		if GetEffectiveLevelStage() == LevelStage.STAGE4_3 then
			if not hushalivebossroom then
				musicmgr:Crossfade(Music.MUSIC_BLUE_WOMB)
				return MusicCancelValue()
			end
		end
	end
	custommusiccollection:CreateCallback(custommusiccollection.PerformDontInterruptBlueWomb, Music.MUSIC_BOSS_OVER)
	
end

local function InChapter6StartRoom()
	local room = Game():GetRoom()
	local door = room:GetDoor(DoorSlot.UP0)
	if door and door.TargetRoomIndex == GridRooms.ROOM_MEGA_SATAN_IDX then
		return true
	end
	return false
end

local sound = SFXManager()
local darkroomstartroom = false
if not DarkRoomDevilDealSoundEffect then

	function custommusiccollection:CheckDarkRoomStartRoom()
		darkroomstartroom = false
		local stagetype = GetEffectiveStageType()
		if stagetype == StageType.STAGETYPE_ORIGINAL then
			if InChapter6StartRoom() then
				darkroomstartroom = true
			end
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.CheckDarkRoomStartRoom)
	
	if usingRGON then
		function custommusiccollection:ReplaceChoirSoundRGON(id, volume, frameDelay, loop, pitch, pan)
			if darkroomstartroom then
				--TODO: see what the volume and other values are here, then adjust the values for the MMC version is necessary
				return {SoundEffect.SOUND_DEVILROOM_DEAL, volume, frameDelay, loop, pitch, pan}
			end
		end
		custommusiccollection:AddCallback(ModCallbacks.MC_PRE_SFX_PLAY, custommusiccollection.ReplaceChoirSoundRGON, SoundEffect.SOUND_CHOIR_UNLOCK)
	else
		function custommusiccollection:ReplaceChoirSound()
			if darkroomstartroom then
				-- TODO: does the SOUND_DEVILROOM_DEAL sound sometimes play when it shouldn't?
				if sound:IsPlaying(SoundEffect.SOUND_CHOIR_UNLOCK) then
					sound:Stop(SoundEffect.SOUND_CHOIR_UNLOCK)
					sound:Play(SoundEffect.SOUND_DEVILROOM_DEAL,1,0,false,1)
				end
			end
		end
		custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, custommusiccollection.ReplaceChoirSound)
	end
	
end

Music.MUSIC_CATACOMBS_GREED = Isaac.GetMusicIdByName("Catacombs (greed)")
Music.MUSIC_DEPTHS_GREED = Isaac.GetMusicIdByName("Depths (greed)")
Music.MUSIC_UTERO_GREED = Isaac.GetMusicIdByName("Utero (greed)")
Music.MUSIC_SHEOL_GREED = Isaac.GetMusicIdByName("Sheol (greed)")
Music.MUSIC_FLOOR_6_GREED = Isaac.GetMusicIdByName("Greed Floor 6")
Music.MUSIC_BOSS_OVER_GREED = Isaac.GetMusicIdByName("Boss Room (empty, greed)")
Music.MUSIC_ULTRAGREEDIER_BOSS = Isaac.GetMusicIdByName("Ultra Greedier")
Music.MUSIC_ANGEL_BOSS = Isaac.GetMusicIdByName("Pool of Yule")
Music.MUSIC_SATAN_BOSS_ALT = Isaac.GetMusicIdByName("Satan 666")
Music.MUSIC_MEGASATAN_BOSS = Isaac.GetMusicIdByName("Mega Satan")
Music.MUSIC_JINGLE_DELIRIUM_OVER = Isaac.GetMusicIdByName("Satan 666 Outro")
Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER = Isaac.GetMusicIdByName("Ultra Greedier outro")
Music.MUSIC_JINGLE_ANGEL_OVER = Isaac.GetMusicIdByName("Pool of Yule outro")
Music.MUSIC_BLACKMARKET_ROOM = Isaac.GetMusicIdByName("Black Market")
Music.MUSIC_DEVIL_ROOM_ALT = Isaac.GetMusicIdByName("Devil Room (late)")
Music.MUSIC_SHOP_ROOM_ALT = Isaac.GetMusicIdByName("Shop Room (late)")
Music.MUSIC_I_AM_ERROR = Isaac.GetMusicIdByName("I Am Error")
Music.MUSIC_BLUE_WOMB_ALT = Isaac.GetMusicIdByName("Armarium")
Music.MUSIC_CATHEDRAL_ALT = Isaac.GetMusicIdByName("Cathedral Alt")
Music.MUSIC_HAPPY_ANNIVERSARY = Isaac.GetMusicIdByName("Happy Anniversary")

--[[Music.MUSIC_CAVES_GREED = Isaac.GetMusicIdByName("Caves (greed)")
Music.MUSIC_FLOODED_CAVES_GREED = Isaac.GetMusicIdByName("Flooded Caves (greed)")
Music.MUSIC_NECROPOLIS_GREED = Isaac.GetMusicIdByName("Necropolis (greed)")
Music.MUSIC_DANK_DEPTHS_GREED = Isaac.GetMusicIdByName("Dank Depths (greed)")--]]

--for Repentogon, must check this for every callback that doesn't filter by music ID
skiptainted = {
	[Music.MUSIC_CREDITS] = true,
	[Music.MUSIC_TITLE] = true,
	[Music.MUSIC_TITLE_AFTERBIRTH] = true,
	[Music.MUSIC_TITLE_REPENTANCE] = true,
	[Music.MUSIC_JINGLE_GAME_START_ALT] = true,
	[Music.MUSIC_JINGLE_NIGHTMARE_ALT] = true,
	[Music.MUSIC_CREDITS_ALT] = true,
	[Music.MUSIC_CREDITS_ALT_FINAL] = true,
	[Music.MUSIC_JINGLE_GAME_START] = true,
	[Music.MUSIC_JINGLE_NIGHTMARE] = true,
	[Music.MUSIC_INTRO_VOICEOVER] = true,
	[Music.MUSIC_EPILOGUE_VOICEOVER] = true,
	[Music.MUSIC_FINAL_VOICEOVER] = true,
}

treasurejingles = {
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0] = true,
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1] = true,
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2] = true,
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3] = true,
}

taintedtreasurejingles = {
	[0] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 1"),
	[1] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 2"),
	[2] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 3"),
	[3] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 4"),
	[4] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 5"),
	[5] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 6"),
	[6] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 7"),
	[7] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 8"),
	[8] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 9"),
}

taintedtreasurejinglesfx = {
	[0] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 1"),
	[1] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 2"),
	[2] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 3"),
	[3] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 4"),
	[4] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 5"),
	[5] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 6"),
	[6] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 7"),
	[7] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 8"),
	[8] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 9"),
}

normaltotainted = {
	[Music.MUSIC_BASEMENT] = Isaac.GetMusicIdByName("Basement (tainted)"),
	[Music.MUSIC_CAVES] = Isaac.GetMusicIdByName("Caves (tainted)"),
	[Music.MUSIC_DEPTHS] = Isaac.GetMusicIdByName("Depths (tainted)"),
	[Music.MUSIC_CELLAR] = Isaac.GetMusicIdByName("Cellar (tainted)"),
	[Music.MUSIC_CATACOMBS] = Isaac.GetMusicIdByName("Catacombs (tainted)"),
	[Music.MUSIC_NECROPOLIS] = Isaac.GetMusicIdByName("Necropolis (tainted)"),
	[Music.MUSIC_WOMB_UTERO] = Isaac.GetMusicIdByName("Womb (tainted)"),
	[Music.MUSIC_GAME_OVER] = Isaac.GetMusicIdByName("Game Over (tainted)"),
	[Music.MUSIC_BOSS] = Isaac.GetMusicIdByName("Boss (tainted)"),
	[Music.MUSIC_CATHEDRAL] = Isaac.GetMusicIdByName("Cathedral (tainted)"),
	[Music.MUSIC_SHEOL] = Isaac.GetMusicIdByName("Sheol (tainted)"),
	[Music.MUSIC_DARK_ROOM] = Isaac.GetMusicIdByName("Dark Room (tainted)"),
	[Music.MUSIC_CHEST] = Isaac.GetMusicIdByName("Chest (tainted)"),
	[Music.MUSIC_BURNING_BASEMENT] = Isaac.GetMusicIdByName("Burning Basement (tainted)"),
	[Music.MUSIC_FLOODED_CAVES] = Isaac.GetMusicIdByName("Flooded Caves (tainted)"),
	[Music.MUSIC_DANK_DEPTHS] = Isaac.GetMusicIdByName("Dank Depths (tainted)"),
	[Music.MUSIC_SCARRED_WOMB] = Isaac.GetMusicIdByName("Scarred Womb (tainted)"),
	[Music.MUSIC_BLUE_WOMB] = Isaac.GetMusicIdByName("Blue Womb (tainted)"),
	[Music.MUSIC_UTERO] = Isaac.GetMusicIdByName("Utero (tainted)"),
	[Music.MUSIC_MOM_BOSS] = Isaac.GetMusicIdByName("Boss (Depths - Mom, tainted)"),
	[Music.MUSIC_MOMS_HEART_BOSS] = Isaac.GetMusicIdByName("Boss (Womb - Mom's Heart, tainted)"),
	[Music.MUSIC_ISAAC_BOSS] = Isaac.GetMusicIdByName("Boss (Cathedral - Isaac, tainted)"),
	[Music.MUSIC_SATAN_BOSS] = Isaac.GetMusicIdByName("Boss (Sheol - Satan, tainted)"),
	[Music.MUSIC_DARKROOM_BOSS] = Isaac.GetMusicIdByName("Boss (Dark Room, tainted)"),
	[Music.MUSIC_BLUEBABY_BOSS] = Isaac.GetMusicIdByName("Boss (Chest - ???, tainted)"),
	[Music.MUSIC_BOSS2] = Isaac.GetMusicIdByName("Boss (alternate, tainted)"),
	[Music.MUSIC_HUSH_BOSS] = Isaac.GetMusicIdByName("Boss (Blue Womb - Hush, tainted)"),
	[Music.MUSIC_ULTRAGREED_BOSS] = Isaac.GetMusicIdByName("Boss (Ultra Greed, tainted)"),
	[Music.MUSIC_LIBRARY_ROOM] = Isaac.GetMusicIdByName("Library Room (tainted)"),
	[Music.MUSIC_SECRET_ROOM] = Isaac.GetMusicIdByName("Secret Room (tainted)"),
	[Music.MUSIC_SECRET_ROOM2] = Isaac.GetMusicIdByName("Secret Room Alt (tainted)"),
	[Music.MUSIC_DEVIL_ROOM] = Isaac.GetMusicIdByName("Devil Room (tainted)"),
	[Music.MUSIC_ANGEL_ROOM] = Isaac.GetMusicIdByName("Angel Room (tainted)"),
	[Music.MUSIC_SHOP_ROOM] = Isaac.GetMusicIdByName("Shop Room (tainted)"),
	[Music.MUSIC_ARCADE_ROOM] = Isaac.GetMusicIdByName("Arcade Room (tainted)"),
	[Music.MUSIC_BOSS_OVER] = Isaac.GetMusicIdByName("Boss Room (empty, tainted)"),
	[Music.MUSIC_CHALLENGE_FIGHT] = Isaac.GetMusicIdByName("Challenge Room (fight, tainted)"),
	[Music.MUSIC_BOSS_RUSH] = Isaac.GetMusicIdByName("Boss Rush (tainted)"),
	[Music.MUSIC_JINGLE_BOSS_RUSH_OUTRO] = Isaac.GetMusicIdByName("Boss Rush Outro (jingle, tainted)"),
	[Music.MUSIC_BOSS3] = Isaac.GetMusicIdByName("Boss (alternate alternate, tainted)"),
	[Music.MUSIC_JINGLE_BOSS_OVER3] = Isaac.GetMusicIdByName("Boss Death Alternate Alternate (jingle, tainted)"),
	[Music.MUSIC_MOTHER_BOSS] = Isaac.GetMusicIdByName("Boss (Mother, tainted)"),
	[Music.MUSIC_DOGMA_BOSS] = Isaac.GetMusicIdByName("Boss (Dogma, tainted)"),
	[Music.MUSIC_BEAST_BOSS] = Isaac.GetMusicIdByName("Boss (Beast, tainted)"),
	[Music.MUSIC_JINGLE_MOTHER_OVER] = Isaac.GetMusicIdByName("Boss Mother Death (jingle, tainted)"),
	--[Music.MUSIC_JINGLE_DOGMA_OVER] = Isaac.GetMusicIdByName("Boss Dogma Death (jingle, tainted)"),
	--[Music.MUSIC_JINGLE_BEAST_OVER] = Isaac.GetMusicIdByName("Boss Beast Death (jingle, tainted)"),
	[Music.MUSIC_PLANETARIUM] = Isaac.GetMusicIdByName("Planetarium (tainted)"),
	[Music.MUSIC_SECRET_ROOM_ALT_ALT] = Isaac.GetMusicIdByName("Secret Room Alt Alt (tainted)"),
	[Music.MUSIC_BOSS_OVER_TWISTED] = Isaac.GetMusicIdByName("Boss Room (empty, twisted, tainted)"),
	--[Music.MUSIC_MOTHERS_SHADOW_INTRO] = Isaac.GetMusicIdByName("Mom's Shadow Intro (tainted)"),
	--[Music.MUSIC_DOGMA_INTRO] = Isaac.GetMusicIdByName("Dogma Intro (tainted)"),
	[Music.MUSIC_STRANGE_DOOR_JINGLE] = Isaac.GetMusicIdByName("Strange Door (jingle, tainted)"),
	[Music.MUSIC_DARK_CLOSET] = Isaac.GetMusicIdByName("Echoes Reverse (tainted)"),
	--[Music.MUSIC_JINGLE_BOSS] = Isaac.GetMusicIdByName("Boss (jingle, tainted)"),
	[Music.MUSIC_JINGLE_BOSS_OVER] = Isaac.GetMusicIdByName("Boss Death (jingle, tainted)"),
	--[Music.MUSIC_JINGLE_HOLYROOM_FIND] = Isaac.GetMusicIdByName("Holy Room Find (jingle, tainted)"),
	[Music.MUSIC_JINGLE_SECRETROOM_FIND] = Isaac.GetMusicIdByName("Secret Room Find (jingle, tainted)"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 1"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 2"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 3"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 4"),
	--[Music.MUSIC_JINGLE_CHALLENGE_ENTRY] = Isaac.GetMusicIdByName("Challenge Room Entry (jingle, tainted)"),
	[Music.MUSIC_JINGLE_CHALLENGE_OUTRO] = Isaac.GetMusicIdByName("Challenge Room Outro (jingle, tainted)"),
	[Music.MUSIC_JINGLE_GAME_OVER] = Isaac.GetMusicIdByName("Game Over (jingle, tainted)"),
	--[Music.MUSIC_JINGLE_DEVILROOM_FIND] = Isaac.GetMusicIdByName("Devil Room appear (jingle, tainted)"),
	[Music.MUSIC_JINGLE_BOSS_OVER2] = Isaac.GetMusicIdByName("Boss Death Alternate (jingle, tainted)"),
	[Music.MUSIC_JINGLE_HUSH_OVER] = Isaac.GetMusicIdByName("Boss Hush Death (jingle, tainted)"),
	[Music.MUSIC_VOID] = Isaac.GetMusicIdByName("Void (tainted)"),
	[Music.MUSIC_VOID_BOSS] = Isaac.GetMusicIdByName("Boss (Void, tainted)"),
	[Music.MUSIC_DOWNPOUR] = Isaac.GetMusicIdByName("Downpour (tainted)"),
	[Music.MUSIC_MINES] = Isaac.GetMusicIdByName("Mines (tainted)"),
	[Music.MUSIC_MAUSOLEUM] = Isaac.GetMusicIdByName("Mausoleum (tainted)"),
	[Music.MUSIC_CORPSE] = Isaac.GetMusicIdByName("Corpse (tainted)"),
	[Music.MUSIC_DROSS] = Isaac.GetMusicIdByName("Dross (tainted)"),
	[Music.MUSIC_ASHPIT] = Isaac.GetMusicIdByName("Ashpit (tainted)"),
	[Music.MUSIC_GEHENNA] = Isaac.GetMusicIdByName("Gehenna (tainted)"),
	--[Music.MUSIC_MORTIS] = Isaac.GetMusicIdByName("not done (tainted)"),
	[Music.MUSIC_ISAACS_HOUSE] = Isaac.GetMusicIdByName("Home (tainted)"),
	[Music.MUSIC_DOWNPOUR_REVERSE] = Isaac.GetMusicIdByName("Downpour (reversed, tainted)"),
	[Music.MUSIC_DROSS_REVERSE] = Isaac.GetMusicIdByName("Dross (reversed, tainted)"),
	[Music.MUSIC_MINESHAFT_AMBIENT] = Isaac.GetMusicIdByName("Abandoned Mineshaft (tainted)"),
	[Music.MUSIC_MINESHAFT_ESCAPE] = Isaac.GetMusicIdByName("Mineshaft Escape (tainted)"),
	[Music.MUSIC_REVERSE_GENESIS] = Isaac.GetMusicIdByName("Genesis (reversed, tainted)"),
	[Music.MUSIC_CATACOMBS_GREED] = Isaac.GetMusicIdByName("Catacombs (tainted)"),
	[Music.MUSIC_DEPTHS_GREED] = Isaac.GetMusicIdByName("Depths (tainted)"),
	[Music.MUSIC_UTERO_GREED] = Isaac.GetMusicIdByName("Utero (tainted)"),
	[Music.MUSIC_SHEOL_GREED] = Isaac.GetMusicIdByName("Sheol (tainted)"),
	[Music.MUSIC_FLOOR_6_GREED] = Isaac.GetMusicIdByName("Greed Floor 6 (tainted)"),
	[Music.MUSIC_BOSS_OVER_GREED] = Isaac.GetMusicIdByName("Boss Room (empty, tainted)"),
	[Music.MUSIC_ULTRAGREEDIER_BOSS] = Isaac.GetMusicIdByName("Ultra Greedier (tainted)"),
	[Music.MUSIC_ANGEL_BOSS] = Isaac.GetMusicIdByName("Angel Fight (tainted)"),
	[Music.MUSIC_SATAN_BOSS_ALT] = Isaac.GetMusicIdByName("Boss (Sheol - Satan, tainted)"),
	[Music.MUSIC_MEGASATAN_BOSS] = Isaac.GetMusicIdByName("Mega Satan (tainted)"),
	[Music.MUSIC_JINGLE_DELIRIUM_OVER] = Isaac.GetMusicIdByName("Delirium (tainted) outro"),
	[Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER] = Isaac.GetMusicIdByName("Ultra Greedier (tainted) outro"),
	[Music.MUSIC_JINGLE_ANGEL_OVER] = Isaac.GetMusicIdByName("Angel Fight (tainted) outro"),
	[Music.MUSIC_BLACKMARKET_ROOM] = Isaac.GetMusicIdByName("Black Market (tainted)"),
	[Music.MUSIC_DEVIL_ROOM_ALT] = Isaac.GetMusicIdByName("Devil Room (tainted)"),
	[Music.MUSIC_SHOP_ROOM_ALT] = Isaac.GetMusicIdByName("Shop Room (tainted)"),
	[Music.MUSIC_I_AM_ERROR] = Isaac.GetMusicIdByName("I Am Error (tainted)"),
	[Music.MUSIC_HAPPY_ANNIVERSARY] = Isaac.GetMusicIdByName("Happy Anniversary"),
	--[[[Music.MUSIC_CAVES_GREED] = Isaac.GetMusicIdByName("Caves (tainted)"),
	[Music.MUSIC_FLOODED_CAVES_GREED] = Isaac.GetMusicIdByName("Flooded Caves (tainted)"),
	[Music.MUSIC_NECROPOLIS_GREED] = Isaac.GetMusicIdByName("Necropolis (tainted)"),
	[Music.MUSIC_DANK_DEPTHS_GREED] = Isaac.GetMusicIdByName("Dank Depths (tainted)"),--]]
}

normaltotaintedalt1 = {
	[Music.MUSIC_BASEMENT] = Isaac.GetMusicIdByName("Basement (tainted) nointro"),
	[Music.MUSIC_CAVES] = Isaac.GetMusicIdByName("Caves (tainted) nointro"),
	[Music.MUSIC_DEPTHS] = Isaac.GetMusicIdByName("Depths (tainted) nointro"),
	[Music.MUSIC_CELLAR] = Isaac.GetMusicIdByName("Cellar (tainted) nointro"),
	[Music.MUSIC_CATACOMBS] = Isaac.GetMusicIdByName("Catacombs (tainted) nointro"),
	[Music.MUSIC_NECROPOLIS] = Isaac.GetMusicIdByName("Necropolis (tainted) nointro"),
	[Music.MUSIC_WOMB_UTERO] = Isaac.GetMusicIdByName("Womb (tainted) nointro"),
	[Music.MUSIC_CATHEDRAL] = Isaac.GetMusicIdByName("Cathedral (tainted) nointro"),
	[Music.MUSIC_SHEOL] = Isaac.GetMusicIdByName("Sheol (tainted) nointro"),
	[Music.MUSIC_DARK_ROOM] = Isaac.GetMusicIdByName("Dark Room (tainted) altloop"),
	[Music.MUSIC_CHEST] = Isaac.GetMusicIdByName("Chest (tainted) altloop"),
	[Music.MUSIC_BURNING_BASEMENT] = Isaac.GetMusicIdByName("Burning Basement (tainted) nointro"),
	[Music.MUSIC_FLOODED_CAVES] = Isaac.GetMusicIdByName("Flooded Caves (tainted) nointro"),
	[Music.MUSIC_DANK_DEPTHS] = Isaac.GetMusicIdByName("Dank Depths (tainted) nointro"),
	[Music.MUSIC_SCARRED_WOMB] = Isaac.GetMusicIdByName("Scarred Womb (tainted) altloop"),
	[Music.MUSIC_BLUE_WOMB] = Isaac.GetMusicIdByName("Blue Womb (tainted) altloop"),
	[Music.MUSIC_UTERO] = Isaac.GetMusicIdByName("Utero (tainted) nointro"),
	[Music.MUSIC_VOID] = Isaac.GetMusicIdByName("Void (tainted) nointro"),
	[Music.MUSIC_DOWNPOUR] = Isaac.GetMusicIdByName("Downpour (tainted) nointro"),
	[Music.MUSIC_MINES] = Isaac.GetMusicIdByName("Mines (tainted) nointro"),
	[Music.MUSIC_MAUSOLEUM] = Isaac.GetMusicIdByName("Mausoleum (tainted) nointro"),
	[Music.MUSIC_CORPSE] = Isaac.GetMusicIdByName("Corpse (tainted) nointro"),
	[Music.MUSIC_DROSS] = Isaac.GetMusicIdByName("Dross (tainted) nointro"),
	[Music.MUSIC_ASHPIT] = Isaac.GetMusicIdByName("Ashpit (tainted) altloop"),
	[Music.MUSIC_GEHENNA] = Isaac.GetMusicIdByName("Gehenna (tainted) nointro"),
	[Music.MUSIC_CATACOMBS_GREED] = Isaac.GetMusicIdByName("Catacombs (tainted) nointro"),
	[Music.MUSIC_DEPTHS_GREED] = Isaac.GetMusicIdByName("Depths (tainted) nointro"),
	[Music.MUSIC_UTERO_GREED] = Isaac.GetMusicIdByName("Utero (tainted) nointro"),
	[Music.MUSIC_SHEOL_GREED] = Isaac.GetMusicIdByName("Sheol (tainted) nointro"),
	[Music.MUSIC_FLOOR_6_GREED] = Isaac.GetMusicIdByName("Greed Floor 6 (tainted) nointro"),
	[Music.MUSIC_ISAACS_HOUSE] = Isaac.GetMusicIdByName("Home (tainted) nointro"),
	[Music.MUSIC_HAPPY_ANNIVERSARY] = Isaac.GetMusicIdByName("Happy Anniversary nointro"),
	--[[[Music.MUSIC_CAVES_GREED] = Isaac.GetMusicIdByName("Caves (tainted) nointro"),
	[Music.MUSIC_FLOODED_CAVES_GREED] = Isaac.GetMusicIdByName("Flooded Caves (tainted) nointro"),
	[Music.MUSIC_NECROPOLIS_GREED] = Isaac.GetMusicIdByName("Necropolis (tainted) nointro"),
	[Music.MUSIC_DANK_DEPTHS_GREED] = Isaac.GetMusicIdByName("Dank Depths (tainted) nointro"),--]]
}

normaltotaintedalt2 = {
	[Music.MUSIC_BASEMENT] = Isaac.GetMusicIdByName("Basement (tainted) altloop"),
	[Music.MUSIC_CAVES] = Isaac.GetMusicIdByName("Caves (tainted) altloop"),
	[Music.MUSIC_DEPTHS] = Isaac.GetMusicIdByName("Depths (tainted) altloop"),
	[Music.MUSIC_CELLAR] = Isaac.GetMusicIdByName("Cellar (tainted) altloop"),
	[Music.MUSIC_CATACOMBS] = Isaac.GetMusicIdByName("Catacombs (tainted) altloop"),
	[Music.MUSIC_NECROPOLIS] = Isaac.GetMusicIdByName("Necropolis (tainted) altloop"),
	[Music.MUSIC_WOMB_UTERO] = Isaac.GetMusicIdByName("Womb (tainted) altloop"),
	[Music.MUSIC_CATHEDRAL] = Isaac.GetMusicIdByName("Cathedral (tainted) altloop"),
	[Music.MUSIC_SHEOL] = Isaac.GetMusicIdByName("Sheol (tainted) altloop"),
	[Music.MUSIC_DARK_ROOM] = Isaac.GetMusicIdByName("Dark Room (tainted) nointro"),
	[Music.MUSIC_CHEST] = Isaac.GetMusicIdByName("Chest (tainted) nointro"),
	[Music.MUSIC_BURNING_BASEMENT] = Isaac.GetMusicIdByName("Burning Basement (tainted) altloop"),
	[Music.MUSIC_FLOODED_CAVES] = Isaac.GetMusicIdByName("Flooded Caves (tainted) altloop"),
	[Music.MUSIC_DANK_DEPTHS] = Isaac.GetMusicIdByName("Dank Depths (tainted) altloop"),
	[Music.MUSIC_SCARRED_WOMB] = Isaac.GetMusicIdByName("Scarred Womb (tainted)"),
	[Music.MUSIC_BLUE_WOMB] = Isaac.GetMusicIdByName("Blue Womb (tainted) altloop 2"),
	[Music.MUSIC_UTERO] = Isaac.GetMusicIdByName("Utero (tainted) altloop"),
	[Music.MUSIC_VOID] = Isaac.GetMusicIdByName("Void (tainted) altloop"),
	[Music.MUSIC_DOWNPOUR] = Isaac.GetMusicIdByName("Downpour (tainted) altloop"),
	[Music.MUSIC_MINES] = Isaac.GetMusicIdByName("Mines (tainted) altloop"),
	[Music.MUSIC_MAUSOLEUM] = Isaac.GetMusicIdByName("Mausoleum (tainted) altloop"),
	[Music.MUSIC_CORPSE] = Isaac.GetMusicIdByName("Corpse (tainted) altloop"),
	[Music.MUSIC_DROSS] = Isaac.GetMusicIdByName("Dross (tainted) altloop"),
	[Music.MUSIC_ASHPIT] = Isaac.GetMusicIdByName("Ashpit (tainted)"),
	[Music.MUSIC_GEHENNA] = Isaac.GetMusicIdByName("Gehenna (tainted) altloop"),
	[Music.MUSIC_CATACOMBS_GREED] = Isaac.GetMusicIdByName("Catacombs (tainted) altloop"),
	[Music.MUSIC_DEPTHS_GREED] = Isaac.GetMusicIdByName("Depths (tainted) altloop"),
	[Music.MUSIC_UTERO_GREED] = Isaac.GetMusicIdByName("Utero (tainted) altloop"),
	[Music.MUSIC_SHEOL_GREED] = Isaac.GetMusicIdByName("Sheol (tainted) altloop"),
	[Music.MUSIC_FLOOR_6_GREED] = Isaac.GetMusicIdByName("Greed Floor 6 (tainted) altloop"),
	[Music.MUSIC_ISAACS_HOUSE] = Isaac.GetMusicIdByName("Home (tainted) altloop"),
	[Music.MUSIC_HAPPY_ANNIVERSARY] = Isaac.GetMusicIdByName("Happy Anniversary altloop"),
	--[[[Music.MUSIC_CAVES_GREED] = Isaac.GetMusicIdByName("Caves (tainted) altloop"),
	[Music.MUSIC_FLOODED_CAVES_GREED] = Isaac.GetMusicIdByName("Flooded Caves (tainted) altloop"),
	[Music.MUSIC_NECROPOLIS_GREED] = Isaac.GetMusicIdByName("Necropolis (tainted) altloop"),
	[Music.MUSIC_DANK_DEPTHS_GREED] = Isaac.GetMusicIdByName("Dank Depths (tainted) altloop"),--]]
}

taintedjinglelength = {
	[Music.MUSIC_JINGLE_BOSS_OVER] = 250, --Invictus
	[Music.MUSIC_JINGLE_BOSS_OVER2] = 250, --not satisfied with The Flagbearer outro (200), so using Invictus instead
	--TODO: use the MOTHER_JINGLE_OVER for the Flagbearer outro?
	[Music.MUSIC_JINGLE_BOSS_OVER3] = 320, --Tandava
}

taintedsfxid = {
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 1"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 2"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 3"),
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 4"),
	[Music.MUSIC_JINGLE_SECRETROOM_FIND] = Isaac.GetSoundIdByName("Secret Room Jingle (tainted)"),
	[Music.MUSIC_STRANGE_DOOR_JINGLE] = Isaac.GetSoundIdByName("Strange Door Jingle (tainted)"),
}

local loopversion = 0
local currentstage = 0
local currentstagetype = 0
local playingMainTrack = true
local coopMixedSoundtrack = false
local newPlayerSpawned = false --used as a flag to call a function on post render

local function PlayerIsTainted(player) --player is an EntityPlayer
	local playerType = player:GetPlayerType()
	if playerType < PlayerType.NUM_PLAYER_TYPES then
		--base game characters
		if playerType >= PlayerType.PLAYER_ISAAC_B then
			return true
		else
			return false
		end
	else
		--modded characters
		local playerName = player:GetName()
		local taintedPlayerType = Isaac.GetPlayerTypeByName(playerName,true)
		if playerType == taintedPlayerType then
			return true
		else
			--check for "Tainted" in the name (the Mei mod does this)
			local posU = string.find(playerName,"Tainted")
			local posL = string.find(playerName,"tainted")
			if posU == nil and posL == nil then
				return false
			else
				return true
			end
		end
	end
	return false --failsafe
end

local function normalAndTaintedPresent()
	local normalPresent = false
	local taintedPresent = false
	for i=0,7 do
		local tempPlayer = Isaac.GetPlayer(i)
		if tempPlayer and tempPlayer.Variant == 0 --0 is true player, 1 is co-op baby
		and not (tempPlayer:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN and not tempPlayer:GetSubPlayer()) then --account for "Soul of the Forgotten"
			if PlayerIsTainted(tempPlayer) then
				taintedPresent = true
			else
				normalPresent = true
			end
		end
	end
	if normalPresent and taintedPresent then
		return true
	end
	return false
end

local function CheckCoopMixOnGameStart()
	coopMixedSoundtrack = normalAndTaintedPresent()
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, CheckCoopMixOnGameStart)

local function CheckCoopMixOnSpawn(entityPlayer)
	newPlayerSpawned = true
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, CheckCoopMixOnSpawn, 0) --0 is true player, 1 is co-op baby

local function CheckCoopMixOnRender()
	if newPlayerSpawned then
		coopMixedSoundtrack = normalAndTaintedPresent()
		newPlayerSpawned = false
	end
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, CheckCoopMixOnRender)

local function resetCoopMix()
	coopMixedSoundtrack = false
end
custommusiccollection:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, resetCoopMix)

local function resetLoopVersion()
	loopversion = 0
end
custommusiccollection:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, resetLoopVersion)
custommusiccollection:AddCallback(ModCallbacks.MC_POST_GAME_END, resetLoopVersion)
custommusiccollection:AddCallback(ModCallbacks.MC_USE_ITEM, resetLoopVersion, CollectibleType.COLLECTIBLE_FORGET_ME_NOW)

function TaintedVersion(trackId)
	if normaltotainted[trackId] then
		local level = Game():GetLevel()
		local truecurrentstage = GetEffectiveLevelStage()
		local truecurrentstagetype = GetEffectiveStageType()
		if truecurrentstage ~= currentstage or truecurrentstagetype ~= currentstagetype then
			currentstage = truecurrentstage
			currentstagetype = truecurrentstagetype
			resetLoopVersion()
		end
		
		local room = Game():GetRoom()
		local roomdesc = level:GetCurrentRoomDesc()
		local roomdata = roomdesc.Data
		if room:IsFirstVisit() and (roomdata.Name == "Start Room" or roomdata.Name == "Starting Room" or roomdata.Name == "Isaac's Bedroom" or InChapter6StartRoom()) then
			resetLoopVersion() --this should cover the "Forget Me Now" Dice Room, and probably makes the earlier check redundant
		end
		
		if not usingRGON and taintedjinglelength[trackId] then
			return normaltotainted[trackId], nil, taintedjinglelength[trackId]
		elseif not usingRGON and taintedsfxid[trackId] then
			if treasurejingles[trackId] then
				local rng = math.random(0,8)
				return 0, nil, taintedtreasurejinglesfx[rng]
			else
				return 0, nil, taintedsfxid[trackId]
			end
		elseif usingRGON and treasurejingles[trackId] then
			local rng = math.random(0,8)
			return taintedtreasurejingles[rng]
		elseif loopversion == 2 and normaltotaintedalt2[trackId] then
			return normaltotaintedalt2[trackId]
		elseif loopversion == 1 and normaltotaintedalt1[trackId] then
			return normaltotaintedalt1[trackId]
		else
			return normaltotainted[trackId]
		end
	else
		return trackId
	end
end

local roomTypesWithMusic = {
	[RoomType.ROOM_BOSS] = true,
	[RoomType.ROOM_MINIBOSS] = true,
	[RoomType.ROOM_SECRET] = true,
	[RoomType.ROOM_SUPERSECRET] = true,
	[RoomType.ROOM_ARCADE] = true,
	[RoomType.ROOM_LIBRARY] = true,
	[RoomType.ROOM_DEVIL] = true,
	[RoomType.ROOM_ANGEL] = true,
	[RoomType.ROOM_PLANETARIUM] = true,
	[RoomType.ROOM_SECRET_EXIT] = true,
	[RoomType.ROOM_ULTRASECRET] = true,
}

local roomTypesMaybeMusic = {
	[RoomType.ROOM_SHOP] = true,
	[RoomType.ROOM_BLACK_MARKET] = true,
	[RoomType.ROOM_ERROR] = true,
	[RoomType.ROOM_CHALLENGE] = true,
	[RoomType.ROOM_BOSSRUSH] = true,
}

if DontInterruptBlueWombFlag then
	roomTypesWithMusic[RoomType.ROOM_BOSS] = nil
	roomTypesMaybeMusic[RoomType.ROOM_BOSS] = true
end

local function changeTrackVersion()
	if loopversion == 1 then
		loopversion = 2
	else
		loopversion = 1
	end
end

custommusiccollection:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	currentstage = GetEffectiveLevelStage()
	currentstagetype = GetEffectiveStageType()
end)

--DELETE THIS enhancement start
local random_music = {
	[0] = Music.MUSIC_BASEMENT,
	[1] = Music.MUSIC_CELLAR,
	[2] = Music.MUSIC_BURNING_BASEMENT,
	[3] = Music.MUSIC_DOWNPOUR,
	[4] = Music.MUSIC_DROSS,
	[5] = Music.MUSIC_CAVES,
	[6] = Music.MUSIC_CATACOMBS,
	[7] = Music.MUSIC_FLOODED_CAVES,
	[8] = Music.MUSIC_MINES,
	[9] = Music.MUSIC_ASHPIT,
	[10] = Music.MUSIC_DEPTHS,
	[11] = Music.MUSIC_NECROPOLIS,
	[12] = Music.MUSIC_DANK_DEPTHS,
	[13] = Music.MUSIC_MAUSOLEUM,
	[14] = Music.MUSIC_GEHENNA,
	[15] = Music.MUSIC_WOMB_UTERO,
	[16] = Music.MUSIC_UTERO,
	[17] = Music.MUSIC_SCARRED_WOMB,
	[18] = Music.MUSIC_CORPSE,
	[19] = Music.MUSIC_BLUE_WOMB,
	[20] = Music.MUSIC_SHEOL,
	[21] = Music.MUSIC_CATHEDRAL_ALT,
	[22] = Music.MUSIC_DARK_ROOM,
	[23] = Music.MUSIC_CHEST,
	[24] = Music.MUSIC_VOID,
	[25] = Music.MUSIC_ISAACS_HOUSE,
	[26] = Music.MUSIC_DOWNPOUR_REVERSE,
	[27] = Music.MUSIC_DROSS_REVERSE,
	[28] = Music.MUSIC_REVERSE_GENESIS,
	[29] = Music.MUSIC_FLOOR_6_GREED,
	[30] = Music.MUSIC_CREDITS,
	[31] = Music.MUSIC_TITLE,
	[32] = Music.MUSIC_TITLE_AFTERBIRTH,
	[33] = Music.MUSIC_TITLE_REPENTANCE,
	[34] = Music.MUSIC_DEPTHS_GREED,
	[35] = Music.MUSIC_CATACOMBS_GREED,
	[36] = Music.MUSIC_SHEOL_GREED,
	[37] = Music.MUSIC_UTERO_GREED,
	[38] = Music.MUSIC_BLUE_WOMB_ALT,
	--TAINTED START
	[39] = Music.MUSIC_BASEMENT,
	[40] = Music.MUSIC_CELLAR,
	[41] = Music.MUSIC_BURNING_BASEMENT,
	[42] = Music.MUSIC_DOWNPOUR,
	[43] = Music.MUSIC_DROSS,
	[44] = Music.MUSIC_CAVES,
	[45] = Music.MUSIC_CATACOMBS,
	[46] = Music.MUSIC_FLOODED_CAVES,
	[47] = Music.MUSIC_MINES,
	[48] = Music.MUSIC_ASHPIT,
	[49] = Music.MUSIC_DEPTHS,
	[50] = Music.MUSIC_NECROPOLIS,
	[51] = Music.MUSIC_DANK_DEPTHS,
	[52] = Music.MUSIC_MAUSOLEUM,
	[53] = Music.MUSIC_GEHENNA,
	[54] = Music.MUSIC_WOMB_UTERO,
	[55] = Music.MUSIC_UTERO,
	[56] = Music.MUSIC_SCARRED_WOMB,
	[57] = Music.MUSIC_CORPSE,
	[58] = Music.MUSIC_BLUE_WOMB,
	[59] = Music.MUSIC_SHEOL,
	[60] = Music.MUSIC_CATHEDRAL,
	[61] = Music.MUSIC_DARK_ROOM,
	[62] = Music.MUSIC_CHEST,
	[63] = Music.MUSIC_VOID,
	[64] = Music.MUSIC_ISAACS_HOUSE,
	[65] = Music.MUSIC_DOWNPOUR_REVERSE,
	[66] = Music.MUSIC_DROSS_REVERSE,
	[67] = Music.MUSIC_REVERSE_GENESIS,
	[68] = Music.MUSIC_FLOOR_6_GREED,
	[69] = Music.MUSIC_HAPPY_ANNIVERSARY,
}
local random_music_size = 70
local random_music_tainted_threshold = 38

local random_boss_music = {
	[0] = Music.MUSIC_NULL,
	[1] = Music.MUSIC_BOSS,
	[2] = Music.MUSIC_BOSS2,
	[3] = Music.MUSIC_BOSS3,
	[4] = Music.MUSIC_CHALLENGE_FIGHT,
	[5] = Music.MUSIC_BOSS_RUSH,
	[6] = Music.MUSIC_MOM_BOSS,
	[7] = Music.MUSIC_MOMS_HEART_BOSS,
	[8] = Music.MUSIC_ISAAC_BOSS,
	[9] = Music.MUSIC_SATAN_BOSS_ALT,
	[10] = Music.MUSIC_DARKROOM_BOSS,
	[11] = Music.MUSIC_BLUEBABY_BOSS,
	[12] = Music.MUSIC_HUSH_BOSS,
	[13] = Music.MUSIC_ULTRAGREED_BOSS,
	[14] = Music.MUSIC_VOID_BOSS,
	[15] = Music.MUSIC_MINESHAFT_ESCAPE,
	[16] = Music.MUSIC_MOTHER_BOSS,
	[17] = Music.MUSIC_DOGMA_BOSS,
	[18] = Music.MUSIC_BEAST_BOSS,
	[19] = Music.MUSIC_ULTRAGREEDIER_BOSS,
	[20] = Music.MUSIC_ANGEL_BOSS,
	[21] = Music.MUSIC_MEGASATAN_BOSS,
	--TAINTED START
	[22] = Music.MUSIC_BOSS,
	[23] = Music.MUSIC_BOSS2,
	[24] = Music.MUSIC_BOSS3,
	[25] = Music.MUSIC_CHALLENGE_FIGHT,
	[26] = Music.MUSIC_BOSS_RUSH,
	[27] = Music.MUSIC_MOM_BOSS,
	[28] = Music.MUSIC_MOMS_HEART_BOSS,
	[29] = Music.MUSIC_ISAAC_BOSS,
	[30] = Music.MUSIC_SATAN_BOSS,
	[31] = Music.MUSIC_DARKROOM_BOSS,
	[32] = Music.MUSIC_BLUEBABY_BOSS,
	[33] = Music.MUSIC_HUSH_BOSS,
	[34] = Music.MUSIC_ULTRAGREED_BOSS,
	[35] = Music.MUSIC_VOID_BOSS,
	[36] = Music.MUSIC_MINESHAFT_ESCAPE,
	[37] = Music.MUSIC_MOTHER_BOSS,
	[38] = Music.MUSIC_DOGMA_BOSS,
	[39] = Music.MUSIC_BEAST_BOSS,
	[40] = Music.MUSIC_ULTRAGREEDIER_BOSS,
	[41] = Music.MUSIC_ANGEL_BOSS,
	[42] = Music.MUSIC_MEGASATAN_BOSS,
}
local random_boss_music_size = 43
local random_boss_music_tainted_threshold = 21

local random_special_music = {
	[0] = Music.MUSIC_NULL,
	[1] = Music.MUSIC_GAME_OVER,
	[2] = Music.MUSIC_LIBRARY_ROOM,
	[3] = Music.MUSIC_SECRET_ROOM,
	[4] = Music.MUSIC_SECRET_ROOM2,
	[5] = Music.MUSIC_SECRET_ROOM_ALT_ALT,
	[6] = Music.MUSIC_DEVIL_ROOM,
	[7] = Music.MUSIC_ANGEL_ROOM,
	[8] = Music.MUSIC_SHOP_ROOM,
	[9] = Music.MUSIC_ARCADE_ROOM,
	[10] = Music.MUSIC_BOSS_OVER,
	[11] = Music.MUSIC_PLANETARIUM,
	[12] = Music.MUSIC_BOSS_OVER_TWISTED,
	[13] = Music.MUSIC_DARK_CLOSET,
	[14] = Music.MUSIC_MINESHAFT_AMBIENT,
	[15] = Music.MUSIC_CREDITS_ALT,
	[16] = Music.MUSIC_BLACKMARKET_ROOM,
	[17] = Music.MUSIC_I_AM_ERROR,
	[18] = Music.MUSIC_DEVIL_ROOM_ALT,
	[19] = Music.MUSIC_SHOP_ROOM_ALT,
	[20] = Music.MUSIC_BOSS_OVER_GREED,
	--TAINTED START
	[21] = Music.MUSIC_GAME_OVER,
	[22] = Music.MUSIC_LIBRARY_ROOM,
	[23] = Music.MUSIC_SECRET_ROOM,
	[24] = Music.MUSIC_SECRET_ROOM2,
	[25] = Music.MUSIC_SECRET_ROOM_ALT_ALT,
	[26] = Music.MUSIC_DEVIL_ROOM,
	[27] = Music.MUSIC_ANGEL_ROOM,
	[28] = Music.MUSIC_SHOP_ROOM,
	[29] = Music.MUSIC_ARCADE_ROOM,
	[30] = Music.MUSIC_BOSS_OVER,
	[31] = Music.MUSIC_PLANETARIUM,
	[32] = Music.MUSIC_BOSS_OVER_TWISTED,
	[33] = Music.MUSIC_DARK_CLOSET,
	[34] = Music.MUSIC_MINESHAFT_AMBIENT,
	[35] = Music.MUSIC_BLACKMARKET_ROOM,
	[36] = Music.MUSIC_I_AM_ERROR,
}
local random_special_music_size = 37
local random_special_music_tainted_threshold = 20

local random_fight_jingle = {
	[0] = Music.MUSIC_NULL,
	[1] = Music.MUSIC_JINGLE_BOSS_OVER,
	[2] = Music.MUSIC_JINGLE_BOSS_OVER2,
	[3] = Music.MUSIC_JINGLE_BOSS_OVER3,
	[4] = Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
	[5] = Music.MUSIC_JINGLE_BOSS_RUSH_OUTRO,
	[6] = Music.MUSIC_JINGLE_GAME_OVER,
	[7] = Music.MUSIC_JINGLE_HUSH_OVER,
	[8] = Music.MUSIC_JINGLE_MOTHER_OVER,
	[9] = Music.MUSIC_JINGLE_DOGMA_OVER,
	[10] = Music.MUSIC_JINGLE_BEAST_OVER,
	[11] = Music.MUSIC_MOTHERS_SHADOW_INTRO,
	[12] = Music.MUSIC_JINGLE_GAME_START,
	[13] = Music.MUSIC_JINGLE_GAME_START_ALT,
	[14] = Music.MUSIC_JINGLE_DELIRIUM_OVER,
	[15] = Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER,
	--TAINTED START
	[16] = Music.MUSIC_JINGLE_BOSS_OVER,
	[17] = Music.MUSIC_JINGLE_BOSS_OVER2,
	[18] = Music.MUSIC_JINGLE_BOSS_OVER3,
	[19] = Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
	[20] = Music.MUSIC_JINGLE_BOSS_RUSH_OUTRO,
	[21] = Music.MUSIC_JINGLE_GAME_OVER,
	[22] = Music.MUSIC_JINGLE_ANGEL_OVER,
	[23] = Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER,
	[24] = Music.MUSIC_JINGLE_DELIRIUM_OVER,
	[25] = Music.MUSIC_JINGLE_MOTHER_OVER,
	--[26] = Music.MUSIC_JINGLE_HUSH_OVER, --doesn't exist
	--[27] = Music.MUSIC_JINGLE_DOGMA_OVER, --doesn't exist
	--[28] = Music.MUSIC_JINGLE_BEAST_OVER, --doesn't exist
	--[29] = Music.MUSIC_MOTHERS_SHADOW_INTRO, --doesn't exist
}
local random_fight_jingle_size = 26
local random_fight_jingle_tainted_threshold = 15

random_jingle = {
	[0] = Music.MUSIC_NULL,
	[1] = Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0,
	[2] = Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1,
	[3] = Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2,
	[4] = Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3,
	[5] = Music.MUSIC_JINGLE_SECRETROOM_FIND,
	[6] = Music.MUSIC_STRANGE_DOOR_JINGLE,
	[7] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 1"),
	[8] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 2"),
	[9] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 3"),
	[10] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 4"),
	[11] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 5"),
	[12] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 6"),
	[13] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 7"),
	[14] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 8"),
	[15] = Isaac.GetMusicIdByName("Treasure Room Entry (jingle, tainted) 9"),
	[16] = Isaac.GetMusicIdByName("Secret Room Find (jingle, tainted)"),
	[17] = Isaac.GetMusicIdByName("Strange Door (jingle, tainted)"),
	[18] = Music.MUSIC_JINGLE_DEVILROOM_FIND,
	[19] = Music.MUSIC_JINGLE_HOLYROOM_FIND,
}
random_jingle_size = 20

random_sound_jingle = {
	[0] = SoundEffect.SOUND_NULL,
	[1] = Isaac.GetSoundIdByName("Treasure Jingle 1"),
	[2] = Isaac.GetSoundIdByName("Treasure Jingle 2"),
	[3] = Isaac.GetSoundIdByName("Treasure Jingle 3"),
	[4] = Isaac.GetSoundIdByName("Treasure Jingle 4"),
	[5] = Isaac.GetSoundIdByName("Secret Room Jingle"),
	[6] = Isaac.GetSoundIdByName("Strange Door Jingle"),
	[7] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 1"),
	[8] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 2"),
	[9] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 3"),
	[10] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 4"),
	[11] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 5"),
	[12] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 6"),
	[13] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 7"),
	[14] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 8"),
	[15] = Isaac.GetSoundIdByName("Treasure Jingle (tainted) 9"),
	[16] = Isaac.GetSoundIdByName("Secret Room Jingle (tainted)"),
	[17] = Isaac.GetSoundIdByName("Strange Door Jingle (tainted)"),
	[18] = SoundEffect.SOUND_SATAN_ROOM_APPEAR,
	[19] = SoundEffect.SOUND_CHOIR_UNLOCK,
}
random_sound_jingle_size = 20

local function getRandomStageMusic(seed)
	local seedIndex = seed % random_music_size
	
	if seedIndex > random_music_tainted_threshold then
		return TaintedVersion(random_music[seedIndex])
	else
		return random_music[seedIndex]
	end
end

local function getRandomBossMusic(seed)
	local seedIndex = seed % random_boss_music_size
	
	if seedIndex > random_boss_music_tainted_threshold then
		return TaintedVersion(random_boss_music[seedIndex])
	else
		return random_boss_music[seedIndex]
	end
end

local function getRandomSpecialMusic(seed)
	local seedIndex = seed % random_special_music_size
	
	if seedIndex > random_special_music_tainted_threshold then
		return TaintedVersion(random_special_music[seedIndex])
	else
		return random_special_music[seedIndex]
	end
end

local function getRandomFightJingle(seed)
	local rng = math.random(0,(random_fight_jingle_size - 1))
	
	if rng > random_fight_jingle_tainted_threshold then
		return TaintedVersion(random_fight_jingle[rng])
	else
		return random_fight_jingle[rng]
	end
end

function getRandomJingle(seed)
	local rng = math.random(0,(random_jingle_size - 1))
	return random_jingle[rng]
end

function getRandomSoundJingle(seed)
	local rng = math.random(0,(random_sound_jingle_size - 1))
	return random_sound_jingle[rng]
end

function custommusiccollection:PerformDeleteThisBossReplacement(trackId)
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		local room = Game():GetRoom()
		local roomseed = room:GetDecorationSeed()
		return getRandomBossMusic(roomseed)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisBossReplacement,
Music.MUSIC_BOSS, 
Music.MUSIC_BOSS2, 
Music.MUSIC_BOSS3, 
Music.MUSIC_MOM_BOSS, 
Music.MUSIC_MOMS_HEART_BOSS, 
Music.MUSIC_ISAAC_BOSS, 
Music.MUSIC_BLUEBABY_BOSS, 
Music.MUSIC_CHALLENGE_FIGHT,
Music.MUSIC_BOSS_RUSH,
Music.MUSIC_DARKROOM_BOSS,
Music.MUSIC_VOID_BOSS,
Music.MUSIC_MOTHER_BOSS,
Music.MUSIC_DOGMA_BOSS,
Music.MUSIC_BEAST_BOSS)

function custommusiccollection:PerformDeleteThisBossPhaseTwo(trackId)
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		local seeds = Game():GetSeeds()
		local runseed = seeds:GetStartSeed()
		return getRandomBossMusic(runseed)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisBossPhaseTwo,
Music.MUSIC_SATAN_BOSS,
Music.MUSIC_HUSH_BOSS)

function custommusiccollection:PerformDeleteThisSpecialRoomReplacement(trackId)
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		local room = Game():GetRoom()
		local roomseed = room:GetDecorationSeed()
		return getRandomSpecialMusic(roomseed)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisSpecialRoomReplacement,
Music.MUSIC_GAME_OVER,
Music.MUSIC_LIBRARY_ROOM,
Music.MUSIC_SECRET_ROOM,
Music.MUSIC_SECRET_ROOM2,
Music.MUSIC_SECRET_ROOM_ALT_ALT,
Music.MUSIC_DEVIL_ROOM,
Music.MUSIC_ANGEL_ROOM,
Music.MUSIC_SHOP_ROOM,
Music.MUSIC_ARCADE_ROOM,
Music.MUSIC_BOSS_OVER,
Music.MUSIC_PLANETARIUM,
Music.MUSIC_DARK_CLOSET)

function custommusiccollection:PerformDeleteThisFightJingleReplacement(trackId)
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		return getRandomFightJingle()
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisFightJingleReplacement,
Music.MUSIC_JINGLE_BOSS_OVER,
Music.MUSIC_JINGLE_BOSS_OVER2,
Music.MUSIC_JINGLE_BOSS_OVER3,
Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
Music.MUSIC_JINGLE_BOSS_RUSH_OUTRO,
Music.MUSIC_JINGLE_GAME_OVER)

if usingRGON then
	function custommusiccollection:PerformDeleteThisJingleReplacement(trackId)
		if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
			return getRandomJingle()
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY_JINGLE, custommusiccollection.PerformDeleteThisJingleReplacement, Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0)
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY_JINGLE, custommusiccollection.PerformDeleteThisJingleReplacement, Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1)
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY_JINGLE, custommusiccollection.PerformDeleteThisJingleReplacement, Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2)
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY_JINGLE, custommusiccollection.PerformDeleteThisJingleReplacement, Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3)
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY_JINGLE, custommusiccollection.PerformDeleteThisJingleReplacement, Music.MUSIC_JINGLE_SECRETROOM_FIND)
	
	local wasclear = 99
	function custommusiccollection:UpdateWasClear()
		if Game():GetRoom():IsClear() == false then
			wasclear = 0
		elseif wasclear < 9 then
			wasclear = wasclear + 1
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_UPDATE, custommusiccollection.UpdateWasClear)
	
	function custommusiccollection:PerformDeleteThisJingleReplacementAngelDevil(id, volume, frameDelay, loop, pitch, pan)
		if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS and wasclear < 5 then
			return {getRandomSoundJingle(), volume, frameDelay, loop, pitch, pan}
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_SFX_PLAY, custommusiccollection.PerformDeleteThisJingleReplacementAngelDevil, SoundEffect.SOUND_SATAN_ROOM_APPEAR)
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_SFX_PLAY, custommusiccollection.PerformDeleteThisJingleReplacementAngelDevil, SoundEffect.SOUND_CHOIR_UNLOCK)
else
	function custommusiccollection:PerformDeleteThisSoundJingleReplacement(trackId)
		if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
			local randomSfx = getRandomSoundJingle()
			
			return 0, nil, randomSfx
		end
	end
	custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisSoundJingleReplacement,
	Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0,
	Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1,
	Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2,
	Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3,
	Music.MUSIC_JINGLE_SECRETROOM_FIND,
	Music.MUSIC_JINGLE_DEVILROOM_FIND,
	Music.MUSIC_JINGLE_HOLYROOM_FIND)
end

function custommusiccollection:PerformDeleteThisBossPortrait(trackId)
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		local room = Game():GetRoom()
		local roomseed = room:GetDecorationSeed()
		local thisRoomBossMusic = getRandomBossMusic(roomseed)
		
		if thisRoomBossMusic == normaltotainted[Music.MUSIC_MOTHER_BOSS]
		or thisRoomBossMusic == normaltotainted[Music.MUSIC_ISAAC_BOSS]
		or thisRoomBossMusic == normaltotainted[Music.MUSIC_ULTRAGREED_BOSS]
		or thisRoomBossMusic == normaltotainted[Music.MUSIC_VOID_BOSS]
		or thisRoomBossMusic == normaltotainted[Music.MUSIC_DOGMA_BOSS] then
			return thisRoomBossMusic
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisBossPortrait, Music.MUSIC_JINGLE_BOSS)

function custommusiccollection:PerformDeleteThisMainReplacement(trackId)
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS and not skiptainted[trackId] and trackId ~= Music.MUSIC_JINGLE_BOSS and trackId > 0 then
		
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		local level = Game():GetLevel()
		
		if (modSaveData["blackmarketroomtheme"] and roomtype == RoomType.ROOM_BLACK_MARKET) or 
		(modSaveData["iamerrorroomtheme"] and roomtype == RoomType.ROOM_ERROR) or 
		(modSaveData["genesisroomtheme"] and level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX) or 
		level:GetCurrentRoomIndex() == GridRooms.ROOM_BLUE_WOOM_IDX then
			local roomseed = room:GetDecorationSeed()
			return getRandomSpecialMusic(roomseed)
		else
			local seeds = Game():GetSeeds()
			local stage = GetEffectiveLevelStage()
			local stageseed = seeds:GetStageSeed(stage)
			return getRandomStageMusic(stageseed)
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeleteThisMainReplacement)
--DELETE THIS enhancement end

--Co-op Mixed soundtrack start
local runSeedTrack = {
	[Music.MUSIC_GAME_OVER] = 1,
	[Music.MUSIC_JINGLE_GAME_OVER] = 2,
	[Music.MUSIC_REVERSE_GENESIS] = 3,
	[Music.MUSIC_DARK_CLOSET] = 4,
}

local stageSeedTrack = {
	[Music.MUSIC_BASEMENT] = 1,
	[Music.MUSIC_CAVES] = 1,
	[Music.MUSIC_DEPTHS] = 1,
	[Music.MUSIC_CELLAR] = 1,
	[Music.MUSIC_CATACOMBS] = 1,
	[Music.MUSIC_NECROPOLIS] = 1,
	[Music.MUSIC_WOMB_UTERO] = 1,
	[Music.MUSIC_CATHEDRAL] = 1,
	[Music.MUSIC_SHEOL] = 1,
	[Music.MUSIC_DARK_ROOM] = 1,
	[Music.MUSIC_CHEST] = 1,
	[Music.MUSIC_BURNING_BASEMENT] = 1,
	[Music.MUSIC_FLOODED_CAVES] = 1,
	[Music.MUSIC_DANK_DEPTHS] = 1,
	[Music.MUSIC_SCARRED_WOMB] = 1,
	[Music.MUSIC_BLUE_WOMB] = 1,
	[Music.MUSIC_UTERO] = 1,
	[Music.MUSIC_VOID] = 1,
	[Music.MUSIC_DOWNPOUR] = 1,
	[Music.MUSIC_MINES] = 1,
	[Music.MUSIC_MAUSOLEUM] = 1,
	[Music.MUSIC_CORPSE] = 1,
	[Music.MUSIC_DROSS] = 1,
	[Music.MUSIC_ASHPIT] = 1,
	[Music.MUSIC_GEHENNA] = 1,
	[Music.MUSIC_ISAACS_HOUSE] = 1,
	[Music.MUSIC_DOWNPOUR_REVERSE] = 1,
	[Music.MUSIC_DROSS_REVERSE] = 1,
	[Music.MUSIC_CATACOMBS_GREED] = 1,
	[Music.MUSIC_DEPTHS_GREED] = 1,
	[Music.MUSIC_UTERO_GREED] = 1,
	[Music.MUSIC_SHEOL_GREED] = 1,
	[Music.MUSIC_FLOOR_6_GREED] = 1,
	[Music.MUSIC_MINESHAFT_AMBIENT] = 2,
	[Music.MUSIC_MINESHAFT_ESCAPE] = 3,
	[Music.MUSIC_BOSS_OVER_TWISTED] = 2,
}

--NOTE: since choosing between boss music 1 and 2 used to be determined by the room seed, we avoided using 1 for many boss themes
local roomSeedTrack = { --TODO: these can be adjusted now that MMC no longer uses room decoration seed for generic boss music
	--cases to handle:
	--generic boss room (1 - MMC; 2 - boss over; 3 - Boss; 5 - Devil jingle; 6 - Angel jingle)
	--Greed Mode Main room (1 - MMC; 2 - boss over greed; 3 - Boss; 4 - Challenge; 5 - Devil jingle; 6 - Angel jingle)
	--challenge/miniboss room (2 - boss over; 4 - Challenge)
	--devil room (2 - boss over; 4 - Challenge; 5 - devil room)
	--angel room (2 - boss over; 3 - angel fight; 1 - angel room)
	--Hush (1 - Hush; 2 - boss over; 3 - BlueBaby)
	--Satan (1 - MMC; 2 - boss over; 3 - Boss; 4 - Satan boss; 5 - devil room)
	--Mega Satan (1 - MMC; 2 - boss over; 3 - Mega Satan boss; 5 - devil room)
	--Ultra Greed ( 1 - Ultra Greedier; 2 - boss over greed; 3 - Ultra Greed)
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0] = 1,
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1] = 1,
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2] = 1,
	[Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3] = 1,
	[Music.MUSIC_LIBRARY_ROOM] = 1,
	[Music.MUSIC_SECRET_ROOM] = 1,
	[Music.MUSIC_SECRET_ROOM2] = 1,
	[Music.MUSIC_SHOP_ROOM] = 1,
	[Music.MUSIC_ARCADE_ROOM] = 1,
	[Music.MUSIC_ANGEL_ROOM] = 1,
	[Music.MUSIC_PLANETARIUM] = 1,
	[Music.MUSIC_SECRET_ROOM_ALT_ALT] = 1,
	[Music.MUSIC_SHOP_ROOM_ALT] = 1,
	[Music.MUSIC_BLACKMARKET_ROOM] = 1,
	[Music.MUSIC_I_AM_ERROR] = 1,
	[Music.MUSIC_ULTRAGREEDIER_BOSS] = 1,
	[Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER] = 1,
	[Music.MUSIC_HUSH_BOSS] = 1,
	[Music.MUSIC_JINGLE_HUSH_OVER] = 1,
	[Music.MUSIC_BOSS_RUSH] = 1,
	[Music.MUSIC_JINGLE_BOSS_RUSH_OUTRO] = 1,
	[Music.MUSIC_MOTHER_BOSS] = 1,
	[Music.MUSIC_JINGLE_MOTHER_OVER] = 1,
	[Music.MUSIC_DOGMA_INTRO] = 1,
	[Music.MUSIC_DOGMA_BOSS] = 1,
	[Music.MUSIC_JINGLE_DOGMA_OVER] = 1,
	[Music.MUSIC_BEAST_BOSS] = 1,
	[Music.MUSIC_JINGLE_BEAST_OVER] = 1,
	[Music.MUSIC_MOTHERS_SHADOW_INTRO] = 1,
	[Music.MUSIC_VOID_BOSS] = 1,
	[Music.MUSIC_JINGLE_DELIRIUM_OVER] = 1,
	
	--Genesis room
	[Music.MUSIC_TITLE] = 1,
	[Music.MUSIC_TITLE_AFTERBIRTH] = 1,
	
	[Music.MUSIC_BOSS_OVER] = 2,
	[Music.MUSIC_BOSS_OVER_GREED] = 2,
	
	[Music.MUSIC_BOSS] = 3,
	[Music.MUSIC_BOSS2] = 3,
	[Music.MUSIC_BOSS3] = 3,
	[Music.MUSIC_JINGLE_BOSS_OVER] = 3,
	[Music.MUSIC_JINGLE_BOSS_OVER2] = 3,
	[Music.MUSIC_JINGLE_BOSS_OVER3] = 3,
	[Music.MUSIC_MOM_BOSS] = 3,
	[Music.MUSIC_MOMS_HEART_BOSS] = 3,
	[Music.MUSIC_ISAAC_BOSS] = 3,
	[Music.MUSIC_ULTRAGREED_BOSS] = 3,
	[Music.MUSIC_DARKROOM_BOSS] = 3,
	[Music.MUSIC_BLUEBABY_BOSS] = 3,
	[Music.MUSIC_MEGASATAN_BOSS] = 3,
	[Music.MUSIC_ANGEL_BOSS] = 3,
	[Music.MUSIC_JINGLE_ANGEL_OVER] = 3,
	
	[Music.MUSIC_CHALLENGE_FIGHT] = 4,
	[Music.MUSIC_JINGLE_CHALLENGE_OUTRO] = 4,
	[Music.MUSIC_SATAN_BOSS] = 4,
	[Music.MUSIC_SATAN_BOSS_ALT] = 4,
	
	[Music.MUSIC_DEVIL_ROOM] = 5,
	[Music.MUSIC_DEVIL_ROOM_ALT] = 5,
	[Music.MUSIC_JINGLE_DEVILROOM_FIND] = 5,
	[Music.MUSIC_JINGLE_SECRETROOM_FIND] = 5,
	
	[Music.MUSIC_JINGLE_HOLYROOM_FIND] = 6,
	[Music.MUSIC_STRANGE_DOOR_JINGLE] = 6,
	--[Music.MUSIC_JINGLE_BOSS] = true, --handled elsewhere
}

local function modBitplaceLowerhalf(seed, bitplace)
	local moduloSeed = (seed % (1 << bitplace))
	--if bitplace is 1, (seed % 2), moduloSeed is 0 or 1, return true if value is less than 1
	--if bitplace is 2, (seed % 4), moduloSeed is 0-3, return true if value is less than 2
	--if bitplace is 3, (seed % 8), moduloSeed is 0-7, return true if value is less than 4
	--etc...
	if moduloSeed < (1 << (bitplace - 1)) then
		return true
	else
		return false
	end
end

function SeededCoopTaintedMix(trackId)
	if runSeedTrack[trackId] and runSeedTrack[trackId] > 0 then
		local seeds = Game():GetSeeds()
		local runseed = seeds:GetStartSeed()
		return modBitplaceLowerhalf(runseed, runSeedTrack[trackId])
	elseif stageSeedTrack[trackId] and stageSeedTrack[trackId] > 0 then
		--TODO: when using "reseed" to test STAGETYPE_REPENTANCE and STAGETYPE_REPENTANCE_B floors, it only ever picks one option... investigate
		local seeds = Game():GetSeeds()
		local stage = GetEffectiveLevelStage()
		local stageseed = seeds:GetStageSeed(stage)
		return modBitplaceLowerhalf((stageseed / 10), stageSeedTrack[trackId])
	elseif roomSeedTrack[trackId] and roomSeedTrack[trackId] > 0 then
		local room = Game():GetRoom()
		local roomseed = room:GetDecorationSeed()
		return modBitplaceLowerhalf(roomseed, roomSeedTrack[trackId])
	end
	return false
end
--Co-op Mixed soundtrack end

local function CheckMaybeRoomConditions(roomtype)
	--return true if this roomtype will play its own special music
	if roomtype == RoomType.ROOM_CHALLENGE or roomtype == RoomType.ROOM_BOSSRUSH then
		local room = Game():GetRoom()
		if room:IsAmbushActive() or room:IsAmbushDone() then
			return true
		end
	elseif roomtype == RoomType.ROOM_SHOP then
		local stage = GetEffectiveLevelStage()
		
		if not Game():IsGreedMode() and stage ~= LevelStage.STAGE4_3 then
			return true
		elseif Game():IsGreedMode() and stage ~= LevelStage.STAGE6_GREED then
			return true
		end
	elseif roomtype == RoomType.ROOM_BLACK_MARKET and modSaveData["blackmarketroomtheme"] then
		local stage = GetEffectiveLevelStage()
		
		if Game():IsGreedMode() or stage ~= LevelStage.STAGE4_3 then
			return true
		end
	elseif roomtype == RoomType.ROOM_ERROR and modSaveData["iamerrorroomtheme"] then
		return true
	elseif roomtype == RoomType.ROOM_BOSS then
		local stage = GetEffectiveLevelStage()
		local room = Game():GetRoom()
		
		if stage ~= LevelStage.STAGE4_3 or not room:IsClear() then
			return true
		end
	end
	
	return false
end

local function RoomIsDeleteThisNullSpecial()
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		local room = Game():GetRoom()
		local roomseed = room:GetDecorationSeed()
		local specialRandom = getRandomSpecialMusic(roomseed)
		if specialRandom == Music.MUSIC_NULL then
			return true
		end
	end
	return false
end

custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    local room = Game():GetRoom()
	local roomtype = room:GetType()
	
	if (roomTypesWithMusic[roomtype] or (roomTypesMaybeMusic[roomtype] and CheckMaybeRoomConditions(roomtype))) and not RoomIsDeleteThisNullSpecial() then
		local level = Game():GetLevel()
		local ascent = level:IsAscent()
		if not ascent then
			if playingMainTrack then
				playingMainTrack = false
				changeTrackVersion()
			end
		end
	else
		playingMainTrack = true
	end
	
	--TODO: have a table of loopversions, per backdroptype, for the Red Redemption challenge
end)

custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	local room = Game():GetRoom()
	local roomtype = room:GetType()
	
	if roomtype == RoomType.ROOM_CHALLENGE or roomtype == RoomType.ROOM_BOSSRUSH then
		if playingMainTrack and (room:IsAmbushActive() or room:IsAmbushDone()) then
			if not RoomIsDeleteThisNullSpecial() then
				playingMainTrack = false
				changeTrackVersion()
			end
		end
	end
end)

function PlayTaintedVersion(trackId)
	local playTaintedVersion = false
	if coopMixedSoundtrack and modSaveData["blendedcoopsoundtrack"] then
		playTaintedVersion = SeededCoopTaintedMix(trackId)
	else
		local player = Isaac.GetPlayer()
		playTaintedVersion = PlayerIsTainted(player)
	end
	return playTaintedVersion
end

function NormalOrTainted(trackId)
	if PlayTaintedVersion(trackId) then
		return TaintedVersion(trackId)
	else
		return trackId
	end
end

function custommusiccollection:PlayEpicDogmaPortrait(entity)
	if modSaveData["dogmafighttaintedmashup"] and PlayTaintedVersion(Music.MUSIC_DOGMA_BOSS) then
		local sprite = entity:GetSprite()
		local anim = sprite:GetAnimation()
		local frame = sprite:GetFrame()
		
		if anim == "Appear" and frame == 215 and not Game():GetHUD():IsVisible() then
			musicmgr:Play(Music.MUSIC_DOGMA_BOSS,0.3)
		end
	end
end
custommusiccollection:AddCallback(ModCallbacks.MC_NPC_UPDATE, custommusiccollection.PlayEpicDogmaPortrait, EntityType.ENTITY_DOGMA)

function custommusiccollection:PerformDarkHomeReplacement(trackId)
	if not Game():IsGreedMode() then
		local stage = GetEffectiveLevelStage()
		if stage == LevelStage.STAGE8 then
			local stage_type = GetEffectiveStageType()
			if stage_type == StageType.STAGETYPE_WOTL then
				if PlayTaintedVersion(Music.MUSIC_ISAACS_HOUSE) then
					if modSaveData["darkhometaintednauseous"] then
						return TaintedVersion(Music.MUSIC_DARK_CLOSET)
					else
						return Music.MUSIC_ISAACS_HOUSE
					end
				end
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDarkHomeReplacement, Music.MUSIC_ISAACS_HOUSE)

function custommusiccollection:PerformBlackMarketReplacement(trackId)
	if modSaveData["blackmarketroomtheme"] and not skiptainted[trackId] then
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		
		--TODO: implement these; might have to check for existence of Mother's Shadow
		--do NOT override Mirror World TODO (don't test, just code)
		--DO override Mineshaft Ambient
		--do NOT override Mineshaft Escape (6CYW-B2K1 this seed has a crawlspace in the mineshaft escape sequence) TODO
		--do NOT override Boss Over Twisted TODO
		--do NOT override Blue Womb
		--do NOT override Ascent
		
		local level = Game():GetLevel()
		local ascent = level:IsAscent()
		--local mineshaftescape = 
		local stage = GetEffectiveLevelStage()
		
		if not ascent and stage ~= LevelStage.STAGE4_3 then
			if roomtype == RoomType.ROOM_BLACK_MARKET then
				return NormalOrTainted(Music.MUSIC_BLACKMARKET_ROOM)
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBlackMarketReplacement)

function custommusiccollection:PerformIAmErrorReplacement(trackId)
	if modSaveData["iamerrorroomtheme"] and not skiptainted[trackId] then
		--DO override Mirror World
		--DO override Mineshaft Ambient
		--DO override Mineshaft Escape
		--DO override Boss Over Twisted
		--DO override Blue Womb
		--do NOT override Ascent
		
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		if roomtype == RoomType.ROOM_ERROR then
			local level = Game():GetLevel()
			local ascent = level:IsAscent()
			if not ascent then
				return NormalOrTainted(Music.MUSIC_I_AM_ERROR)
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformIAmErrorReplacement)

function custommusiccollection:PerformGenesisRoomReplacement(trackId)
	if modSaveData["genesisroomtheme"] and not skiptainted[trackId] then
		--DO override Mirror World
		--DO override Mineshaft Ambient
		--DO override Mineshaft Escape
		--DO override Boss Over Twisted
		--DO override Blue Womb
		--do NOT override Ascent
		
		local level = Game():GetLevel()
		if level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX then
			local ascent = level:IsAscent()
			if not ascent then
				if PlayTaintedVersion(Music.MUSIC_TITLE) then
					return Music.MUSIC_TITLE_AFTERBIRTH
				else
					return Music.MUSIC_TITLE
				end
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformGenesisRoomReplacement)

if StageAPI and StageAPI.Loaded then
	function custommusiccollection:PerformGenesisRoomReplacementForStageAPI(musicID, roomType, musicRNG)
		return custommusiccollection:PerformGenesisRoomReplacement(musicID)
	end
	
	local tpriority = 0
	StageAPI.AddCallback(custommusiccollection.Name, StageAPI.Enum.Callbacks.POST_SELECT_STAGE_MUSIC, tpriority, custommusiccollection.PerformGenesisRoomReplacementForStageAPI)
end

--this code is used to play the boss over jingle through entering the door to the Blue Womb exit room
local jingletimer = 0

local function InWombIIBossRoom()
	if not Game():IsGreedMode() then
		local stage = GetEffectiveLevelStage()
		local stagetype = GetEffectiveStageType()
		if stage == LevelStage.STAGE4_2 and stagetype < StageType.STAGETYPE_REPENTANCE then --Womb/Utero/Scarred Womb II
			local room = Game():GetRoom()
			if room:GetBossID() == 25 or room:GetBossID() == 8 then --It Lives or Mom's Heart
				return true
			end
		end
	end
	return false
end

local function InBlueWombExitRoom()
	local level = Game():GetLevel()
	if level:GetCurrentRoomIndex() == GridRooms.ROOM_BLUE_WOOM_IDX then
		return true
	end
	return false
end

function custommusiccollection:ProcessJingleTimer()
	if jingletimer > 0 then
		jingletimer = jingletimer - 1
		if jingletimer == 0 then
			musicmgr:Crossfade(Music.MUSIC_BOSS_OVER)
		end
	end
	if jingletimer < 0 then
		jingletimer = 0
	end
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, custommusiccollection.ProcessJingleTimer)

function custommusiccollection:ResetJingleTimer()
	if not InWombIIBossRoom() and not InBlueWombExitRoom() then
		jingletimer = 0
	end
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.ResetJingleTimer)

function custommusiccollection:PerformBlueWombJingleSet(trackId)
	if InWombIIBossRoom() then
	
		local jinglelength = 0
		if PlayTaintedVersion(trackId) then
			jinglelength = taintedjinglelength[trackId]
		elseif trackId == Music.MUSIC_JINGLE_BOSS_OVER then
			jinglelength = 370
		elseif trackId == Music.MUSIC_JINGLE_BOSS_OVER2 then
			jinglelength = 242
		end
		
		jingletimer = jinglelength
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBlueWombJingleSet, Music.MUSIC_JINGLE_BOSS_OVER, Music.MUSIC_JINGLE_BOSS_OVER2)

function custommusiccollection:PerformBlueWombExitMusic(trackId)
	if InBlueWombExitRoom() then
		if jingletimer > 0 then
			return MusicCancelValue()
		else
			return NormalOrTainted(Music.MUSIC_BOSS_OVER)
		end
	elseif InWombIIBossRoom() then
		if jingletimer > 0 then
			return MusicCancelValue()
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBlueWombExitMusic, Music.MUSIC_WOMB_UTERO, Music.MUSIC_UTERO, Music.MUSIC_SCARRED_WOMB, Music.MUSIC_BOSS_OVER)

function custommusiccollection:PerformDeliriumOver(trackId)
	if not Game():IsGreedMode() then
		local stage = GetEffectiveLevelStage()
		if stage == LevelStage.STAGE7 then
			local room = Game():GetRoom()
			if room:GetBossID() == 70 then
				return NormalOrTainted(Music.MUSIC_JINGLE_DELIRIUM_OVER)
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeliriumOver, Music.MUSIC_JINGLE_BOSS_OVER, Music.MUSIC_JINGLE_BOSS_OVER2)

function custommusiccollection:PerformHushOver(trackId)
	if GetEffectiveLevelStage() == LevelStage.STAGE4_3 then
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		if roomtype == RoomType.ROOM_BOSS then
			return NormalOrTainted(Music.MUSIC_JINGLE_HUSH_OVER)
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformHushOver, Music.MUSIC_JINGLE_BOSS_OVER, Music.MUSIC_JINGLE_BOSS_OVER2)

if usingRGON then
	function custommusiccollection:PerformMotherOver(trackId)
		local level = Game():GetLevel()
		local stage = GetEffectiveLevelStage()
		local stage_type = GetEffectiveStageType()
		
		--TODO: the Mother over jingle is not working in Mortis... maybe it's related to the "hacky solution" in the PerformMainTrackReplacement function
		
		local curseoflabyrinth = (level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH) == LevelCurse.CURSE_OF_LABYRINTH
		
		if ((stage == LevelStage.STAGE4_2 or (curseoflabyrinth and stage == LevelStage.STAGE4_1)) and stage_type >= StageType.STAGETYPE_REPENTANCE) then
			local room = Game():GetRoom()
			local roomtype = room:GetType()
			if roomtype == RoomType.ROOM_BOSS then
				return NormalOrTainted(Music.MUSIC_JINGLE_MOTHER_OVER)
			end
		end
	end
	custommusiccollection:CreateCallback(custommusiccollection.PerformMotherOver, Music.MUSIC_JINGLE_BOSS_OVER3)
end

function custommusiccollection:PerformMegaSatanReplacement(trackId)
	if not Game():IsGreedMode() then
		local stage = GetEffectiveLevelStage()
		if stage == LevelStage.STAGE6 then
			if PlayTaintedVersion(Music.MUSIC_MEGASATAN_BOSS) and not modSaveData["megasatantaintedspeedup"] then
				return Isaac.GetMusicIdByName("Mega Satan (tainted, vanilla)")
			else
				return NormalOrTainted(Music.MUSIC_MEGASATAN_BOSS)
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformMegaSatanReplacement, Music.MUSIC_SATAN_BOSS)

--enable Sacris Cathedral layer
custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if modSaveData["cathedralsacris"] then
		local currentMusicID = musicmgr:GetCurrentMusicID()
		if currentMusicID == Music.MUSIC_CATHEDRAL_ALT then
			if not musicmgr:IsLayerEnabled(1) then
				local room = Game():GetRoom()
				if Isaac.CountBosses() > 0 and room:GetFrameCount() < 20 then
					musicmgr:EnableLayer(1)
				end
			end
		end
	end
end)

--disable Sacris Cathedral layer
custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if modSaveData["cathedralsacris"] then
		local currentMusicID = musicmgr:GetCurrentMusicID()
		if currentMusicID == Music.MUSIC_CATHEDRAL_ALT then
			if musicmgr:IsLayerEnabled(1) then
				local room = Game():GetRoom()
				if room:IsClear() then
					musicmgr:DisableLayer(1)
				end
			end
		end
	end
end)

--in DELETE THIS, only play Dark Home layer in larger rooms
custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if modSaveData["deletethisenhancement"] and Isaac.GetChallenge() == Challenge.CHALLENGE_DELETE_THIS then
		local room = Game():GetRoom()
		if room:GetFrameCount() < 20 then
		
			local seeds = Game():GetSeeds()
			local stage = GetEffectiveLevelStage()
			local stageseed = seeds:GetStageSeed(stage)
			randomStageMusic = getRandomStageMusic(stageseed)
			
			if randomStageMusic == Music.MUSIC_ISAACS_HOUSE then
				if musicmgr:IsLayerEnabled() then
					local roomshape = room:GetRoomShape()
					
					if roomshape < RoomShape.ROOMSHAPE_2x2 then --play Dark Home layer only for 2x2 rooms and L-shaped rooms
						musicmgr:DisableLayer() --we don't need to re-enable on new room
					end
				end
			end
		end
	end
end)

--TODO: in DELETE THIS, play non-tainted Ascent layer music based on what floor we're on?

custommusiccollection:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(_, entity)
    if modSaveData["ultragreediertheme"] and entity.Variant == 1 then
		local currentMusicID = musicmgr:GetCurrentMusicID()
		if currentMusicID == Music.MUSIC_ULTRAGREED_BOSS or currentMusicID == TaintedVersion(Music.MUSIC_ULTRAGREED_BOSS) then
			musicmgr:Crossfade(Music.MUSIC_ULTRAGREEDIER_BOSS)
			musicmgr:UpdateVolume()
		end
    end
end, EntityType.ENTITY_ULTRA_GREED)

local function GrabBossTrack()
	if usingRGON then
		local room = Game():GetRoom()
		local boss_id = room:GetBossID()
		
		if boss_id == 6 then
			return Music.MUSIC_MOM_BOSS
		elseif boss_id == 8 then
			return Music.MUSIC_MOMS_HEART_BOSS
		elseif boss_id == 25 then
			return Music.MUSIC_MOMS_HEART_BOSS
		elseif boss_id == 24 then
			return Music.MUSIC_DEVIL_ROOM
		elseif boss_id == 39 then
			return Music.MUSIC_ISAAC_BOSS
		elseif boss_id == 40 then
			return Music.MUSIC_BLUEBABY_BOSS
		elseif boss_id == 54 then
			return Music.MUSIC_DARKROOM_BOSS
		elseif boss_id == 55 then
			return Music.MUSIC_DEVIL_ROOM
		elseif boss_id == 62 then
			return Music.MUSIC_ULTRAGREED_BOSS
		elseif boss_id == 63 then
			return Music.MUSIC_BLUEBABY_BOSS
		elseif boss_id == 70 then
			return Music.MUSIC_VOID_BOSS
		elseif boss_id == 88 then
			return Music.MUSIC_MOTHER_BOSS
		end
		
		return getGenericBossMusic()
	elseif MMC then
		return MMC.GetBossTrack()
	end
end

function custommusiccollection:PerformBossPortraitBossMusic(trackId)
	local level = Game():GetLevel()
	local stage = GetEffectiveLevelStage()
	local stage_type = GetEffectiveStageType()
	local room = Game():GetRoom()
	local curseoflabyrinth = (level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH) == LevelCurse.CURSE_OF_LABYRINTH
	
	--go straight into boss theme during VS portrait
	if ((stage == LevelStage.STAGE4_2 or (curseoflabyrinth and stage == LevelStage.STAGE4_1)) and stage_type >= StageType.STAGETYPE_REPENTANCE) --Mother
	or (Isaac.GetChallenge() == Challenge.CHALLENGE_RED_REDEMPTION and stage == LevelStage.STAGE4_1) --Mother in Red Redemption challenge
	or (stage == LevelStage.STAGE5 and stage_type == StageType.STAGETYPE_WOTL) --Isaac in Cathedral
	or (stage == LevelStage.STAGE7 and (room:GetBossID() == 39 or room:GetBossID() == 70)) --Delirium and Isaac in Void
	or (stage == LevelStage.STAGE7_GREED and Game():IsGreedMode()) --Ultra Greed
	then
		local bosstrack = GrabBossTrack()
		if PlayTaintedVersion(bosstrack) then
			return normaltotainted[bosstrack]
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBossPortraitBossMusic, Music.MUSIC_JINGLE_BOSS)

function custommusiccollection:PerformAngelFightReplacement(trackId)
	if modSaveData["angelfighttheme"] then
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		if roomtype == RoomType.ROOM_ANGEL or roomtype == RoomType.ROOM_SACRIFICE or roomtype == RoomType.ROOM_SUPERSECRET then
			return NormalOrTainted(Music.MUSIC_ANGEL_BOSS)
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformAngelFightReplacement, Music.MUSIC_BOSS, Music.MUSIC_BOSS2, Music.MUSIC_BOSS3)

function custommusiccollection:PerformAngelOverReplacement(trackId)
	if modSaveData["angelfighttheme"] then
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		if roomtype == RoomType.ROOM_ANGEL or roomtype == RoomType.ROOM_SACRIFICE or roomtype == RoomType.ROOM_SUPERSECRET then
			return NormalOrTainted(Music.MUSIC_JINGLE_ANGEL_OVER)
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformAngelOverReplacement, Music.MUSIC_JINGLE_BOSS_OVER, Music.MUSIC_JINGLE_BOSS_OVER2, Music.MUSIC_JINGLE_BOSS_OVER3)

function custommusiccollection:PerformDevilWaveGreedReplacement(trackId)
	if modSaveData["devilwavegreedambush"] and Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_CHALLENGE_FIGHT)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDevilWaveGreedReplacement, Music.MUSIC_SATAN_BOSS)

local ultragreedalivebossroom = false
function custommusiccollection:CheckUltraGreedAliveBossRoom()
	if Game():IsGreedMode() then
		ultragreedalivebossroom = false
		if GetEffectiveLevelStage() == LevelStage.STAGE7_GREED then
			local room = Game():GetRoom()
			local roomtype = room:GetType()
			if roomtype == RoomType.ROOM_BOSS and room:GetBossID() == 62 then
				if Isaac.CountBosses() > 0 then
					ultragreedalivebossroom = true
				end
			end
		end
	end
end
custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.CheckUltraGreedAliveBossRoom)

function custommusiccollection:PerformUltraGreedierOver(trackId)
	if Game():IsGreedMode() and ultragreedalivebossroom and modSaveData["ultragreediertheme"] then
		local room = Game():GetRoom()
		if room:GetBossID() == 62 then
			if Game().Difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if modSaveData["postbossgreedspiritum"] then
					return NormalOrTainted(Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER), NormalOrTainted(Music.MUSIC_BOSS_OVER_GREED)
				else
					return NormalOrTainted(Music.MUSIC_JINGLE_ULTRAGREEDIER_OVER), NormalOrTainted(Music.MUSIC_BOSS_OVER)
				end
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformUltraGreedierOver, Music.MUSIC_BOSS_OVER)

function custommusiccollection:PerformBossOverGreedReplacement(trackId)
	if modSaveData["postbossgreedspiritum"] and Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_BOSS_OVER_GREED)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBossOverGreedReplacement, Music.MUSIC_BOSS_OVER)

function custommusiccollection:PerformShopRoomReplacement(trackId)
	local game = Game()
	local stage = GetEffectiveLevelStage()
	
	if game:IsGreedMode() then
		if modSaveData["lateshoproomtheme"] and (stage == LevelStage.STAGE4_GREED or stage == LevelStage.STAGE5_GREED) then
			return NormalOrTainted(Music.MUSIC_SHOP_ROOM_ALT)
		elseif modSaveData["shopfloorgreedtheme"] and stage == LevelStage.STAGE6_GREED then
			return NormalOrTainted(Music.MUSIC_FLOOR_6_GREED)
		end
	else
		if modSaveData["lateshoproomtheme"] and stage > LevelStage.STAGE3_2 then
			return NormalOrTainted(Music.MUSIC_SHOP_ROOM_ALT)
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformShopRoomReplacement, Music.MUSIC_SHOP_ROOM)

function custommusiccollection:PerformGreedShopChallengeCancel(trackId)
	if modSaveData["shopfloorgreedtheme"] and Game():IsGreedMode() then
		local room = Game():GetRoom()
		local roomtype = room:GetType()
		if roomtype ~= RoomType.ROOM_DEVIL then
			return MusicCancelValue()
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformGreedShopChallengeCancel, Music.MUSIC_CHALLENGE_FIGHT, Music.MUSIC_JINGLE_CHALLENGE_OUTRO)

function custommusiccollection:PerformBlueWombAltReplacement(trackId)
	if modSaveData["bluewombdevoid"] and not PlayTaintedVersion(trackId) then
		if Game():GetStateFlag(GameStateFlag.STATE_BLUEWOMB_DONE) then
			return Music.MUSIC_BLUE_WOMB_ALT
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBlueWombAltReplacement, Music.MUSIC_BLUE_WOMB)

function custommusiccollection:PerformDepthsGreedReplacement(trackId)
	if modSaveData["depthsgreeddepressoloco"] and Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_DEPTHS_GREED)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDepthsGreedReplacement, Music.MUSIC_DEPTHS)

function custommusiccollection:PerformCatacombsGreedReplacement(trackId)
	if modSaveData["catacombsgreedregeneratione"] and Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_CATACOMBS_GREED)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformCatacombsGreedReplacement, Music.MUSIC_CATACOMBS)

function custommusiccollection:PerformUteroGreedReplacement(trackId)
	if modSaveData["uterogreedviscera"] and Game():IsGreedMode() and not PlayTaintedVersion(Music.MUSIC_UTERO) then
		return NormalOrTainted(Music.MUSIC_UTERO_GREED)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformUteroGreedReplacement, Music.MUSIC_UTERO)

function custommusiccollection:PerformSheolGreedReplacement(trackId)
	if modSaveData["sheolgreedinfernum"] and Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_SHEOL_GREED)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformSheolGreedReplacement, Music.MUSIC_SHEOL)

function custommusiccollection:PerformDevilRoomReplacement(trackId)
	if modSaveData["latedevilroomtheme"] then
		local game = Game()
		local stage = GetEffectiveLevelStage()
		local room = game:GetRoom()
		
		if room:GetType() == RoomType.ROOM_DEVIL then
			if game:IsGreedMode() then
				if stage > LevelStage.STAGE4_GREED then
					return NormalOrTainted(Music.MUSIC_DEVIL_ROOM_ALT)
				end
			else
				if stage > LevelStage.STAGE4_2 then
					return NormalOrTainted(Music.MUSIC_DEVIL_ROOM_ALT)
				end
			end
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDevilRoomReplacement, Music.MUSIC_DEVIL_ROOM)

function custommusiccollection:PerformSatanBossReplacement(trackId)
	if modSaveData["satanfightsatan666"] and not Game():IsGreedMode() then
		local stage = GetEffectiveLevelStage()
		if stage == LevelStage.STAGE5 or stage == LevelStage.STAGE7 then
			return NormalOrTainted(Music.MUSIC_SATAN_BOSS_ALT)
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformSatanBossReplacement, Music.MUSIC_SATAN_BOSS)

function custommusiccollection:PerformCathedralReplacement(trackId)
	if not PlayTaintedVersion(Music.MUSIC_CATHEDRAL) then
		return Music.MUSIC_CATHEDRAL_ALT
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformCathedralReplacement, Music.MUSIC_CATHEDRAL)

--play the original Dark Room music
function custommusiccollection:PerformDarkRoomReversion(trackId)
	if not modSaveData["darkroomdescensum"] and not PlayTaintedVersion(Music.MUSIC_DARK_ROOM) then
		return Music.MUSIC_BLUE_WOMB
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDarkRoomReversion, Music.MUSIC_DARK_ROOM)

--play the original Blue Womb music
function custommusiccollection:PerformBlueWombReversion(trackId)
	if not modSaveData["bluewombdevoid"] and not PlayTaintedVersion(Music.MUSIC_BLUE_WOMB) then
		return Music.MUSIC_WOMB_UTERO
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBlueWombReversion, Music.MUSIC_BLUE_WOMB)

--play the original Womb music
function custommusiccollection:PerformWombReversion(trackId)
	if not modSaveData["wombnativitate"] and not PlayTaintedVersion(Music.MUSIC_WOMB_UTERO) then
		return Music.MUSIC_UTERO_GREED
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformWombReversion, Music.MUSIC_WOMB_UTERO)

function custommusiccollection:PerformUteroReversion(trackId)
	if not modSaveData["uterotaintedtsunami"] and PlayTaintedVersion(Music.MUSIC_UTERO) then
		return TaintedVersion(Music.MUSIC_WOMB_UTERO)
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformUteroReversion, Music.MUSIC_UTERO)

function custommusiccollection:PerformDrossReversion(trackId)
	if PlayTaintedVersion(trackId) then
		if modSaveData["drosstainted"] == 1 then
			return TaintedVersion(Music.MUSIC_DOWNPOUR)
		elseif modSaveData["drosstainted"] == 0 then
			return trackId
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDrossReversion, Music.MUSIC_DROSS)

function custommusiccollection:PerformDrossReverseReversion(trackId)
	if PlayTaintedVersion(trackId) then
		if modSaveData["drosstainted"] == 1 then
			return TaintedVersion(Music.MUSIC_DOWNPOUR_REVERSE)
		elseif modSaveData["drosstainted"] == 0 then
			return trackId
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDrossReverseReversion, Music.MUSIC_DROSS_REVERSE)

function custommusiccollection:PerformAshpitReversion(trackId)
	if PlayTaintedVersion(trackId) then
		if modSaveData["ashpittainted"] == 1 then
			return TaintedVersion(Music.MUSIC_MINES)
		elseif modSaveData["ashpittainted"] == 0 then
			return trackId
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformAshpitReversion, Music.MUSIC_ASHPIT)

function custommusiccollection:PerformGehennaReversion(trackId)
	if PlayTaintedVersion(trackId) then
		if modSaveData["gehennatainted"] == 1 then
			return TaintedVersion(Music.MUSIC_MAUSOLEUM)
		elseif modSaveData["gehennatainted"] == 0 then
			return trackId
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformGehennaReversion, Music.MUSIC_GEHENNA)

if usingRGON and StageAPI and StageAPI.Loaded then
	function custommusiccollection:PerformMortisReversion(trackId)
		if PlayTaintedVersion(trackId) then
			if modSaveData["mortistainted"] == 1 then
				return TaintedVersion(Music.MUSIC_CORPSE)
			elseif modSaveData["mortistainted"] == 0 then
				return trackId
			end
		end
	end
	--callback created post mods loading
	
	function custommusiccollection:PlayCorrectMortisStageMusicForStageAPI(musicID, roomType, musicRNG)
		if musicID == Music.MUSIC_MORTIS and PlayTaintedVersion(musicID) then
			if modSaveData["mortistainted"] == 2 then
				return TaintedVersion(musicID)
			else
				return custommusiccollection:PerformMortisReversion(musicID)
			end
		end
	end
	local tpriority = 0
	StageAPI.AddCallback(custommusiccollection.Name, StageAPI.Enum.Callbacks.POST_SELECT_STAGE_MUSIC, tpriority, custommusiccollection.PlayCorrectMortisStageMusicForStageAPI)
end

function custommusiccollection:PerformAscentReversion(trackId)
	if not modSaveData["ascenttainteddescent"] and PlayTaintedVersion(trackId) then
		return trackId
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformAscentReversion, Music.MUSIC_REVERSE_GENESIS)

function custommusiccollection:PerformHomeReversion(trackId)
	if not modSaveData["hometaintedintro"] and PlayTaintedVersion(trackId) then
		return trackId
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformHomeReversion, Music.MUSIC_ISAACS_HOUSE)

function custommusiccollection:PerformDeathCertificateReplacement(trackId)
	if PlayTaintedVersion(trackId) then
		if modSaveData["deathcertificatedescenttwisted"] then
			return Isaac.GetMusicIdByName("Descent Twisted") --TODO: use this as Music.DESCENT_TWISTED or something...
		else
			return Music.MUSIC_DARK_CLOSET
		end
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDeathCertificateReplacement, Music.MUSIC_DARK_CLOSET)

function custommusiccollection:ShouldPlayTwistedJingle()
	local room = Game():GetRoom()
	local backdrop = room:GetBackdropType()
	if backdrop == BackdropType.DARK_CLOSET and musicmgr:GetCurrentMusicID() == Isaac.GetMusicIdByName("Descent Twisted") then
		return true
	end
	return false
end

if usingRGON then
	function custommusiccollection:PlayTaintedDeathCertificateJingleRGON(id, volume, frameDelay, loop, pitch, pan)
		if custommusiccollection:ShouldPlayTwistedJingle() then
			musicmgr:VolumeSlide(0.1, 0.05)
			return {Isaac.GetSoundIdByName("Descent Twisted Jingle"), volume, frameDelay, loop, pitch, pan}
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_SFX_PLAY, custommusiccollection.PlayTaintedDeathCertificateJingleRGON, SoundEffect.SOUND_CHOIR_UNLOCK)
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_SFX_PLAY, custommusiccollection.PlayTaintedDeathCertificateJingleRGON, SoundEffect.SOUND_1UP)
else
	function custommusiccollection:PlayTaintedDeathCertificateJingle()
		if custommusiccollection:ShouldPlayTwistedJingle() then
			if sound:IsPlaying(SoundEffect.SOUND_CHOIR_UNLOCK)
			or sound:IsPlaying(SoundEffect.SOUND_1UP) then
				sound:Stop(SoundEffect.SOUND_CHOIR_UNLOCK)
				sound:Stop(SoundEffect.SOUND_1UP)
				musicmgr:VolumeSlide(0.1, 0.05)
				sound:Play(Isaac.GetSoundIdByName("Descent Twisted Jingle"),1,0,false,1)
			end
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, custommusiccollection.PlayTaintedDeathCertificateJingle)
end
	

--play vanilla Baleful Circus
function custommusiccollection:PerformBossRushReversion(trackId)
	if not modSaveData["bossrushtaintedspeedup"] and PlayTaintedVersion(Music.MUSIC_BOSS_RUSH) then
		return Isaac.GetMusicIdByName("Boss Rush (tainted, vanilla)")
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBossRushReversion, Music.MUSIC_BOSS_RUSH)

function custommusiccollection:PerformDogmaBossReversion(trackId)
	if not modSaveData["dogmafighttaintedmashup"] and PlayTaintedVersion(trackId) then
		return trackId
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformDogmaBossReversion, Music.MUSIC_DOGMA_BOSS)

function custommusiccollection:PerformBeastBossReversion(trackId)
	if not modSaveData["beastfighttaintedapocalypse"] and PlayTaintedVersion(trackId) then
		return trackId
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformBeastBossReversion, Music.MUSIC_BEAST_BOSS)

function custommusiccollection:PerformMineshaftAmbientReversion(trackId)
	if not modSaveData["mineshaftambienttaintednaught"] and PlayTaintedVersion(trackId) then
		return trackId
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformMineshaftAmbientReversion, Music.MUSIC_MINESHAFT_AMBIENT)

function custommusiccollection:PerformMineshaftEscapeReversion(trackId)
	if not modSaveData["mineshaftescapetaintedturn"] and PlayTaintedVersion(trackId) then
		return trackId
	end
end
custommusiccollection:CreateCallback(custommusiccollection.PerformMineshaftEscapeReversion, Music.MUSIC_MINESHAFT_ESCAPE)

--[[MMC.AddMusicCallback(custommusiccollection, function()
	if Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_CAVES_GREED)
	end
end, Music.MUSIC_CAVES)

MMC.AddMusicCallback(custommusiccollection, function()
	if Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_FLOODED_CAVES_GREED)
	end
end, Music.MUSIC_FLOODED_CAVES)

MMC.AddMusicCallback(custommusiccollection, function()
	if Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_NECROPOLIS_GREED)
	end
end, Music.MUSIC_NECROPOLIS)

MMC.AddMusicCallback(custommusiccollection, function()
	if Game():IsGreedMode() then
		return NormalOrTainted(Music.MUSIC_DANK_DEPTHS_GREED)
	end
end, Music.MUSIC_DANK_DEPTHS)--]]

if usingRGON then
	--will be called post mods loaded
	function custommusiccollection:CheckForCustomStageMusic()
		if StageAPI and StageAPI.Loaded and LastJudgement then
			Music.MUSIC_MORTIS = LastJudgement.Music.Mortis
			
			normaltotainted[Music.MUSIC_MORTIS] = Isaac.GetMusicIdByName("Mortis (tainted)")
			normaltotaintedalt1[Music.MUSIC_MORTIS] = Isaac.GetMusicIdByName("Mortis (tainted) altloop")
			normaltotaintedalt2[Music.MUSIC_MORTIS] = Isaac.GetMusicIdByName("Mortis (tainted) altloop 2")
			--random_music --TODO: add Mortis music to DELETE THIS? I'm not sure I will, not without mixing in the Mortis backdrops into DELETE THIS
			stageSeedTrack[Music.MUSIC_MORTIS] = 1
			
			custommusiccollection:CreateCallback(custommusiccollection.PerformMortisReversion, Music.MUSIC_MORTIS)
		end
	end
end

function custommusiccollection:PerformMainTrackReplacement(trackId)
	
	--TODO: move this block to its own function
	if StageAPI and StageAPI.Loaded and StageAPI.CurrentStage and StageAPI.InNewStage() then
		--hacky solution: play boss over jingle 3 for Mortis
		--TODO: figure out a better way to do this... maybe set boss music for custom stage api in HandleStageAPI() ?
		if GetEffectiveStageType() >= StageType.STAGETYPE_REPENTANCE then
			if trackId == Music.MUSIC_JINGLE_BOSS_OVER or trackId == Music.MUSIC_JINGLE_BOSS_OVER2 then
				return NormalOrTainted(Music.MUSIC_JINGLE_BOSS_OVER3)
			end
		end
	end
	
	
	if trackId > 0 and not skiptainted[trackId] then
		--NOTE: this mod will not allow other mods that are later in the load order to handle music callbacks
		--if we want to change this, check for trackToReturn ~= trackId before returning trackToReturn
		if usingRGON then
			local returnTrack = NormalOrTainted(trackId)
			if returnTrack == musicmgr:GetCurrentMusicID() then
				return MusicCancelValue()
			else
				return returnTrack
			end
		else
			return NormalOrTainted(trackId)
		end
	end
end
if usingRGON then
	function custommusiccollection:PerformMainTrackReplacementPostLoad()
		custommusiccollection:CheckForCustomStageMusic()
		custommusiccollection:CreateCallback(custommusiccollection.PerformMainTrackReplacement)
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, custommusiccollection.PerformMainTrackReplacementPostLoad)
else
	custommusiccollection:CreateCallback(custommusiccollection.PerformMainTrackReplacement)
end

if usingRGON then
	function custommusiccollection:PerformMainJingleReplacement(trackId)
		if trackId > 0 then
			local returnTrack = NormalOrTainted(trackId)
			return returnTrack
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_MUSIC_PLAY_JINGLE, custommusiccollection.PerformMainJingleReplacement)
end

--TODO: treasure room jingle room transition volume issue
--NOTE: I discovered that the room transition volume issues pop up when Crossfade/Play is called upon New Room
--I think this is an issue with Repentogon and not something I need to correct in this mod

--TODO: test Custom Stage API when MMC is on

if usingRGON then
	cdmLastMusicID = 0
	
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function()
		cdmLastMusicID = 0
	end)
	
	function custommusiccollection:CheckDifferentMusic()
		--NOTE: MC_PRE_MUSIC_PLAY does not trigger on new room when the vanilla music is already playing
		--make up for the base game triggering fewer music play callbacks on new rooms than MMC does
		--create music callbacks when the main track keeps playing in a new room
		
		local level = Game():GetLevel()
		local ascent = level:IsAscent()
		local room = Game():GetRoom()
		local backdrop = room:GetBackdropType()
		local roomtype = room:GetType()
		
		if ascent then
			if modSaveData["ascenttainteddescent"] and cdmLastMusicID == Music.MUSIC_REVERSE_GENESIS and PlayTaintedVersion(Music.MUSIC_REVERSE_GENESIS) then
				musicmgr:Crossfade(cdmLastMusicID)
			end
		elseif backdrop == BackdropType.DARK_CLOSET then --death certificate rooms
			if modSaveData["deathcertificatedescenttwisted"] and cdmLastMusicID == Music.MUSIC_DARK_CLOSET and PlayTaintedVersion(Music.MUSIC_DARK_CLOSET) then
				musicmgr:Crossfade(cdmLastMusicID)
			end
		elseif room:HasCurseMist() and not level:GetStateFlag(LevelStateFlag.STATE_MINESHAFT_ESCAPE) then --Mineshaft Ambient
			if modSaveData["mineshaftambienttaintednaught"] and cdmLastMusicID == Music.MUSIC_MINESHAFT_AMBIENT and PlayTaintedVersion(Music.MUSIC_MINESHAFT_AMBIENT) then
				musicmgr:Crossfade(cdmLastMusicID)
			end
		elseif roomtype == RoomType.ROOM_BLACK_MARKET and GetEffectiveLevelStage() ~= LevelStage.STAGE4_3 then
			if modSaveData["blackmarketroomtheme"] then
				musicmgr:Crossfade(NormalOrTainted(Music.MUSIC_BLACKMARKET_ROOM))
			end
		elseif roomtype == RoomType.ROOM_ERROR then
			if modSaveData["iamerrorroomtheme"] then
				musicmgr:Crossfade(NormalOrTainted(Music.MUSIC_I_AM_ERROR))
			end
		elseif level:GetCurrentRoomIndex() == GridRooms.ROOM_GENESIS_IDX then
			if modSaveData["genesisroomtheme"] then
				if PlayTaintedVersion(Music.MUSIC_TITLE) then
					musicmgr:Crossfade(Music.MUSIC_TITLE_AFTERBIRTH)
				else
					musicmgr:Crossfade(Music.MUSIC_TITLE)
				end
			end
		else
			--normal floor music
			local stage = GetEffectiveLevelStage()
			local stage_type = GetEffectiveStageType()
			
			if StageAPI and StageAPI.Loaded and StageAPI.CurrentStage and StageAPI.InNewStage() then
				local curMusic = musicmgr:GetCurrentMusicID()
				if not StageAPI.CanOverrideMusic(curMusic) then
					local stageApiMusic = StageAPI.GetCurrentStage():GetPlayingMusic()
					musicmgr:Crossfade(stageApiMusic)
				end
			elseif Game():IsGreedMode() then
				if stage == LevelStage.STAGE6_GREED then
					if modSaveData["shopfloorgreedtheme"] and cdmLastMusicID == Music.MUSIC_SHOP_ROOM then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE5_GREED and stage_type == StageType.STAGETYPE_ORIGINAL then
					if modSaveData["sheolgreedinfernum"] and cdmLastMusicID == Music.MUSIC_SHEOL then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE4_GREED and stage_type == StageType.STAGETYPE_ORIGINAL then
					if not modSaveData["wombnativitate"] and cdmLastMusicID == Music.MUSIC_WOMB_UTERO then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE4_GREED and stage_type == StageType.STAGETYPE_WOTL then
					if modSaveData["uterogreedviscera"] and cdmLastMusicID == Music.MUSIC_UTERO then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE3_GREED and stage_type == StageType.STAGETYPE_ORIGINAL then
					if modSaveData["depthsgreeddepressoloco"] and cdmLastMusicID == Music.MUSIC_DEPTHS then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE2_GREED and stage_type == StageType.STAGETYPE_WOTL then
					if modSaveData["catacombsgreedregeneratione"] and cdmLastMusicID == Music.MUSIC_CATACOMBS then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				end
			else
				if stage == LevelStage.STAGE8 and stage_type == StageType.STAGETYPE_ORIGINAL then
					if modSaveData["hometaintedintro"] and cdmLastMusicID == Music.MUSIC_ISAACS_HOUSE and PlayTaintedVersion(Music.MUSIC_ISAACS_HOUSE) then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE8 and stage_type == StageType.STAGETYPE_WOTL then
					if modSaveData["darkhometaintednauseous"] and cdmLastMusicID == Music.MUSIC_ISAACS_HOUSE and PlayTaintedVersion(Music.MUSIC_ISAACS_HOUSE) then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE6 and stage_type == StageType.STAGETYPE_ORIGINAL then
					if not modSaveData["darkroomdescensum"] and cdmLastMusicID == Music.MUSIC_DARK_ROOM then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif stage == LevelStage.STAGE4_3 then
					if not modSaveData["bluewombdevoid"] and cdmLastMusicID == Music.MUSIC_BLUE_WOMB then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif (stage == LevelStage.STAGE4_1 or stage == LevelStage.STAGE4_2) and stage_type == StageType.STAGETYPE_ORIGINAL then
					if not modSaveData["wombnativitate"] and cdmLastMusicID == Music.MUSIC_WOMB_UTERO then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif (stage == LevelStage.STAGE3_1 or stage == LevelStage.STAGE3_2) and stage_type == StageType.STAGETYPE_REPENTANCE_B then
					if modSaveData["gehennatainted"] > 0 and cdmLastMusicID == Music.MUSIC_GEHENNA and PlayTaintedVersion(Music.MUSIC_GEHENNA) then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif (stage == LevelStage.STAGE2_1 or stage == LevelStage.STAGE2_2) and stage_type == StageType.STAGETYPE_REPENTANCE_B then
					if modSaveData["ashpittainted"] > 0 and cdmLastMusicID == Music.MUSIC_ASHPIT and PlayTaintedVersion(Music.MUSIC_ASHPIT) then
						musicmgr:Crossfade(cdmLastMusicID)
					end
				elseif (stage == LevelStage.STAGE1_1 or stage == LevelStage.STAGE1_2) and stage_type == StageType.STAGETYPE_REPENTANCE_B then
					if room:IsMirrorWorld() then
						if modSaveData["drosstainted"] > 0 and cdmLastMusicID == Music.MUSIC_DROSS_REVERSE and PlayTaintedVersion(Music.MUSIC_DROSS_REVERSE) then
							musicmgr:Crossfade(cdmLastMusicID)
						end
					else
						if modSaveData["drosstainted"] > 0 and cdmLastMusicID == Music.MUSIC_DROSS and PlayTaintedVersion(Music.MUSIC_DROSS) then
							musicmgr:Crossfade(cdmLastMusicID)
						end
					end
				end
			end
		end
		
		
		cdmLastMusicID = musicmgr:GetCurrentMusicID()
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.CheckDifferentMusic)
	
	--handle Greed Mode weirdness
	local roomclearbefore = false
	local previousgreedwave = 0
	
	function custommusiccollection:SetRoomIsClear()
		roomclearbefore = Game():GetRoom():IsClear()
		previousgreedwave = 0
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, custommusiccollection.SetRoomIsClear)
	
	function custommusiccollection:SetValuesOnExit()
		roomclearbefore = false
		previousgreedwave = 0
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, custommusiccollection.SetValuesOnExit)
	
	function custommusiccollection:HandleGreedModeCases()
		local room = Game():GetRoom()
		local roomclearnow = room:IsClear()
		local level = Game():GetLevel()
		if Game():IsGreedMode() then
			local bossMusic
			local bossOverJingle
			
			local roomdesc = level:GetCurrentRoomDesc()
			local roomdescflags = roomdesc.Flags
			if (roomdescflags & RoomDescriptor.FLAG_ALT_BOSS_MUSIC) == 0 then
				bossMusic = Music.MUSIC_BOSS
				bossOverJingle = Music.MUSIC_JINGLE_BOSS_OVER
			else
				bossMusic = Music.MUSIC_BOSS2
				bossOverJingle = Music.MUSIC_JINGLE_BOSS_OVER2
			end
			
			local currentgreedwave = level.GreedModeWave
			local totalWaves
			
			if Game().Difficulty == Difficulty.DIFFICULTY_GREEDIER then
				totalWaves = 12
			else
				totalWaves = 11
			end
			
			if room:GetType() == RoomType.ROOM_DEFAULT then
				if GetEffectiveLevelStage() == LevelStage.STAGE6_GREED and not modSaveData["shopfloorgreedtheme"] then
					if currentgreedwave < (totalWaves - 2) then
						if roomclearnow and not roomclearbefore then
							--do this for tainted Characters
							--is the tainted challenge music the culprit, or the tainted shop music the culprit? Just do for both for now
							if PlayTaintedVersion(Music.MUSIC_CHALLENGE_FIGHT) or PlayTaintedVersion(Music.MUSIC_SHOP_ROOM) then
								musicmgr:Crossfade(Music.MUSIC_JINGLE_CHALLENGE_OUTRO)
								musicmgr:Queue(Music.MUSIC_SHOP_ROOM)
							end
						end
					end
				end
				
				if roomclearnow and not roomclearbefore then
					if currentgreedwave == (totalWaves - 2) or currentgreedwave == (totalWaves - 1) then
						--do this for tainted Characters
						--is the tainted boss music the culprit, or the tainted boss over music the culprit? Just do for both for now
						if PlayTaintedVersion(bossMusic) or PlayTaintedVersion(Music.MUSIC_BOSS_OVER) then
							musicmgr:Crossfade(bossOverJingle)
							musicmgr:Queue(Music.MUSIC_BOSS_OVER)
						end
					elseif currentgreedwave == totalWaves then
						--do for tainted characters no matter what
						--do for non-tainted characters only if greed mode devil wave challenge music is on
						--Challenge fight and Satan fight have the same value for room seed track
						if modSaveData["devilwavegreedambush"] or PlayTaintedVersion(Music.MUSIC_SATAN_BOSS) or PlayTaintedVersion(Music.MUSIC_BOSS_OVER) then
							musicmgr:Crossfade(Music.MUSIC_BOSS_OVER) --no boss over jingle after Devil Deal Wave
						end
					end
				end
			end
			
			previousgreedwave = currentgreedwave
		end
		roomclearbefore = roomclearnow
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_RENDER, custommusiccollection.HandleGreedModeCases)
	
	function custommusiccollection:HandleStageAPI()
		if StageAPI and StageAPI.Loaded then
			
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_GAME_OVER], false, true)
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_GAME_OVER])
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_BOSS_OVER])
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_BOSS_OVER2])
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_BOSS_OVER3])
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_CHALLENGE_OUTRO])
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_BOSS_RUSH_OUTRO])
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_MOTHER_OVER])
			
			StageAPI.StopOverridingMusic(Music.MUSIC_JINGLE_ANGEL_OVER)
			StageAPI.StopOverridingMusic(normaltotainted[Music.MUSIC_JINGLE_ANGEL_OVER])
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, custommusiccollection.HandleStageAPI)
	
	function custommusiccollection:SetUpMusicForCustomStage()
		if StageAPI and StageAPI.Loaded and StageAPI.CurrentStage and StageAPI.InNewStage() then
			local currentstage = StageAPI.GetCurrentStage()
			currentstage:SetMusic(NormalOrTainted(Music.MUSIC_I_AM_ERROR), RoomType.ROOM_ERROR)
			currentstage:SetMusic(NormalOrTainted(Music.MUSIC_BLACKMARKET_ROOM), RoomType.ROOM_BLACK_MARKET)
		end
	end
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, custommusiccollection.SetUpMusicForCustomStage)
	custommusiccollection:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, custommusiccollection.SetUpMusicForCustomStage)
end
