local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BLUE = "|cff6666ff";
local WHITE = "|cFFFFFFFF"
local INDENT = "    ";

    --Main AtlasLoot Frame
    local mainframe = CreateFrame("FRAME", "AtlasLootDefaultFrame", UIParent,"PortraitFrameTemplate");
    mainframe:SetPoint("CENTER",0,0);
    mainframe:SetSize(880,690);
    mainframe:EnableMouse(true);
    mainframe:SetMovable(1);
    mainframe.portrait:SetPortraitTexture("Interface\\Icons\\INV_Box_01")
    mainframe:SetFrameStrata("HIGH");
    mainframe.TitleText:SetText(AtlasLoot.Version);
    mainframe:RegisterForDrag("LeftButton");
    mainframe:SetMovable(true);
    mainframe:EnableKeyboard(true)
    mainframe:Hide()
    mainframe:SetScript("OnShow", function()
        AtlasLootDefaultFrame_OnShow();
    end);
    mainframe:SetScript("OnMouseDown", function()
        AtlasLoot.Dewdrop:Close();
    end);
    mainframe:SetScript("OnHide", function() AtlasLootDefaultFrame_OnHide() end)
    mainframe:SetScript("OnDragStart", function(self)
        self:StartMoving();
        self.isMoving = true;
    end);
    mainframe:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing();
        self.isMoving = false;
     end);

    --Loot Background
local lootBackground = CreateFrame("Frame", "AtlaslLoot_LootBackground", mainframe);
    lootBackground:SetSize(540,515);
    lootBackground:SetPoint("BOTTOMLEFT", mainframe, "BOTTOMLEFT",40,90);
    lootBackground:EnableMouse();
    lootBackground:EnableMouseWheel();
    lootBackground:SetScript("OnMouseDown",function(self, button)
        if _G["AtlasLootItemsFrame_BACK"]:IsVisible() and button == "RightButton" then
            AtlasLoot:BackButton_OnClick();
        elseif AtlasLootDefaultFrame_AdvancedSearchPanel:IsVisible() and button == "RightButton" then
            AtlasLoot_AdvancedSearchClose();
        end
        AtlasLoot.Dewdrop:Close();
    end);
    lootBackground:SetScript("OnMouseWheel", function(self,delta)
            if AtlasLootItemsFrame_NEXT:IsVisible() and delta == -1 then
                AtlasLootItemsFrame_NEXT:Click();
            end
            if AtlasLootItemsFrame_PREV:IsVisible() and delta == 1 then
                AtlasLootItemsFrame_PREV:Click();
            end
    end);

----------------------------------- Item Loot Panel -------------------------------------------
local itemframe = CreateFrame("Frame", "AtlasLootItemsFrame", lootBackground);
        itemframe:SetSize(535,510);
        itemframe:Hide();
        itemframe:SetPoint("TOPLEFT", lootBackground, "TOPLEFT", 2, -2);
        itemframe.Label = itemframe:CreateFontString("AtlasLoot_BossName","OVERLAY","GameFontHighlightLarge");
        itemframe.Label:SetPoint("TOP", "AtlasLootItemsFrame", "TOP");
        itemframe.Label:SetSize(512,30);
        itemframe.Label:SetJustifyH("CENTER");
        itemframe.Back = itemframe:CreateTexture("AtlasLootItemsFrame_Back", "BACKGROUND");
        itemframe.Back:SetAllPoints();
        itemframe.Back:SetPoint("TOPLEFT",lootBackground,"TOPLEFT");
        itemframe.Back:SetPoint("BOTTOMRIGHT",lootBackground,"BOTTOMRIGHT");

for num = 1, 30 do
    local button = CreateFrame("Button","AtlasLootItem_"..num, AtlasLootItemsFrame);
        button:SetID(num);
        button:SetSize(236,28);
        button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
        button.icon = button:CreateTexture("AtlasLootItem_"..num.."_Icon","ARTWORK");
        button.icon:SetSize(25,25);
        button.icon:SetPoint("TOPLEFT", "AtlasLootItem_"..num,"TOPLEFT",1,-1);
        button.Highlight = button:CreateTexture("AtlasLootItem_"..num.."_Highlight", "OVERLAY");
        button.Highlight:SetSize(26,26);
        button.Highlight:SetPoint("CENTER", button.icon, 0, 0);
        button.Highlight:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\knownGreen");
        button.Highlight:Hide();
        button.name = button:CreateFontString("AtlasLootItem_"..num.."_Name","ARTWORK","GameFontNormal");
        button.name:SetSize(205,12);
        button.name:SetPoint("TOPLEFT","AtlasLootItem_"..num.."_Icon","TOPRIGHT",3,0);
        button.name:SetJustifyH("LEFT");
        button.extra = button:CreateFontString("AtlasLootItem_"..num.."_Extra","ARTWORK","GameFontNormal");
        button.extra:SetSize(205,10);
        button.extra:SetPoint("TOPLEFT","AtlasLootItem_"..num.."_Name","BOTTOMLEFT",0,-1);
        button.extra:SetJustifyH("LEFT");
        button:RegisterForClicks("AnyDown");
        button.number = num;
        button:SetScript("OnEnter", function(self) AtlasLootItem_OnEnter(self) end);
        button:SetScript("OnLeave", function(self) AtlasLootItem_OnLeave(self) end);
        button:SetScript("OnClick", function(self, arg1) AtlasLootItem_OnClick(self, arg1) end);
        button.unsafe = button:CreateTexture("AtlasLootItem_"..num.."_Unsafe","BACKGROUND");
        button.unsafe:Hide();
        button.unsafe:SetSize(27,27);
        button.unsafe:SetPoint("TOPLEFT","AtlasLootItem_"..num,"TOPLEFT");
        button.unsafe:SetVertexColor(1,0,0,1);
        if num == 1 then
            button:SetPoint("TOP", "AtlasLootItemsFrame", "TOP",-125,-35);
        elseif num == 16 then
            button:SetPoint("TOP", "AtlasLootItemsFrame", "TOP",125,-35);
        else
            button:SetPoint("TOPLEFT", "AtlasLootItem_"..(num - 1), "BOTTOMLEFT");
        end
