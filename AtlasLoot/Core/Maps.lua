local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot")

local BLUE = "|cff6666ff"
local GREY = "|cff999999"
local GREN = "|cff66cc33"
local _RED = "|cffcc6666"
local ORANGE = "|cffFF8400"
local PURP = "|cff9900ff"
local INDENT = "      "
local YELLOW = "|cffFFd200"
local GOLD  = "|cffffcc00"
local WHITE = "|cFFFFFFFF"
local CYAN =  "|cff00ffff"
local DefaultPin = "questlog-questtypeicon-daily"
-- Map Functions
local playerFaction = UnitFactionGroup("player")
local lastMap
local totalPins = 0

-- Creates the map pins 
function AtlasLoot:CreateMapPins(list)
    _G["AtlasLoot_PlayerMapPin"]:Hide()
    -- Hide all pins before reshowing so any extras arnt showing
    if totalPins then
        for i = 1, totalPins do
            _G["AtlasLoot_MapPin"..i]:Hide()
        end
    end
    -- Creates buttons on the map for pins if a button dosnt already exist
    -- If a button exists reuse it
    for i,map in ipairs(list) do
        --create pin buttons
        if not _G["AtlasLoot_MapPin"..i] then
            -- Map Pins
            local mapPin = CreateFrame("Button","AtlasLoot_MapPin"..i, AtlasLootDefaultFrame_Map)
            mapPin:SetSize(25,25)
            mapPin:SetFrameStrata("HIGH")
            mapPin.text = mapPin:CreateFontString(nil, "OVERLAY","GameFontNormal")
            mapPin.text:SetPoint("LEFT",mapPin, 30, 0)
            mapPin.text:SetJustifyH("LEFT")
            mapPin.text:SetFont("GameFontNormal", 28)
            mapPin.text:SetSize(150,12)
            mapPin.tex = mapPin:CreateTexture(nil, "ARTWORK")
            mapPin.tex:SetPoint("CENTER")
            totalPins = totalPins + 1
        end
        -- converts a standard coordinate x,y to stardard anchor points
        local x = ((AtlasLootDefaultFrame_Map:GetWidth()/100) * map[2][1]) - (_G["AtlasLoot_MapPin"..i]:GetWidth()/2)
        local y = (-(AtlasLootDefaultFrame_Map:GetHeight()/100) * map[2][2]) + (_G["AtlasLoot_MapPin"..i]:GetHeight()/2)
        _G["AtlasLoot_MapPin"..i]:SetScript("OnEnter", function(self)
            AtlasLoot.showCords = true
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:AddLine(WHITE..map[1])
            if map[4] and list.groups[map[4]] then
                for _,v in ipairs(list.groups[map[4]]) do
                    if v ~= map[1] then
                        GameTooltip:AddLine(WHITE..v)
                    end
                end
            end
            GameTooltip:AddLine("("..map[2][1]..", "..map[2][2]..")")
            GameTooltip:Show()
        end)
        _G["AtlasLoot_MapPin"..i]:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        if map[3] then
            local tex = AtlasUtil:GetAtlasInfo(map[3])
            _G["AtlasLoot_MapPin"..i].tex:SetTexture(tex.filename)
            _G["AtlasLoot_MapPin"..i].tex:SetTexCoord(tex.leftTexCoord, tex.rightTexCoord, tex.topTexCoord, tex.bottomTexCoord)
            _G["AtlasLoot_MapPin"..i].tex:SetSize(25,25)
        else
            local tex = AtlasUtil:GetAtlasInfo(DefaultPin)
            _G["AtlasLoot_MapPin"..i].tex:SetTexture(tex.filename)
            _G["AtlasLoot_MapPin"..i].tex:SetTexCoord(tex.leftTexCoord, tex.rightTexCoord, tex.topTexCoord, tex.bottomTexCoord)
            _G["AtlasLoot_MapPin"..i].tex:SetSize(25,25)
        end
        _G["AtlasLoot_MapPin"..i].text:SetText(CYAN..map[1])
        _G["AtlasLoot_MapPin"..i]:ClearAllPoints()
        _G["AtlasLoot_MapPin"..i]:SetPoint("TOPLEFT",AtlasLootDefaultFrame_Map,x ,y)
        _G["AtlasLoot_MapPin"..i]:Show()
    end
end

