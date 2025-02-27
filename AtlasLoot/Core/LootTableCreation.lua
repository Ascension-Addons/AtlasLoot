local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")

--Creates tables for raid tokens from the collections tables
function AtlasLoot:CreateToken(dataID)
	local itemType, slotType, itemName, itemType2
	--orginal dataID
	local orgID = dataID
	--list of item types to find
	local names = { {"HEAD", "INVTYPE_HEAD", "Head"}, {"SHOULDER", "INVTYPE_SHOULDER", "Shoulders"}, {"CHEST", "INVTYPE_CHEST", "Chest", "INVTYPE_ROBE"}, {"WRIST", "INVTYPE_WRIST", "Wrists"}, {"HAND", "INVTYPE_HAND", "Hands"}, {"WAIST", "INVTYPE_WAIST", "Waist"}, {"LEGS", "INVTYPE_LEGS", "Legs"}, {"FEET", "INVTYPE_FEET", "Feet"}, {"FINGER", "INVTYPE_FINGER", "Rings"}, {"BACK", "INVTYPE_CLOAK", "Back"}, {"NECK", "INVTYPE_NECK", "Necklace"}}
	--finds the item type to create a list of
	for _, b in pairs(names) do
		dataID = gsub(dataID, b[1], "")
		slotType = gsub(orgID, dataID, "")
		if slotType == b[1] then
			itemType = b[2]
			itemType2 = b[4]
			itemName = b[3]
			break
		end
	end
	--Creates data set of the item type
	if (AtlasLoot_TokenData[orgID] == nil) then
		AtlasLoot_TokenData[orgID] = {
			Name = itemName,
			Type = AtlasLoot_Data[dataID].Type,
			Back = true,
			NoSubt = true,
			[1] = { Name = itemName },
		}
	end
	local count = #AtlasLoot_Data[dataID][1] * #AtlasLoot_Data[dataID]
	local function addItem(itemID, desc)
		if itemType == select(9, AtlasLoot:GetItemInfo(itemID)) or itemType2 == select(9, AtlasLoot:GetItemInfo(itemID)) then
			table.insert(AtlasLoot_TokenData[orgID][1], {itemID = itemID, desc = desc})
		end
		if count == 1 then
			self:ShowItemsFrame(self.itemframe.refresh[1], self.itemframe.refresh[2], self.itemframe.refresh[3])
		end
		count = count - 1
	end
	--Fills table with items
	for _, t in ipairs(AtlasLoot_Data[dataID]) do
		for _, v in ipairs(t) do
			if type(v) == "table" then
				if v.itemID then
					addItem(v.itemID, t.Name)
				end
			end
		end
	end
end