end

        -- LootInfo
local lootinfo = CreateFrame("Frame", "AtlasLootInfo")
        lootinfo:SetSize(128,75);
        lootinfo.text1 = lootinfo:CreateFontString("AtlasLootInfo_Text1", "OVERLAY", "GameFontNormal");
        lootinfo.text1:SetSize(180,10);
        lootinfo.text1:SetText("AtlasLoot.Version");
        lootinfo.text1:SetJustifyH("LEFT");
        lootinfo.text1:SetPoint("TOPLEFT", "AtlasLootInfo", "TOPLEFT",0,25);
        lootinfo.text2 = lootinfo:CreateFontString("AtlasLootInfo_Text2", "OVERLAY", "GameFontNormal");
        lootinfo.text2:SetSize(180,10);
        lootinfo.text2:SetJustifyH("LEFT");
        lootinfo.text2:SetText(AL["Click boss name to view loot."]);
        lootinfo.text2:SetPoint("TOPLEFT", "AtlasLootInfo", "TOPLEFT",0,-2);

        -- Next Button
local nextbtn = CreateFrame("Button", "AtlasLootItemsFrame_NEXT", AtlasLootItemsFrame);
        nextbtn:SetPoint("BOTTOMRIGHT", "AtlasLootItemsFrame", "BOTTOMRIGHT",-5,5);
        nextbtn:SetSize(32,32);
        nextbtn.texture = nextbtn:CreateTexture(nil, "BACKGROUND");
        nextbtn.texture:SetTexture("Interface\\Buttons\\UI-PageButton-Background");
        nextbtn.texture:SetSize(32,32);
        nextbtn.texture:SetPoint("CENTER",0,0);
        nextbtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
        nextbtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
        nextbtn:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
        nextbtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
        nextbtn:SetScript("OnClick", function(self) AtlasLoot:NavButton_OnClick(self) end)
        nextbtn:Hide();

        -- Previous button
local prevbtn = CreateFrame("Button", "AtlasLootItemsFrame_PREV", AtlasLootItemsFrame);
        prevbtn:SetPoint("BOTTOMLEFT", "AtlasLootItemsFrame", "BOTTOMLEFT",5,5);
        prevbtn:SetSize(32,32);
        prevbtn.texture = prevbtn:CreateTexture(nil, "BACKGROUND");
        prevbtn.texture:SetTexture("Interface\\Buttons\\UI-PageButton-Background");
        prevbtn.texture:SetSize(32,32);
        prevbtn.texture:SetPoint("CENTER",0,0);
        prevbtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
        prevbtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
        prevbtn:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
        prevbtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
        prevbtn:SetScript("OnClick", function(self) AtlasLoot:NavButton_OnClick(self) end)
        prevbtn:Hide();

        -- Back button
local backbtn = CreateFrame("Button", "AtlasLootItemsFrame_BACK", AtlasLootItemsFrame, "OptionsButtonTemplate");
        backbtn:SetPoint("BOTTOM", "AtlasLootItemsFrame", "BOTTOM",0,4);
        backbtn:SetText(AL["Back"]);
        backbtn:SetScript("OnClick", function(self) AtlasLoot:BackButton_OnClick() end)
        backbtn:Hide();

        -- Wishlist Own/Swap button
local swapbtn = CreateFrame("Button", "AtlasLootItemsFrame_Wishlist_Swap", AtlasLootItemsFrame, "OptionsButtonTemplate");
        swapbtn:SetPoint("BOTTOM", "AtlasLootItemsFrame", "BOTTOM",50,4);
        swapbtn:SetScript("OnClick", function(self) AtlasLoot:WishListSwapButton("","","","","",self,true) end)
        swapbtn:Hide();

        -- Wishlist Options button
local wishOptionsbtn = CreateFrame("Button", "AtlasLootItemsFrame_Wishlist_Options", AtlasLootItemsFrame, "OptionsButtonTemplate");
    wishOptionsbtn:SetPoint("BOTTOM", "AtlasLootItemsFrame_Wishlist_Swap", "BOTTOM",-100,0);
    wishOptionsbtn:SetText(AL["Options"]);
    wishOptionsbtn:SetScript("OnClick", function(self) AtlasLoot:WishListOptionsOpen(); end);
    wishOptionsbtn:Hide();

        -- Wishlist Item Lock button
local lockbtn = CreateFrame("Button", "AtlasLootItemsFrame_Wishlist_UnLock", AtlasLootItemsFrame, "OptionsButtonTemplate");
        lockbtn:SetPoint("BOTTOM", "AtlasLootItemsFrame_Wishlist_Options", "BOTTOM",-100,0);
        lockbtn:SetScript("OnClick", function(self)
            if AtlasLoot.itemUnlock then
                AtlasLoot.itemUnlock = false;
                lockbtn:SetText("Locked");
            else
                AtlasLoot.itemUnlock = true;
                lockbtn:SetText("UnLocked");
            end
        end)
        lockbtn:SetScript("OnEnter", function(self)
            GameTooltip:ClearLines();
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5);
            GameTooltip:AddLine("Toggle Item Moving");
            GameTooltip:AddLine("Left Click to move item up");
            GameTooltip:AddLine("Right Click to move item down");
            GameTooltip:AddLine("Alt + Left Click to add a Custom Header");
            GameTooltip:Show();
        end);
        lockbtn:SetScript("OnLeave", function()
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
        end);
        lockbtn:SetText("Locked");
        lockbtn:Hide();
    -- Wishlist Share button
