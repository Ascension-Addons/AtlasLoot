local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot")

function AtlasLoot:InitializeSkins()
    self.CloseDefaults = {}
    local DF = self.CloseDefaults
    DF[1], DF[2], DF[3], DF[4], DF[5] = _G["AtlasLootDefaultFrameCloseButton"]:GetPoint()

    self.TitleDefaults = {}
    local TDF = self.TitleDefaults
    TDF[1], TDF[2], TDF[3], TDF[4], TDF[5] = self.mainUI.TitleText:GetPoint()

    local buttons = {
        "AtlasLootDefaultFrame_Menu",
        "AtlasLootDefaultFrame_SubMenu",
        "AtlasLootDefaultFrame_ExpansionMenu",
        "AtlasLootDefaultFrame_Preset1",
        "AtlasLootDefaultFrame_Preset2",
        "AtlasLootDefaultFrame_Preset3",
        "AtlasLootDefaultFrame_Preset4",
        "AtlasLootDefaultFrameSearchButton",
        "AtlasLootDefaultFrameLastResultButton",
        "AtlasLootDefaultFrameWishListButton",
        "AtlasLootDefaultFrameAdvancedSearchButton",
        "AtlasLootDefaultFrame_AdvancedSearchPanel_EquipButton",
        "AtlasLootDefaultFrame_AdvancedSearchPanel_EquipSubButton",
        "AtlasLootDefaultFrame_AdvancedSearchPanel_CategoryButton",
        "AtlasLootDefaultFrame_AdvancedSearchPanel_SearchButton",
        "AtlasLootDefaultFrame_AdvancedSearchPanel_ClearButton",
        "AtlasLootDefaultFrame_MapButton",
        "AtlasLootDefaultFrame_LoadInstanceButton",
        "AtlasLoot_Favorites",
    }

    self.skinKeys = {
        {"Modern", AL["Modern"]},
        {"OldAtlasLoot", AL["Old AtlasLoot"]},
        {"ElvUIDark", AL["ElvUI Dark"]},
    }

    local skins = {
        Modern = {
            DefaultFrame = {
                bg = "Interface\\DialogFrame\\UI-DialogBox-Background",
                bgColor = {2,2,2,2},
                edge = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeColor = {1,1,1,1},
                tile = true,
            },
            Backdrop = {
                bg = "Interface\\DialogFrame\\UI-DialogBox-Background",
                bgColor = {2,2,2,2},
                edge = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeColor = {1,1,1,1},
                tile = true,
            },
            btTex = "Interface\\Buttons\\UI-Silver-Button-Up",
            insets = {1,1,1,1},
            showFrame = true,
            searchP = {0,-0.5},
            searchH = 24,
            edgeSize = 16,
            closebtn = {0,0},
            title = {0,0},
        },

        OldAtlasLoot = {
            DefaultFrame = {
                bg = "Interface/AchievementFrame/UI-Achievement-AchievementBackground",
                bgColor = {1, 1, 1, 0.5},
                edge = "Interface/Tooltips/UI-Tooltip-Border",
                edgeColor = {1, 0.675, 0.125, 1},
                tile = false,
            },
            Backdrop = {
                bg = "Interface/AchievementFrame/UI-Achievement-StatsBackground",
                bgColor = {0, 0, 0, .7},
                edge = nil,
                edgeColor = {nil,nil,nil,nil},
                tile = false,
            },
            btTex = "Interface/AchievementFrame/UI-Achievement-Category-Background",
            insets = {4,4,4,4},
            showFrame = false,
            searchP = {2,0},
            searchH = 23,
            edgeSize = 8,
            closebtn = {-5,-5},
            title = {0,-5},
        },

        ElvUIDark = {
            DefaultFrame = {
                bg = "Interface\\DialogFrame\\UI-DialogBox-Background",
                bgColor = {2,2,2,2},
                edge = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeColor = {0,0,0,5},
                tile = true,
            },
            Backdrop = {
                bg = "Interface\\DialogFrame\\UI-DialogBox-Background",
                bgColor = {2,2,2,2},
                edge = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeColor = {0,0,0,5},
                tile = true,
            },
            btTex = {0,0,0,.6},
            insets = {1,1,1,1},
            showFrame = false,
            searchP = {2,0},
            searchH = 25,
            edgeSize = 8,
            closebtn = {-5,-5},
            title = {0,0},
        },
    }

    local backDropFrames = {
        "AtlasLoot_FavoritesPopupFrame",
        "AtlasLoot_LootBackground",
        "Atlasloot_Difficulty_ScrollFrame",
        "Atlasloot_SubTableFrame",
        "AtlasLoot_PopupFrame",
    }

    --[[
    AtlasLoot:SetSkin()
    Changes the skin
    ]]
    function AtlasLoot:SetSkin(skin)
        skin = skins[skin]
            for _, frame in pairs(backDropFrames) do
                _G[frame]:SetBackdrop({
                    bgFile = skin.Backdrop.bg, tile = skin.Backdrop.tile, tileSize = 16,
                    edgeFile = skin.Backdrop.edge, edgeSize = skin.edgeSize,
                    insets = { left = skin.insets[1], right = skin.insets[2], top = skin.insets[3], bottom = skin.insets[4] },
                })
                _G[frame]:SetBackdropColor(skin.Backdrop.bgColor[1], skin.Backdrop.bgColor[2], skin.Backdrop.bgColor[3], skin.Backdrop.bgColor[4])
                _G[frame]:SetBackdropBorderColor(skin.Backdrop.edgeColor[1], skin.Backdrop.edgeColor[2], skin.Backdrop.edgeColor[3], skin.Backdrop.edgeColor[4])
            end

            local DF = self.CloseDefaults
            _G["AtlasLootDefaultFrameCloseButton"]:SetPoint(DF[1], DF[2], DF[3], DF[4]+skin.closebtn[1], DF[5]+skin.closebtn[2])

            local TDF = self.TitleDefaults
            self.mainUI.TitleText:SetPoint(TDF[1], TDF[2], TDF[3], TDF[4]+skin.title[1], TDF[5]+skin.title[2])

            if type(skin.btTex) == "table" then
                local color = skin.btTex
                self.mainUI.searchbox.Left:SetTexture(color[1],color[2],color[3],color[4])
                self.mainUI.searchbox.Right:SetTexture(color[1],color[2],color[3],color[4])
                self.mainUI.searchbox.Middle:SetTexture(color[1],color[2],color[3],color[4])
            else
                self.mainUI.searchbox.Left:SetTexture("")
                self.mainUI.searchbox.Right:SetTexture("")
                self.mainUI.searchbox.Middle:SetTexture("")
                self.mainUI.searchbox.Left:SetAtlas("common-search-border-left")
                self.mainUI.searchbox.Right:SetAtlas("common-search-border-right")
                self.mainUI.searchbox.Middle:SetAtlas("common-search-border-middle")
            end

            self.mainUI.searchbox.Left:SetHeight(skin.searchH)
            self.mainUI.searchbox.Right:SetHeight(skin.searchH)
            self.mainUI.searchbox.Middle:SetHeight(skin.searchH)
            self.mainUI.searchButton:ClearAllPoints()
            self.mainUI.searchButton:SetPoint("LEFT",self.mainUI.searchbox,"RIGHT",skin.searchP[1],skin.searchP[2])

            local frame = {"RightEdge","LeftEdge","BottomEdge","TopEdge","BottomRightCorner","BottomLeftCorner","TopRightCorner","TopLeftCorner"}
            if skin.showFrame then
                for _, frame in ipairs(frame) do
                    _G["AtlasLootDefaultFrameNineSlice"][frame]:Show()
                end
                _G["AtlasLootDefaultFramePortrait"]:Show()
                _G["AtlasLootDefaultFrameBg"]:Show()
                self.mainUI.TitleBg:Show()
                _G["AtlasLootDefaultFrameTopTileStreaks"]:Show()
                self.mainUI:SetBackdrop(nil)
            else
                for _, frame in ipairs(frame) do
                    _G["AtlasLootDefaultFrameNineSlice"][frame]:Hide()
                end
                _G["AtlasLootDefaultFramePortrait"]:Hide()
                _G["AtlasLootDefaultFrameBg"]:Hide()
                self.mainUI.TitleBg:Hide()
                _G["AtlasLootDefaultFrameTopTileStreaks"]:Hide()
                self.mainUI:SetBackdrop({
                    bgFile = skin.DefaultFrame.bg, tile = skin.DefaultFrame.tile, tileSize = 16,
                    edgeFile = skin.DefaultFrame.edge, edgeSize = skin.edgeSize,
                    insets = { left = skin.insets[1], right = skin.insets[2], top = skin.insets[3], bottom = skin.insets[4] },
                })
                self.mainUI:SetBackdropColor(skin.DefaultFrame.bgColor[1], skin.DefaultFrame.bgColor[2], skin.DefaultFrame.bgColor[3], skin.DefaultFrame.bgColor[4])
                self.mainUI:SetBackdropBorderColor(skin.DefaultFrame.edgeColor[1], skin.DefaultFrame.edgeColor[2], skin.DefaultFrame.edgeColor[3], skin.DefaultFrame.edgeColor[4])
            end

            local function SetButtons(path)
                if _G[path].template and _G[path].template == "AtlasLootDropMenuTemplate" then
                    local tex, tex2, tex3, tex4
                    if type(skin.btTex) == "table" then
                        tex, tex2, tex3, tex4 = unpack(skin.btTex)
                    else
                        tex = skin.btTex
                    end
                    _G[path.."TopLeft"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."TopRight"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."BottomLeft"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."BottomRight"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."TopMiddle"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."MiddleLeft"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."MiddleRight"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."BottomMiddle"]:SetTexture(tex, tex2, tex3, tex4)
                    _G[path.."MiddleMiddle"]:SetTexture(tex, tex2, tex3, tex4)
                end
            end

            for _, v in pairs(buttons) do
                SetButtons(v)
            end
    end

    --Set visual style for the loot browser
	if self.selectedProfile.LootBrowserStyle then
		self:SetSkin(self.skinKeys[self.selectedProfile.LootBrowserStyle][1])
	end
end
