local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local BabbleSubZone = AtlasLoot_GetLocaleLibBabble("LibBabble-SubZone-3.0");
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")


local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "      ";
local YELLOW = "|cffFFd200"
local WHITE = "|cFFFFFFFF"

local ZONE = 1;
local NPC = 2;
local ITEM = 3;
local OBJECT = 4;
local FACTION = 5;
local QUEST = 6;

local lastMapNum, lastMap

--called everytime you on a map hiding the loot item buttons 
function AtlasLoot:MapOnShow()
    if AtlasLootDefaultFrame_Map:IsVisible() then
        AtlasLootDefaultFrame_Map:Hide();
        AtlasLootDefaultFrame_LootBackground:Show();
        AtlasLoot:BackButton_OnClick();
        AtlasLoot_BossName:Show();
        Atlasloot_HeaderLabel:Hide();
        AtlasLoot:ScrollFrameUpdate();
    else
        if ATLASLOOT_CURRENT_MAP then
            AtlasLoot_BossName:Hide();
            --Ditch the Quicklook selector
            AtlasLootQuickLooksButton:Hide();
            -- Hide the Filter Check-Box
	        AtlasLootFilterCheck:Hide();
            --Hide navigation buttons by default, only show what we need
            _G["AtlasLootItemsFrame_BACK"]:Hide();
            _G["AtlasLootItemsFrame_NEXT"]:Hide();
            _G["AtlasLootItemsFrame_PREV"]:Hide();
            AtlasLootDefaultFrame_LootBackground:Hide();
            --Hide UI objects so that only needed ones are shown
            for i = 1, 30, 1 do
                _G["AtlasLootItem_"..i.."_Unsafe"]:Hide();
                _G["AtlasLootItem_"..i]:Hide();
                _G["AtlasLootItem_"..i].itemID = 0;
                _G["AtlasLootItem_"..i].spellitemID = 0;
            end
                AtlasLootDefaultFrame_Map:Show();
                Atlasloot_HeaderLabel:Show();
                AtlasLoot:ScrollFrameUpdate(true);
                AtlasLootDefaultFrameScroll:Hide();
                local mapNum = 1
                if lastMap == ATLASLOOT_CURRENT_MAP then mapNum = lastMapNum end
                AtlasLoot:SubTableScrollFrameUpdate(ATLASLOOT_CURRENT_MAP, "AtlasLoot_MapData", mapNum);
                lastMapNum = mapNum
        end
    end
    if not AtlasLoot.db.profile.FrameExpanded then AtlasLoot:ExpandFrame(false, false) end
end

--called to change the current displayed map
function AtlasLoot:MapSelect(mapID, mapNum)
    mapNum = mapNum or 1
    if AtlasLoot_MapData[mapID].MapName then
        for i = 1, 12 do
            _G["AtlasLoot_MapDetailTile"..i]:SetTexture("Interface\\Worldmap\\"..AtlasLoot_MapData[mapID].MapName.."\\"..AtlasLoot_MapData[mapID].MapName..mapNum.."_"..i);
        end
    end  
    Atlasloot_HeaderLabel:SetText(
    AtlasLoot_MapData[mapID].ZoneName[1].._RED.." ["..AtlasLoot_MapData[mapID].Acronym.."]\n"..
    WHITE.."Location: "..AtlasLoot_MapData[mapID].Location[1].."\n"..
    "Level Range: "..AtlasLoot_MapData[mapID].LevelRange.."\n"..
    "Minimum Level: "..AtlasLoot_MapData[mapID].MinLevel.."\n"..
    "Player Limit: "..AtlasLoot_MapData[mapID].PlayerLimit
    );
    AtlasLootDefaultFrame_MapSelectButton:SetText(AtlasLoot_MapData[mapID][mapNum][1][1]);
end

--called when you click on a map in the drop down menu
function AtlasLoot:MapMenuClick(mapID, mapNum)
    mapNum = mapNum or 1
    if AtlasLootDefaultFrame_Map:IsVisible() then
        AtlasLoot:SubTableScrollFrameUpdate(mapID, "AtlasLoot_MapData", mapNum);
        lastMapNum = mapNum
    end
    AtlasLoot:MapSelect(mapID, mapNum);
    AtlasLootDefaultFrame_MapSelectButton:SetText(AtlasLoot_MapData[mapID][mapNum][1][1]);
    ATLASLOOT_CURRENT_MAP = mapID;
end

--drop down map menu
local lastMapLoaded
function AtlasLoot:MapMenuOpen(self)
    local mapID = ATLASLOOT_CURRENT_MAP;
    if AtlasLoot_Dewdrop:IsOpen(self) then AtlasLoot_Dewdrop:Close() return end
    if lastMapLoaded ~= mapID then
        AtlasLoot_Dewdrop:Register(self,
            'point', function(parent)
                return "TOP", "BOTTOM"
            end,
            'children', function(level, value)
                    for i,v in ipairs(AtlasLoot_MapData[mapID]) do
                        AtlasLoot_Dewdrop:AddLine(
                            'text', v[1][1],
                            'func', function() AtlasLoot:MapMenuClick(mapID, i) end,
                            'textHeight', 12,
                            'textWidth', 12,
                            'closeWhenClicked', true,
                            'notCheckable', true
                        )
                    end
                    --Close button
                    AtlasLoot:CloseDewDrop(true,35)
            end,
            'dontHook', true
        )
    end
    AtlasLoot_Dewdrop:Open(self)
end



--all the map data
AtlasLoot_MapData = {
--************************************************
-- Kalimdor Instances (Classic)
--************************************************

["BlackfathomDeeps"] = {
    ZoneName = { BabbleZone["Blackfathom Deeps"], 719 };
    Location = { BabbleZone["Ashenvale"], 331 };
    LevelRange = "20-28";
    MinLevel = "19";
    PlayerLimit = "5";
    Acronym = AL["BFD"];
    MapName = "BlackFathomDeeps";
    [1] = {
        { BabbleSubZone["The Pool of Ask'ar"]};
        { WHITE.."1) "..AL["Ghamoo-ra"], NPC, 4887, cords = {32.9,59.9}};
        { WHITE.."2) "..AL["Lorgalis Manuscript"], ITEM, 5359 };
        { WHITE.."3) "..AL["Lady Sarevess"], NPC, 4831, cords = {10.1,36}};
        { WHITE.."4) "..AL["Argent Guard Thaelrid <The Argent Dawn>"], NPC, 4787 };
        { WHITE.."5) "..AL["Gelihast"], NPC, 6243, cords = {52.3,55.1} };
        { WHITE..INDENT..AL["Shrine of Gelihast"] };
    };
    [2] = {
        { BabbleSubZone["Moonshrine Sanctum"]};
        { WHITE.."6) "..AL["Lorgus Jett"].." ("..AL["Varies"]..")", NPC, 12902, cords = {46,68.9} };
        { WHITE.."7) "..AL["Fathom Stone"], OBJECT, 177964 };
        { WHITE..INDENT..AL["Baron Aquanis"], NPC, 12876 };
        { WHITE.."9) "..AL["Old Serra'kis"], NPC, 4830, cords = {53.4,69.4} };
        { WHITE.."10) "..AL["Aku'mai"], NPC, 4829, cords = {81.7,84.5} };
        { WHITE..INDENT..AL["Morridune"], NPC, 6729 };
        { WHITE..INDENT..AL["Altar of the Deeps"] };
    };
    [3] = {
        { BabbleSubZone["The Forgotten Pool"]};
        { WHITE.."8) "..AL["Twilight Lord Kelris"], NPC, 4832, cords = {55.8,69.2} };
    };
};

["DireMaul"] = {
    ZoneName = { BabbleZone["Dire Maul"], 2557 };
    Location = { BabbleZone["Feralas"], 357 };
    LevelRange = "57-60";
    MinLevel = "45";
    PlayerLimit = "5";
    Acronym = AL["DM"];
    MapName = "DireMaul";
    [1] = {
        { AL["Gordok Commons"].." (North)" };
        { BLUE.."B) "..BabbleZone["Library"].." "..AL["Entrance"] };
        { WHITE.."1) "..AL["Guard Mol'dar"], NPC, 14326, cords = {69.9,76} };
        { WHITE.."2) "..AL["Stomper Kreeg <The Drunk>"], NPC, 14322, cords = {} };
        { WHITE.."3) "..AL["Guard Fengus"], NPC, 14321, cords = {42.9,77.6} };
        { WHITE.."4) "..AL["Knot Thimblejack"], NPC, 14338 };
        { WHITE..INDENT..AL["Guard Slip'kik"], NPC, 14323, cords = {26.5,57.8} };
        { WHITE.."5) "..AL["Captain Kromcrush"], NPC, 14325, cords = {31.8,51.4} };
        { WHITE.."6) "..AL["King Gordok"], NPC, 11501, cords = {32,27.7} };
        { WHITE..INDENT..AL["Cho'Rush the Observer"], NPC, 14324, cords = {31.4,26.2} };
    };
    [2] = {
        { BabbleSubZone["Capital Gardens"].." (West)" };
        { BLUE.."B) "..AL["Pylons"] };
    };
    [3] = {
        { BabbleSubZone["Court of the Highborne"].." (West)" };
        { WHITE.."1) "..AL["Shen'dralar Ancient"], NPC, 14358 };
        { WHITE.."2) "..AL["Tendris Warpwood"], NPC, 11489, cords = {49.4,49.5} };
    };
    [4] = {
        { BabbleSubZone["Prison of Immol'thar"].." (West)" };
        { WHITE..INDENT..AL["Ancient Equine Spirit"], NPC, 14566 };
        { WHITE.."3) "..AL["Illyanna Ravenoak"], NPC, 11488, cords = {36.2,57.4} };
        { WHITE..INDENT..AL["Ferra"], NPC, 14308 };
        { WHITE.."4) "..AL["Magister Kalendris"], NPC, 11487, cords = {66.1,47.3} };
        { WHITE.."5) "..AL["Tsu'zee"].." ("..AL["Rare"]..")", NPC, 11467, cords = {68.3,23.9} };
        { WHITE.."6) "..AL["Immol'thar"], NPC, 11496, cords = {35.2,58.1} };
        { WHITE..INDENT..AL["Lord Hel'nurath"].." ("..AL["Summon"]..")", NPC, 14506, cords = {14.9,57.7} };
        { WHITE.."7) "..AL["Prince Tortheldrin"], NPC, 11486, cords = {61.4,15.1} };
        { GREN.."1') "..BabbleZone["Library"] };
        { GREN..INDENT..AL["Falrin Treeshaper"], NPC, 16032 };
        { GREN..INDENT..AL["Lorekeeper Lydros"], NPC, 14368 };
        { GREN..INDENT..AL["Lorekeeper Javon"], NPC, 14381 };
        { GREN..INDENT..AL["Lorekeeper Kildrath"], NPC, 14383 };
        { GREN..INDENT..AL["Lorekeeper Mykos"], NPC, 14382 };
        { GREN..INDENT..AL["Shen'dralar Provisioner"], NPC, 14371 };
        { GREN..INDENT..AL["Skeletal Remains of Kariel Winthalus"], OBJECT, 179544 };
    };
    [5] = {
        { BabbleSubZone["Warpwood Quarter"].." (East)" };
        { WHITE.."3) "..AL["Zevrim Thornhoof"], NPC, 11490 };
        { WHITE..INDENT..AL["Hydrospawn"], NPC, 13280, cords = {41,49.2} };
        { WHITE..INDENT..AL["Lethtendris"], NPC, 14327, cords = {44.5,46.6} };
        { WHITE..INDENT..AL["Pimgib"], NPC, 14349 };
    };
    [6] = {
        { BabbleSubZone["The Shrine of Eldretharr"].." (East)" };
        { WHITE.."4) "..AL["Old Ironbark"], NPC, 11491 };
        { WHITE.."5) "..AL["Alzzin the Wildshaper"], NPC, 11492, cords = {57.3,28.9} };
        { WHITE..INDENT..AL["Isalien"].." ("..AL["Summon"]..")", NPC, 16097 };
    };
};
["Maraudon"] = {
    ZoneName = { BabbleZone["Maraudon"], 2100 };
    Location = { BabbleZone["Desolace"], 405 };
    LevelRange = "42-51";
    MinLevel = "30";
    PlayerLimit = "5";
    Acronym = AL["Mara"];
    MapName = "Maraudon";
    [1] = {
    { BLUE.."A) "..AL["Entrance"].." ("..AL["Orange"]..")" };
    { BLUE.."B) "..AL["Entrance"].." ("..AL["Purple"]..")" };
    { BLUE.."C) "..AL["Entrance"].." ("..AL["Portal"]..")" };
    { WHITE.."1) "..AL["Veng <The Fifth Khan>"], NPC, 13738 };
    { WHITE.."2) "..AL["Noxxion"], NPC, 13282 };
    { WHITE.."3) "..AL["Razorlash"], NPC, 12258 };
    { WHITE.."4) "..AL["Maraudos <The Fourth Khan>"], NPC, 13739 };
    { WHITE.."5) "..AL["Lord Vyletongue"], NPC, 12236 };
    { WHITE.."6) "..AL["Meshlok the Harvester"].." ("..AL["Rare"]..")", NPC, 12237 };
    { WHITE.."7) "..AL["Celebras the Cursed"], NPC, 12225 };
    { WHITE.."8) "..AL["Landslide"], NPC, 12203 };
    { WHITE.."9) "..AL["Tinkerer Gizlock"], NPC, 13601 };
    { WHITE.."10) "..AL["Rotgrip"], NPC, 13596 };
    { WHITE.."11) "..AL["Princess Theradras"], NPC, 12201 };
    { WHITE.."12) "..AL["Elder Splitrock"].." ("..AL["Lunar Festival"]..")", NPC, 15556 };
    };
};
["RagefireChasm"] = {
    ZoneName = { BabbleZone["Ragefire Chasm"], 2437 };
    Location = { BabbleZone["Orgrimmar"], 1637 };
    LevelRange = "12-18";
    MinLevel = "8";
    PlayerLimit = "5";
    Acronym = AL["RFC"];
    MapName = "RagefireChasm";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Maur Grimtotem"], NPC, 11834 };
    { WHITE..INDENT..AL["Oggleflint <Ragefire Chieftain>"], NPC, 11517 };
    { WHITE.."2) "..AL["Taragaman the Hungerer"], NPC, 11520 };
    { WHITE.."3) "..AL["Jergosh the Invoker"], NPC, 11518 };
    { WHITE..INDENT..AL["Zelemar the Wrathful"].." ("..AL["Summon"]..")", NPC, 17830 };
    { WHITE.."4) "..AL["Bazzalan"], NPC, 11519 };
    };
};
["RazorfenDowns"] = {
    ZoneName = { BabbleZone["Razorfen Downs"], 722 };
    Location = { BabbleZone["The Barrens"], 17 };
    LevelRange = "33-42";
    MinLevel = "25";
    PlayerLimit = "5";
    Acronym = AL["RFD"];
    MapName = "RazorfenDowns";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Tuten'kash"], NPC, 7355 };
    { WHITE.."2) "..AL["Henry Stern"], NPC, 8696 };
    { WHITE..INDENT..AL["Belnistrasz"], NPC, 8516 };
    { WHITE..INDENT..AL["Sah'rhee"], NPC, 8767 };
    { WHITE.."3) "..AL["Mordresh Fire Eye"], NPC, 7357 };
    { WHITE.."4) "..AL["Glutton"], NPC, 8567 };
    { WHITE.."5) "..AL["Ragglesnout"].." ("..AL["Rare"]..", "..AL["Varies"]..")", NPC, 7354 };
    { WHITE.."6) "..AL["Amnennar the Coldbringer"], NPC, 7358 };
    { WHITE.."7) "..AL["Plaguemaw the Rotting"], NPC, 7356 };
    };
};
["RazorfenKraul"] = {
    ZoneName = { BabbleZone["Razorfen Kraul"], 491 };
    Location = { BabbleZone["The Barrens"], 17 };
    LevelRange = "23-33";
    MinLevel = "17";
    PlayerLimit = "5";
    Acronym = AL["RFK"];
    MapName = "RazorfenKraul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Roogug"], NPC, 6168 };
    { WHITE.."2) "..AL["Aggem Thorncurse <Death's Head Prophet>"], NPC, 4424 };
    { WHITE.."3) "..AL["Death Speaker Jargba <Death's Head Captain>"], NPC, 4428 };
    { WHITE.."4) "..AL["Overlord Ramtusk"], NPC, 4420 };
    { WHITE..INDENT..AL["Razorfen Spearhide"], NPC, 4438 };
    { WHITE.."5) "..AL["Agathelos the Raging"], NPC, 4422 };
    { WHITE.."6) "..AL["Blind Hunter"].." ("..AL["Rare"]..")", NPC, 4425 };
    { WHITE.."7) "..AL["Charlga Razorflank <The Crone>"], NPC, 4421 };
    { WHITE.."8) "..AL["Willix the Importer"], NPC, 4508 };
    { WHITE..INDENT..AL["Heralath Fallowbrook"], NPC, 4510 };
    { WHITE.."9) "..AL["Earthcaller Halmgar"].." ("..AL["Rare"]..")", NPC, 4842 };
    };
};
["TheRuinsofAhnQiraj"] = {
    ZoneName = { BabbleZone["Ruins of Ahn'Qiraj"], 3429 };
    Location = { BabbleZone["Silithus"], 1377 };
    LevelRange = "60-70";
    MinLevel = "50";
    PlayerLimit = "20";
    Acronym = AL["AQ20"];
    MapName = "RuinsofAhnQiraj";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Cenarion Circle"], FACTION, 609 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Kurinnaxx"], NPC, 15348 };
    { WHITE..INDENT..AL["Lieutenant General Andorov"], NPC, 15471 };
    { WHITE..INDENT..AL["Four Kaldorei Elites"], NPC, 15473 };
    { WHITE.."2) "..AL["General Rajaxx"], NPC, 15341 };
    { WHITE..INDENT..AL["Captain Qeez"], NPC, 15391 };
    { WHITE..INDENT..AL["Captain Tuubid"], NPC, 15392 };
    { WHITE..INDENT..AL["Captain Drenn"], NPC, 15389 };
    { WHITE..INDENT..AL["Captain Xurrem"], NPC, 15390 };
    { WHITE..INDENT..AL["Major Yeggeth"], NPC, 15386 };
    { WHITE..INDENT..AL["Major Pakkon"], NPC, 15388 };
    { WHITE..INDENT..AL["Colonel Zerran"], NPC, 15385 };
    { WHITE.."3) "..AL["Moam"].." ("..AL["Optional"]..")", NPC, 15340 };
    { WHITE.."4) "..AL["Buru the Gorger"].." ("..AL["Optional"]..")", NPC, 15370 };
    { WHITE.."5) "..AL["Ayamiss the Hunter"].." ("..AL["Optional"]..")", NPC, 15369 };
    { WHITE.."6) "..AL["Ossirian the Unscarred"], NPC, 15339 };
    { GREN.."1') "..AL["Safe Room"] };
    };
};
["TheTempleofAhnQiraj"] = {
    ZoneName = { BabbleZone["Temple of Ahn'Qiraj"], 3428 };
    Location = { BabbleZone["Silithus"], 1377 };
    LevelRange = "60-70";
    MinLevel = "50";
    PlayerLimit = "10-25";
    Acronym = AL["AQ40"];
    MapName = "AhnQiraj";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Brood of Nozdormu"], FACTION, 910 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["The Prophet Skeram"].." ("..AL["Outside"]..")", NPC, 15263 };
    { WHITE.."2) "..AL["The Bug Family"].." ("..AL["Optional"]..")" };
    { WHITE..INDENT..AL["Vem"], NPC, 15544 };
    { WHITE..INDENT..AL["Lord Kri"], NPC, 15511 };
    { WHITE..INDENT..AL["Princess Yauj"], NPC, 15543 };
    { WHITE.."3) "..AL["Battleguard Sartura"], NPC, 15516 };
    { WHITE.."4) "..AL["Fankriss the Unyielding"], NPC, 15510 };
    { WHITE.."5) "..AL["Viscidus"].." ("..AL["Optional"]..")", NPC, 15299 };
    { WHITE.."6) "..AL["Princess Huhuran"], NPC, 15509 };
    { WHITE.."7) "..AL["Twin Emperors"] };
    { WHITE..INDENT..AL["Emperor Vek'lor"], NPC, 15276 };
    { WHITE..INDENT..AL["Emperor Vek'nilash"], NPC, 15275 };
    { WHITE.."8) "..AL["Ouro"].." ("..AL["Optional"]..")", NPC, 15517 };
    { WHITE.."9) "..AL["Eye of C'Thun"], NPC, 15589 };
    { WHITE..INDENT..AL["C'Thun"], NPC, 15727 };
    { GREN.."1') "..AL["Andorgos <Brood of Malygos>"], NPC, 15502 };
    { GREN..INDENT..AL["Vethsera <Brood of Ysera>"], NPC, 15504 };
    { GREN..INDENT..AL["Kandrostrasz <Brood of Alexstrasza>"], NPC, 15503 };
    { GREN.."2') "..AL["Arygos"], NPC, 15380 };
    { GREN..INDENT..AL["Caelestrasz"], NPC, 15379 };
    { GREN..INDENT..AL["Merithra of the Dream"], NPC, 15378 };
    };
};
["WailingCaverns"] = {
    ZoneName = { BabbleZone["Wailing Caverns"], 718 };
    Location = { BabbleZone["The Barrens"], 17 };
    LevelRange = "16-25";
    MinLevel = "10";
    PlayerLimit = "5";
    Acronym = AL["WC"];
    MapName = "WailingCaverns";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Disciple of Naralex"], NPC, 3678 };
    { WHITE.."2) "..AL["Lord Cobrahn <Fanglord>"], NPC, 3669 };
    { WHITE.."3) "..AL["Lady Anacondra <Fanglord>"].." ("..AL["Varies"]..")", NPC, 3671 };
    { WHITE.."4) "..AL["Kresh"].." ("..AL["Varies"]..")", NPC, 3653 };
    { WHITE.."5) "..AL["Lord Pythas <Fanglord>"], NPC, 3670 };
    { WHITE.."6) "..AL["Skum"], NPC, 3674 };
    { WHITE.."7) "..AL["Lord Serpentis <Fanglord>"].." ("..AL["Upper"]..")", NPC, 3673 };
    { WHITE.."8) "..AL["Verdan the Everliving"].." ("..AL["Upper"]..")", NPC, 5775 };
    { WHITE.."9) "..AL["Mutanus the Devourer"], NPC, 3654 };
    { WHITE..INDENT..AL["Naralex"], NPC, 3679 };
    { WHITE.."10) "..AL["Deviate Faerie Dragon"].." ("..AL["Rare"]..")", NPC, 5912 };
    };
};
["ZulFarrak"] = {
    ZoneName = { BabbleZone["Zul'Farrak"], 978 };
    Location = { BabbleZone["Tanaris"], 440 };
    LevelRange = "42-48";
    MinLevel = "35";
    PlayerLimit = "5";
    Acronym = AL["ZF"];
    MapName = "ZulFarrak";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Antu'sul <Overseer of Sul>"], NPC, 8127 };
    { WHITE.."2) "..AL["Theka the Martyr"], NPC, 7272 };
    { WHITE.."3) "..AL["Witch Doctor Zum'rah"], NPC, 7271 };
    { WHITE..INDENT..AL["Zul'Farrak Dead Hero"], NPC, 7276 };
    { WHITE.."4) "..AL["Nekrum Gutchewer"], NPC, 7796 };
    { WHITE..INDENT..AL["Shadowpriest Sezz'ziz"], NPC, 7275 };
    { WHITE..INDENT..AL["Dustwraith"].." ("..AL["Rare"]..")", NPC, 10081 };
    { WHITE.."5) "..AL["Sergeant Bly"], NPC, 7604 };
    { WHITE..INDENT..AL["Weegli Blastfuse"], NPC, 7607 };
    { WHITE..INDENT..AL["Murta Grimgut"], NPC, 7608 };
    { WHITE..INDENT..AL["Raven"], NPC, 7605 };
    { WHITE..INDENT..AL["Oro Eyegouge"], NPC, 7606 };
    { WHITE..INDENT..AL["Sandfury Executioner"], NPC, 7274 };
    { WHITE.."6) "..AL["Hydromancer Velratha"], NPC, 7795 };
    { WHITE..INDENT..AL["Gahz'rilla"].." ("..AL["Summon"]..")", NPC, 7273 };
    { WHITE..INDENT..AL["Elder Wildmane"].." ("..AL["Lunar Festival"]..")", NPC, 15578 };
    { WHITE.."7) "..AL["Chief Ukorz Sandscalp"], NPC, 7267 };
    { WHITE..INDENT..AL["Ruuzlu"], NPC, 7797 };
    { WHITE.."8) "..AL["Zerillis"].." ("..AL["Rare"]..", "..AL["Wanders"]..")", NPC, 10082 };
    { WHITE.."9) "..AL["Sandarr Dunereaver"].." ("..AL["Rare"]..")", NPC, 10080 };
    };
};