local sharebtn = CreateFrame("Button", "AtlasLootItemsFrame_Wishlist_Share", AtlasLootItemsFrame, "OptionsButtonTemplate");
        sharebtn:SetPoint("BOTTOM", "AtlasLootItemsFrame_Wishlist_Swap", "BOTTOM",100,0);
        sharebtn:SetText(AL["Share"]);
        sharebtn:SetScript("OnClick", function() AtlasLoot:ShareWishList() end)
        sharebtn:Hide();
        -- Filter Button
local filterbtn = CreateFrame("CheckButton","AtlasLootFilterCheck",AtlasLootItemsFrame,"OptionsCheckButtonTemplate");
        filterbtn:SetPoint("BOTTOM", "AtlasLootItemsFrame", "BOTTOM",85 ,27);
        filterbtn.Label = filterbtn:CreateFontString("AtlasLootFilterCheckText","OVERLAY","GameFontNormal");
        filterbtn.Label:SetText(AL["Filter"]);
        filterbtn.Label:SetPoint("RIGHT", AtlasLootFilterCheck, 30, 2);
        filterbtn:RegisterForClicks("LeftButtonDown","RightButtonDown");
        filterbtn:SetScript("OnClick", function(self, btnclick) AtlasLoot_FilterEnableButton(self, btnclick) end);

        -- Quick Looks Button
local looksbtn = CreateFrame("Button", "AtlasLootQuickLooksButton", AtlasLootItemsFrame);
        looksbtn:SetPoint("BOTTOM", "AtlasLootItemsFrame", "BOTTOM",58,28);
        looksbtn:SetSize(25,25);
        looksbtn.Label = looksbtn:CreateFontString("AtlasLoot_QuickLooks","OVERLAY","GameFontNormal");
        looksbtn.Label:SetSize(200,25);
        looksbtn.Label:SetText(AL["Add to QuickLooks:"]);
        looksbtn.Label:SetPoint("LEFT", "AtlasLootQuickLooksButton", -125, 0);
        looksbtn.Label:SetJustifyH("LEFT");
        looksbtn:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
        looksbtn:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
        looksbtn:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
        looksbtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
        looksbtn:SetScript("OnClick", function(self) AtlasLoot:ShowQuickLooks(self) end)
        looksbtn:SetScript("OnShow", function(self)
            if (AtlasLootItemsFrame.refresh) and ((AtlasLootItemsFrame.refresh[1] == "SearchResult") or (AtlasLootItemsFrame.refresh[1] == "WishList")) then
                self:Disable();
            else
                self:Enable();
            end
        end)
        looksbtn:Hide();
        
------------------------------------ Buttons at the top of the frame ---------------------------------------

    --SubMenu Button
local submenubtn = CreateFrame("Button", "AtlasLootDefaultFrame_SubMenu", AtlasLootDefaultFrame, "FilterDropDownMenuTemplate");
    submenubtn:SetSize(275,25);
    submenubtn:SetPoint("TOP", AtlaslLoot_LootBackground,"TOP",56,30)
    submenubtn.Lable = submenubtn:CreateFontString(nil, "OVERLAY","GameFontNormal")
    submenubtn.Lable:SetPoint("TOP",submenubtn,"BOTTOM",0,39);
    submenubtn.Lable:SetText("Select Subcategory");
    submenubtn.Lable:Show();
    submenubtn:SetScript("OnClick", function(self)
        AtlasLoot:DewdropSubMenuOpen(AtlasLoot_SubMenus[AtlasLoot.currentTable]);
    end);

    --Moduel Menu Button
local menubtn = CreateFrame("Button", "AtlasLootDefaultFrame_Menu", AtlasLootDefaultFrame, "FilterDropDownMenuTemplate");
    menubtn:SetSize(275,25);
    menubtn:SetPoint("RIGHT", "AtlasLootDefaultFrame_SubMenu", "LEFT",0,0);
    menubtn.Lable = menubtn:CreateFontString(nil, "OVERLAY","GameFontNormal")
    menubtn.Lable:SetPoint("TOP",menubtn,"BOTTOM",0,39);
    menubtn.Lable:SetText("Select Module");
    menubtn.Lable:Show();
    menubtn:SetText(AL["Select Loot Table"]);
    menubtn:SetScript("OnClick", function(self)
        AtlasLoot:DewdropOpen()
    end);

    --Options Button
local optionsbtn = CreateFrame("Button", nil, AtlasLootDefaultFrame, "SettingsGearButtonTemplate");
    optionsbtn:SetPoint("LEFT", "AtlasLootDefaultFrame_Menu",-27,0);
    optionsbtn:SetScript("OnClick", function(self,button) AtlasLoot:OptionsToggle() end);
    optionsbtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:AddLine("Options");
        GameTooltip:Show();
    end);
    optionsbtn:SetScript("OnLeave", function() GameTooltip:Hide() end);
    mainframe.optionsbtn = optionsbtn

    --Expansion Menu Button
local expansionmenubtn = CreateFrame("Button", "AtlasLootDefaultFrame_ExpansionMenu", AtlasLootDefaultFrame, "FilterDropDownMenuTemplate");
    expansionmenubtn:SetSize(185,25);
    expansionmenubtn:SetPoint("LEFT", "AtlasLootDefaultFrame_SubMenu", "RIGHT",5,0);
    expansionmenubtn:SetText(AtlasLoot_ExpansionMenu[GetAccountExpansionLevel()+1][1]);
    expansionmenubtn.Lable = expansionmenubtn:CreateFontString(nil, "OVERLAY","GameFontNormal")
    expansionmenubtn.Lable:SetPoint("TOP",expansionmenubtn,"BOTTOM",0,39);
    expansionmenubtn.Lable:SetText("Select Expansion");
    expansionmenubtn.Lable:Show();
    expansionmenubtn:SetScript("OnClick", function(self)
        AtlasLoot:DewdropExpansionMenuOpen();
    end);

