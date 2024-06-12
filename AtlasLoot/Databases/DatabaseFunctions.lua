
local difficultys = {
	[1] = "Bloodforged",
	[100] = "Heroic Bloodforged",
	[3] = "Heroic",
	[4] = "Mythic",
	[5] = "Mythic 1",  [6] = "Mythic 2",  [7] = "Mythic 3",  [8] = "Mythic 4",  [9] = "Mythic 5",
	[10] = "Mythic 6", [11] = "Mythic 7", [12] = "Mythic 8", [13] = "Mythic 9", [14] = "Mythic 10",
	[15] = "Mythic 11", [16] = "Mythic 12", [17] = "Mythic 13", [18] = "Mythic 14", [19] = "Mythic 15",
	[20] = "Mythic 16", [21] = "Mythic 17", [22] = "Mythic 18", [23] = "Mythic 19", [24] = "Mythic 20",
	[25] = "Mythic 21", [26] = "Mythic 22", [27] = "Mythic 23", [28] = "Mythic 24", [29] = "Mythic 25",
	[30] = "Mythic 26", [31] = "Mythic 27", [32] = "Mythic 28", [33] = "Mythic 29", [34] = "Mythic 30",
	[35] = "Mythic 31", [36] = "Mythic 32", [37] = "Mythic 33", [38] = "Mythic 34", [39] = "Mythic 35",
	[40] = "Mythic 36", [41] = "Mythic 37", [42] = "Mythic 38", [43] = "Mythic 39", [44] = "Mythic 40",
};

local raidDifficultys = {
	[3] = "Heroic Raid",
	[4] = "Ascended Raid",
	[5] = "Mythic Raid",
}

local difficultyList = {
	["Heroic"] = 3,
	["Mythic"] = 4,
	["Heroic Raid"] = 3,
	["Mythic Raid"] = 5,
	["Ascended Raid"] = 4,
	["Heroic Bloodforged"] = 100,
	["Bloodforged"] = 1,
	["Mythic 1"] = 5,  ["Mythic 2"] = 6,  ["Mythic 3"] = 7,  ["Mythic 4"] = 8,  ["Mythic 5"] = 9,
	["Mythic 6"] = 10, ["Mythic 7"] = 11, ["Mythic 8"] = 12, ["Mythic 9"] = 13, ["Mythic 10"] = 14,
	["Mythic 11"] = 15, ["Mythic 12"] = 16, ["Mythic 13"] = 17, ["Mythic 14"] = 18, ["Mythic 15"] = 19,
	["Mythic 16"] = 20, ["Mythic 17"] = 21, ["Mythic 18"] = 22, ["Mythic 19"] = 23, ["Mythic 20"] = 24,
	["Mythic 21"] = 25, ["Mythic 22"] = 26, ["Mythic 23"] = 27, ["Mythic 24"] = 28, ["Mythic 25"] = 29,
	["Mythic 26"] = 30, ["Mythic 27"] = 31, ["Mythic 28"] = 32, ["Mythic 29"] = 33, ["Mythic 30"] = 34,
	["Mythic 31"] = 35, ["Mythic 32"] = 36, ["Mythic 33"] = 37, ["Mythic 34"] = 38, ["Mythic 35"] = 39,
	["Mythic 36"] = 40, ["Mythic 37"] = 41, ["Mythic 38"] = 42, ["Mythic 39"] = 43, ["Mythic 40"] = 44,
};

function AtlasLoot:GetDifficulty(item)
	if not item then return end
	for difficuilty, id in pairs(difficultyList) do
		local _, description, _ = string.split("@", item.description, 3)
		if description then
			description = self:StripTextColor(description)
			if difficuilty == description then
				return id, difficuilty
			end
		end
	end
end

function AtlasLoot:CheckItemID(newIDs, ID, dif)
	if not newIDs then return end
	if type(newIDs) ~= "table" then newIDs = {newIDs} end
	for _, newID in ipairs(newIDs) do
		local ogName = GetItemInfoInstant(ID)
		local newName = GetItemInfoInstant(newID)
		if newName and ogName and newName.name and ogName.name then
			ogName.name = ogName.name:gsub( "%W", "" )
			newName.name = newName.name:gsub( "%W", "" )
			if dif == 1 or dif == 100 then
				ogName.name = "Bloodforged"..ogName.name
			end
		local _, description = self:GetDifficulty(newName)
			if description then
				if (not dif or (dif and (difficultys[dif] == description or raidDifficultys[dif] == description))) then
					if ogName.name == newName.name then
						return  newID
					end
				end
			end
		end
	end
end

function AtlasLoot:CheckIfEmptyTable(table)
	if next(table) then
		return false
	else
		return true
	end
end