-- Track the coordinates off the mouse while it is on the map frame
function AtlasLoot:CursorCords()
    if AtlasLoot.showCords then
        local scale,x, y = AtlasLootDefaultFrame_Map:GetEffectiveScale(), GetCursorPosition()
        local width, height = AtlasLootDefaultFrame_Map:GetWidth()/100, AtlasLootDefaultFrame_Map:GetHeight()/100
        x, y = math.ceil(((x/scale) - AtlasLootDefaultFrame_Map:GetLeft())/width), math.ceil((((y/scale) - AtlasLootDefaultFrame_Map:GetTop())/height) * -1)
        AtlasLootDefaultFrame_Map.cursorCords:SetText(WHITE.."Cursor: "..x.." , "..y)
    end
end

function AtlasLoot:PlayerPin(firstSet)
    if AtlasLootDefaultFrame_Map:IsVisible() and AtlasLoot_MapData[AtlasLoot.CurrentMap].ZoneName[1] == GetRealZoneText() and AtlasLoot.MapNum == GetCurrentMapDungeonLevel() then
        _G["AtlasLoot_PlayerMapPin"]:Show()
    else
        return
    end
    if GetUnitSpeed("player") > 0 or firstSet then
        local x, y = GetPlayerMapPosition("player")
        x = ((AtlasLootDefaultFrame_Map:GetWidth()/100) * (x * 100)) - (_G["AtlasLoot_PlayerMapPin"]:GetWidth()/2)
        y = (-(AtlasLootDefaultFrame_Map:GetHeight()/100) * (y * 100)) + (_G["AtlasLoot_PlayerMapPin"]:GetHeight()/2)
        _G["AtlasLoot_PlayerMapPin"]:ClearAllPoints()
        _G["AtlasLoot_PlayerMapPin"]:SetPoint("TOPLEFT",AtlasLootDefaultFrame_Map, x, y )
        _G["AtlasLoot_PlayerMapPin"].texture:SetRotation(GetPlayerFacing())
    end
    AtlasLoot.playerPinTimer = AtlasLoot:ScheduleTimer("PlayerPin", .1)
end

function AtlasLoot:SetNavButtons(mapID, mapNum)
    if not AtlasLootDefaultFrame_Map:IsVisible() then return end
    --Hide navigation buttons by default, only show what we need
    _G["AtlasLootItemsFrame_BACK"]:Hide()
    _G["AtlasLootItemsFrame_NEXT"]:Hide()
    _G["AtlasLootItemsFrame_PREV"]:Hide()

        if mapNum ~= #_G["AtlasLoot_MapData"][mapID] then
            _G["AtlasLootItemsFrame_NEXT"]:SetParent("AtlasLootDefaultFrame_Map")
            _G["AtlasLootItemsFrame_NEXT"]:Show()
            _G["AtlasLootItemsFrame_NEXT"].mapNum = mapNum + 1
            _G["AtlasLootItemsFrame_NEXT"].mapID = mapID
            _G["AtlasLootItemsFrame_NEXT"]:ClearAllPoints()
            _G["AtlasLootItemsFrame_NEXT"]:SetPoint("BOTTOMRIGHT", "AtlasLootDefaultFrame_Map", "BOTTOMRIGHT",-5,5)
        end
        if mapNum ~= 1 then
            _G["AtlasLootItemsFrame_PREV"]:SetParent("AtlasLootDefaultFrame_Map")
            _G["AtlasLootItemsFrame_PREV"]:Show()
            _G["AtlasLootItemsFrame_PREV"].mapNum = mapNum - 1
            _G["AtlasLootItemsFrame_PREV"].mapID = mapID
            _G["AtlasLootItemsFrame_PREV"]:ClearAllPoints()
            _G["AtlasLootItemsFrame_PREV"]:SetPoint("BOTTOMLEFT", "AtlasLootDefaultFrame_Map", "BOTTOMLEFT",5,5)
        end
end

--called everytime you open a map hiding the loot item buttons 
function AtlasLoot:MapOnShow(mapID, mapNum, refresh)
    if not refresh and AtlasLootDefaultFrame_Map:IsVisible() then
        AtlasLootDefaultFrame_Map:Hide()
        AtlaslLoot_LootBackground:Show()
        AtlasLoot:BackButton_OnClick()
        AtlasLoot_BossName:Show()
        Atlasloot_HeaderLabel:Hide()
        AtlasLoot:ScrollFrameUpdate()
    else
        if AtlasLoot.CurrentMap then
            AtlasLoot_BossName:Hide()
            -- Hide the Filter Check-Box
	        AtlasLootFilterCheck:Hide()
            AtlaslLoot_LootBackground:Hide()
            --Hide UI objects so that only needed ones are shown
            for i = 1, 30, 1 do
                _G["AtlasLootItem_"..i]:Hide()
                _G["AtlasLootItem_"..i].itemID = 0
            end
                AtlasLootDefaultFrame_Map:Show()
                Atlasloot_HeaderLabel:Show()
                AtlasLoot:ScrollFrameUpdate(true)
                AtlasLootDefaultFrameScroll:Hide()
                mapNum = mapNum or 1
                SetMapToCurrentZone()
                if AtlasLoot_MapData[AtlasLoot.CurrentMap].ZoneName[1] == GetRealZoneText() then
                    if GetCurrentMapDungeonLevel() == 0 then
                        mapNum = 1
                    else
                        mapNum = GetCurrentMapDungeonLevel()
                    end
                elseif mapID then
                    AtlasLoot.CurrentMap = mapID
                elseif lastMap == AtlasLoot.CurrentMap then
                    mapNum = AtlasLoot.MapNum
                end
                lastMap = AtlasLoot.CurrentMap
                AtlasLoot:MapSelect(AtlasLoot.CurrentMap, mapNum)
        end
    end