---------------------------------------- Buttons Under the loot and subtable frames -------------------------------------------

    --Wish List Button
local wishbtn = CreateFrame("Button", "AtlasLootDefaultFrameWishListButton", AtlasLootDefaultFrame, "OptionsButtonTemplate");
        wishbtn:SetPoint("BOTTOMLEFT", "AtlasLootDefaultFrame", "BOTTOMLEFT", 40, 63);
        wishbtn:SetSize(105,20);
        wishbtn:RegisterForClicks("LeftButtonDown","RightButtonDown");
        wishbtn:SetScript("OnClick", function(self, btnclick)AtlasLoot:WishListButton("","","","","",self,true,btnclick) end);
        wishbtn:SetText(AL["Wishlist"]);
        wishbtn:SetScript("OnEnter", function(self)
                GameTooltip:ClearLines();
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5);
                GameTooltip:AddLine("Right Click For Menu");
                GameTooltip:Show();
        end);
        wishbtn:SetScript("OnLeave", function()
            if(GameTooltip:IsVisible()) then
                GameTooltip:Hide();
            end
        end);

    --Quick Look Buttons
local function presetcreate(preset,num)
    preset:SetSize(105,20);
    preset:SetScript("OnEnter", function(self)
        if self:IsEnabled() then
            GameTooltip:ClearLines();
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 5);
            GameTooltip:AddLine(AtlasLootCharDB["QuickLooks"][num][6]);
            GameTooltip:Show();
        end
    end);
    preset:SetScript("OnLeave", function()
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
    end);
    preset:SetScript("OnClick", function()
        if AtlasLoot:IsLootTableAvailable(AtlasLootCharDB["QuickLooks"][num][4]) then
            AtlasLoot.lastModule = AtlasLootCharDB["QuickLooks"][num][4];
            AtlasLoot.currentTable = AtlasLootCharDB["QuickLooks"][num][5];
            if AtlasLootCharDB["QuickLooks"][num][2] == "AtlasLootWishList" then
                AtlasLoot:ShowWishList(AtlasLootCharDB["QuickLooks"][num][1], AtlasLootCharDB["QuickLooks"][num][3]);
            else
                AtlasLoot:ShowItemsFrame(AtlasLootCharDB["QuickLooks"][num][1], AtlasLootCharDB["QuickLooks"][num][2], AtlasLootCharDB["QuickLooks"][num][3]);
            end
        end
    end);
    preset:SetScript("OnShow", function(self)
            self:SetText(AL["QuickLook"].." "..num);
            if ((not AtlasLootCharDB["QuickLooks"][num]) or (not AtlasLootCharDB["QuickLooks"][num][1])) or (AtlasLootCharDB["QuickLooks"][num][1]==nil) then
                self:Disable();
            end
    end);

end
    --QuickLook Button 1
local presetsize = 3.75;
local preset1 = CreateFrame("Button", "AtlasLootDefaultFrame_Preset1", AtlasLootDefaultFrame, "OptionsButtonTemplate");
    presetcreate(preset1,1);
    preset1:SetPoint("LEFT", AtlasLootDefaultFrameWishListButton, "RIGHT", presetsize, 0);
    --QuickLook Button 2
local preset2 = CreateFrame("Button", "AtlasLootDefaultFrame_Preset2", AtlasLootDefaultFrame, "OptionsButtonTemplate");
    presetcreate(preset2,2);
    preset2:SetPoint("LEFT", "AtlasLootDefaultFrame_Preset1", "RIGHT", presetsize, 0);
    --QuickLook Button 3
local preset3 = CreateFrame("Button", "AtlasLootDefaultFrame_Preset3", AtlasLootDefaultFrame, "OptionsButtonTemplate");
    presetcreate(preset3,3);
    preset3:SetPoint("LEFT", "AtlasLootDefaultFrame_Preset2", "RIGHT", presetsize, 0);
    --QuickLook Button 4
local preset4 = CreateFrame("Button", "AtlasLootDefaultFrame_Preset4", AtlasLootDefaultFrame, "OptionsButtonTemplate");
    presetcreate(preset4,4);
    preset4:SetPoint("LEFT", "AtlasLootDefaultFrame_Preset3", "RIGHT", presetsize, 0);

    --Search Edit Box
local searchbox = CreateFrame("EditBox","AtlasLootDefaultFrameSearchBox",AtlasLootDefaultFrame,"InputBoxTemplate");
    searchbox:SetSize(190,32);
    searchbox:SetMaxLetters(100);
    searchbox:SetAutoFocus(false);
    searchbox:SetPoint("TOPLEFT",AtlasLootDefaultFrameWishListButton,"BOTTOMLEFT",7,-3)
    searchbox:SetTextInsets(0, 8, 0, 0);
    searchbox:SetScript("OnEnterPressed", function(self)
        AtlasLoot:Search(self:GetText());
        self:ClearFocus();
    end)
    local fstring = searchbox:CreateFontString("AtlasLootDefaultFrameSearchString", "ARTWORK", "GameFontNormal");

    --Search Button