--Creates a sorted and consolidated loottable of all of an xpacs dungeon loot
function AtlasLoot:CreateOnDemandLootTable(typeL)
	-- Return and show loot table if its already been created
	if AtlasLoot_OnDemand and AtlasLoot_OnDemand[typeL] then return self:ShowItemsFrame(typeL, "AtlasLoot_OnDemand", 1) end
	-- Create ondemand loot table if it dosnt exist
	if not AtlasLoot_OnDemand then AtlasLoot_OnDemand = {} end

	-- Text Conversion
	local equipSlot = {
		INVTYPE_HEAD = BabbleInventory["Head"], INVTYPE_SHOULDER = BabbleInventory["Shoulder"], INVTYPE_CHEST = BabbleInventory["Chest"],
		INVTYPE_WRIST = BabbleInventory["Wrist"], INVTYPE_HAND = BabbleInventory["Hands"], INVTYPE_WAIST = BabbleInventory["Waist"],
		INVTYPE_LEGS = BabbleInventory["Legs"], INVTYPE_FEET = BabbleInventory["Feet"], INVTYPE_FINGER = BabbleInventory["Ring"],
		INVTYPE_CLOAK = BabbleInventory["Back"], INVTYPE_NECK = BabbleInventory["Neck"], INVTYPE_WEAPONOFFHAND = BabbleInventory["Off Hand"],
		INVTYPE_WEAPONMAINHAND = "Mainhand", INVTYPE_TRINKET = "Trinket", INVTYPE_HOLDABLE = "Caster Offhand"}

	local function correctText(text)
		text = gsub(text, "Cloth Armor %- Back", "Back")
		text = gsub(text, "Miscellaneous Armor %- " , "")
		text = gsub(text, "Armor %- " , "Armor "..self.Colors.WHITE.."%- ")
		text = gsub(text, "Weapon %- " , self.Colors.WHITE.."%- ")
		return text
	end

	-- Combind robes with chest
	local function getEquip(equipLoc)
		if equipLoc == "INVTYPE_ROBE" then
			return "INVTYPE_CHEST"
		end
		return equipLoc
	end

	-- Show the loot table or refresh it
	local firstLoad
	local function showTable()
		if firstLoad then
			self:ShowItemsFrame(self.itemframe.refresh[1], self.itemframe.refresh[2], self.itemframe.refresh[3])
		else
			self:ShowItemsFrame(typeL, "AtlasLoot_OnDemand", 1)
			firstLoad = true
		end
	end

	local unsorted = {}
	-- Creates type catagorys and then adds items to them
	local function sortItem(item, armorSubType, equipLoc, armorType)
		if not unsorted[armorSubType] then unsorted[armorSubType] = {} end
		if equipLoc and not unsorted[armorSubType][getEquip(equipLoc)] then unsorted[armorSubType][getEquip(equipLoc)] = {} end
		if equipLoc then
			tinsert(unsorted[armorSubType][getEquip(equipLoc)], {item, armorType})
		else
			tinsert(unsorted[armorSubType]["Misc"], {item, armorType})
		end
		AtlasLoot_OnDemand[typeL] = {Name = "All Dungeon Items", Type = typeL, filter = true }

		for aType, v in pairs(unsorted) do
			for eLoc, t in pairs(v) do
				for i, items in ipairs(t) do
					local name = equipSlot[getEquip(eLoc)] and aType.." "..items[2].." - "..equipSlot[getEquip(eLoc)] or aType
					if #t > 30 and (i == 1 or i == 31 or i == 61 or i == 91)  then
						tinsert(AtlasLoot_OnDemand[typeL],{Name = correctText(name)..self.Colors.WHITE.." - Page".. math.ceil(i/30) })
					elseif i == 1 then
						tinsert(AtlasLoot_OnDemand[typeL],{Name = correctText(name)})
					end
					tinsert(AtlasLoot_OnDemand[typeL][#AtlasLoot_OnDemand[typeL]], items[1])
				end
			end
		end
		showTable()
	end

	-- Load items to cache and check they are either an armor or weapon
	local function processItem(itemData)
		if not itemData then return end
		if itemData.itemID then
			self:ItemsLoading(-1)
			local armorType, armorSubType, _, equipLoc = select(6,AtlasLoot:GetItemInfo(itemData.itemID))
			if (armorType == "Armor" or armorType == "Weapon") then
				sortItem(itemData, armorSubType, equipLoc, armorType)
			end
		end
	end

	--Fills table with items
	local itemList = {}
	local checkList = {}
	for dataID, data in pairs(AtlasLoot_Data) do
		if data.Type == typeL then
			for tableNum, t in ipairs(data) do
				for _, itemData in pairs(t) do
					if type(itemData) == "table" and itemData.itemID and not checkList[itemData.itemID] then
						itemData.dropLoc = {data.DisplayName or data.Name, t.Name}
						itemData.lootTable = {{dataID, "AtlasLoot_Data", tableNum}, "Source"}
						checkList[itemData.itemID] = true
						tinsert(itemList, {itemData})
					end
				end
			end
		end
	end
	wipe(checkList)
	-- rate limit tied to half the current frame rate
	self:ItemsLoading(#itemList)
	local maxDuration = 500/GetFramerate()
	local startTime = debugprofilestop()
	local function continue()
		startTime = debugprofilestop()
		local task = tremove(itemList)
		while (task) do
			processItem(task[1])
			if (debugprofilestop() - startTime > maxDuration) then
				Timer.After(0, continue)
				return
			end
			task = tremove(itemList)
		end
	end

	return continue()
end