--************************************************
-- Eastern Kingdoms Instances (Classic)
--************************************************

["BlackrockDepths"] = {
    ZoneName = { BabbleZone["Blackrock Depths"], 1584 };
    Location = { BabbleZone["Searing Gorge"].." / "..BabbleZone["Burning Steppes"], 51, 46 };
    LevelRange = "52-58";
    MinLevel = "10-25";
    PlayerLimit = "5";
    Acronym = AL["BRD"];
    MapName = "BlackrockDepths";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["Shadowforge Key"], ITEM, 11000 };
    { ORNG..AL["Key"]..": "..AL["Prison Cell Key"].." ("..AL["Jail Break!"]..")", ITEM, 11140 };
    { ORNG..AL["Key"]..": "..AL["Banner of Provocation"].." ("..AL["Theldren"]..")", ITEM, 21986 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Lord Roccor"], NPC, 9025 };
    { WHITE.."2) "..AL["Kharan Mighthammer"], NPC, 9021 };
    { WHITE.."3) "..AL["Commander Gor'shak <Kargath Expeditionary Force>"], NPC, 9020 };
    { WHITE.."4) "..AL["Marshal Windsor"], NPC, 9023 };
    { WHITE.."5) "..AL["High Interrogator Gerstahn <Twilight's Hammer Interrogator>"], NPC, 9018 };
    { WHITE.."6) "..AL["Ring of Law"] };
    { WHITE..INDENT..AL["Anub'shiah"].." ("..AL["Random"]..")", NPC, 9031 };
    { WHITE..INDENT..AL["Eviscerator"].." ("..AL["Random"]..")", NPC, 9029 };
    { WHITE..INDENT..AL["Gorosh the Dervish"].." ("..AL["Random"]..")", NPC, 9027 };
    { WHITE..INDENT..AL["Grizzle"].." ("..AL["Random"]..")", NPC, 9028 };
    { WHITE..INDENT..AL["Hedrum the Creeper"].." ("..AL["Random"]..")", NPC, 9032 };
    { WHITE..INDENT..AL["Ok'thor the Breaker"].." ("..AL["Random"]..")", NPC, 9030 };
    { WHITE..INDENT..AL["Theldren"].." ("..AL["Summon"]..")", NPC, 16059 };
    { WHITE..INDENT..AL["Lefty"], NPC, 16049 };
    { WHITE..INDENT..AL["Malgen Longspear"], NPC, 16052 };
    { WHITE..INDENT..AL["Gnashjaw <Malgen Longspear's Pet>"], NPC, 16095 };
    { WHITE..INDENT..AL["Rotfang"], NPC, 16050 };
    { WHITE..INDENT..AL["Va'jashni"], NPC, 16055 };
    { WHITE..INDENT..AL["Houndmaster Grebmar"].." ("..AL["Lower"]..")", NPC, 9319 };
    { WHITE..INDENT..AL["Elder Morndeep"].." ("..AL["Lunar Festival"]..")", NPC, 15549 };
    { WHITE..INDENT..AL["High Justice Grimstone"], NPC, 10096 };
    { WHITE.."7) "..AL["Monument of Franclorn Forgewright"], OBJECT, 164689 };
    { WHITE..INDENT..AL["Pyromancer Loregrain"], NPC, 9024 };
    { WHITE.."8) "..AL["The Vault"] };
    { WHITE..INDENT..AL["Warder Stilgiss"], NPC, 9041 };
    { WHITE..INDENT..AL["Verek"], NPC, 9042 };
    { WHITE..INDENT..AL["Watchman Doomgrip"], NPC, 9476 };
    { WHITE.."9) "..AL["Fineous Darkvire <Chief Architect>"], NPC, 9056 };
    { WHITE.."10) "..AL["The Black Anvil"] };
    { WHITE..INDENT..AL["Lord Incendius"], NPC, 9017 };
    { WHITE.."11) "..AL["Bael'Gar"], NPC, 9016 };
    { WHITE.."12) "..AL["Shadowforge Lock"] };
    { WHITE.."13) "..AL["General Angerforge"], NPC, 9033 };
    { WHITE.."14) "..AL["Golem Lord Argelmach"], NPC, 8983 };
    { WHITE..INDENT..AL["Field Repair Bot 74A"], NPC, 14337 };
    { WHITE..INDENT..AL["Blacksmithing Plans"], OBJECT, 173232 };
    { WHITE.."15) "..AL["The Grim Guzzler"] };
    { WHITE..INDENT..AL["Hurley Blackbreath"], NPC, 9537 };
    { WHITE..INDENT..AL["Lokhtos Darkbargainer <The Thorium Brotherhood>"], NPC, 12944 };
    { WHITE..INDENT..AL["Mistress Nagmara"], NPC, 9500 };
    { WHITE..INDENT..AL["Phalanx"], NPC, 9502 };
    { WHITE..INDENT..AL["Plugger Spazzring"], NPC, 9499 };
    { WHITE..INDENT..AL["Private Rocknot"], NPC, 9503 };
    { WHITE..INDENT..AL["Ribbly Screwspigot"], NPC, 9543 };
    { WHITE..INDENT..AL["Coren Direbrew"].." ("..AL["Brewfest"]..")", NPC, 23872 };
    { WHITE..INDENT..AL["Griz Gutshank <Arena Vendor>"], NPC, 28225 };
    { WHITE.."16) "..AL["Ambassador Flamelash"], NPC, 9156 };
    { WHITE.."17) "..AL["Panzor the Invincible"].." ("..AL["Rare"]..")", NPC, 8923 };
    { WHITE..INDENT..AL["Blacksmithing Plans"], OBJECT, 173232 };
    { WHITE.."18) "..AL["Summoner's Tomb"] };
    { WHITE.."19) "..AL["The Lyceum"] };
    { WHITE.."20) "..AL["Magmus"], NPC, 9938 };
    { WHITE.."21) "..AL["Emperor Dagran Thaurissan"], NPC, 9019 };
    { WHITE..INDENT..AL["Princess Moira Bronzebeard <Princess of Ironforge>"], NPC, 8929 };
    { WHITE..INDENT..AL["High Priestess of Thaurissan"], NPC, 10076 };
    { WHITE.."22) "..AL["The Black Forge"] };
    { WHITE.."23) "..BabbleZone["Molten Core"], ZONE, 2717 };
    { WHITE..INDENT..AL["Core Fragment"], OBJECT, 179553 };
    { WHITE.."24) "..AL["Overmaster Pyron"], NPC, 9026 };
    { WHITE.."25) "..AL["Blacksmithing Plans"], OBJECT, 173232 };
    };
};
["BlackrockSpireLower"] = {
    ZoneName = { BabbleZone["Blackrock Spire"].." ("..AL["Lower"]..")", 1583 };
    Location = { BabbleZone["Searing Gorge"].." / "..BabbleZone["Burning Steppes"], 51, 46 };
    LevelRange = "54-60";
    MinLevel = "45";
    PlayerLimit = "5";
    Acronym = AL["LBRS"];
    MapName = "BlackrockSpire";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["Brazier of Invocation"].." ("..AL["DS2"]..")", ITEM, 22057 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..BabbleZone["Blackrock Spire"].." ("..AL["Upper"]..")", ZONE, 1583 };
    { BLUE.."C-F) "..AL["Connection"] };
    { WHITE.."1) "..AL["Vaelan"].." ("..AL["Upper"]..")", NPC, 10296 };
    { WHITE.."2) "..AL["Warosh <The Cursed>"].." ("..AL["Wanders"]..")", NPC, 10799 };
    { WHITE..INDENT..AL["Elder Stonefort"].." ("..AL["Lunar Festival"]..")", NPC, 15560 };
    { WHITE.."3) "..AL["Roughshod Pike"], OBJECT, 175886 };
    { WHITE.."4) "..AL["Spirestone Butcher"].." ("..AL["Rare"]..")", NPC, 9219 };
    { WHITE.."5) "..AL["Highlord Omokk"], NPC, 9196 };
    { WHITE.."6) "..AL["Spirestone Battle Lord"].." ("..AL["Rare"]..")", NPC, 9218 };
    { WHITE..INDENT..AL["Spirestone Lord Magus"].." ("..AL["Rare"]..")", NPC, 9217 };
    { WHITE.."7) "..AL["Shadow Hunter Vosh'gajin"], NPC, 9236 };
    { WHITE..INDENT..AL["Fifth Mosh'aru Tablet"], OBJECT, 175949 };
    { WHITE.."8) "..AL["Bijou"], NPC, 10257 };
    { WHITE.."9) "..AL["War Master Voone"], NPC, 9237 };
    { WHITE..INDENT..AL["Mor Grayhoof"].." ("..AL["Summon"]..")", NPC, 16080 };
    { WHITE..INDENT..AL["Sixth Mosh'aru Tablet"], OBJECT, 175950 };
    { WHITE.."10) "..AL["Bijou's Belongings"], OBJECT, 175334 };
    { WHITE.."11) "..AL["Human Remains"].." ("..AL["Lower"]..")", OBJECT, 176090 };
    { WHITE..INDENT..AL["Unfired Plate Gauntlets"].." ("..AL["Lower"]..")", OBJECT, 176089 };
    { WHITE.."12) "..AL["Bannok Grimaxe <Firebrand Legion Champion>"].." ("..AL["Rare"]..")", NPC, 9596 };
    { WHITE.."13) "..AL["Mother Smolderweb"], NPC, 10596 };
    { WHITE.."14) "..AL["Crystal Fang"].." ("..AL["Rare"]..")", NPC, 10376 };
    { WHITE.."15) "..AL["Urok's Tribute Pile"], OBJECT, 175621 };
    { WHITE..INDENT..AL["Urok Doomhowl"].." ("..AL["Summon"]..")", NPC, 10584 };
    { WHITE.."16) "..AL["Quartermaster Zigris <Bloodaxe Legion>"], NPC, 9736 };
    { WHITE.."17) "..AL["Halycon"], NPC, 10220 };
    { WHITE..INDENT..AL["Gizrul the Slavener"], NPC, 10268 };
    { WHITE.."18) "..AL["Ghok Bashguud <Bloodaxe Champion>"].." ("..AL["Rare"]..")", NPC, 9718 };
    { WHITE.."19) "..AL["Overlord Wyrmthalak"], NPC, 9568 };
    { GREN.."1') "..AL["Burning Felguard"].." ("..AL["Rare"]..", "..AL["Summon"]..")", NPC, 10263 };
    };
    [2] = {
    { ORNG..AL["Key"]..": "..AL["Brazier of Invocation"].." ("..AL["DS2"]..")", ITEM, 22057 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..BabbleZone["Blackrock Spire"].." ("..AL["Lower"]..")", ZONE, 1583 };
    { BLUE.."C-E) "..AL["Connection"] };
    { WHITE.."1) "..AL["Pyroguard Emberseer"], NPC, 9816 };
    { WHITE.."2) "..AL["Solakar Flamewreath"], NPC, 10264 };
    { WHITE..INDENT..AL["Father Flame"], OBJECT, 175245 };
    { WHITE.."3) "..AL["Darkstone Tablet"], OBJECT, 175385 };
    { WHITE..INDENT..AL["Doomrigger's Coffer"], OBJECT, 175382 };
    { WHITE.."4) "..AL["Jed Runewatcher <Blackhand Legion>"].." ("..AL["Rare"]..")", NPC, 10509 };
    { WHITE.."5) "..AL["Goraluk Anvilcrack <Blackhand Legion Armorsmith>"], NPC, 10899 };
    { WHITE.."6) "..AL["Warchief Rend Blackhand"], NPC, 10429 };
    { WHITE..INDENT..AL["Gyth <Rend Blackhand's Mount>"], NPC, 10339 };
    { WHITE.."7) "..AL["Awbee"], NPC, 10740 };
    { WHITE.."8) "..AL["The Beast"], NPC, 10430 };
    { WHITE..INDENT..AL["Lord Valthalak"].." ("..AL["Summon"]..")", NPC, 16042 };
    { WHITE..INDENT..AL["Finkle Einhorn"], NPC, 10776 };
    { WHITE.."9) "..AL["General Drakkisath"], NPC, 10363 };
    { WHITE..INDENT..AL["Drakkisath's Brand"], OBJECT, 179880 };
    { WHITE.."10) "..BabbleZone["Blackwing Lair"], ZONE, 2677 };
    };
};
["BlackwingLair"] = {
    ZoneName = { BabbleZone["Blackwing Lair"], 2677 };
    Location = { BabbleZone["Searing Gorge"].." / "..BabbleZone["Burning Steppes"], 51, 46 };
    LevelRange = "60-70";
    MinLevel = "60";
    PlayerLimit = "10-25";
    Acronym = AL["BWL"];
    MapName = "BlackwingLair";
    [1] = {
    { ORNG..AL["Attunement Required"] };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Connection"] };
    { BLUE.."C) "..AL["Connection"] };
    { WHITE.."1) "..AL["Razorgore the Untamed"], NPC, 12435 };
    { WHITE.."2) "..AL["Vaelastrasz the Corrupt"], NPC, 13020 };
    { WHITE.."3) "..AL["Broodlord Lashlayer"], NPC, 12017 };
    { WHITE.."4) "..AL["Firemaw"], NPC, 11983 };
    { WHITE.."5) "..AL["Draconic for Dummies (Chapter VII)"], ITEM, 21109 };
    { WHITE.."6) "..AL["Master Elemental Shaper Krixix"], NPC, 14401 };
    { WHITE.."7) "..AL["Ebonroc"], NPC, 14601 };
    { WHITE.."8) "..AL["Flamegor"], NPC, 11981 };
    { WHITE.."9) "..AL["Chromaggus"], NPC, 14020 };
    { WHITE.."10) "..AL["Nefarian"], NPC, 11583 };
    };
};
["Gnomeregan"] = {
    ZoneName = { BabbleZone["Gnomeregan"], 133 };
    Location = { BabbleZone["Dun Morogh"], 1 };
    LevelRange = "24-32";
    MinLevel = "20";
    PlayerLimit = "5";
    Acronym = AL["Gnome"];
    MapName = "Gnomeregan";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["Workshop Key"].." ("..AL["Back"]..")", ITEM, 6893 };
    { BLUE.."A) "..AL["Entrance"].." ("..AL["Front"]..")" };
    { BLUE.."B) "..AL["Entrance"].." ("..AL["Back"]..")" };
    { WHITE.."1) "..AL["Blastmaster Emi Shortfuse"], NPC, 7998 };
    { WHITE..INDENT..AL["Grubbis"], NPC, 7361 };
    { WHITE..INDENT..AL["Chomper"], NPC, 6215 };
    { WHITE.."2) "..AL["Clean Room"] };
    { WHITE..INDENT..AL["Tink Sprocketwhistle <Engineering Supplies>"], NPC, 9676 };
    { WHITE..INDENT..AL["The Sparklematic 5200"], OBJECT, 142487 };
    { WHITE..INDENT..AL["Mail Box"] };
    { WHITE.."3) "..AL["Kernobee"], NPC, 7850 };
    { WHITE..INDENT..AL["Alarm-a-bomb 2600"], NPC, 7897 };
    { WHITE..INDENT..AL["Matrix Punchograph 3005-B"], OBJECT, 142475 };
    { WHITE.."4) "..AL["Viscous Fallout"], NPC, 7079 };
    { WHITE.."5) "..AL["Electrocutioner 6000"], NPC, 6235 };
    { WHITE..INDENT..AL["Matrix Punchograph 3005-C"], OBJECT, 142476 };
    { WHITE.."6) "..AL["Crowd Pummeler 9-60"].." ("..AL["Upper"]..")", NPC, 6229 };
    { WHITE..INDENT..AL["Matrix Punchograph 3005-D"], OBJECT, 142696 };
    { WHITE.."7) "..AL["Dark Iron Ambassador"], NPC, 6228 };
    { WHITE.."8) "..AL["Mekgineer Thermaplugg"], NPC, 7800 };
    };
};
["MoltenCore"] = {
    ZoneName = { BabbleZone["Molten Core"], 2717 };
    Location = { BabbleZone["Searing Gorge"].." / "..BabbleZone["Burning Steppes"], 51, 46 };
    LevelRange = "60-70";
    MinLevel = "50";
    PlayerLimit = "10-25";
    Acronym = AL["MC"];
    MapName = "MoltenCore";
    [1] = {
    { ORNG..AL["Attunement Required"] };
    { ORNG..AL["Reputation"]..": "..AL["Hydraxian Waterlords"], FACTION, 749 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Lucifron"], NPC, 12118 };
    { WHITE.."2) "..AL["Magmadar"], NPC, 11982 };
    { WHITE.."3) "..AL["Gehennas"], NPC, 12259 };
    { WHITE.."4) "..AL["Garr"], NPC, 12057 };
    { WHITE.."5) "..AL["Shazzrah"], NPC, 12264 };
    { WHITE.."6) "..AL["Baron Geddon"], NPC, 12056 };
    { WHITE.."7) "..AL["Golemagg the Incinerator"], NPC, 11988 };
    { WHITE.."8) "..AL["Sulfuron Harbinger"], NPC, 12098 };
    { WHITE.."9) "..AL["Majordomo Executus"], NPC, 12018 };
    { WHITE.."10) "..AL["Ragnaros"], NPC, 11502 };
    };
};
["Scholomance"] = {
    ZoneName = { BabbleZone["Scholomance"], 2057 };
    Location = { BabbleZone["Western Plaguelands"], 28 };
    LevelRange = "58-60";
    MinLevel = "45";
    PlayerLimit = "5";
    Acronym = AL["Scholo"];
    MapName = "Scholomance";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Argent Dawn"], FACTION, 529 };
    { ORNG..AL["Key"]..": "..AL["Skeleton Key"], ITEM, 13704 };
    { ORNG..AL["Key"]..": "..AL["Viewing Room Key"].." ("..AL["Viewing Room"]..")", ITEM, 13873 };
    { ORNG..AL["Key"]..": "..AL["Blood of Innocents"].." ("..AL["Kirtonos the Herald"]..")", ITEM, 13523 };
    { ORNG..AL["Key"]..": "..AL["Brazier of Invocation"].." ("..AL["DS2"]..")", ITEM, 22057 };
    { ORNG..AL["Key"]..": "..AL["Divination Scryer"].." ("..AL["Death Knight Darkreaver"]..")", ITEM, 18746 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Connection"] };
    { BLUE.."C) "..AL["Connection"] };
    { WHITE.."1) "..AL["Blood Steward of Kirtonos"], NPC, 14861 };
    { WHITE..INDENT..AL["The Deed to Southshore"], OBJECT, 176486 };
    { WHITE.."2) "..AL["Kirtonos the Herald"].." ("..AL["Summon"]..")", NPC, 10506 };
    { WHITE.."3) "..AL["Jandice Barov"], NPC, 10503 };
    { WHITE.."4) "..AL["The Deed to Tarren Mill"], OBJECT, 176487 };
    { WHITE.."5) "..AL["Rattlegore"].." ("..AL["Lower"]..")", NPC, 11622 };
    { WHITE..INDENT..AL["Death Knight Darkreaver"].." ("..AL["Summon"]..")", NPC, 14516 };
    { WHITE.."6) "..AL["Marduk Blackpool"], NPC, 10433 };
    { WHITE..INDENT..AL["Vectus"], NPC, 10432 };
    { WHITE.."7) "..AL["Ras Frostwhisper"], NPC, 10508 };
    { WHITE..INDENT..AL["The Deed to Brill"], OBJECT, 176484 };
    { WHITE..INDENT..AL["Kormok"].." ("..AL["Summon"]..")", NPC, 16118 };
    { WHITE.."8) "..AL["Instructor Malicia"], NPC, 10505 };
    { WHITE.."9) "..AL["Doctor Theolen Krastinov <The Butcher>"], NPC, 11261 };
    { WHITE.."10) "..AL["Lorekeeper Polkelt"], NPC, 10901 };
    { WHITE.."11) "..AL["The Ravenian"], NPC, 10507 };
    { WHITE.."12) "..AL["Lord Alexei Barov"], NPC, 10504 };
    { WHITE..INDENT..AL["The Deed to Caer Darrow"], OBJECT, 176485 };
    { WHITE.."13) "..AL["Lady Illucia Barov"], NPC, 10502 };
    { WHITE.."14) "..AL["Darkmaster Gandling"], NPC, 1853 };
    { GREN.."1') "..AL["Torch Lever"] };
    { GREN.."2') "..AL["Secret Chest"] };
    { GREN.."3') "..AL["Alchemy Lab"] };
    };
};
["ShadowfangKeep"] = {
    ZoneName = { BabbleZone["Shadowfang Keep"], 209 };
    Location = { BabbleZone["Silverpine Forest"], 130 };
    LevelRange = "17-25";
    MinLevel = "10";
    PlayerLimit = "5";
    Acronym = AL["SFK"];
    MapName = "ShadowfangKeep";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Rethilgore <The Cell Keeper>"], NPC, 3914 };
    { WHITE..INDENT..AL["Sorcerer Ashcrombe"], NPC, 3850 };
    { WHITE..INDENT..AL["Deathstalker Adamant"], NPC, 3849 };
    { WHITE..INDENT..AL["Landen Stilwell"], NPC, 17822 };
    { WHITE.."2) "..AL["Investigator Fezzen Brasstacks"].." ("..AL["Love is in the Air"]..")", NPC, 38208 };
    { WHITE.."3) "..AL["Deathstalker Vincent"], NPC, 4444 };
    { WHITE.."4) "..AL["Apothecary Trio"].." ("..AL["Love is in the Air"]..")" };
    { WHITE..INDENT..AL["Apothecary Hummel <Crown Chemical Co.>"], NPC, 36296 };
    { WHITE..INDENT..AL["Apothecary Baxter <Crown Chemical Co.>"], NPC, 36565 };
    { WHITE..INDENT..AL["Apothecary Frye <Crown Chemical Co.>"], NPC, 36272 };
    { WHITE.."5) "..AL["Fel Steed"], NPC, 3864 };
    { WHITE..INDENT..AL["Jordan's Hammer"], OBJECT, 91138 };
    { WHITE..INDENT..AL["Crate of Ingots"], OBJECT, 182011 };
    { WHITE.."6) "..AL["Razorclaw the Butcher"], NPC, 3886 };
    { WHITE.."7) "..AL["Baron Silverlaine"], NPC, 3887 };
    { WHITE.."8) "..AL["Commander Springvale"], NPC, 4278 };
    { WHITE.."9) "..AL["Odo the Blindwatcher"], NPC, 4279 };
    { WHITE.."10) "..AL["Deathsworn Captain"].." ("..AL["Rare"]..")", NPC, 3872 };
    { WHITE.."11) "..AL["Fenrus the Devourer"], NPC, 4274 };
    { WHITE..INDENT..AL["Arugal's Voidwalker"], NPC, 4627 };
    { WHITE..INDENT..AL["The Book of Ur"], OBJECT, 36738 };
    { WHITE.."12) "..AL["Wolf Master Nandos"], NPC, 3927 };
    { WHITE.."13) "..AL["Archmage Arugal"], NPC, 4275 };
    };
};
["ScarletMonastery"] = {
    ZoneName = { BabbleZone["Armory"], 796 };
    Location = { BabbleZone["Tirisfal Glades"], 85 };
    LevelRange = "33-40";
    MinLevel = "20";
    PlayerLimit = "5";
    Acronym = AL["Armory"];
    MapName = "ScarletMonastery";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["The Scarlet Key"], ITEM, 7146 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Herod <The Scarlet Champion>"], NPC, 3975 };
    };
    [2] = {
    { ORNG..AL["Key"]..": "..AL["The Scarlet Key"], ITEM, 7146 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["High Inquisitor Fairbanks"], NPC, 4542 };
    { WHITE.."2) "..AL["Scarlet Commander Mograine"], NPC, 3976 };
    { WHITE..INDENT..AL["High Inquisitor Whitemane"], NPC, 3977 };
    };
    [3] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Interrogator Vishas"], NPC, 3983 };
    { WHITE..INDENT..AL["Vorrel Sengutz"], NPC, 3981 };
    { WHITE.."2) "..AL["Pumpkin Shrine"].." ("..AL["Hallow's End"]..")", OBJECT, 186267 };
    { WHITE..INDENT..AL["Headless Horseman"].." ("..AL["Summon"]..")", NPC, 23682 };
    { WHITE.."3) "..AL["Bloodmage Thalnos"], NPC, 4543 };
    { GREN.."1') "..AL["Ironspine"].." ("..AL["Rare"]..")", NPC, 6489 };
    { GREN..INDENT..AL["Azshir the Sleepless"].." ("..AL["Rare"]..")", NPC, 6490 };
    { GREN..INDENT..AL["Fallen Champion"].." ("..AL["Rare"]..")", NPC, 6488 };
    };
    [4] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Houndmaster Loksey"], NPC, 3974 };
    { WHITE.."2) "..AL["Arcanist Doan"], NPC, 6487 };
    };
};
["Stratholme"] = {
    ZoneName = { BabbleZone["Stratholme"], 2017 };
    Location = { BabbleZone["Eastern Plaguelands"], 139 };
    LevelRange = "58-60";
    MinLevel = "45";
    PlayerLimit = "5";
    Acronym = AL["Strat"];
    MapName = "Stratholme";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Argent Dawn"], FACTION, 529 };
    { ORNG..AL["Key"]..": "..AL["The Scarlet Key"].." ("..AL["Living Side"]..")", ITEM, 7146 };
    { ORNG..AL["Key"]..": "..AL["Key to the City"].." ("..AL["Undead Side"]..")", ITEM, 12382 };
    { ORNG..AL["Key"]..": "..AL["Various Postbox Keys"].." ("..AL["Postmaster Malown"]..")" };
    { ORNG..AL["Key"]..": "..AL["Brazier of Invocation"].." ("..AL["DS2"]..")", ITEM, 22057 };
    { BLUE.."A) "..AL["Entrance"].." ("..AL["Front"]..")" };
    { BLUE.."B) "..AL["Entrance"].." ("..AL["Side"]..")" };
    { WHITE.."1) "..AL["Skul"].." ("..AL["Rare"]..", "..AL["Varies"]..")", NPC, 10393 };
    { WHITE..INDENT..AL["Stratholme Courier"], NPC, 11082 };
    { WHITE..INDENT..AL["Fras Siabi"], NPC, 11058 };
    { WHITE.."2) "..AL["Atiesh <Hand of Sargeras>"].." ("..AL["Summon"]..")", NPC, 16387 };
    { WHITE.."3) "..AL["Hearthsinger Forresten"].." ("..AL["Varies"]..")", NPC, 10558 };
    { WHITE.."4) "..AL["The Unforgiven"], NPC, 10516 };
    { WHITE.."5) "..AL["Elder Farwhisper"].." ("..AL["Lunar Festival"]..")", NPC, 15607 };
    { WHITE.."6) "..AL["Timmy the Cruel"], NPC, 10808 };
    { WHITE.."7) "..AL["Malor the Zealous"], NPC, 11032 };
    { WHITE..INDENT..AL["Malor's Strongbox"], OBJECT, 176112 };
    { WHITE.."8) "..AL["Crimson Hammersmith"].." ("..AL["Summon"]..")", NPC, 11120 };
    { WHITE..INDENT..AL["Blacksmithing Plans"], OBJECT, 173232 };
    { WHITE.."9) "..AL["Cannon Master Willey"], NPC, 10997 };
    { WHITE.."10) "..AL["Archivist Galford"], NPC, 10811 };
    { WHITE.."11) "..AL["Grand Crusader Dathrohan"], NPC, 10812 };
    { WHITE..INDENT..AL["Balnazzar"], NPC, 10813 };
    { WHITE..INDENT..AL["Sothos"].." ("..AL["Summon"]..")", NPC, 16102 };
    { WHITE..INDENT..AL["Jarien"].." ("..AL["Summon"]..")", NPC, 16101 };
    { WHITE.."12) "..AL["Magistrate Barthilas"].." ("..AL["Varies"]..")", NPC, 10435 };
    { WHITE.."13) "..AL["Aurius"], NPC, 10917 };
    { WHITE.."14) "..AL["Stonespine"].." ("..AL["Rare"]..")", NPC, 10809 };
    { WHITE.."15) "..AL["Baroness Anastari"], NPC, 10436 };
    { WHITE..INDENT..AL["Black Guard Swordsmith"].." ("..AL["Summon"]..")", NPC, 11121 };
    { WHITE..INDENT..AL["Blacksmithing Plans"], OBJECT, 173232 };
    { WHITE.."16) "..AL["Nerub'enkan"], NPC, 10437 };
    { WHITE.."17) "..AL["Maleki the Pallid"], NPC, 10438 };
    { WHITE.."18) "..AL["Ramstein the Gorger"], NPC, 10439 };
    { WHITE.."19) "..AL["Baron Rivendare"], NPC, 10440 };
    { WHITE..INDENT..AL["Ysida Harmon"], NPC, 16031 };
    { GREN.."1') "..AL["Crusaders' Square Postbox"] };
    { GREN.."2') "..AL["Market Row Postbox"] };
    { GREN.."3') "..AL["Festival Lane Postbox"] };
    { GREN.."4') "..AL["Elders' Square Postbox"] };
    { GREN.."5') "..AL["King's Square Postbox"] };
    { GREN.."6') "..AL["Fras Siabi's Postbox"] };
    { GREN..AL["3rd Box Opened"]..": "..AL["Postmaster Malown"], NPC, 11143 };
    };
};
["TheDeadmines"] = {
    ZoneName = { BabbleZone["The Deadmines"], 1581 };
    Location = { BabbleZone["Westfall"], 40 };
    LevelRange = "16-22";
    MinLevel = "10";
    PlayerLimit = "5";
    Acronym = AL["VC"];
    MapName = "TheDeadmines";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Exit"] };
    { WHITE.."1) "..AL["Rhahk'Zor <The Foreman>"], NPC, 644 };
    { WHITE.."2) "..AL["Miner Johnson"].." ("..AL["Rare"]..")", NPC, 3586 };
    { WHITE.."3) "..AL["Sneed <Lumbermaster>"], NPC, 643 };
    { WHITE..INDENT..AL["Sneed's Shredder <Lumbermaster>"], NPC, 642 };
    { WHITE.."4) "..AL["Gilnid <The Smelter>"], NPC, 1763 };
    { WHITE.."5) "..AL["Defias Gunpowder"], OBJECT, 17155 };
    { WHITE.."6) "..AL["Captain Greenskin"], NPC, 647 };
    { WHITE..INDENT..AL["Edwin VanCleef <Defias Kingpin>"], NPC, 639 };
    { WHITE..INDENT..AL["Mr. Smite <The Ship's First Mate>"], NPC, 646 };
    { WHITE..INDENT..AL["Cookie <The Ship's Cook>"], NPC, 645 };
    };
};
["TheStockade"] = {
    ZoneName = { BabbleZone["The Stockade"], 717 };
    Location = { BabbleZone["Stormwind City"], 1519 };
    LevelRange = "21-27";
    MinLevel = "15";
    PlayerLimit = "5";
    Acronym = AL["Stocks"];
    MapName = "TheStockade";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Targorr the Dread"].." ("..AL["Varies"]..")", NPC, 1696 };
    { WHITE.."2) "..AL["Kam Deepfury"], NPC, 1666 };
    { WHITE.."3) "..AL["Hamhock"], NPC, 1717 };
    { WHITE.."4) "..AL["Bazil Thredd"], NPC, 1716 };
    { WHITE.."5) "..AL["Dextren Ward"], NPC, 1663 };
    { WHITE.."6) "..AL["Bruegal Ironknuckle"].." ("..AL["Rare"]..")", NPC, 1720 };
    };
};
["TheSunkenTemple"] = {
    ZoneName = { BabbleZone["Sunken Temple"], 1417 };
    Location = { BabbleZone["Swamp of Sorrows"], 8 };
    LevelRange = "46-53";
    MinLevel = "35";
    PlayerLimit = "5";
    Acronym = AL["ST"];
    MapName = "TheTempleOfAtalHakkar";
    [1] = {
    { ORNG..AL["AKA"]..": "..BabbleZone["The Temple of Atal'Hakkar"] };
    { ORNG..AL["Key"]..": "..AL["Yeh'kinya's Scroll"].." ("..AL["Avatar of Hakkar"]..")", ITEM, 10818 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B-I) "..AL["Connection"] };
    { WHITE.."1) "..AL["Altar of Hakkar"], OBJECT, 148836 };
    { WHITE..INDENT..AL["Atal'alarion <Guardian of the Idol>"], NPC, 8580 };
    { WHITE.."2) "..AL["Dreamscythe"], NPC, 5721 };
    { WHITE..INDENT..AL["Weaver"], NPC, 5720 };
    { WHITE.."3) "..AL["Avatar of Hakkar"], NPC, 8443 };
    { WHITE.."4) "..AL["Jammal'an the Prophet"], NPC, 5710 };
    { WHITE..INDENT..AL["Ogom the Wretched"], NPC, 5711 };
    { WHITE.."5) "..AL["Morphaz"], NPC, 5719 };
    { WHITE..INDENT..AL["Hazzas"], NPC, 5722 };
    { WHITE.."6) "..AL["Shade of Eranikus"], NPC, 5709 };
    { WHITE..INDENT..AL["Essence Font"], OBJECT, 148512 };
    { WHITE.."7) "..AL["Spawn of Hakkar"].." ("..AL["Rare"]..")", NPC, 5708 };
    { WHITE.."8) "..AL["Elder Starsong"].." ("..AL["Lunar Festival"]..")", NPC, 15593 };
    { GREN.."1'-6') "..AL["Statue Activation Order"] };
    { GREN.."7') "..AL["Atal'ai Defenders"] };
    { GREN..INDENT..AL["Gasher"], NPC, 5713 };
    { GREN..INDENT..AL["Loro"], NPC, 5714 };
    { GREN..INDENT..AL["Hukku"], NPC, 5715 };
    { GREN..INDENT..AL["Zolo"], NPC, 5712 };
    { GREN..INDENT..AL["Mijan"], NPC, 5717 };
    { GREN..INDENT..AL["Zul'Lor"], NPC, 5716 };
    };
};
["Uldaman"] = {
    ZoneName = { BabbleZone["Uldaman"], 1337 };
    Location = { BabbleZone["Badlands"], 3 };
    LevelRange = "36-42";
    MinLevel = "30";
    PlayerLimit = "5";
    Acronym = AL["Ulda"];
    MapName = "Uldaman";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["Staff of Prehistoria"].." ("..AL["Ironaya"]..")", ITEM, 7733 };
    { BLUE.."A) "..AL["Entrance"].." ("..AL["Front"]..")" };
    { BLUE.."B) "..AL["Entrance"].." ("..AL["Back"]..")" };
    { WHITE.."1) "..AL["Baelog"], NPC, 6906 };
    { WHITE..INDENT..AL["Eric \"The Swift\""], NPC, 6907 };
    { WHITE..INDENT..AL["Olaf"], NPC, 6908 };
    { WHITE..INDENT..AL["Baelog's Chest"], OBJECT, 123329 };
    { WHITE..INDENT..AL["Conspicuous Urn"], OBJECT, 125477 };
    { WHITE.."2) "..AL["Remains of a Paladin"], NPC, 6912 };
    { WHITE.."3) "..AL["Revelosh"], NPC, 6910 };
    { WHITE.."4) "..AL["Ironaya"], NPC, 7228 };
    { WHITE.."5) "..AL["Obsidian Sentinel"], NPC, 7023 };
    { WHITE.."6) "..AL["Annora <Enchanting Trainer>"], NPC, 11073 };
    { WHITE.."7) "..AL["Ancient Stone Keeper"], NPC, 7206 };
    { WHITE.."8) "..AL["Galgann Firehammer"], NPC, 7291 };
    { WHITE..INDENT..AL["Tablet of Will"], OBJECT, 142088 };
    { WHITE..INDENT..AL["Shadowforge Cache"], OBJECT, 113757 };
    { WHITE.."9) "..AL["Grimlok <Stonevault Chieftain>"], NPC, 4854 };
    { WHITE.."10) "..AL["Archaedas <Ancient Stone Watcher>"].." ("..AL["Lower"]..")", NPC, 2748 };
    { WHITE.."11) "..AL["The Discs of Norgannon"].." ("..AL["Lower"]..")", OBJECT, 131474 };
    { WHITE..INDENT..AL["Ancient Treasure"].." ("..AL["Lower"]..")", OBJECT, 141979 };
    };
};
["ZulGurub"] = {
    ZoneName = { BabbleZone["Zul'Gurub"], 19 };
    Location = { BabbleZone["Stranglethorn Vale"], 33 };
    LevelRange = "56-70";
    MinLevel = "50";
    PlayerLimit = "20";
    Acronym = AL["ZG"];
    MapName = "ZulGurub";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Zandalar Tribe"], FACTION, 270 };
    { ORNG..AL["Key"]..": "..AL["Mudskunk Lure"].." ("..AL["Gahz'ranka"]..")", ITEM, 19974 };
    { ORNG..AL["Key"]..": "..AL["Gurubashi Mojo Madness"].." ("..AL["Edge of Madness"]..")", ITEM, 19931 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["High Priestess Jeklik"].." ("..AL["Bat"]..")", NPC, 14517 };
    { WHITE.."2) "..AL["High Priest Venoxis"].." ("..AL["Snake"]..")", NPC, 14507 };
    { WHITE.."3) "..AL["Zanza the Restless"], NPC, 15042 };
    { WHITE.."4) "..AL["High Priestess Mar'li"].." ("..AL["Spider"]..")", NPC, 14510 };
    { WHITE.."5) "..AL["Bloodlord Mandokir"].." ("..AL["Raptor"]..", "..AL["Optional"]..")", NPC, 11382 };
    { WHITE..INDENT..AL["Ohgan"], NPC, 14988 };
    { WHITE.."6) "..AL["Edge of Madness"].." ("..AL["Optional"]..")" };
    { WHITE..INDENT..AL["Gri'lek"].." ("..AL["Random"]..")", NPC, 15082 };
    { WHITE..INDENT..AL["Hazza'rah"].." ("..AL["Random"]..")", NPC, 15083 };
    { WHITE..INDENT..AL["Renataki"].." ("..AL["Random"]..")", NPC, 15084 };
    { WHITE..INDENT..AL["Wushoolay"].." ("..AL["Random"]..")", NPC, 15085 };
    { WHITE.."7) "..AL["Gahz'ranka"].." ("..AL["Optional"]..", "..AL["Summon"]..")", NPC, 15114 };
    { WHITE.."8) "..AL["High Priest Thekal"].." ("..AL["Tiger"]..")", NPC, 14509 };
    { WHITE..INDENT..AL["Zealot Zath"], NPC, 11348 };
    { WHITE..INDENT..AL["Zealot Lor'Khan"], NPC, 11347 };
    { WHITE.."9) "..AL["High Priestess Arlokk"].." ("..AL["Panther"]..")", NPC, 14515 };
    { WHITE.."10) "..AL["Jin'do the Hexxer"].." ("..AL["Undead"]..", "..AL["Optional"]..")", NPC, 11380 };
    { WHITE.."11) "..AL["Hakkar"], NPC, 14834 };
    { GREN.."1') "..AL["Muddy Churning Waters"] };
    };
};