local searchbtn = CreateFrame("Button","AtlasLootDefaultFrameSearchButton",AtlasLootDefaultFrame,"UIPanelButtonTemplate2");
    searchbtn:SetSize(69,32);
    searchbtn:SetPoint("LEFT","AtlasLootDefaultFrameSearchBox","RIGHT",2,0);
	searchbtn:SetText(AL["Search"]);
    searchbtn:SetScript("OnClick", function()
        AtlasLoot:Search(AtlasLootDefaultFrameSearchBox:GetText());
        AtlasLootDefaultFrameSearchBox:ClearFocus();
    end);

    --Search Options Button
local searchopt = CreateFrame("Button", "AtlasLootDefaultFrameSearchOptionsButton", AtlasLootDefaultFrameSearchButton);
    searchopt:SetSize(28,28);
    searchopt:SetPoint("LEFT","AtlasLootDefaultFrameSearchButton","RIGHT",-5,0);
    searchopt:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
    searchopt:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
    searchopt:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
    searchopt:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight","ADD");
    searchopt:SetScript("OnClick", function(self) AtlasLoot:ShowSearchOptions(self) end)

    --Clear Search Button
local searchclear = CreateFrame("Button","AtlasLootDefaultFrameSearchClearButton",AtlasLootDefaultFrameSearchBox,"UIPanelButtonTemplate2");
    searchclear:SetSize(58,32);
    searchclear:SetPoint("LEFT",AtlasLootDefaultFrameSearchOptionsButton,"RIGHT",-2,0);
    searchclear:SetText(AL["Clear"]);
    searchclear:SetScript("OnClick", function()
        AtlasLootDefaultFrameSearchBox:SetText("");
        AtlasLootDefaultFrameSearchBox:ClearFocus();
    end);

    --Last Result Button
local lastresult = CreateFrame("Button","AtlasLootDefaultFrameLastResultButton",AtlasLootDefaultFrameSearchBox,"UIPanelButtonTemplate2");
    lastresult:SetSize(100,32);
    lastresult:SetPoint("LEFT",AtlasLootDefaultFrameSearchClearButton,"RIGHT",1,0);
    lastresult:SetText(AL["Last Result"]);
    lastresult:SetScript("OnClick", function() AtlasLoot:ShowSearchResult() end);

    -- Advanced Search Button
local advSearch = CreateFrame("Button","AtlasLootDefaultFrameAdvancedSearchButton", AtlasLootDefaultFrame,"UIPanelButtonTemplate2");
    advSearch:SetSize(95,32);
    advSearch:SetPoint("LEFT",AtlasLootDefaultFrameLastResultButton,"RIGHT",2);
    advSearch:SetText("Advanced");
    advSearch:SetScript("OnClick", function()
        AtlasLoot_AdvancedSearchShow();
        AtlasLootDefaultFrameSearchBox:ClearFocus();
    end)

---------------------  Diffcuility ScrollFrame ----------------------------------
local ROW_HEIGHT = 16;   -- How tall is each row?
local MAX_ROWS = 5;      -- How many rows can be shown at once?

local scrollFrame = CreateFrame("Frame", "Atlasloot_Difficulty_ScrollFrame", AtlasLootDefaultFrame);
    scrollFrame:EnableMouse(true);
    scrollFrame:SetSize(265, ROW_HEIGHT * MAX_ROWS + 16);
    scrollFrame:SetPoint("TOPRIGHT","AtlasLootDefaultFrame",-22,-60);
    scrollFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    });
    scrollFrame.Lable = scrollFrame:CreateFontString("Atlasloot_HeaderLabel", "OVERLAY","GameFontNormal")
    scrollFrame.Lable:SetPoint("TOPLEFT",Atlasloot_Difficulty_ScrollFrame,10,-10);
    scrollFrame.Lable:SetJustifyH("LEFT");
    scrollFrame.Lable:SetFont("GameFontNormal", 24);