end

--called to change the current displayed map
function AtlasLoot:MapSelect(mapID, mapNum)
    local map = AtlasLoot_MapData[mapID]
    if map.MapName then
        for i = 1, 12 do
            local texture = _G["AtlasLoot_MapDetailTile"..i]:SetTexture("Interface\\Worldmap\\"..map.MapName.."\\"..map.MapName..mapNum.."_"..i)
            if not texture then
                _G["AtlasLoot_MapDetailTile"..i]:SetTexture("Interface\\Worldmap\\"..map.MapName.."\\"..map.MapName..i)
            end
        end
    end
    local pinsList = {groups = {}}
    local group = 0
    for _, v in ipairs (map[mapNum]) do
        if v.cords then
            group = group + 1
            tinsert(pinsList,{v[1],v.cords,v.pinType, group})
        end
        if group ~= 0 then
            if not pinsList.groups[group] then pinsList.groups[group] = {} end
            tinsert(pinsList.groups[group], v[1])
        end
    end
    AtlasLoot.MapNum = mapNum
    AtlasLoot.CurrentMap = mapID
    AtlasLoot:SubTableScrollFrameUpdate(mapID, "AtlasLoot_MapData", mapNum)
    AtlasLoot:SetNavButtons(mapID, mapNum)
    AtlasLoot:CreateMapPins(pinsList)
    AtlasLoot:CancelTimer(AtlasLoot.playerPinTimer)
    AtlasLoot:PlayerPin(true)

    local text = map.ZoneName[1]..WHITE.." ["..map.Acronym.."]\n"..
    GOLD .. "Location: ".. WHITE..map.Location[1].."\n"..
    GOLD .. "Level Range: ".. WHITE..map.LevelRange.."\n"..
    GOLD .. "Minimum Level: ".. WHITE..map.MinLevel.."\n"..
    GOLD .. "Player Limit: ".. WHITE..map.PlayerLimit

    if map.Reputation and type(map.Reputation) == "table" then
        text = text .. "\n" .. GOLD .. AL["Reputation"] .. ": ".. WHITE .. map.Reputation[playerFaction]
    elseif map.Reputation then
        text = text .. "\n" .. GOLD .. AL["Reputation"] .. ": ".. WHITE .. map.Reputation
    end
    Atlasloot_HeaderLabel:SetText(text)
    AtlasLoot:SetMapButtonText(mapID, mapNum)
end

function AtlasLoot:SetMapButtonText(mapID, mapNum)
    local map = AtlasLoot_MapData[mapID]
    mapNum = mapNum or 1
    local text
    if map[mapNum][1].Zone then
        text = map[mapNum][2][1]
    else
        text = map[mapNum][1][1]
    end
    AtlasLootDefaultFrame_MapButton:SetText(text)
end

--drop down map menu
function AtlasLoot:MapMenuOpen(self)
    local mapID = AtlasLoot.CurrentMap
    local map = AtlasLoot_MapData[mapID]

    local menuList = { [1] = {} }
        for i,v in ipairs(map) do
            local text
            if v[1].Zone then
                text = map[i][2][1]
            else
                text = v[1][1]
            end
            tinsert(menuList[1], {text = WHITE..text, func = function() AtlasLoot:MapSelect(mapID, i) end, notCheckable = true, closeWhenClicked = true, textHeight = 12, textWidth = 12})
        end

        tinsert(menuList[1], {divider = 35})
        tinsert(menuList[1], {text = ORANGE..AL["Open AscensionDB To Zone Map"], func = function() AtlasLoot:OpenDBURL(AtlasLoot_MapData[AtlasLoot.CurrentMap].ZoneName[2] , "zone") end, notCheckable = true, closeWhenClicked = true, textHeight = 12, textWidth = 12})
		tinsert(menuList[1], {close = true, divider = 35})

    AtlasLoot:OpenDewdropMenu(self, menuList)
end