local updateFrameCreated
function AtlasLoot:CreateUpdateText()
    if updateFrameCreated then return end
    local updateCounterFrame = CreateFrame("Frame", "AtlasLootDbUpdate", UIParrnt, nil)
	updateCounterFrame:SetPoint("CENTER",0,200)
	updateCounterFrame:SetSize(400,50)
	updateCounterFrame:Hide()
	updateCounterFrame.cText = updateCounterFrame:CreateFontString("AtlasLootDbUpdateText","OVERLAY","GameFontNormal")
	updateCounterFrame.cText:Show()
	updateCounterFrame.cText:SetPoint("CENTER",0,0)
    updateFrameCreated = true
end

local itemTypeIgnore = {[18] = true, [19] = true, [24] = true}

AtlasLoot.unknownIDs = {}
function AtlasLoot:UpdateItemIDsDatabase(firstID, lastID)
	self.db.profile.overWrightCache = false
	self:IsLootTableAvailable("AtlasLootOriginalWoW")
	self:IsLootTableAvailable("AtlasLootBurningCrusade")
    for dataID, data in pairs(AtlasLoot_Data) do
		if data.Type then
			for tableNum, t in ipairs(data) do
				for _, itemData in pairs(t) do
					if type(itemData) == "table" then
						if itemData.itemID then
							for _, dif in pairs(self.Difficultys[data.Type]) do
								local idCheck = ItemIDsDatabase[itemData.itemID] and self:CheckItemID(ItemIDsDatabase[itemData.itemID][dif[2]], itemData.itemID, dif[2]) or nil
								local itemType = GetItemInfoInstant(itemData.itemID) or nil
								if dif[2] ~= 100 and dif[2] ~= 1 and dif[2] ~= 2 and itemType and itemType.inventoryType ~= 0 and not itemTypeIgnore[itemType.inventoryType] and
								((not ItemIDsDatabase[itemData.itemID]) or
								(ItemIDsDatabase[itemData.itemID] and (not ItemIDsDatabase[itemData.itemID][dif[2]] or
								(ItemIDsDatabase[itemData.itemID][dif[2]] and not idCheck)))) then
									self.unknownIDs[itemData.itemID] = self.unknownIDs[itemData.itemID] or {}
									self.unknownIDs[itemData.itemID][dif[2]] = dif[2]
								end
							end
						end
					end
				end
			end
		end
    end
	self:GetItemVariationIDs(firstID, lastID)
end

function AtlasLoot:GetItemVariationIDs(firstID, lastID)
	if self:CheckIfEmptyTable(self.unknownIDs) then return end
    self:CreateUpdateText()
    AtlasLootDbUpdate:Show()

	local maxDuration = GetFramerate() - 5
    local startTime = debugprofilestop()
	firstID = firstID or 1
	lastID = lastID or 5500000
	AtlasLootDbUpdateText:SetText("Updating AtlasLoot Item Cache\n"..firstID.." / ".. lastID)

		local function checkID(item, difficulty)
			for ID, diffList in pairs (self.unknownIDs) do
				local ogName = GetItemInfoInstant(ID)
					if difficulty and item and ogName and item.name and ogName.name then
						local orignalName = ogName.name:gsub( "%W", "" )
						local foundName = item.name:gsub( "%W", "" )
						if orignalName == foundName then
							AtlasLootItemCache[ID] = AtlasLootItemCache[ID] or {}
							AtlasLootItemCache[ID][difficulty] = item.itemID
							ItemIDsDatabase[ID] = ItemIDsDatabase[ID] or {}
							ItemIDsDatabase[ID][difficulty] = item.itemID
							self.unknownIDs[ID][difficulty] = nil
							if self:CheckIfEmptyTable(self.unknownIDs[ID]) then self.unknownIDs[ID] = nil end
						end
					end
			end
			AtlasLootDbUpdateText:SetText("Updating AtlasLoot Item Cache\n"..firstID.." / ".. lastID)
		end

    local function continue()
		if self:CheckIfEmptyTable(self.unknownIDs) then
			return
		end
        startTime = debugprofilestop()
        while (firstID ~= lastID) do
			local item = GetItemInfoInstant(firstID)
			local difficulty = self:GetDifficulty(item)
			if item and item.quality > 2 and item.inventoryType ~= 0 and not itemTypeIgnore[item.inventoryType] and difficulty then
				checkID(item, difficulty)
			end
			firstID = firstID + 1
            AtlasLootDbUpdateText:SetText("Updating AtlasLoot Item Cache\n"..firstID.." / ".. lastID)
            if (debugprofilestop() - startTime > maxDuration) then
                Timer.After(0, continue)
                return
            end
        end
		AtlasLootDbUpdateText:SetText("Updating AtlasLoot Item Cache\nUpdate Complete Reloadui To Save")
    end

    return continue()
end