function AtlasLoot:ScrollFrameUpdate(hide,wishlist)
    local maxValue,offset,row,value;
    scrollFrame.wishList = nil;
    if wishlist then
        scrollFrame.wishList = wishlist;
        maxValue = #AtlasLootWishList[wishlist];
        FauxScrollFrame_Update(scrollFrame.scrollBar, maxValue, MAX_ROWS, ROW_HEIGHT);
        offset = FauxScrollFrame_GetOffset(scrollFrame.scrollBar);
        for i = 1, MAX_ROWS do
            value = i + offset
            scrollFrame.rows[i]:SetChecked(false);
            scrollFrame.rows[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
            if value <= maxValue and AtlasLootWishList[wishlist][value] then
                row = scrollFrame.rows[i]
                row:SetText("|cffFFd200"..AtlasLootWishList[wishlist][value].Name);
                row.itemIndex = value;
                if row.itemIndex == ATLASLOOT_CURRENT_WISHLIST_NUM then
                    row:SetChecked(true);
                end
                row:Show()
            else
                scrollFrame.rows[i]:Hide()
            end
        end
    elseif AtlasLoot_Difficulty then
        maxValue = #AtlasLoot_Difficulty[AtlasLoot.CurrentType];
        FauxScrollFrame_Update(scrollFrame.scrollBar, maxValue, MAX_ROWS, ROW_HEIGHT);
        offset = FauxScrollFrame_GetOffset(scrollFrame.scrollBar);
        for i = 1, MAX_ROWS do
            value = i + offset
            scrollFrame.rows[i]:SetChecked(false);
            scrollFrame.rows[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
            if value <= maxValue and AtlasLoot_Difficulty[AtlasLoot.CurrentType][value] and hide == nil then
                row = scrollFrame.rows[i]
                row:SetText("|cffFFd200"..AtlasLoot_Difficulty[AtlasLoot.CurrentType][value][1]);
                row.itemIndex = AtlasLoot_Difficulty[AtlasLoot.CurrentType][value][2];
                if row.itemIndex == ItemindexID then
                    row:SetChecked(true);
                end
                row:Show()
            else
                scrollFrame.rows[i]:Hide()
            end
        end
    end
end

local scrollSlider = CreateFrame("ScrollFrame","AtlasLootDefaultFrameScroll", Atlasloot_Difficulty_ScrollFrame, "FauxScrollFrameTemplate");
    scrollSlider:SetPoint("TOPLEFT", 0, -8);
    scrollSlider:SetPoint("BOTTOMRIGHT", -30, 8);
    scrollSlider:SetScript("OnVerticalScroll", function(self, offset)
    self.offset = math.floor(offset / ROW_HEIGHT + 0.5);
    if scrollFrame.wishList then
        AtlasLoot:ScrollFrameUpdate(nil,scrollFrame.wishList);
    else
        AtlasLoot:ScrollFrameUpdate();
    end
end)

scrollSlider:SetScript("OnShow", function()
    if scrollFrame.wishList then
        AtlasLoot:ScrollFrameUpdate(nil,scrollFrame.wishList);
    else
        AtlasLoot:ScrollFrameUpdate();
    end
end)

scrollFrame.scrollBar = scrollSlider

local rows = setmetatable({}, { __index = function(t, i)
	local row = CreateFrame("CheckButton", "$parentRow"..i, Atlasloot_Difficulty_ScrollFrame)
	row:SetSize(230, ROW_HEIGHT);
    row:SetFrameStrata("HIGH");
	row:SetNormalFontObject(GameFontHighlightLeft);
    row:SetCheckedTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
    row:SetScript("OnClick", function()
        if scrollFrame.wishList then
            AtlasLoot:ShowWishList(scrollFrame.wishList,row.itemIndex);
            AtlasLoot_CurrentWishList["Show"].ListNum = row.itemIndex;
            AtlasLoot:ScrollFrameUpdate(nil,scrollFrame.wishList);
        else
            ItemindexID = row.itemIndex;
            if not AtlasLootDefaultFrame_AdvancedSearchPanel:IsVisible() then
            AtlasLoot:ShowItemsFrame(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3]);
            end
            AtlasLoot:ScrollFrameUpdate();
        end

    end)
	if i == 1 then
		row:SetPoint("TOPLEFT", scrollFrame, 8, -8)
	else
		row:SetPoint("TOPLEFT", scrollFrame.rows[i-1], "BOTTOMLEFT")
	end

	rawset(t, i, row)
	return row
end })

scrollFrame.rows = rows
local MAX_ROWS2 = 26;      -- How many rows can be shown at once?

--------------------Subtable Frame--------------------
local subtableFrame = CreateFrame("Frame", "Atlasloot_SubTableFrame", AtlasLootDefaultFrame);
    subtableFrame:EnableMouse(true);
    subtableFrame:SetSize(265, ROW_HEIGHT * MAX_ROWS2 + 23);
    subtableFrame:SetPoint("BOTTOMLEFT","Atlasloot_Difficulty_ScrollFrame",0,-446);
    subtableFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    });

function AtlasLoot:SubTableScrollFrameUpdate(tablename, dataSource, tablenum)
    local maxValue = #_G[dataSource][tablename];
    if dataSource == "AtlasLoot_MapData" then maxValue = #_G[dataSource][tablename][tablenum] end
    subtableFrame.tablename = tablename;
    subtableFrame.dataSource = dataSource;
    subtableFrame.tablenum = tablenum;
    FauxScrollFrame_Update(subtableFrame.scrollBar, maxValue, MAX_ROWS2, ROW_HEIGHT);
    local offset = FauxScrollFrame_GetOffset(subtableFrame.scrollBar);
    for i = 1, MAX_ROWS2 do
        local value = i + offset
        subtableFrame.rows[i]:SetChecked(false);
        subtableFrame.rows[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
        if value <= maxValue and (_G[dataSource][tablename][value] or _G[dataSource][tablename][tablenum][value]) and tablename ~= "SearchMENU" then
            local row = subtableFrame.rows[i]
                row.dataSource = dataSource;
                row.tablename = tablename;
                row.tablenum = value;
            if dataSource == "AtlasLoot_MapData" then
                local text = _G[dataSource][tablename][tablenum][value][1]
                if _G[dataSource][tablename][tablenum][value][2] then text = text.._G[dataSource][tablename][tablenum][value][2] end
                if _G[dataSource][tablename][tablenum][value].SubZone then
                    text = BLUE..text
                elseif not _G[dataSource][tablename][tablenum][value].Zone then
                    text = WHITE..text
                end
                if not _G[dataSource][tablename][tablenum][value].cords and not _G[dataSource][tablename][tablenum][value].Zone and not _G[dataSource][tablename][tablenum][value].SubZone then text = INDENT..text end
                row.Text:SetText(text);
                row:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_TOP");
                    GameTooltip:SetText(_G[dataSource][tablename][tablenum][value][1]);
                    GameTooltip:Show();
                end)
                row:SetScript("OnLeave", function() GameTooltip:Hide() end)
            else
                row.Text:SetText("|cffFFd200".._G[dataSource][tablename][value].Name);
                row:SetScript("OnEnter", function(self)
                    GameTooltip:Hide();
                end)
                if tablenum == value and dataSource ~= "AtlasLoot_MapData" then
                    row:SetChecked(true);
                end
            end
            row:Show();
        else
            subtableFrame.rows[i]:Hide();
        end
    end
end