--************************************************
-- Burning Crusade Instances
--************************************************

["AuchAuchenaiCrypts"] = {
    ZoneName = { BabbleZone["Auchenai Crypts"], 3790 };
    Location = { BabbleZone["Terokkar Forest"], 3519 };
    LevelRange = "64-70";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["AC"];
    MapName = "AuchenaiCrypts";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Lower City"], FACTION, 1011 };
    { ORNG..AL["Key"]..": "..AL["Auchenai Key"].." ("..AL["Heroic"]..")", ITEM, 30633 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Shirrak the Dead Watcher"], NPC, 18371 };
    { WHITE.."2) "..AL["Exarch Maladaar"], NPC, 18373 };
    { WHITE..INDENT..AL["Avatar of the Martyred"], NPC, 18478 };
    { WHITE..INDENT..AL["D'ore"], NPC, 19412 };
    };
};
["AuchManaTombs"] = {
    ZoneName = { BabbleZone["Mana-Tombs"], 3792 };
    Location = { BabbleZone["Terokkar Forest"], 3519 };
    LevelRange = "63-70";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["MT"];
    MapName = "ManaTombs";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Consortium"], FACTION, 933 };
    { ORNG..AL["Key"]..": "..AL["Auchenai Key"].." ("..AL["Heroic"]..")", ITEM, 30633 };
    { ORNG..AL["Key"]..": "..AL["The Eye of Haramad"].." ("..AL["Exalted"]..", "..AL["Yor <Void Hound of Shaffar>"]..")", ITEM, 32092 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Pandemonius"], NPC, 18341 };
    { WHITE..INDENT..AL["Shadow Lord Xiraxis"], NPC, 19666 };
    { WHITE.."2) "..AL["Ambassador Pax'ivi"].." ("..AL["Heroic"]..")", NPC, 22928 };
    { WHITE.."3) "..AL["Tavarok"], NPC, 18343 };
    { WHITE.."4) "..AL["Cryo-Engineer Sha'heen"], NPC, 19671 };
    { WHITE..INDENT..AL["Ethereal Transporter Control Panel"], OBJECT, 183877 };
    { WHITE.."5) "..AL["Nexus-Prince Shaffar"], NPC, 18344 };
    { WHITE..INDENT..AL["Yor <Void Hound of Shaffar>"].." ("..AL["Summon"]..", "..AL["Heroic"]..")", NPC, 22930 };
    };
};
["AuchSethekkHalls"] = {
    ZoneName = {BabbleZone["Sethekk Halls"], 3791 };
    Location = { BabbleZone["Terokkar Forest"], 3519 };
    LevelRange = "66-70";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["Seth"];
    MapName = "SethekkHalls";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Lower City"], FACTION, 1011 };
    { ORNG..AL["Key"]..": "..AL["Auchenai Key"].." ("..AL["Heroic"]..")", ITEM, 30633 };
    { ORNG..AL["Key"]..": "..AL["Essence-Infused Moonstone"].." ("..AL["Anzu"]..")", ITEM, 32449 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Darkweaver Syth"], NPC, 18472 };
    { WHITE..INDENT..AL["Lakka"], NPC, 18956 };
    { WHITE.."2) "..AL["The Saga of Terokk"], OBJECT, 183050 };
    { WHITE..INDENT..AL["Anzu"].." ("..AL["Summon"]..", "..AL["Heroic"]..")", NPC, 23035 };
    { WHITE.."3) "..AL["Talon King Ikiss"], NPC, 18473 };
    };
};
["AuchShadowLabyrinth"] = {
    ZoneName = { BabbleZone["Shadow Labyrinth"], 3789 };
    Location = { BabbleZone["Terokkar Forest"], 3519 };
    LevelRange = "69-70";
    MinLevel = "65";
    PlayerLimit = "5";
    Acronym = AL["SL"];
    MapName = "ShadowLabyrinthb";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Lower City"], FACTION, 1011 };
    { ORNG..AL["Key"]..": "..AL["Shadow Labyrinth Key"], ITEM, 27991 };
    { ORNG..AL["Key"]..": "..AL["Auchenai Key"].." ("..AL["Heroic"]..")", ITEM, 30633 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Spy To'gun"], NPC, 18891 };
    { WHITE.."2) "..AL["Ambassador Hellmaw"], NPC, 18731 };
    { WHITE.."3) "..AL["Blackheart the Inciter"], NPC, 18667 };
    { WHITE.."4) "..AL["Grandmaster Vorpil"], NPC, 18732 };
    { WHITE..INDENT..AL["The Codex of Blood"], OBJECT, 182947 };
    { WHITE.."5) "..AL["Murmur"], NPC, 18708 };
    { WHITE.."6) "..AL["Arcane Container"], OBJECT, 182196 };
    { WHITE..INDENT..AL["First Fragment Guardian"], NPC, 22890 };
    };
};
["BlackTemple"] = {
    ZoneName = { BabbleZone["Black Temple"].." [A] ("..AL["Start"]..")", 3959 };
    Location = { BabbleZone["Shadowmoon Valley"], 3520 };
    LevelRange = "70";
    MinLevel = "70";
    PlayerLimit = "10-25";
    Acronym = AL["BT"];
    MapName = "BlackTemple";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Ashtongue Deathsworn"], FACTION, 1012 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Towards Reliquary of Souls"] };
    { BLUE.."C) "..AL["Towards Teron Gorefiend"] };
    { BLUE.."D) "..AL["Towards Illidan Stormrage"] };
    { WHITE.."1) "..AL["Spirit of Olum"], NPC, 23411 };
    { WHITE.."2) "..AL["High Warlord Naj'entus"], NPC, 22887 };
    { WHITE.."3) "..AL["Supremus"], NPC, 22898 };
    { WHITE.."4) "..AL["Shade of Akama"], NPC, 22841 };
    { WHITE.."5) "..AL["Spirit of Udalo"], NPC, 23410 };
    { WHITE..INDENT..AL["Aluyen <Reagents>"], NPC, 23157 };
    { WHITE..INDENT..AL["Okuno <Ashtongue Deathsworn Quartermaster>"], NPC, 23159 };
    { WHITE..INDENT..AL["Seer Kanai"], NPC, 23158 };
    };
    [2] = {
    { ORNG..AL["Reputation"]..": "..AL["Ashtongue Deathsworn"], FACTION, 1012 };
    { BLUE.."B) "..AL["Entrance"] };
    { BLUE.."C) "..AL["Entrance"] };
    { WHITE.."6) "..AL["Gurtogg Bloodboil"], NPC, 22948 };
    { WHITE.."7) "..AL["Reliquary of Souls"] };
    { WHITE..INDENT..AL["Essence of Suffering"], NPC, 23418 };
    { WHITE..INDENT..AL["Essence of Desire"], NPC, 23419 };
    { WHITE..INDENT..AL["Essence of Anger"], NPC, 23420 };
    { WHITE.."8) "..AL["Teron Gorefiend"], NPC, 22871 };
    };
    [3] = {
    { ORNG..AL["Reputation"]..": "..AL["Ashtongue Deathsworn"], FACTION, 1012 };
    { BLUE.."D) "..AL["Entrance"] };
    { WHITE.."9) "..AL["Mother Shahraz"], NPC, 22947 };
    { WHITE.."10) "..AL["The Illidari Council"], NPC, 23426 };
    { WHITE..INDENT..AL["Lady Malande"].." ("..AL["Priest"]..")", NPC, 22951 };
    { WHITE..INDENT..AL["Gathios the Shatterer"].." ("..AL["Paladin"]..")", NPC, 22949 };
    { WHITE..INDENT..AL["High Nethermancer Zerevor"].." ("..AL["Mage"]..")", NPC, 22950 };
    { WHITE..INDENT..AL["Veras Darkshadow"].." ("..AL["Rogue"]..")", NPC, 22952 };
    { WHITE.."11) "..AL["Illidan Stormrage <The Betrayer>"], NPC, 22917 };
    };
};
["CFRSerpentshrineCavern"] = {
    ZoneName = { BabbleZone["Serpentshrine Cavern"], 3607 };
    Location = { BabbleZone["Zangarmarsh"], 3521 };
    LevelRange = "70";
    MinLevel = "70";
    PlayerLimit = "10-25";
    Acronym = AL["SC"];
    MapName = "CoilfangReservoir";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Cenarion Expedition"], FACTION, 942 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Hydross the Unstable <Duke of Currents>"], NPC, 21216 };
    { WHITE.."2) "..AL["The Lurker Below"], NPC, 21217 };
    { WHITE.."3) "..AL["Leotheras the Blind"], NPC, 21215 };
    { WHITE.."4) "..AL["Fathom-Lord Karathress"], NPC, 21214 };
    { WHITE..INDENT..AL["Seer Olum"], NPC, 22820 };
    { WHITE.."5) "..AL["Morogrim Tidewalker"], NPC, 21213 };
    { WHITE.."6) "..AL["Lady Vashj <Coilfang Matron>"], NPC, 21212 };
    };
};
["CFRTheSlavePens"] = {
    ZoneName = { BabbleZone["The Slave Pens"], 3717 };
    Location = { BabbleZone["Zangarmarsh"], 3521 };
    LevelRange = "61-69";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["SP"];
    MapName = "TheSlavePens";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Cenarion Expedition"], FACTION, 942 };
    { ORNG..AL["Key"]..": "..AL["Reservoir Key"].." ("..AL["Heroic"]..")", ITEM, 30623 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Ahune <The Frost Lord>"].." ("..AL["Midsummer Festival"]..")", NPC, 25740 };
    { WHITE.."2) "..AL["Mennu the Betrayer"], NPC, 17941 };
    { WHITE.."3) "..AL["Weeder Greenthumb"], NPC, 17890 };
    { WHITE.."4) "..AL["Skar'this the Heretic"].." ("..AL["Heroic"]..")", NPC, 22421 };
    { WHITE.."5) "..AL["Rokmar the Crackler"], NPC, 17991 };
    { WHITE.."6) "..AL["Naturalist Bite"], NPC, 17893 };
    { WHITE.."7) "..AL["Quagmirran"], NPC, 17942 };
    };
};
["CFRTheSteamvault"] = {
    ZoneName = { BabbleZone["The Steamvault"], 3715 };
    Location = { BabbleZone["Zangarmarsh"], 3521 };
    LevelRange = "69-70";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["SV"];
    MapName = "TheSteamvault";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Cenarion Expedition"], FACTION, 942 };
    { ORNG..AL["Key"]..": "..AL["Reservoir Key"].." ("..AL["Heroic"]..")", ITEM, 30623 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Hydromancer Thespia"], NPC, 17797 };
    { WHITE..INDENT..AL["Main Chambers Access Panel"] };
    { WHITE.."2) "..AL["Arcane Container"], OBJECT, 182196 };
    { WHITE..INDENT..AL["Second Fragment Guardian"], NPC, 22891 };
    { WHITE.."3) "..AL["Mekgineer Steamrigger"], NPC, 17796 };
    { WHITE..INDENT..AL["Main Chambers Access Panel"] };
    { WHITE.."4) "..AL["Warlord Kalithresh"], NPC, 17798 };
    };
};
["CFRTheUnderbog"] = {
    ZoneName = { BabbleZone["The Underbog"], 3716 };
    Location = { BabbleZone["Zangarmarsh"], 3521 };
    LevelRange = "62-70";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["UB"];
    MapName = "TheUnderbog";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Cenarion Expedition"], FACTION, 942 };
    { ORNG..AL["Key"]..": "..AL["Reservoir Key"].." ("..AL["Heroic"]..")", ITEM, 30623 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Hungarfen"], NPC, 17770 };
    { WHITE..INDENT..AL["The Underspore"], OBJECT, 182054 };
    { WHITE.."2) "..AL["Ghaz'an"], NPC, 18105 };
    { WHITE.."3) "..AL["Earthbinder Rayge"], NPC, 17885 };
    { WHITE.."4) "..AL["Swamplord Musel'ek"], NPC, 17826 };
    { WHITE..INDENT..AL["Claw <Swamplord Musel'ek's Pet>"], NPC, 17827 };
    { WHITE.."5) "..AL["The Black Stalker"], NPC, 17882 };
    };
};
["CoTBlackMorass"] = {
    ZoneName = { BabbleZone["The Black Morass"], 2366 };
    Location = { BabbleZone["Tanaris"], 440 };
    LevelRange = "68-70";
    MinLevel = "66";
    PlayerLimit = "5";
    Acronym = AL["CoT2"];
    MapName = "CoTTheBlackMorass";
    [1] = {
    { PURP..AL["Event"]..": "..AL["Opening of the Dark Portal"] };
    { ORNG..AL["Attunement Required"] };
    { ORNG..AL["Reputation"]..": "..AL["Keepers of Time"], FACTION, 989 };
    { ORNG..AL["Key"]..": "..AL["Key of Time"].." ("..AL["Heroic"]..")", ITEM, 30635 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE..INDENT..AL["Sa'at <Keepers of Time>"], NPC, 20201 };
    { ORNG.."X) "..AL["Portal"].." ("..AL["Spawn Point"]..")" };
    { ORNG..INDENT..AL["Wave 6"]..": "..AL["Chrono Lord Deja"], NPC, 17879 };
    { ORNG..INDENT..AL["Wave 12"]..": "..AL["Temporus"], NPC, 17880 };
    { ORNG..INDENT..AL["Wave 18"]..": "..AL["Aeonus"], NPC, 17881 };
    { WHITE.."1) "..AL["The Dark Portal"] };
    { WHITE..INDENT..AL["Medivh"], NPC, 15608 };
    };
};
["CoTHyjal"] = {
    ZoneName = { BabbleZone["Hyjal Summit"], 3606 };
    Location = { BabbleZone["Tanaris"], 440 };
    LevelRange = "70";
    MinLevel = "70";
    PlayerLimit = "10-25";
    Acronym = AL["CoT3"];
    MapName = "CoTMountHyjal";
    [1] = {
    { PURP..AL["Event"]..": "..AL["Battle for Mount Hyjal"] };
    { ORNG..AL["Reputation"]..": "..AL["The Scale of the Sands"], FACTION, 990 };
    { BLUE.."A) "..AL["Alliance Base"] };
    { BLUE..INDENT..AL["Lady Jaina Proudmoore"], NPC, 17772 };
    { BLUE.."B) "..AL["Horde Encampment"] };
    { BLUE..INDENT..AL["Thrall <Warchief>"], NPC, 17852 };
    { BLUE.."C) "..AL["Night Elf Village"] };
    { BLUE..INDENT..AL["Tyrande Whisperwind <High Priestess of Elune>"], NPC, 7999 };
    { WHITE.."1) "..AL["Rage Winterchill"], NPC, 17767 };
    { WHITE.."2) "..AL["Anetheron"], NPC, 17808 };
    { WHITE.."3) "..AL["Kaz'rogal"], NPC, 17888 };
    { WHITE.."4) "..AL["Azgalor"], NPC, 17842 };
    { WHITE.."5) "..AL["Archimonde"], NPC, 17968 };
    { WHITE.."?) "..AL["Indormi <Keeper of Ancient Gem Lore>"], NPC, 23437 };
    { WHITE..INDENT..AL["Tydormu <Keeper of Lost Artifacts>"], NPC, 23381 };
    };
};
["CoTOldHillsbrad"] = {
    ZoneName = { BabbleZone["Old Hillsbrad Foothills"], 2367 };
    Location = { BabbleZone["Tanaris"], 440 };
    LevelRange = "66-70";
    MinLevel = "66";
    PlayerLimit = "5";
    Acronym = AL["CoT1"];
    MapName = "CoTHillsbradFoothills";
    [1] = {
    { PURP..AL["Event"]..": "..AL["Escape from Durnholde Keep"] };
    { ORNG..AL["Attunement Required"] };
    { ORNG..AL["Reputation"]..": "..AL["Keepers of Time"], FACTION, 989 };
    { ORNG..AL["Key"]..": "..AL["Key of Time"].." ("..AL["Heroic"]..")", ITEM, 30635 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE..INDENT..AL["Erozion"], NPC, 18723 };
    { BLUE..INDENT..AL["Brazen"], NPC, 18725 };
    { BLUE.."B) "..AL["Landing Spot"] };
    { BLUE.."C) "..BabbleSubZone["Southshore"] };
    { BLUE.."D) "..BabbleSubZone["Tarren Mill"] };
    { WHITE.."1) "..AL["Lieutenant Drake"], NPC, 17848 };
    { WHITE.."2) "..AL["Thrall"].." ("..AL["Lower"]..")", NPC, 17876 };
    { WHITE.."3) "..AL["Captain Skarloc"], NPC, 17862 };
    { WHITE..INDENT..AL["Thrall"].." ("..AL["Second Stop"]..")", NPC, 17876 };
    { WHITE.."4) "..AL["Thrall"].." ("..AL["Third Stop"]..")", NPC, 17876 };
    { WHITE.."5) "..AL["Epoch Hunter"], NPC, 18096 };
    { WHITE..INDENT..AL["Thrall"].." ("..AL["Fourth Stop"]..", "..AL["Upper"]..")", NPC, 17876 };
    { WHITE..INDENT..AL["Taretha"].." ("..AL["Upper"]..")", NPC, 18887 };
    { WHITE.."6) "..AL["Jonathan Revah"], NPC, 20372 };
    { WHITE..INDENT..AL["Jerry Carter"], NPC, 20376 };
    { "" };
    { ORNG..AL["Traveling"] };
    { WHITE..INDENT..AL["Thomas Yance <Travelling Salesman>"], NPC, 18672 };
    { WHITE..INDENT..AL["Aged Dalaran Wizard"], NPC, 18664 };
    { WHITE..INDENT..AL["Don Carlos"], NPC, 28132 };
    { WHITE..INDENT..AL["Guerrero"], NPC, 28163 };
    { "" };
    { ORNG..BabbleSubZone["Southshore"] };
    { WHITE..INDENT..AL["Kel'Thuzad <The Kirin Tor>"], NPC, 20350 };
    { WHITE..INDENT..AL["Helcular"], NPC, 20353 };
    { WHITE..INDENT..AL["Farmer Kent"], NPC, 20368 };
    { WHITE..INDENT..AL["Sally Whitemane"], NPC, 20357 };
    { WHITE..INDENT..AL["Renault Mograine"], NPC, 20358 };
    { WHITE..INDENT..AL["Little Jimmy Vishas"], NPC, 20359 };
    { WHITE..INDENT..AL["Herod the Bully"], NPC, 20360 };
    { WHITE..INDENT..AL["Nat Pagle"], NPC, 20344 };
    { WHITE..INDENT..AL["Hal McAllister"], NPC, 20342 };
    { WHITE..INDENT..AL["Zixil <Aspiring Merchant>"], NPC, 20419 };
    { WHITE..INDENT..AL["Overwatch Mark 0 <Protector>"], NPC, 20420 };
    { "" };
    { ORNG..AL["Southshore Inn"] };
    { WHITE..INDENT..AL["Captain Edward Hanes"], NPC, 20400 };
    { WHITE..INDENT..AL["Captain Sanders"], NPC, 20351 };
    { WHITE..INDENT..AL["Commander Mograine"], NPC, 20345 };
    { WHITE..INDENT..AL["Isillien"], NPC, 20346 };
    { WHITE..INDENT..AL["Abbendis"], NPC, 20347 };
    { WHITE..INDENT..AL["Fairbanks"], NPC, 20348 };
    { WHITE..INDENT..AL["Tirion Fordring"], NPC, 20349 };
    { WHITE..INDENT..AL["Arcanist Doan"], NPC, 20352 };
    { WHITE..INDENT..AL["Taelan"].." ("..AL["Upper"]..")", NPC, 20361 };
    { WHITE..INDENT..AL["Barkeep Kelly <Bartender>"], NPC, 20377 };
    { WHITE..INDENT..AL["Frances Lin <Barmaid>"], NPC, 20401 };
    { WHITE..INDENT..AL["Chef Jessen <Speciality Meat & Slop>"], NPC, 20378 };
    { WHITE..INDENT..AL["Stalvan Mistmantle"].." ("..AL["Upper"]..")", NPC, 20355 };
    { WHITE..INDENT..AL["Phin Odelic <The Kirin Tor>"].." ("..AL["Upper"]..")", NPC, 20370 };
    { "" };
    { ORNG..BabbleSubZone["Southshore Town Hall"] };
    { WHITE..INDENT..AL["Magistrate Henry Maleb"], NPC, 20373 };
    { WHITE..INDENT..AL["Raleigh the True"], NPC, 20380 };
    { WHITE..INDENT..AL["Nathanos Marris"], NPC, 20354 };
    { WHITE..INDENT..AL["Bilger the Straight-laced"], NPC, 20379 };
    { "" };
    { ORNG..BabbleSubZone["Tarren Mill"] };
    { WHITE..INDENT..AL["Innkeeper Monica"], NPC, 18649 };
    { WHITE..INDENT..AL["Julie Honeywell"], NPC, 18656 };
    { WHITE..INDENT..AL["Jay Lemieux"], NPC, 18655 };
    { WHITE..INDENT..AL["Young Blanchy"], NPC, 18651 };
    };
};
["GruulsLair"] = {
    ZoneName = { BabbleZone["Gruul's Lair"], 3923 };
    Location = { BabbleZone["Blade's Edge Mountains"], 3522 };
    LevelRange = "70";
    MinLevel = "65";
    PlayerLimit = "10-25";
    Acronym = AL["GL"];
    MapName = "GruulsLair";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["High King Maulgar <Lord of the Ogres>"], NPC, 18831 };
    { WHITE..INDENT..AL["Kiggler the Crazed"].." ("..AL["Shaman"]..")", NPC, 18835 };
    { WHITE..INDENT..AL["Blindeye the Seer"].." ("..AL["Priest"]..")", NPC, 18836 };
    { WHITE..INDENT..AL["Olm the Summoner"].." ("..AL["Warlock"]..")", NPC, 18834 };
    { WHITE..INDENT..AL["Krosh Firehand"].." ("..AL["Mage"]..")", NPC, 18832 };
    { WHITE.."2) "..AL["Gruul the Dragonkiller"], NPC, 19044 };
    };
};
["HCBloodFurnace"] = {
    ZoneName = { BabbleZone["The Blood Furnace"], 3713 };
    Location = { BabbleZone["Hellfire Peninsula"], 3483 };
    LevelRange = "60-68";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["BF"];
    MapName = "TheBloodFurnace";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Thrallmar"].." ("..AL["Horde"]..")", FACTION, 947 };
    { ORNG..AL["Reputation"]..": "..AL["Honor Hold"].." ("..AL["Alliance"]..")", FACTION, 946 };
    { ORNG..AL["Key"]..": "..AL["Flamewrought Key"].." ("..AL["Heroic"]..")", ITEM, 30637 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["The Maker"], NPC, 17381 };
    { WHITE.."2) "..AL["Broggok"], NPC, 17380 };
    { WHITE.."3) "..AL["Keli'dan the Breaker"], NPC, 17377 };
    };
};
["HCHellfireRamparts"] = {
    ZoneName = { BabbleZone["Hellfire Ramparts"], 3562 };
    Location = { BabbleZone["Hellfire Peninsula"], 3483 };
    LevelRange = "59-67";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["Ramp"];
    MapName = "HellfireRamparts";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Thrallmar"].." ("..AL["Horde"]..")", FACTION, 947 };
    { ORNG..AL["Reputation"]..": "..AL["Honor Hold"].." ("..AL["Alliance"]..")", FACTION, 946 };
    { ORNG..AL["Key"]..": "..AL["Flamewrought Key"].." ("..AL["Heroic"]..")", ITEM, 30637 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Watchkeeper Gargolmar"], NPC, 17306 };
    { WHITE.."2) "..AL["Omor the Unscarred"], NPC, 17308 };
    { WHITE.."3) "..AL["Vazruden"], NPC, 17537 };
    { WHITE..INDENT..AL["Nazan <Vazruden's Mount>"], NPC, 17536 };
    { WHITE..INDENT..AL["Reinforced Fel Iron Chest"], OBJECT, 185168 };
    };
};
["HCMagtheridonsLair"] = {
    ZoneName = { BabbleZone["Magtheridon's Lair"], 3836 };
    Location = { BabbleZone["Hellfire Peninsula"], 3483 };
    LevelRange = "70";
    MinLevel = "65";
    PlayerLimit = "10-25";
    Acronym = AL["Mag"];
    MapName = "Magtheridonslair";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Magtheridon"], NPC, 17257 };
    };
};
["HCTheShatteredHalls"] = {
    ZoneName = { BabbleZone["The Shattered Halls"], 3714 };
    Location = { BabbleZone["Hellfire Peninsula"], 3483 };
    LevelRange = "69-70";
    MinLevel = "55";
    PlayerLimit = "5";
    Acronym = AL["SH"];
    MapName = "TheShatteredHalls";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Thrallmar"].." ("..AL["Horde"]..")", FACTION, 947 };
    { ORNG..AL["Reputation"]..": "..AL["Honor Hold"].." ("..AL["Alliance"]..")", FACTION, 946 };
    { ORNG..AL["Key"]..": "..AL["Shattered Halls Key"], ITEM, 28395 };
    { ORNG..AL["Key"]..": "..AL["Flamewrought Key"].." ("..AL["Heroic"]..")", ITEM, 30637 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Randy Whizzlesprocket"].." ("..AL["Alliance"]..", "..AL["Heroic"]..")", NPC, 17288 };
    { WHITE..INDENT..AL["Drisella"].." ("..AL["Horde"]..", "..AL["Heroic"]..")", NPC, 17294 };
    { WHITE.."2) "..AL["Grand Warlock Nethekurse"], NPC, 16807 };
    { WHITE.."3) "..AL["Blood Guard Porung"].." ("..AL["Heroic"]..")", NPC, 20923 };
    { WHITE.."4) "..AL["Warbringer O'mrogg"], NPC, 16809 };
    { WHITE.."5) "..AL["Warchief Kargath Bladefist"], NPC, 16808 };
    { WHITE..INDENT..AL["Shattered Hand Executioner"].." ("..AL["Heroic"]..")", NPC, 17301 };
    { WHITE..INDENT..AL["Private Jacint"].." ("..AL["Alliance"]..", "..AL["Heroic"]..")", NPC, 17292 };
    { WHITE..INDENT..AL["Rifleman Brownbeard"].." ("..AL["Alliance"]..", "..AL["Heroic"]..")", NPC, 17289 };
    { WHITE..INDENT..AL["Captain Alina"].." ("..AL["Alliance"]..", "..AL["Heroic"]..")", NPC, 17290 };
    { WHITE..INDENT..AL["Scout Orgarr"].." ("..AL["Horde"]..", "..AL["Heroic"]..")", NPC, 17297 };
    { WHITE..INDENT..AL["Korag Proudmane"].." ("..AL["Horde"]..", "..AL["Heroic"]..")", NPC, 17295 };
    { WHITE..INDENT..AL["Captain Boneshatter"].." ("..AL["Horde"]..", "..AL["Heroic"]..")", NPC, 17296 };
    };
};
["Karazhan"] = {
    ZoneName = { BabbleZone["Karazhan"].." [A] ("..AL["Start"]..")", 3457 };
    Location = { BabbleZone["Deadwind Pass"], 41 };
    LevelRange = "70";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["Kara"];
    MapName = "Karazhan";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Violet Eye"], FACTION, 967 };
    { ORNG..AL["Key"]..": "..AL["The Master's Key"], ITEM, 24490 };
    { BLUE.."A) "..AL["Entrance"].." ("..AL["Front"]..")" };
    { BLUE.."B) "..AL["Staircase to the Ballroom"].." ("..AL["Moroes <Tower Steward>"]..")" };
    { BLUE.."C) "..AL["Stairs to Upper Stable"] };
    { BLUE.."D) "..AL["Ramp to the Guest Chambers"].." ("..AL["Maiden of Virtue"]..")" };
    { BLUE.."E) "..AL["Stairs to Opera House Orchestra Level"] };
    { BLUE.."F) "..AL["Ramp from Mezzanine to Balcony"] };
    { BLUE.."G) "..AL["Entrance"].." ("..AL["Back"]..")" };
    { BLUE.."H) "..AL["Connection to Master's Terrace"].." ("..AL["Nightbane"]..")" };
    { BLUE.."I) "..AL["Path to the Broken Stairs"] };
    { WHITE.."1) "..AL["Hastings <The Caretaker>"], NPC, 16169 };
    { WHITE.."2) "..AL["Servant Quarters"] };
    { WHITE..INDENT..AL["Hyakiss the Lurker"].." ("..AL["Rare"]..", "..AL["Random"]..")", NPC, 16179 };
    { WHITE..INDENT..AL["Rokad the Ravager"].." ("..AL["Rare"]..", "..AL["Random"]..")", NPC, 16181 };
    { WHITE..INDENT..AL["Shadikith the Glider"].." ("..AL["Rare"]..", "..AL["Random"]..")", NPC, 16180 };
    { WHITE.."3) "..AL["Berthold <The Doorman>"], NPC, 16153 };
    { WHITE.."4) "..AL["Calliard <The Nightman>"], NPC, 16159 };
    { WHITE.."5) "..AL["Attumen the Huntsman"], NPC, 15550 };
    { WHITE..INDENT..AL["Midnight"], NPC, 16151 };
    { WHITE.."6) "..AL["Koren <The Blacksmith>"], NPC, 16388 };
    { WHITE.."7) "..AL["Moroes <Tower Steward>"], NPC, 15687 };
    { WHITE..INDENT..AL["Baroness Dorothea Millstipe"].." ("..AL["Random"]..", "..AL["Shadow Priest"]..")", NPC, 19875 };
    { WHITE..INDENT..AL["Lady Catriona Von'Indi"].." ("..AL["Random"]..", "..AL["Holy Priest"]..")", NPC, 19872 };
    { WHITE..INDENT..AL["Lady Keira Berrybuck"].." ("..AL["Random"]..", "..AL["Holy Paladin"]..")", NPC, 17007 };
    { WHITE..INDENT..AL["Baron Rafe Dreuger"].." ("..AL["Random"]..", "..AL["Retribution Paladin"]..")", NPC, 19874 };
    { WHITE..INDENT..AL["Lord Robin Daris"].." ("..AL["Random"]..", "..AL["Arms Warrior"]..")", NPC, 19876 };
    { WHITE..INDENT..AL["Lord Crispin Ference"].." ("..AL["Random"]..", "..AL["Protection Warrior"]..")", NPC, 19873 };
    { WHITE.."8) "..AL["Bennett <The Sergeant at Arms>"], NPC, 16426 };
    { WHITE.."9) "..AL["Ebonlocke <The Noble>"], NPC, 16806 };
    { WHITE.."10) "..AL["Keanna's Log"], OBJECT, 182199 };
    { WHITE.."11) "..AL["Maiden of Virtue"], NPC, 16457 };
    { WHITE.."12) "..AL["Sebastian <The Organist>"], NPC, 16811 };
    { WHITE.."13) "..AL["Barnes <The Stage Manager>"], NPC, 16812 };
    { WHITE.."14) "..AL["The Opera Event"] };
    { WHITE..INDENT..AL["Red Riding Hood"].." ("..AL["Random"]..")" };
    { WHITE..INDENT..INDENT..AL["The Big Bad Wolf"], NPC, 17521 };
    { WHITE..INDENT..AL["Wizard of Oz"].." ("..AL["Random"]..")" };
    { WHITE..INDENT..INDENT..AL["Dorothee"], NPC, 17535 };
    { WHITE..INDENT..INDENT..AL["Tito"], NPC, 17548 };
    { WHITE..INDENT..INDENT..AL["Strawman"], NPC, 17543 };
    { WHITE..INDENT..INDENT..AL["Tinhead"], NPC, 17547 };
    { WHITE..INDENT..INDENT..AL["Roar"], NPC, 17546 };
    { WHITE..INDENT..INDENT..AL["The Crone"], NPC, 18168 };
    { WHITE..INDENT..AL["Romulo and Julianne"].." ("..AL["Random"]..")" };
    { WHITE..INDENT..INDENT..AL["Romulo"], NPC, 17533 };
    { WHITE..INDENT..INDENT..AL["Julianne"], NPC, 17534 };
    { WHITE.."15) "..AL["The Master's Terrace"] };
    { WHITE..INDENT..AL["Nightbane"].." ("..AL["Summon"]..")", NPC, 17225 };
    };
    [2] = {
    { ORNG..AL["Reputation"]..": "..AL["The Violet Eye"], FACTION, 967 };
    { ORNG..AL["Key"]..": "..AL["The Master's Key"], ITEM, 24490 };
    { BLUE.."I) "..AL["Path to the Broken Stairs"] };
    { BLUE.."J) "..AL["Broken Stairs"] };
    { BLUE.."K) "..AL["Ramp to Guardian's Library"].." ("..AL["Shade of Aran"]..")" };
    { BLUE.."L) "..AL["Suspicious Bookshelf"].." ("..AL["Terestian Illhoof"]..")" };
    { BLUE.."M) "..AL["Ramp up to the Celestial Watch"].." ("..AL["Netherspite"]..")" };
    { BLUE..INDENT..AL["Ramp down to the Gamesman's Hall"].." ("..AL["Chess Event"]..")" };
    { BLUE.."N) "..AL["Ramp to Medivh's Chamber"] };
    { BLUE.."O) "..AL["Spiral Stairs to Netherspace"].." ("..AL["Prince Malchezaar"]..")" };
    { WHITE.."16) "..AL["The Curator"], NPC, 15691 };
    { WHITE.."17) "..AL["Wravien <The Mage>"], NPC, 16813 };
    { WHITE.."18) "..AL["Gradav <The Warlock>"], NPC, 16814 };
    { WHITE.."19) "..AL["Kamsis <The Conjurer>"], NPC, 16815 };
    { WHITE.."20) "..AL["Terestian Illhoof"], NPC, 15688 };
    { WHITE..INDENT..AL["Kil'rek"].." ("..AL["Imp"]..")", NPC, 17229 };
    { WHITE.."21) "..AL["Shade of Aran"], NPC, 16524 };
    { WHITE.."22) "..AL["Netherspite"], NPC, 15689 };
    { WHITE.."23) "..AL["Ythyar"].." ("..AL["Repair"]..", "..AL["Rewards"]..")", NPC, 17518 };
    { WHITE.."24) "..AL["Echo of Medivh"], NPC, 16816 };
    { WHITE.."25) "..AL["Dust Covered Chest"].." ("..AL["Chess Event"]..")", OBJECT, 185119 };
    { WHITE.."26) "..AL["Prince Malchezaar"], NPC, 15690 };
    };
};
["MagistersTerrace"] = {
    ZoneName = { BabbleZone["Magisters' Terrace"], 4095 };
    Location = { BabbleZone["Isle of Quel'Danas"], 4080 };
    LevelRange = "70";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["MaT"];
    MapName = "MagistersTerrace";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["Shattered Sun Offensive"], FACTION, 1077 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Selin Fireheart"], NPC, 24723 };
    { WHITE..INDENT..AL["Fel Crystals"], NPC, 24722 };
    { WHITE.."2) "..AL["Tyrith"], NPC, 24822 };
    { WHITE.."3) "..AL["Vexallus"], NPC, 24744 };
    { WHITE.."4) "..AL["Scrying Orb"] };
    { WHITE..INDENT..AL["Kalecgos"], NPC, 24850 };
    { WHITE.."5) "..AL["Priestess Delrissa"].." ("..AL["Lower"]..")", NPC, 24560 };
    { WHITE..INDENT..AL["Apoko"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Shaman"]..")", NPC, 24553 };
    { WHITE..INDENT..AL["Eramas Brightblaze"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Monk"]..")", NPC, 24554 };
    { WHITE..INDENT..AL["Ellrys Duskhallow"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Warlock"]..")", NPC, 24558 };
    { WHITE..INDENT..INDENT..AL["Fizzle"].." ("..AL["Lower"]..", "..AL["Random"]..")", NPC, 24656 };
    { WHITE..INDENT..AL["Garaxxas"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Hunter"]..")", NPC, 24555 };
    { WHITE..INDENT..INDENT..AL["Sliver <Garaxxas' Pet>"].." ("..AL["Lower"]..", "..AL["Random"]..")", NPC, 24552 };
    { WHITE..INDENT..AL["Kagani Nightstrike"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Rogue"]..")", NPC, 24557 };
    { WHITE..INDENT..AL["Warlord Salaris"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Warrior"]..")", NPC, 24559 };
    { WHITE..INDENT..AL["Yazzai"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Mage"]..")", NPC, 24561 };
    { WHITE..INDENT..AL["Zelfan"].." ("..AL["Lower"]..", "..AL["Random"]..", "..AL["Engineer"]..")", NPC, 24556 };
    { WHITE.."6) "..AL["Kael'thas Sunstrider <Lord of the Blood Elves>"], NPC, 24664 };
    };
};
["SunwellPlateau"] = {
    ZoneName = { BabbleZone["Sunwell Plateau"], 4075 };
    Location = { BabbleZone["Isle of Quel'Danas"], 4080 };
    LevelRange = "70";
    MinLevel = "70";
    PlayerLimit = "10-25";
    Acronym = AL["SuP"];
    MapName = "SunwellPlateau";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Kalecgos"], NPC, 24850 };
    { WHITE..INDENT..AL["Sathrovarr the Corruptor"], NPC, 24892 };
    { WHITE.."2) "..AL["Madrigosa"], NPC, 24895 };
    { WHITE..INDENT..AL["Brutallus"], NPC, 24882 };
    { WHITE..INDENT..AL["Felmyst"], NPC, 25038 };
    { WHITE.."3) "..AL["Eredar Twins"].." ("..AL["Lower"]..")" };
    { WHITE..INDENT..AL["Grand Warlock Alythess"].." ("..AL["Lower"]..")", NPC, 25166 };
    { WHITE..INDENT..AL["Lady Sacrolash"].." ("..AL["Lower"]..")", NPC, 25165 };
    { WHITE..INDENT..AL["M'uru"].." ("..AL["Upper"]..")", NPC, 25741 };
    { WHITE..INDENT..AL["Entropius"].." ("..AL["Upper"]..")", NPC, 25840 };
    { WHITE.."4) "..AL["Kil'jaeden <The Deceiver>"], NPC, 25315 };
    };
};
["TempestKeepArcatraz"] = {
    ZoneName = {BabbleZone["The Arcatraz"], 3846 };
    Location = { BabbleZone["Netherstorm"], 3523 };
    LevelRange = "69-70";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["Arca"];
    MapName = "TheArcatraz";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Sha'tar"], FACTION, 935 };
    { ORNG..AL["Key"]..": "..AL["Key to the Arcatraz"], ITEM, 31084 };
    { ORNG..AL["Key"]..": "..AL["Warpforged Key"].." ("..AL["Heroic"]..")", ITEM, 30634 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Zereketh the Unbound"], NPC, 20870 };
    { WHITE.."2) "..AL["Arcane Container"], OBJECT, 182196 };
    { WHITE..INDENT..AL["Third Fragment Guardian"], NPC, 22892 };
    { WHITE.."3) "..AL["Dalliah the Doomsayer"], NPC, 20885 };
    { WHITE.."4) "..AL["Wrath-Scryer Soccothrates"], NPC, 20886 };
    { WHITE.."5) "..AL["Udalo"], NPC, 21962 };
    { WHITE.."6) "..AL["Harbinger Skyriss"], NPC, 20912 };
    { WHITE..INDENT..AL["Warden Mellichar"], NPC, 20904 };
    { WHITE..INDENT..AL["Millhouse Manastorm"], NPC, 20977 };
    };
};
["TempestKeepBotanica"] = {
    ZoneName = { BabbleZone["The Botanica"], 3847 };
    Location = { BabbleZone["Netherstorm"], 3523 };
    LevelRange = "69-70";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["Bota"];
    MapName = "TheBotanica";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Sha'tar"], FACTION, 935 };
    { ORNG..AL["Key"]..": "..AL["Warpforged Key"].." ("..AL["Heroic"]..")", ITEM, 30634 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Exit"] };
    { WHITE.."1) "..AL["Commander Sarannis"], NPC, 17976 };
    { WHITE.."2) "..AL["High Botanist Freywinn"], NPC, 17975 };
    { WHITE.."3) "..AL["Thorngrin the Tender"], NPC, 17978 };
    { WHITE.."4) "..AL["Laj"], NPC, 17980 };
    { WHITE.."5) "..AL["Warp Splinter"], NPC, 17977 };
    };
};
["TempestKeepMechanar"] = {
    ZoneName = { BabbleZone["The Mechanar"], 3849 };
    Location = { BabbleZone["Netherstorm"], 3523 };
    LevelRange = "68-70";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["Mech"];
    MapName = "TheMechanar";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Sha'tar"], FACTION, 935 };
    { ORNG..AL["Key"]..": "..AL["Warpforged Key"].." ("..AL["Heroic"]..")", ITEM, 30634 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Exit"] };
    { WHITE.."1) "..AL["Gatewatcher Gyro-Kill"], NPC, 19218 };
    { WHITE.."2) "..AL["Gatewatcher Iron-Hand"], NPC, 19710 };
    { WHITE..INDENT..AL["Cache of the Legion"], OBJECT, 184465 };
    { WHITE.."3) "..AL["Mechano-Lord Capacitus"], NPC, 19219 };
    { WHITE..INDENT..AL["Overcharged Manacell"], OBJECT, 185015 };
    { WHITE.."4) "..AL["Nethermancer Sepethrea"], NPC, 19221 };
    { WHITE.."5) "..AL["Pathaleon the Calculator"], NPC, 19220 };
    };
};
["TempestKeepTheEye"] = {
    ZoneName = { BabbleZone["The Eye"], 3845 };
    Location = { BabbleZone["Netherstorm"], 3523 };
    LevelRange = "70";
    MinLevel = "70";
    PlayerLimit = "10-25";
    Acronym = AL["Eye"];
    MapName = "TempestKeep";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Sha'tar"], FACTION, 935 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Al'ar <Phoenix God>"], NPC, 19514 };
    { WHITE.."2) "..AL["Void Reaver"], NPC, 19516 };
    { WHITE.."3) "..AL["High Astromancer Solarian"], NPC, 18805 };
    { WHITE.."4) "..AL["Kael'thas Sunstrider <Lord of the Blood Elves>"], NPC, 19622 };
    { WHITE..INDENT..AL["Thaladred the Darkener <Advisor to Kael'thas>"].." ("..AL["Warrior"]..")", NPC, 20064 };
    { WHITE..INDENT..AL["Master Engineer Telonicus <Advisor to Kael'thas>"].." ("..AL["Hunter"]..")", NPC, 20063 };
    { WHITE..INDENT..AL["Grand Astromancer Capernian <Advisor to Kael'thas>"].." ("..AL["Mage"]..")", NPC, 20062 };
    { WHITE..INDENT..AL["Lord Sanguinar <The Blood Hammer>"].." ("..AL["Paladin"]..")", NPC, 20060 };
    };
};
["ZulAman"] = {
    ZoneName = { BabbleZone["Zul'Aman"], 3805 };
    Location = { BabbleZone["Ghostlands"], 3433 };
    LevelRange = "70";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["ZA"];
    MapName = "ZulAman";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE..INDENT..AL["Harrison Jones"], NPC, 24358 };
    { WHITE.."1) "..AL["Nalorakk <Bear Avatar>"], NPC, 23576 };
    { WHITE..INDENT..AL["Tanzar"], NPC, 23790 };
    { WHITE..INDENT..AL["The Map of Zul'Aman"], OBJECT, 186733 };
    { WHITE.."2) "..AL["Akil'Zon <Eagle Avatar>"], NPC, 23574 };
    { WHITE..INDENT..AL["Harkor"], NPC, 23999 };
    { WHITE.."3) "..AL["Jan'Alai <Dragonhawk Avatar>"], NPC, 23578 };
    { WHITE..INDENT..AL["Kraz"], NPC, 24024 };
    { WHITE.."4) "..AL["Halazzi <Lynx Avatar>"], NPC, 23577 };
    { WHITE..INDENT..AL["Ashli"], NPC, 24001 };
    { WHITE.."5) "..AL["Zungam"], NPC, 23897 };
    { WHITE.."6) "..AL["Hex Lord Malacrass"], NPC, 24239 };
    { WHITE..INDENT..AL["Thurg"].." ("..AL["Random"]..")", NPC, 24241 };
    { WHITE..INDENT..AL["Gazakroth"].." ("..AL["Random"]..")", NPC, 24244 };
    { WHITE..INDENT..AL["Lord Raadan"].." ("..AL["Random"]..")", NPC, 24243 };
    { WHITE..INDENT..AL["Darkheart"].." ("..AL["Random"]..")", NPC, 24246 };
    { WHITE..INDENT..AL["Alyson Antille"].." ("..AL["Random"]..")", NPC, 24240 };
    { WHITE..INDENT..AL["Slither"].." ("..AL["Random"]..")", NPC, 24242 };
    { WHITE..INDENT..AL["Fenstalker"].." ("..AL["Random"]..")", NPC, 24245 };
    { WHITE..INDENT..AL["Koragg"].." ("..AL["Random"]..")", NPC, 24247 };
    { WHITE.."7) "..AL["Zul'jin"], NPC, 23863 };
    { GREN.."1') "..AL["Forest Frogs"], NPC, 24396 };
    { GREN..INDENT..AL["Kyren <Reagents>"], NPC, 24409 };
    { GREN..INDENT..AL["Gunter <Food Vendor>"], NPC, 24408 };
    { GREN..INDENT..AL["Adarrah"], NPC, 24405 };
    { GREN..INDENT..AL["Brennan"], NPC, 24453 };
    { GREN..INDENT..AL["Darwen"], NPC, 24407 };
    { GREN..INDENT..AL["Deez"], NPC, 24403 };
    { GREN..INDENT..AL["Galathryn"], NPC, 24404 };
    { GREN..INDENT..AL["Mitzi"], NPC, 24445 };
    { GREN..INDENT..AL["Mannuth"], NPC, 24397 };
    };
};	

--************************************************
-- Wrath of the Lich King Instances
--************************************************

["AhnKahet"] = {
    ZoneName = { BabbleZone["Ahn'kahet: The Old Kingdom"], 4494 };
    Location = { BabbleZone["Dragonblight"], 65 };
    LevelRange = "71-78";
    MinLevel = "68";
    PlayerLimit = "5";
    Acronym = AL["AK, Kahet"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Exit"] };
    { WHITE.."1) "..AL["Elder Nadox"], NPC, 29309 };
    { WHITE.."2) "..AL["Prince Taldaram"], NPC, 29308 };
    { WHITE.."3) "..AL["Amanitar"].." ("..AL["Heroic"]..")", NPC, 30258 };
    { WHITE.."4) "..AL["Jedoga Shadowseeker"], NPC, 29310 };
    { WHITE.."5) "..AL["Herald Volazj"], NPC, 29311 };
    { WHITE.."6) "..AL["Ahn'kahet Brazier"] };
    };
};
["AzjolNerub"] = {
    ZoneName = { BabbleZone["Azjol-Nerub"], 3477 };
    Location = { BabbleZone["Dragonblight"], 65 };
    LevelRange = "70-77";
    MinLevel = "67";
    PlayerLimit = "5";
    Acronym = AL["AN, Nerub"];
    MapName = "DireMaul";
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Connection"] };
    { BLUE.."C) "..AL["Exit"] };
    { WHITE.."1) "..AL["Krik'thir the Gatewatcher"], NPC, 28684 };
    { WHITE..INDENT..AL["Watcher Gashra"], NPC, 28730 };
    { WHITE..INDENT..AL["Watcher Narjil"], NPC, 28729 };
    { WHITE..INDENT..AL["Watcher Silthik"], NPC, 28731 };
    { WHITE.."2) "..AL["Hadronox"], NPC, 28921 };
    { WHITE.."3) "..AL["Elder Nurgen"].." ("..AL["Lunar Festival"]..")", NPC, 30533 };
    { WHITE.."4) "..AL["Anub'arak"], NPC, 29120 };
    };
};
["CoTOldStratholme"] = {
    ZoneName = { BabbleZone["Caverns of Time"]..": "..BabbleZone["The Culling of Stratholme"], 4100 };
    Location = { BabbleZone["Tanaris"], 440 };
    LevelRange = "78-80";
    MinLevel = "75";
    PlayerLimit = "5";
    Acronym = AL["CoT-Strat"];
    MapName = "DireMaul";
    [1] = {
    { PURP..AL["Event"]..": "..AL["The Culling of Stratholme"] };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Exit"].." ("..AL["Portal"]..")" };
    { ORNG.."X) "..AL["Scourge Invasion Points"] };
    { ORNG..INDENT..AL["Wave 5"]..": "..AL["Meathook"], NPC, 26529 };
    { ORNG..INDENT..AL["Wave 10"]..": "..AL["Salramm the Fleshcrafter"], NPC, 26530 };
    { WHITE.."1) "..AL["Chromie"], NPC, 26527 };
    { WHITE.."2) "..AL["Chromie"], NPC, 27915 };
    { WHITE.."3) "..AL["Chrono-Lord Epoch"], NPC, 26532 };
    { WHITE.."4) "..AL["Infinite Corruptor"].." ("..AL["Heroic"]..")", NPC, 32273 };
    { WHITE..INDENT..AL["Guardian of Time"], NPC, 32281 };
    { WHITE.."5) "..AL["Mal'Ganis"], NPC, 26533 };
    { WHITE..INDENT..AL["Chromie"], NPC, 30997 };
    };
};
["DrakTharonKeep"] = {
    ZoneName = { BabbleZone["Drak'Tharon Keep"], 4196 };
    Location = { BabbleZone["Grizzly Hills"], 394 };
    LevelRange = "72-78";
    MinLevel = "69";
    PlayerLimit = "5";
    Acronym = AL["DTK"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Connection"] };
    { BLUE.."C) "..AL["Connection"] };
    { WHITE.."1) "..AL["Trollgore"], NPC, 26630 };
    { WHITE.."2) "..AL["Kurzel"], NPC, 26664 };
    { WHITE.."3) "..AL["Novos the Summoner"], NPC, 26631 };
    { WHITE.."4) "..AL["Elder Kilias"].." ("..AL["Lunar Festival"]..")", NPC, 30534 };
    { WHITE.."5) "..AL["King Dred"], NPC, 27483 };
    { WHITE.."6) "..AL["The Prophet Tharon'ja"], NPC, 26632 };
    { WHITE.."7) "..AL["Drakuru's Brazier"] };
    };
};
["FHHallsOfReflection"] = {
    ZoneName = { BabbleSubZone["The Frozen Halls"]..": "..BabbleZone["Halls of Reflection"], 4820 };
    Location = { BabbleZone["Icecrown Citadel"], 4812 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "5";
    Acronym = AL["HoR"]..", "..AL["FH3"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Attunement Required"] };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Portal"].." ("..BabbleZone["Dalaran"]..")", ZONE, 4395 };
    { WHITE.."1) "..AL["Lady Jaina Proudmoore"].." ("..AL["Alliance"]..")", NPC, 37221 };
    { WHITE..INDENT..AL["Archmage Koreln <Kirin Tor>"].." ("..AL["Alliance"]..")", NPC, 37582 };
    { WHITE..INDENT..AL["Lady Sylvanas Windrunner <Banshee Queen>"].." ("..AL["Horde"]..")", NPC, 37223 };
    { WHITE..INDENT..AL["Dark Ranger Loralen"].." ("..AL["Horde"]..")", NPC, 37779 };
    { WHITE.."2) "..AL["Falric"].." ("..AL["Wave 5"]..")", NPC, 38112 };
    { WHITE.."3) "..AL["Marwyn"].." ("..AL["Wave 10"]..")", NPC, 38113 };
    { WHITE.."4) "..AL["Wrath of the Lich King"].." ("..AL["Event"]..")", NPC, 37226 };
    { WHITE..INDENT..AL["The Captain's Chest"], OBJECT, 201710 };
    };
};
["FHPitOfSaron"] = {
    ZoneName = { BabbleSubZone["The Frozen Halls"]..": "..BabbleZone["Pit of Saron"], 4813 };
    Location = { BabbleZone["Icecrown Citadel"], 4812 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "5";
    Acronym = AL["PoS"]..", "..AL["FH2"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Attunement Required"] };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Portal"].." ("..BabbleZone["Halls of Reflection"]..")", ZONE, 4820 };
    { WHITE.."1) "..AL["Lady Jaina Proudmoore"].." ("..AL["Alliance"]..")", NPC, 36993 };
    { WHITE..INDENT..AL["Archmage Koreln <Kirin Tor>"].." ("..AL["Alliance"]..")", NPC, 37582 };
    { WHITE..INDENT..AL["Archmage Elandra <Kirin Tor>"].." ("..AL["Alliance"]..")", NPC, 37774 };
    { WHITE..INDENT..AL["Lady Sylvanas Windrunner <Banshee Queen>"].." ("..AL["Horde"]..")", NPC, 36990 };
    { WHITE..INDENT..AL["Dark Ranger Loralen"].." ("..AL["Horde"]..")", NPC, 37779 };
    { WHITE..INDENT..AL["Dark Ranger Kalira"].." ("..AL["Horde"]..")", NPC, 37583 };
    { WHITE.."2) "..AL["Forgemaster Garfrost"], NPC, 36494 };
    { WHITE..INDENT..AL["Martin Victus"].." ("..AL["Alliance"]..")", NPC, 37591 };
    { WHITE..INDENT..AL["Gorkun Ironskull"].." ("..AL["Horde"]..")", NPC, 37592 };
    { WHITE.."3) "..AL["Krick and Ick"], NPC, 36477 };
    { WHITE.."4) "..AL["Scourgelord Tyrannus"], NPC, 36658 };
    { WHITE..INDENT..AL["Rimefang"], NPC, 36661 };
    };
};
["FHTheForgeOfSouls"] = {
    ZoneName = { BabbleSubZone["The Frozen Halls"]..": "..BabbleZone["The Forge of Souls"], 4809 };
    Location = { BabbleZone["Icecrown Citadel"], 4812 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "5";
    Acronym = AL["FoS"]..", "..AL["FH1"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Portal"].." ("..BabbleZone["Pit of Saron"]..")", ZONE, 4813 };
    { WHITE.."1) "..AL["Lady Jaina Proudmoore"].." ("..AL["Alliance"]..")", NPC, 37597 };
    { WHITE..INDENT..AL["Archmage Koreln <Kirin Tor>"].." ("..AL["Alliance"]..")", NPC, 37582 };
    { WHITE..INDENT..AL["Archmage Elandra <Kirin Tor>"].." ("..AL["Alliance"]..")", NPC, 37774 };
    { WHITE..INDENT..AL["Lady Sylvanas Windrunner <Banshee Queen>"].." ("..AL["Horde"]..")", NPC, 37596 };
    { WHITE..INDENT..AL["Dark Ranger Loralen"].." ("..AL["Horde"]..")", NPC, 37779 };
    { WHITE..INDENT..AL["Dark Ranger Kalira"].." ("..AL["Horde"]..")", NPC, 37583 };
    { WHITE.."2) "..AL["Bronjahm <Godfather of Souls>"], NPC, 36497 };
    { WHITE.."3) "..AL["Devourer of Souls"], NPC, 36502 };
    };
};
["Gundrak"] = {
    ZoneName = { BabbleZone["Gundrak"], 4375 };
    Location = { BabbleZone["Zul'Drak"], 66 };
    LevelRange = "76-80";
    MinLevel = "71";
    PlayerLimit = "5";
    Acronym = AL["Gun"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Exit"] };
    { WHITE.."1) "..AL["Slad'ran <High Prophet of Sseratus>"], NPC, 29304 };
    { WHITE.."2) "..AL["Drakkari Colossus"], NPC, 29307 };
    { WHITE.."3) "..AL["Elder Ohanzee"].." ("..AL["Lunar Festival"]..")", NPC, 30537 };
    { WHITE.."4) "..AL["Moorabi <High Prophet of Mam'toth>"], NPC, 29305 };
    { WHITE.."5) "..AL["Eck the Ferocious"].." ("..AL["Heroic"]..", "..AL["Summon"]..")", NPC, 29932 };
    { WHITE.."6) "..AL["Gal'darah <High Prophet of Akali>"], NPC, 29306 };
    };
};
["IcecrownCitadelA"] = {
    ZoneName = { BabbleZone["Icecrown Citadel"].." [A] ("..AL["Lower"]..")", 4812 };
    Location = { BabbleZone["Icecrown"], 210 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["IC"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Ashen Verdict"], FACTION, 1156 };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Connection"] };
    { BLUE.."C) "..AL["To next map"] };
    { WHITE.."1) "..AL["Lord Marrowgar"], NPC, 36612 };
    { WHITE.."2) "..AL["Lady Deathwhisper"], NPC, 36855 };
    { WHITE.."3) "..AL["Gunship Battle"].." ("..AL["Alliance"]..")", OBJECT, 201873 };
    { WHITE.."4) "..AL["Gunship Battle"].." ("..AL["Horde"]..")", OBJECT, 201873 };
    { WHITE.."5) "..AL["Deathbringer Saurfang"], NPC, 37813 };
    { GREN.."1') "..BabbleSubZone["Light's Hammer"].." ("..AL["Teleporter"]..")" };
    { GREN.."2') "..BabbleSubZone["Oratory of the Damned"].." ("..AL["Teleporter"]..")" };
    { GREN.."3') "..BabbleSubZone["Rampart of Skulls"].." ("..AL["Teleporter"]..", "..AL["Lower"]..")" };
    { GREN..INDENT..BabbleSubZone["Deathbringer's Rise"].." ("..AL["Teleporter"]..", "..AL["Upper"]..")" };
    };
};
["IcecrownCitadelB"] = {
    ZoneName = { BabbleZone["Icecrown Citadel"].." [B] ("..AL["Upper"]..")", 4812 };
    Location = { BabbleZone["Icecrown"], 210 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["IC"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Ashen Verdict"], FACTION, 1156 };
    { BLUE.."C) "..AL["From previous map"] };
    { BLUE.."D-H) "..AL["Connection"] };
    { BLUE.."I) "..AL["To next map"] };
    { WHITE.."6) "..AL["Festergut"], NPC, 36626 };
    { WHITE.."7) "..AL["Rotface"], NPC, 36627 };
    { WHITE.."8) "..AL["Professor Putricide"], NPC, 36678 };
    { WHITE.."9) "..AL["Blood Prince Council"] };
    { WHITE..INDENT..AL["Prince Keleseth"], NPC, 37972 };
    { WHITE..INDENT..AL["Prince Taldaram"], NPC, 37973 };
    { WHITE..INDENT..AL["Prince Valanar"], NPC, 37970 };
    { WHITE.."10) "..AL["Blood-Queen Lana'thel"], NPC, 38004 };
    { WHITE.."11) "..AL["Valithria Dreamwalker"], NPC, 36789 };
    { WHITE.."12) "..AL["Sindragosa <Queen of the Frostbrood>"], NPC, 37755 };
    { GREN.."4') "..AL["Upper Spire"].." ("..AL["Teleporter"]..")" };
    { GREN.."5') "..AL["Sindragosa's Lair"].." ("..AL["Teleporter"]..")" };
    };
};
["IcecrownCitadelC"] = {
    ZoneName = { BabbleZone["Icecrown Citadel"].." [C] ("..BabbleSubZone["The Frozen Throne"]..")", 4812 };
    Location = { BabbleZone["Icecrown"], 210 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["IC"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Reputation"]..": "..AL["The Ashen Verdict"], FACTION, 1156 };
    { BLUE.."I) "..AL["From previous map"] };
    { WHITE.."13) "..AL["The Lich King"], NPC, 36597 };
    };
};
["Naxxramas60"] = {
    ZoneName = { BabbleZone["Naxxramas"], 3456 };
    Location = { BabbleZone["Eastern Plaguelands"], 65 };
    LevelRange = "60+";
    MinLevel = "60";
    PlayerLimit = "10-25";
    Acronym = "Nax60";
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE..INDENT.."1) "..AL["Patchwerk"], NPC, 16028 };
    { WHITE..INDENT.."2) "..AL["Grobbulus"], NPC, 15931 };
    { WHITE..INDENT.."3) "..AL["Gluth"], NPC, 15932 };
    { WHITE..INDENT.."4) "..AL["Thaddius"], NPC, 15928 };
    { ORNG..INDENT.."1) "..AL["Anub'Rekhan"], NPC, 15956 };
    { ORNG..INDENT.."2) "..AL["Grand Widow Faerlina"], NPC, 15953 };
    { ORNG..INDENT.."3) "..AL["Maexxna"], NPC, 15952 };
    { _RED..INDENT.."1) "..AL["Instructor Razuvious"], NPC, 16061 };
    { _RED..INDENT.."2) "..AL["Gothik the Harvester"], NPC, 16060 };
    { _RED..INDENT.."3) "..AL["Four Horsemen Chest"], OBJECT, 181366 };
    { PURP..INDENT.."1) "..AL["Noth the Plaguebringer"], NPC, 15954 };
    { PURP..INDENT.."2) "..AL["Heigan the Unclean"], NPC, 15936 };
    { PURP..INDENT.."3) "..AL["Loatheb"], NPC, 16011 };
    { GREN..INDENT.."1) "..AL["Sapphiron"], NPC, 15989 };
    { GREN..INDENT.."2) "..AL["Kel'Thuzad"], NPC, 15990 };
    };
};
["Naxxramas"] = {
    ZoneName = { BabbleZone["Naxxramas"], 3456 };
    Location = { BabbleZone["Dragonblight"], 65 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Nax"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE..INDENT..AL["Mr. Bigglesworth"].." ("..AL["Wanders"]..")", NPC, 16998 };
    { WHITE..BabbleSubZone["The Construct Quarter"] };
    { WHITE..INDENT.."1) "..AL["Patchwerk"], NPC, 16028 };
    { WHITE..INDENT.."2) "..AL["Grobbulus"], NPC, 15931 };
    { WHITE..INDENT.."3) "..AL["Gluth"], NPC, 15932 };
    { WHITE..INDENT.."4) "..AL["Thaddius"], NPC, 15928 };
    { ORNG..BabbleSubZone["The Arachnid Quarter"] };
    { ORNG..INDENT.."1) "..AL["Anub'Rekhan"], NPC, 15956 };
    { ORNG..INDENT.."2) "..AL["Grand Widow Faerlina"], NPC, 15953 };
    { ORNG..INDENT.."3) "..AL["Maexxna"], NPC, 15952 };
    { _RED..BabbleSubZone["The Military Quarter"] };
    { _RED..INDENT.."1) "..AL["Instructor Razuvious"], NPC, 16061 };
    { _RED..INDENT.."2) "..AL["Gothik the Harvester"], NPC, 16060 };
    { _RED..INDENT.."3) "..AL["The Four Horsemen"] };
    { _RED..INDENT..INDENT..AL["Thane Korth'azz"], NPC, 16064 };
    { _RED..INDENT..INDENT..AL["Lady Blaumeux"], NPC, 16065 };
    { _RED..INDENT..INDENT..AL["Baron Rivendare"], NPC, 30549 };
    { _RED..INDENT..INDENT..AL["Sir Zeliek"], NPC, 16063 };
    { _RED..INDENT..INDENT..AL["Four Horsemen Chest"], OBJECT, 181366 };
    { PURP..BabbleSubZone["The Plague Quarter"] };
    { PURP..INDENT.."1) "..AL["Noth the Plaguebringer"], NPC, 15954 };
    { PURP..INDENT.."2) "..AL["Heigan the Unclean"], NPC, 15936 };
    { PURP..INDENT.."3) "..AL["Loatheb"], NPC, 16011 };
    { GREN..AL["Frostwyrm Lair"] };
    { GREN..INDENT.."1) "..AL["Sapphiron"], NPC, 15989 };
    { GREN..INDENT.."2) "..AL["Kel'Thuzad"], NPC, 15990 };
    };
};
["ObsidianSanctum"] = {
    ZoneName = { BabbleSubZone["Chamber of the Aspects"]..": "..BabbleZone["The Obsidian Sanctum"], 4493 };
    Location = { BabbleZone["Dragonblight"], 65 };
    LevelRange = "80";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["OS"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["AKA"]..": "..AL["Black Dragonflight Chamber"] };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Tenebron"], NPC, 30452 };
    { WHITE.."2) "..AL["Shadron"], NPC, 30451 };
    { WHITE.."3) "..AL["Vesperon"], NPC, 30449 };
    { WHITE.."4) "..AL["Sartharion <The Onyx Guardian>"], NPC, 28860 };
    };
};
["OnyxiasLair"] = {
    ZoneName = { BabbleZone["Onyxia's Lair"], 2159 };
    Acronym = AL["Ony"];
    MapName = "DireMaul";
    Location = { BabbleZone["Dustwallow Marsh"], 15 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Onyxian Warders"], NPC, 12129 };
    { WHITE.."2) "..AL["Whelp Eggs"] };
    { WHITE.."3) "..AL["Onyxia"], NPC, 10184 };
    };
};
["Onyxia60"] = {
    ZoneName = { BabbleZone["Onyxia's Lair"], 2159 };
    Acronym = AL["Ony"];
    MapName = "DireMaul";
    Location = { BabbleZone["Dustwallow Marsh"], 15 };
    LevelRange = "60+";
    MinLevel = "60";
    PlayerLimit = "10-25";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Onyxian Warders"], NPC, 12129 };
    { WHITE.."2) "..AL["Whelp Eggs"] };
    { WHITE.."3) "..AL["Onyxia"], NPC, 10184 };
    };
};
["RubySanctum"] = {
    ZoneName = { BabbleSubZone["Chamber of the Aspects"]..": "..BabbleZone["The Ruby Sanctum"], 4987 };
    Location = { BabbleZone["Dragonblight"], 65 };
    LevelRange = "80";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["RS"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["AKA"]..": "..AL["Red Dragonflight Chamber"] };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Baltharus the Warborn"], NPC, 39751 };
    { WHITE.."2) "..AL["Saviana Ragefire"], NPC, 39747 };
    { WHITE.."3) "..AL["General Zarithrian"], NPC, 39746 };
    { WHITE.."4) "..AL["Halion <The Twilight Destroyer>"], NPC, 39863 };		
    };
};
["TheEyeOfEternity"] = {
    ZoneName = { BabbleZone["The Nexus"]..": "..BabbleZone["The Eye of Eternity"], 4500 };
    Location = { BabbleZone["Borean Tundra"], 3537 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["TEoE"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["Key to the Focusing Iris"], ITEM, 44582 };
    { WHITE.."1) "..AL["Malygos"], NPC, 28859 };
    };
};
["TheNexus"] = {
    ZoneName = { BabbleZone["The Nexus"]..": "..BabbleZone["The Nexus"], 4120 };
    Location = { BabbleZone["Borean Tundra"], 3537 };
    LevelRange = "70-75";
    MinLevel = "66";
    PlayerLimit = "5";
    Acronym = AL["Nex, Nexus"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Berinand's Research"], OBJECT, 192788 };
    { WHITE..INDENT..AL["Commander Stoutbeard"].." ("..AL["Horde"]..", "..AL["Heroic"]..")", NPC, 26796 };
    { WHITE..INDENT..AL["Commander Kolurg"].." ("..AL["Alliance"]..", "..AL["Heroic"]..")", NPC, 26798 };
    { WHITE.."2) "..AL["Grand Magus Telestra"], NPC, 26731 };
    { WHITE.."3) "..AL["Anomalus"], NPC, 26763 };
    { WHITE.."4) "..AL["Elder Igasho"].." ("..AL["Lunar Festival"]..")", NPC, 30536 };
    { WHITE.."5) "..AL["Ormorok the Tree-Shaper"], NPC, 26794 };
    { WHITE.."6) "..AL["Keristrasza"], NPC, 26723 };
    };
};
["TheOculus"] = {
    ZoneName = { BabbleZone["The Nexus"]..": "..BabbleZone["The Oculus"], 4228 };
    Location = { BabbleZone["The Nexus"], 4120 };
    LevelRange = "78-80";
    MinLevel = "75";
    PlayerLimit = "5";
    Acronym = AL["Ocu"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Portal"] };
    { WHITE.."1) "..AL["Drakos the Interrogator"], NPC, 27654 };
    { WHITE.."2) "..AL["Varos Cloudstrider <Azure-Lord of the Blue Dragonflight>"], NPC, 27447 };
    { WHITE.."3) "..AL["Mage-Lord Urom"], NPC, 27655 };
    { WHITE.."4) "..AL["Ley-Guardian Eregos"], NPC, 27656 };
    { WHITE.."5) "..AL["Cache of Eregos"], OBJECT, 191349};
    { GREN.."1') "..AL["Centrifuge Construct"], NPC, 27641 };
    };
};
["TrialOfTheChampion"] = {
    ZoneName = { AL["Crusaders' Coliseum"]..": "..BabbleZone["Trial of the Champion"], 4723 };
    Location = { BabbleZone["Icecrown"], 210 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "5";
    Acronym = AL["Champ"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Grand Champions"] };
    { WHITE..INDENT..AL["Champions of the Alliance"] };
    { WHITE..INDENT..INDENT..AL["Marshal Jacob Alerius"], NPC, 34705 };
    { WHITE..INDENT..INDENT..AL["Ambrose Boltspark"], NPC, 34702 };
    { WHITE..INDENT..INDENT..AL["Colosos"], NPC, 34701 };
    { WHITE..INDENT..INDENT..AL["Jaelyne Evensong"], NPC, 34657 };
    { WHITE..INDENT..INDENT..AL["Lana Stouthammer"], NPC, 34703 };
    { WHITE..INDENT..AL["Champions of the Horde"] };
    { WHITE..INDENT..INDENT..AL["Mokra the Skullcrusher"], NPC, 35572 };
    { WHITE..INDENT..INDENT..AL["Eressea Dawnsinger"], NPC, 35569 };
    { WHITE..INDENT..INDENT..AL["Runok Wildmane"], NPC, 35571 };
    { WHITE..INDENT..INDENT..AL["Zul'tore"], NPC, 35570 };
    { WHITE..INDENT..INDENT..AL["Deathstalker Visceri"], NPC, 35617 };
    { WHITE..INDENT..AL["Eadric the Pure <Grand Champion of the Argent Crusade>"], NPC, 35119 };
    { WHITE..INDENT..AL["Argent Confessor Paletress"], NPC, 34928 };
    { WHITE..INDENT..AL["The Black Knight"], NPC, 35451 };
    };
};
["TrialOfTheCrusader"] = {
    ZoneName = { AL["Crusaders' Coliseum"]..": "..BabbleZone["Trial of the Crusader"], 4722 };
    Location = { BabbleZone["Icecrown"], 210 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Crus"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Heroic: Trial of the Grand Crusader"] };
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..AL["Cavern Entrance"] };
    { WHITE.."1) "..AL["Northrend Beasts"] };
    { WHITE..INDENT..INDENT..AL["Gormok the Impaler"], NPC, 34796 };
    { WHITE..INDENT..INDENT..AL["Acidmaw"], NPC, 35144 };
    { WHITE..INDENT..INDENT..AL["Dreadscale"], NPC, 34799 };
    { WHITE..INDENT..INDENT..AL["Icehowl"], NPC, 34797 };
    { WHITE..INDENT..AL["Lord Jaraxxus"], NPC, 34780 };
    { WHITE..INDENT..AL["Faction Champions"] };
    { WHITE..INDENT..AL["Twin Val'kyr"] };
    { WHITE..INDENT..INDENT..AL["Fjola Lightbane"], NPC, 34497 };
    { WHITE..INDENT..INDENT..AL["Eydis Darkbane"], NPC, 34496 };
    { WHITE.."2) "..AL["Anub'arak"], NPC, 34564 };
    };
};
["UlduarA"] = {
    ZoneName = { BabbleZone["Ulduar"].." [A] ("..AL["The Siege"]..")", 4273 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Uldu"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE.."B) "..BabbleSubZone["The Antechamber"] };
    { ORNG.."A') "..AL["Tower of Life"] };
    { ORNG.."B') "..AL["Tower of Flame"] };
    { ORNG.."C') "..AL["Tower of Frost"] };
    { ORNG.."D') "..AL["Tower of Storms"] };
    { WHITE.."1) "..AL["Flame Leviathan"], NPC, 33113 };
    { WHITE.."2) "..AL["Razorscale"].." ("..AL["Optional"]..")", NPC, 33186 };
    { WHITE.."3) "..AL["Ignis the Furnace Master"].." ("..AL["Optional"]..")", NPC, 33118 };
    { WHITE.."4) "..AL["XT-002 Deconstructor"], NPC, 33293 };
    { GREN.."1') "..BabbleSubZone["Expedition Base Camp"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    { GREN.."2') "..BabbleSubZone["Formation Grounds"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    { GREN.."3') "..BabbleSubZone["The Colossal Forge"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    { GREN.."4') "..BabbleSubZone["The Scrapyard"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    };
};
["UlduarB"] = {
    ZoneName = { BabbleZone["Ulduar"].." [B] ("..BabbleSubZone["The Antechamber"]..")", 4273 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Uldu"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["Celestial Planetarium Key"], ITEM, 45796 };
    { BLUE.."B) "..AL["The Siege"] };
    { BLUE.."C) "..AL["The Keepers"] };
    { WHITE.."5) "..AL["Assembly of Iron"].." ("..AL["Optional"]..")" };
    { WHITE..INDENT..AL["Steelbreaker"], NPC, 32867 };
    { WHITE..INDENT..AL["Runemaster Molgeim"], NPC, 32867 };
    { WHITE..INDENT..AL["Stormcaller Brundir"], NPC, 32867 };
    { WHITE.."6) "..AL["Prospector Doren"], NPC, 33956 };
    { WHITE..INDENT..AL["Archivum Console"], OBJECT, 194555 };
    { WHITE.."7) "..AL["Kologarn"], NPC, 32930 };
    { WHITE.."8) "..AL["Algalon the Observer"].." ("..AL["Optional"]..")" };
    { GREN.."5') "..BabbleSubZone["The Antechamber"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    };
};
["UlduarC"] = {
    ZoneName = { BabbleZone["Ulduar"].." [C] ("..AL["The Keepers"]..")", 4273 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Uldu"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."C) "..BabbleSubZone["The Antechamber"] };
    { BLUE.."D) "..BabbleSubZone["The Spark of Imagination"] };
    { BLUE.."E) "..BabbleSubZone["The Descent into Madness"] };
    { WHITE.."9) "..AL["Auriaya"].." ("..AL["Optional"]..")", NPC, 33515 };
    { WHITE.."10) "..AL["Hodir"], NPC, 32845 };
    { WHITE.."11) "..AL["Thorim"], NPC, 32865 };
    { WHITE.."12) "..AL["Freya"], NPC, 32906 };
    { GREN.."6') "..BabbleSubZone["The Shattered Walkway"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    { GREN.."7') "..BabbleSubZone["The Conservatory of Life"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    };
};
["UlduarD"] = {
    ZoneName = { BabbleZone["Ulduar"].." [D] ("..BabbleSubZone["The Spark of Imagination"]..")", 4273 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Uldu"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."D) "..AL["The Keepers"] };
    { WHITE.."13) "..AL["Mimiron"], NPC, 33412 };
    { GREN.."8') "..BabbleSubZone["The Spark of Imagination"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    };
};
["UlduarE"] = {
    ZoneName = { BabbleZone["Ulduar"].." [E] ("..BabbleSubZone["The Descent into Madness"]..")", 4273 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["Uldu"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."E) "..AL["The Keepers"] };
    { WHITE.."14) "..AL["General Vezax"], NPC, 33271 };
    { WHITE.."15) "..AL["Yogg-Saron"], NPC, 33288 };
    { GREN.."9') "..BabbleSubZone["The Prison of Yogg-Saron"].." ("..AL["Teleporter"]..")", OBJECT, 194569 };
    };
};
["UlduarHallsofLightning"] = {
    ZoneName = { BabbleZone["Ulduar"]..": "..BabbleZone["Halls of Lightning"], 4272 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "78-80";
    MinLevel = "75";
    PlayerLimit = "5";
    Acronym = AL["HoL"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["General Bjarngrim"].." ("..AL["Wanders"]..")", NPC, 28586 };
    { WHITE.."2) "..AL["Volkhan"], NPC, 28587 };
    { WHITE.."3) "..AL["Ionar"], NPC, 28546 };
    { WHITE.."4) "..AL["Loken"], NPC, 28923 };
    };
};
["UlduarHallsofStone"] = {
    ZoneName = { BabbleZone["Ulduar"]..": "..BabbleZone["Halls of Stone"], 4264 };
    Location = { BabbleZone["The Storm Peaks"], 67 };
    LevelRange = "75-80";
    MinLevel = "72";
    PlayerLimit = "5";
    Acronym = AL["HoS"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Elder Yurauk"].." ("..AL["Lunar Festival"]..")", NPC, 30535 };
    { WHITE.."2) "..AL["Krystallus"], NPC, 27977 };
    { WHITE.."3) "..AL["Maiden of Grief"], NPC, 27975 };
    { WHITE.."4) "..AL["Brann Bronzebeard"], NPC, 28070 };
    { WHITE.."5) "..AL["Tribunal Chest"], OBJECT, 190586 };
    { WHITE.."6) "..AL["Sjonnir the Ironshaper"], NPC, 27978 };
    };
};
["UtgardeKeep"] = {
    ZoneName = { BabbleZone["Utgarde Keep"]..": "..BabbleZone["Utgarde Keep"], 206 };
    Location = { BabbleZone["Howling Fjord"], 495 };
    LevelRange = "68-75";
    MinLevel = "65";
    PlayerLimit = "5";
    Acronym = AL["UK, Keep"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE..INDENT..AL["Dark Ranger Marrah"], NPC, 24137 };
    { BLUE.."B-C) "..AL["Connection"] };
    { WHITE.."1) "..AL["Prince Keleseth <The San'layn>"], NPC, 23953 };
    { WHITE.."2) "..AL["Elder Jarten"].." ("..AL["Lunar Festival"]..", "..AL["Lower"]..")", NPC, 30531 };
    { WHITE.."3) "..AL["Dalronn the Controller"], NPC, 24201 };
    { WHITE..INDENT..AL["Skarvald the Constructor"], NPC, 24200 };
    { WHITE.."4) "..AL["Ingvar the Plunderer"], NPC, 23980 };
    };
};
["UtgardePinnacle"] = {
    ZoneName = { BabbleZone["Utgarde Keep"]..": "..BabbleZone["Utgarde Pinnacle"], 1196 };
    Location = { BabbleZone["Utgarde Keep"], 206 };
    LevelRange = "78-80";
    MinLevel = "75";
    PlayerLimit = "5";
    Acronym = AL["UP, Pinn"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { BLUE..INDENT..AL["Brigg Smallshanks"], NPC, 30871 };
    { WHITE.."1) "..AL["Svala Sorrowgrave"], NPC, 26668 };
    { WHITE.."2) "..AL["Gortok Palehoof"], NPC, 26687 };
    { WHITE.."3) "..AL["Skadi the Ruthless"], NPC, 26693 };
    { WHITE.."4) "..AL["Elder Chogan'gada"].." ("..AL["Lunar Festival"]..")", NPC, 30538 };
    { WHITE.."5) "..AL["King Ymiron"], NPC, 26861 };
    };
};
["VaultOfArchavon"] = {
    ZoneName = { BabbleZone["Vault of Archavon"], 4603 };
    Location = { BabbleZone["Wintergrasp"], 4197 };
    LevelRange = "80+";
    MinLevel = "80";
    PlayerLimit = "10/25";
    Acronym = AL["VoA"];
    MapName = "DireMaul";
    [1] = {
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Archavon the Stone Watcher"], NPC, 31125 };
    { WHITE.."2) "..AL["Emalon the Storm Watcher"], NPC, 33993 };
    { WHITE.."3) "..AL["Koralon the Flame Watcher"], NPC, 35013 };
    { WHITE.."4) "..AL["Toravon the Ice Watcher"], NPC, 38433 };
    };
};
["VioletHold"] = {
    ZoneName = { BabbleZone["The Violet Hold"], 4415 };
    Location = { BabbleZone["Dalaran"], 4395 };
    LevelRange = "73-79";
    MinLevel = "70";
    PlayerLimit = "5";
    Acronym = AL["VH"];
    MapName = "DireMaul";
    [1] = {
    { ORNG..AL["Key"]..": "..AL["The Violet Hold Key"], ITEM, 42482 };
    { BLUE.."A) "..AL["Entrance"] };
    { WHITE.."1) "..AL["Erekem"].." ("..AL["Random"]..")", NPC, 29315 };
    { WHITE.."2) "..AL["Zuramat the Obliterator"].." ("..AL["Upper"]..", "..AL["Random"]..")", NPC, 29314 };
    { WHITE..INDENT..AL["Xevozz"].." ("..AL["Lower"]..", "..AL["Random"]..")", NPC, 29266 };
    { WHITE.."3) "..AL["Ichoron"].." ("..AL["Random"]..")", NPC, 29313 };
    { WHITE.."4) "..AL["Moragg"].." ("..AL["Random"]..")", NPC, 29316 };
    { WHITE.."5) "..AL["Lavanthor"].." ("..AL["Random"]..")", NPC, 29312 };
    { WHITE.."6) "..AL["Cyanigosa"].." ("..AL["Wave 18"]..")", NPC, 31134 };
    };
};
};