--[[
AtlasLoot:FindId(id, difficulty)
Finds the Ids of other difficulties based on the normal id of the item and the difficulty parameter given.
On the form of {ID, {normal, heroic, mythic, mythic1, mythic2, ... ,mythicN}}
]]
function AtlasLoot:FindId(id, difficulty, type, sourceType)
	local hasID
	if difficulty == 2 then return end
	if difficulty == 100 then
		local newIDs = {
			(id < 1000000 and (id) + 6300000),
			(id < 1000000 and (id) + 7800000),
			(id > 1000000 and (id - 1500000) + 6300000),
			(id > 1000000 and (id - 1500000) + 7800000),
	}
		hasID = self:CheckItemID(newIDs, id, difficulty)
		if hasID then return  hasID, true end
		if not ItemIDsDatabase[id] then return nil, false end
	end

	if difficulty == 1 then
		local newIDs = {
			(id < 1000000 and (id) + 6000000),
			(id < 1000000 and (id) + 7500000),
			(id > 1000000 and (id - 1500000) + 6000000),
			(id > 1000000 and (id - 1500000) + 7500000),
	}
		hasID = self:CheckItemID(newIDs, id, difficulty)
		if hasID then return  hasID, true end
	end

	if difficulty == 3 then
		local newIDs = {
			(id < 1000000 and (id) + 1550000),
			(id > 1000000 and (id - 1500000) + 1550000),
	}
		hasID = self:CheckItemID(newIDs, id, difficulty)
		if hasID then return  hasID, true end
	end

	if difficulty == 4 then
		local newIDs = {
			(id < 1000000 and (id) + 1650000),
			(id > 1000000 and (id - 1500000) + 1650000),
	}
		hasID = self:CheckItemID(newIDs, idid, difficulty)
		if hasID then return  hasID, true end
	end

	if (difficulty == 4 and (type == "BCRaid" or type == "ClassicRaid") and sourceType == "Search") then
		difficulty = 5
	elseif (difficulty == 5 and (type == "BCRaid" or type == "ClassicRaid") and sourceType == "Search") then
		difficulty = 4
	end

	if ItemIDsDatabase[id] then
		hasID = self:CheckItemID(ItemIDsDatabase[id][difficulty] or nil, id, difficulty)
		if hasID then
			return hasID, true
		end
	end
end

-- Loads the Item Variations into a table from the data content folder
function AtlasLoot:LoadItemIDsDatabase()
	local content = C_ContentLoader:Load("ItemVariationData")
	content:SetParser(function(index, data)
		-- run for each item in the data
		self:CancelTimer(self.missingItemsTimer)
        content:SetParser(function(index, data)
            -- run for each item in the data
        if index ~= 0 and data.Normal ~= 0 and not ItemIDsDatabase[data.Normal] then
                ItemIDsDatabase[data.Normal] = {}
                ItemIDsDatabase[data.Normal]["MythicRaid"] = tonumber("13"..data.Normal)
                table.insert(ItemIDsDatabase[data.Normal],data.Bloodforged)
                table.insert(ItemIDsDatabase[data.Normal],data.HeroicBloodforged)
                table.insert(ItemIDsDatabase[data.Normal],data.Normal)
                if data.Heroic ~= 0 then table.insert(ItemIDsDatabase[data.Normal],data.Heroic) end
                    for _,v in ipairs(data["Mythic"]) do
                        if v ~= 0 then
                            table.insert(ItemIDsDatabase[data.Normal],v)
                        end
                    end
            end
        end)
		self.missingItemsTimer = self:ScheduleTimer("LoadMissingIDs", 5)
	end)

	-- This will run over time (usually about 30s for a file this size), but will maintain playable fps while running.
	content:ParseAsync()
end

--Updates the ItemIDsDatabase with any missing or incorrect items
function AtlasLoot:LoadMissingIDs()
	--loads the items in AtlasLoot_Cache
	if AtlasLootUpdateCache then
		for normalID, item in pairs(AtlasLootUpdateCache) do
			for itemDif, itemID in pairs(item) do
				ItemIDsDatabase[normalID] = ItemIDsDatabase[normalID] or {}
				ItemIDsDatabase[normalID][itemDif] = itemID
			end
		end	
	end
	--loads any items in the saved varriables cache
    if AtlasLootItemCache and not self:CheckIfEmptyTable(AtlasLootItemCache) then
		for normalID, item in pairs(AtlasLootItemCache) do
			for itemDif, itemID in pairs(item) do
				ItemIDsDatabase[normalID] = ItemIDsDatabase[normalID] or {}
				ItemIDsDatabase[normalID][itemDif] = itemID
			end
		end
	end
	-- loads ids that have been manuely corrected
	if ItemIDManuelCorrections then
		for normalID, item in pairs(ItemIDManuelCorrections) do
			for itemDif, itemID in pairs(item) do
				ItemIDsDatabase[normalID] = ItemIDsDatabase[normalID] or {}
				ItemIDsDatabase[normalID][itemDif] = itemID
			end
		end
	end
	--if this is true will overwright the varriables cache with the itemcache to make it easyer to update
	if self.db.profile.overWrightCache then
		AtlasLootItemCache = AtlasLootUpdateCache
	end
	ItemIDManuelCorrections = nil
	AtlasLootUpdateCache = nil
    collectgarbage("collect")
end