local scrollSlider2 = CreateFrame("ScrollFrame","AtlasLootDefaultFrameSubTableScroll",Atlasloot_SubTableFrame,"FauxScrollFrameTemplate");
    scrollSlider2:SetPoint("TOPLEFT", 0, -8)
    scrollSlider2:SetPoint("BOTTOMRIGHT", -30, 8)
    scrollSlider2:SetScript("OnVerticalScroll", function(self, offset)
        self.offset = math.floor(offset / ROW_HEIGHT + 0.5)
            AtlasLoot:SubTableScrollFrameUpdate(subtableFrame.tablename, subtableFrame.dataSource, subtableFrame.tablenum);
    end)

    subtableFrame.scrollBar = scrollSlider2

local rows2 = setmetatable({}, { __index = function(t, i)
    local row = CreateFrame("CheckButton", "$parentRow"..i, Atlasloot_SubTableFrame)
    row:SetSize(230, ROW_HEIGHT);
    row:SetFrameStrata("HIGH");
    row:SetNormalFontObject(GameFontHighlightLeft);
    row:SetCheckedTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
    row.Text = row:CreateFontString("$parentRow"..i.."Text","OVERLAY","GameFontNormal");
    row.Text:SetSize(230, ROW_HEIGHT);
    row.Text:SetPoint("LEFT",row);
    row.Text:SetJustifyH("LEFT");
    row:SetScript("OnClick", function()
        if row.dataSource ~= "AtlasLoot_MapData" then
            AtlasLoot:ShowItemsFrame(row.tablename, row.dataSource, row.tablenum);
        else
            row:SetChecked(false);
        end
    end)
    if i == 1 then
        row:SetPoint("TOPLEFT", subtableFrame, 8, -8)
    else
        row:SetPoint("TOPLEFT", subtableFrame.rows[i-1], "BOTTOMLEFT")
    end

    rawset(t, i, row)
    return row
end })

subtableFrame.rows = rows2

--------------------------------- Map Frame and buttons -----------------------------------------------

    --AtlasLoot Maps
    local mapFrame = CreateFrame("Frame", "AtlasLootDefaultFrame_Map", AtlasLootDefaultFrame);
        mapFrame:SetSize(770,513);
        mapFrame:SetPoint("BOTTOMLEFT", AtlasLootDefaultFrame,"BOTTOMLEFT",40,90);
        mapFrame:SetFrameStrata("HIGH");
        mapFrame:Hide();
        mapFrame:EnableMouse();
        mapFrame:SetScript("OnMouseDown", function(self, button)
            if button == "RightButton" then
                AtlasLoot:MapOnShow();
            end
        end);
        mapFrame:EnableMouseWheel(true);
        mapFrame.cursorCords = mapFrame:CreateFontString(nil,"ARTWORK","GameFontNormal")
        mapFrame.cursorCords:SetPoint("TOPRIGHT", mapFrame, -10, 0)
        mapFrame.cursorCords:Show()
        mapFrame.cursorCords:SetSize(100, 25)
        mapFrame:SetScript("OnMouseWheel", function(self,delta)
            if AtlasLootItemsFrame_NEXT:IsVisible() and delta == -1 then
                AtlasLootItemsFrame_NEXT:Click();
            end
            if AtlasLootItemsFrame_PREV:IsVisible() and delta == 1 then
                AtlasLootItemsFrame_PREV:Click();
            end
        end);
    local lastCord1, lastCord2 = 0,0
        mapFrame:SetScript("OnShow", function() mapFrame.cursorCords:SetText(WHITE.."Cursor: ---") end)
        mapFrame:SetScript("OnUpdate", function(self)
            if AtlasLoot.showCords then
                local scale,x, y = mapFrame:GetEffectiveScale(), GetCursorPosition()
                local width, height = mapFrame:GetWidth()/100, mapFrame:GetHeight()/100
                x, y = math.ceil(((x/scale) - mapFrame:GetLeft())/width), math.ceil((((y/scale) - mapFrame:GetTop())/height) * -1)
                if lastCord1 ~= x and lastCord2 ~= y then 
                    mapFrame.cursorCords:SetText(WHITE.."Cursor: "..x.." , "..y)
                    lastCord1 = x
                    lastCord2 = y
                end
            end
        end)
        mapFrame:SetScript("OnEnter", function() AtlasLoot.showCords = true end)
        mapFrame:SetScript("OnLeave", function()
            AtlasLoot.showCords = false
            mapFrame.cursorCords:SetText(WHITE.."Cursor: ---")
        end)

    for i=1, 12 do
        mapFrame.tile = mapFrame:CreateTexture("AtlasLoot_MapDetailTile"..i, "BACKGROUND");
        mapFrame.tile:SetSize(196,196)
        mapFrame.tile:Show()
    end

    AtlasLoot_MapDetailTile1:SetPoint("TOPLEFT", mapFrame)
    AtlasLoot_MapDetailTile2:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile1,"TOPRIGHT")
    AtlasLoot_MapDetailTile3:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile2,"TOPRIGHT")
    AtlasLoot_MapDetailTile4:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile3,"TOPRIGHT")
    AtlasLoot_MapDetailTile5:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile1,"BOTTOMLEFT")
    AtlasLoot_MapDetailTile6:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile5,"TOPRIGHT")
    AtlasLoot_MapDetailTile7:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile6,"TOPRIGHT")
    AtlasLoot_MapDetailTile8:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile7,"TOPRIGHT")
    AtlasLoot_MapDetailTile9:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile5,"BOTTOMLEFT")
    AtlasLoot_MapDetailTile10:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile9,"TOPRIGHT")
    AtlasLoot_MapDetailTile11:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile10,"TOPRIGHT")
    AtlasLoot_MapDetailTile12:SetPoint("TOPLEFT", AtlasLoot_MapDetailTile11,"TOPRIGHT")

        mapFrame.playerPin = CreateFrame("Button", "AtlasLoot_PlayerMapPin", AtlasLootDefaultFrame_Map)
        mapFrame.playerPin:SetSize(35,35)
        mapFrame.playerPin:SetFrameStrata("HIGH")
        mapFrame.playerPin.texture = mapFrame.playerPin:CreateTexture(nil, "ARTWORK");
        mapFrame.playerPin.texture:SetTexture("Interface\\Minimap\\MinimapArrow");
        mapFrame.playerPin.texture:SetSize(35,35);
        mapFrame.playerPin.texture:SetPoint("CENTER",0,0);
        mapFrame.playerPin:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
            GameTooltip:AddLine("You are here")
            GameTooltip:Show()
        end)
        mapFrame.playerPin:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        mapFrame.playerPin:Hide()

        -- Map Button
        mainframe.mapButton = CreateFrame("Button","AtlasLootDefaultFrame_MapButton", AtlasLootDefaultFrame,"OptionsButtonTemplate");
        mainframe.mapButton:SetSize(90,24);
        mainframe.mapButton:SetPoint("BOTTOMLEFT",Atlasloot_SubTableFrame,0,-27.5);
        mainframe.mapButton:SetText("Map");
        mainframe.mapButton:SetScript("OnClick", function() AtlasLoot:MapOnShow(); end)

        -- Map Select Button
        mainframe.mapSelbutton = CreateFrame("Button","AtlasLootDefaultFrame_MapSelectButton", AtlasLootDefaultFrame,"OptionsButtonTemplate");
        mainframe.mapSelbutton:SetSize(180,24);
        mainframe.mapSelbutton:SetPoint("BOTTOMRIGHT",Atlasloot_SubTableFrame,5,-27.5);
        mainframe.mapSelbutton:SetScript("OnClick", function(self) AtlasLoot:MapMenuOpen(self) end);
        mainframe.mapSelbutton:SetText("No Map");

        -- Load Current Instance Button
        mainframe.currentInstance = CreateFrame("Button","AtlasLootDefaultFrame_LoadInstanceButton", AtlasLootDefaultFrame,"OptionsButtonTemplate");
        mainframe.currentInstance:SetSize(135,24);
        mainframe.currentInstance:SetPoint("BOTTOMRIGHT",Atlasloot_SubTableFrame,-133,-58);
        mainframe.currentInstance:SetScript("OnClick", function() AtlasLoot:ShowInstance(); end)
        mainframe.currentInstance:SetText("Current Instance");

        -- Load Current Map in ascension db
        mainframe.openDB = CreateFrame("Button","AtlasLootDefaultFrame_LoadInstanceDBButton", AtlasLootDefaultFrame,"OptionsButtonTemplate");
        mainframe.openDB:SetSize(135,24);
        mainframe.openDB:SetPoint("RIGHT",AtlasLootDefaultFrame_LoadInstanceButton,135,0);
        mainframe.openDB:SetScript("OnClick", function() AtlasLoot:OpenDBURL(AtlasLoot_MapData[AtlasLoot.CurrentMap].ZoneName[2] , "zone") end)
        mainframe.openDB:SetText("Open In DB");


        


local streamIcon = CreateFrame("Frame", "AtlasLoot_ItemsLoading", AtlaslLoot_LootBackground);
    streamIcon:SetPoint("TOPRIGHT", AtlaslLoot_LootBackground, "TOPRIGHT");
    streamIcon:SetSize(48, 48);
    streamIcon.tooltip = "Searching...";
    streamIcon:EnableMouse(true);

    streamIcon.icon = streamIcon:CreateTexture("$parentSpinner", "BACKGROUND");
    streamIcon.icon:SetTexture("Interface\\Addons\\AtlasLoot\\Images\\streamcircle");
    streamIcon.icon:SetVertexColor(0,1,0);
    streamIcon.icon:SetAllPoints();
    streamIcon.spark = streamIcon:CreateTexture("OVERLAY");
    streamIcon.spark:SetTexture("Interface\\Addons\\AtlasLoot\\Images\\streamspark");
    streamIcon.spark:SetAllPoints();

    streamIcon.frame = CreateFrame("Frame", "$parentFrame", AtlasLoot_ItemsLoading);
    streamIcon.frame:SetAllPoints();
    streamIcon.frame.bg = streamIcon.frame:CreateTexture("$parentBackground", "BACKGROUND");
    streamIcon.frame.bg:SetTexture("Interface\\Addons\\AtlasLoot\\Images\\streambackground");
    streamIcon.frame.bg:SetVertexColor(0,1,0);
    streamIcon.frame.bg:SetAllPoints();
    streamIcon.frame.alpha = streamIcon.frame:CreateTexture("$parentAlpha", "ARTWORK");
    streamIcon.frame.alpha:SetTexture("Interface\\Addons\\AtlasLoot\\Images\\streamframe");
    streamIcon.frame.alpha:SetAllPoints();

    streamIcon.Loop = streamIcon:CreateAnimationGroup("$parentLoopAnim");
    streamIcon.Loop:SetLooping("REPEAT");
local rotAnim = streamIcon.Loop:CreateAnimation("ROTATION");
    rotAnim:SetOrder(1);
    rotAnim:SetDuration(8);
    rotAnim:SetDegrees(-360);

    streamIcon:SetScript("OnEnter",
        function(self) 
            if(self.tooltip ~= nil) then
                GameTooltip:SetOwner(self, "ANCHOR_LEFT");
                GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true);
            end
        end);
    streamIcon:SetScript("OnLeave", GameTooltip_Hide);
    streamIcon:SetScript("OnShow", function(self) self:SetFrameLevel( (self:GetParent()):GetFrameLevel() + 1 ) end);

    streamIcon:SetPoint("TOPRIGHT", AtlaslLoot_LootBackground, "TOPRIGHT");
    streamIcon:Hide();