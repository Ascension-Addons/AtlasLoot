local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")
local BabbleZone = AtlasLoot_GetLocaleLibBabble("LibBabble-Zone-3.0")
local WHITE = "|cffFFFFFF";

local ALCHEMY = GetSpellInfo(2259);
local BLACKSMITHING = GetSpellInfo(2018);
local ARMORSMITH = GetSpellInfo(9788);
local WEAPONSMITH = GetSpellInfo(9787);
local AXESMITH = GetSpellInfo(17041);
local HAMMERSMITH = GetSpellInfo(17040);
local SWORDSMITH = GetSpellInfo(17039);
local COOKING = GetSpellInfo(2550);
local ENCHANTING = GetSpellInfo(7411);
local ENGINEERING = GetSpellInfo(4036);
local GNOMISH = GetSpellInfo(20220);
local GOBLIN = GetSpellInfo(20221);
local FIRSTAID = GetSpellInfo(3273);
local FISHING = GetSpellInfo(63275);
local INSCRIPTION = GetSpellInfo(45357);
local JEWELCRAFTING = GetSpellInfo(25229);
local LEATHERWORKING = GetSpellInfo(2108);
local DRAGONSCALE = GetSpellInfo(10656);
local ELEMENTAL = GetSpellInfo(10658);
local TRIBAL = GetSpellInfo(10660);
local MINING = GetSpellInfo(2575);
local TAILORING = GetSpellInfo(3908);
local MOONCLOTH = GetSpellInfo(26798);
local SHADOWEAVE = GetSpellInfo(26801);
local SPELLFIRE = GetSpellInfo(26797);


local APPRENTICE = select(2, GetSpellInfo(2259));
local JOURNEYMAN = select(2, GetSpellInfo(3101));
local EXPERT = select(2, GetSpellInfo(3464));
local ARTISAN = select(2, GetSpellInfo(11611));
local MASTER = select(2, GetSpellInfo(28596));

-- Index
--- Tradeskill List
---- Alchemy
----- Battle Elixirs
----- Guardian Elixirs
----- Potions
----- Flasks
----- Transmutes
----- Miscellaneous
---- Blacksmithing
----- Armor
----- Weapons
----- Enhancements
----- Miscellaneous
----- Armorsmith
----- Weaponsmith
----- Axesmith
----- Hammersmith
----- Swordsmith
---- Cooking
---- Enchanting
----- Boots
----- Bracers
----- Chest
----- Cloaks
----- Gloves
----- Rings
----- Shields
----- 2 Hand Weapons
----- 1 Hand Weapons
----- Staves
----- Miscellaneous
---- Engineering
---- First Aid
---- Inscription
---- Jewelcrafting
---- Leatherworking
---- Mining
---- Tailoring
--- Profession Sets
---- Blacksmithing Mail Sets
---- Blacksmithing Plate Sets
---- Leatherworking Leather Sets
---- Leatherworking Mail Sets
---- Tailoring Sets
--- Other
---- Crafted Epic Weapons

-----------------------
--- Tradeskill List ---
-----------------------

---------------
--- Alchemy ---
---------------

AtlasLoot_Data["AlchemyWRATH"] = {
	Name = ALCHEMY;
	Type = "Crafting";
	{
		Name = AL["Battle Elixirs"];
		[1] = {itemID = 44330, spellID = 60365 }; --Elixir of Armor Piercing
		[2] = {itemID = 44327, spellID = 60355 }; --Elixir of Deadly Strikes
		[3] = {itemID = 44329, spellID = 60357 }; --Elixir of Expertise
		[4] = {itemID = 44331, spellID = 60366 }; --Elixir of Lightning Speed
		[5] = {itemID = 44325, spellID = 60354 }; --Elixir of Accuracy
		[6] = {itemID = 39666, spellID = 53840 }; --Elixir of Mighty Agility
		[7] = {itemID = 40073, spellID = 54218 }; --Elixir of Mighty Strength
		[8] = {itemID = 40076, spellID = 53848 }; --Guru's Elixir
		[9] = {itemID = 40070, spellID = 53842 }; --Spellpower Elixir
		[10] = {itemID = 40068, spellID = 53841 }; --WRATH Elixir
	};
	{
		Name = AL["Guardian Elixirs"];
		[1] = {itemID = 44328, spellID = 60356 }; --Elixir of Mighty Defense
		[2] = {itemID = 40109, spellID = 56519 }; --Elixir of Mighty Mageblood
		[3] = {itemID = 40097, spellID = 54220 }; --Elixir of Protection
		[4] = {itemID = 8827, spellID = 62410 }; --Elixir of Water Walking
		[5] = {itemID = 40078, spellID = 53898 }; --Elixir of Mighty Fortitude
		[6] = {itemID = 44332, spellID = 60367 }; --Elixir of Mighty Thoughts
		[7] = {itemID = 40072, spellID = 53847 }; --Elixir of Spirit
	};
	{
		Name = AL["Potions"];
		[1] = {itemID = 40211, spellID = 54221 }; --Potion of Speed
		[2] = {itemID = 40212, spellID = 54222 }; --Potion of Wild Magic
		[3] = {itemID = 40087, spellID = 53904 }; --Powerful Rejuvenation Potion
		[4] = {itemID = 43570, spellID = 58868 }; --Endless Mana Potion
		[5] = {itemID = 33448, spellID = 53837 }; --Runic Mana Potion
		[6] = {itemID = 43569, spellID = 58871 }; --Endless Healing Potion
		[7] = {itemID = 33447, spellID = 53836 }; --Runic Healing Potion
		[8] = {itemID = 40213, spellID = 53936 }; --Mighty Arcane Protection Potion
		[9] = {itemID = 40214, spellID = 53939 }; --Mighty Fire Protection Potion
		[10] = {itemID = 40215, spellID = 53937 }; --Mighty Frost Protection Potion
		[11] = {itemID = 40216, spellID = 53942 }; --Mighty Nature Protection Potion
		[12] = {itemID = 40217, spellID = 53938 }; --Mighty Shadow Protection Potion
		[13] = {itemID = 40093, spellID = 53905 }; --Indestructible Potion
		[14] = {itemID = 40081, spellID = 53900 }; --Potion of Nightmares
		[15] = {itemID = 40077, spellID = 53895 }; --Crazy Alchemist's Potion
		[16] = {itemID = 40067, spellID = 53839 }; --Icy Mana Potion
		[17] = {itemID = 39671, spellID = 53838 }; --Resurgent Healing Potion
	};
	{
		Name = AL["Flasks"];
		[1] = {itemID = 47499, spellID = 67025 }; --Flask of the North
		[2] = {itemID = 46377, spellID = 53903 }; --Flask of Endless Rage
		[3] = {itemID = 46378, spellID = 54213 }; --Flask of Pure Mojo
		[4] = {itemID = 46379, spellID = 53902 }; --Flask of Stoneblood
		[5] = {itemID = 46376, spellID = 53901 }; --Flask of the Frost Wyrm
		[6] = {itemID = 44939, spellID = 62213 }; --Lesser Flask of Resistance
		[7] = {itemID = 40079, spellID = 53899 }; --Lesser Flask of Toughness
	};
	{
		Name = AL["Transmutes"];
		[1] = {itemID = 35624, spellID = 53777 }; --Transmute: Eternal Air to Earth
		[2] = {itemID = 35622, spellID = 53776 }; --Transmute: Eternal Air to Water
		[3] = {itemID = 35623, spellID = 53781 }; --Transmute: Eternal Earth to Air
		[4] = {itemID = 35627, spellID = 53782 }; --Transmute: Eternal Earth to Shadow
		[5] = {itemID = 35625, spellID = 53775 }; --Transmute: Eternal Fire to Life
		[6] = {itemID = 35622, spellID = 53774 }; --Transmute: Eternal Fire to Water
		[7] = {itemID = 36860, spellID = 53773 }; --Transmute: Eternal Life to Fire
		[8] = {itemID = 35627, spellID = 53771 }; --Transmute: Eternal Life to Shadow
		[9] = {itemID = 35624, spellID = 53779 }; --Transmute: Eternal Shadow to Earth
		[10] = {itemID = 35625, spellID = 53780 }; --Transmute: Eternal Shadow to Life
		[11] = {itemID = 35623, spellID = 53783 }; --Transmute: Eternal Water to Air
		[12] = {itemID = 36860, spellID = 53784 }; --Transmute: Eternal Water to Fire
		[13] = {itemID = 41163, spellID = 60350 }; --Transmute: Titanium
		[16] = {itemID = 36919, spellID = 66659 }; --Transmute: Cardinal Ruby
		[17] = {itemID = 36931, spellID = 66658 }; --Transmute: Ametrine
		[18] = {itemID = 36928, spellID = 66662 }; --Transmute: Dreadstone
		[19] = {itemID = 36934, spellID = 66664 }; --Transmute: Eye of Zul
		[20] = {itemID = 36922, spellID = 66660 }; --Transmute: King's Amber
		[21] = {itemID = 36925, spellID = 66663 }; --Transmute: Majestic Zircon
		[22] = {itemID = 40248, spellID = 54020 }; --Transmute: Eternal Might
		[23] = {itemID = 41334, spellID = 57427 }; --Transmute: Earthsiege Diamond
		[24] = {itemID = 41266, spellID = 57425 }; --Transmute: Skyflare Diamond
	};
	{
		Name = AL["Miscellaneous"];
		[1] = {itemID = 35751, spellID = 47050 }; --Assassin's Alchemist Stone
		[2] = {itemID = 35748, spellID = 47046 }; --Guardian's Alchemist Stone
		[3] = {itemID = 35750, spellID = 47049 }; --Redeemer's Alchemist Stone
		[4] = {itemID = 35749, spellID = 47048 }; --Sorcerer's Alchemist Stone
		[5] = {itemID = 13503, spellID = 17632 }; --Alchemist's Stone
		[6] = {itemID = 44323, spellID = 60403 }; --Indestructible Alchemist Stone
		[7] = {itemID = 44322, spellID = 60396 }; --Mercurial Alchemist Stone
		[8] = {itemID = 44324, spellID = 60405 }; --Mighty Alchemist Stone
		[10] = {itemID = 31080, spellID = 38070 }; --Mercurial Stone
		[11] = {itemID = 44958, spellID = 62409 }; --Ethereal Oil
		[12] = {itemID = 40195, spellID = 53812 }; --Pygmy Oil
	};
};

---------------------
--- Blacksmithing ---
---------------------

AtlasLoot_Data["SmithingWRATH"] = {
	Name = BLACKSMITHING;
	Type = "Crafting";
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Chest";
		[1] = { spellID = 67130, itemID = 47592 };
		[2] = { spellID = 67091, itemID = 47591 };
		[3] = { spellID = 67095, itemID = 47593 };
		[4] = { spellID = 67134, itemID = 47594 };
		[5] = { spellID = 67093, itemID = 47589 };
		[6] = { spellID = 67132, itemID = 47590 };
		[7] = {itemID = 43586, spellID = 61008 }; --Icebane Chestguard
		[8] = {itemID = 42725, spellID = 56555 }; --Ornate Saronite Hauberk
		[9] = {itemID = 41353, spellID = 55311 }; --Savage Saronite Hauberk
		[10] = {itemID = 41129, spellID = 55058 }; --Brilliant Saronite Breastplate
		[11] = {itemID = 40672, spellID = 54553 }; --Tempered Saronite Breastplate
		[12] = {itemID = 40951, spellID = 54944 }; --Spiked Cobalt Chestpiece
		[13] = {itemID = 40959, spellID = 54981 }; --Reinforced Cobalt Chestpiece
		[14] = {itemID = 39085, spellID = 52570 }; --Cobalt Chestpiece
	};
	{ Name = BabbleInventory["Armor"] .. WHITE .. " - Feet";
		[1] = {itemID = 49907, spellID = 70568 }; --Boots of Kingly Upheaval
		[2] = {itemID = 49906, spellID = 70566 }; --Hellfrozen Bonegrinders
		[3] = {itemID = 45559, spellID = 63188 }; --Battlelord's Plate Boots
		[4] = {itemID = 45560, spellID = 63192 }; --Spiked Deathdealers
		[5] = {itemID = 45561, spellID = 63190 }; --Treads of Destiny
		[6] = {itemID = 41394, spellID = 55377 }; --Brilliant Titansteel Treads
		[7] = {itemID = 41391, spellID = 55375 }; --Spiked Titansteel Treads
		[8] = {itemID = 41392, spellID = 55376 }; --Tempered Titansteel Treads
		[9] = {itemID = 43588, spellID = 61010 }; --Icebane Treads
		[10] = {itemID = 42730, spellID = 56552 }; --Ornate Saronite Walkers
		[11] = {itemID = 41348, spellID = 55308 }; --Savage Saronite Walkers
		[12] = {itemID = 41128, spellID = 55057 }; --Brilliant Saronite Boots
		[13] = {itemID = 40671, spellID = 54552 }; --Tempered Saronite Boots
		[14] = {itemID = 40949, spellID = 54918 }; --Spiked Cobalt Boots
		[15] = {itemID = 39088, spellID = 52569 }; --Cobalt Boots
		[16] = {itemID = 49905, spellID = 70563 }; --Protectors of Life
	};
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Hands";
		[1] = {itemID = 41357, spellID = 55301 }; --Daunting Handguards
		[2] = {itemID = 42724, spellID = 56553 }; --Ornate Saronite Gauntlets
		[3] = {itemID = 41356, spellID = 55300 }; --Righteous Gauntlets
		[4] = {itemID = 41349, spellID = 55309 }; --Savage Saronite Gauntlets
		[5] = {itemID = 41114, spellID = 55015 }; --Tempered Saronite Gauntlets
		[6] = {itemID = 41127, spellID = 55056 }; --Brilliant Saronite Gauntlets
		[7] = {itemID = 40952, spellID = 54945 }; --Spiked Cobalt Gauntlets
		[8] = {itemID = 41975, spellID = 55835 }; --Cobalt Gauntlets
	};
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Head";
		[1] = {itemID = 41388, spellID = 55374 }; --Brilliant Titansteel Helm
		[2] = {itemID = 41386, spellID = 55372 }; --Spiked Titansteel Helm
		[3] = {itemID = 41387, spellID = 55373 }; --Tempered Titansteel Helm
		[4] = {itemID = 41344, spellID = 55302 }; --Helm of Command
		[5] = {itemID = 42728, spellID = 56556 }; --Ornate Saronite Skullshield
		[6] = {itemID = 41350, spellID = 55312 }; --Savage Saronite Skullshield
		[7] = {itemID = 43870, spellID = 59441 }; --Brilliant Saronite Helm
		[8] = {itemID = 40673, spellID = 54555 }; --Tempered Saronite Helm
		[9] = {itemID = 40955, spellID = 54949 }; --Horned Cobalt Helm
		[10] = {itemID = 40957, spellID = 54979 }; --Reinforced Cobalt Helm
		[11] = {itemID = 40942, spellID = 54917 }; --Spiked Cobalt Helm
		[12] = {itemID = 39084, spellID = 52571 }; --Cobalt Helm
	};
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Legs";
		[1] = {itemID = 49903, spellID = 70565 }; --Legplates of Painful Death
		[2] = {itemID = 49904, spellID = 70567 }; --Pillars of Might
		[3] = {itemID = 49902, spellID = 70562 }; --Puresteel Legplates
		[4] = {itemID = 41345, spellID = 55303 }; --Daunting Legplates
		[5] = {itemID = 42726, spellID = 56554 }; --Ornate Saronite Legplates
		[6] = {itemID = 41346, spellID = 55304 }; --Righteous Greaves
		[7] = {itemID = 41347, spellID = 55310 }; --Savage Saronite Legplates
		[8] = {itemID = 41190, spellID = 55187 }; --Legplates of Conquest
		[9] = {itemID = 41126, spellID = 55055 }; --Brilliant Saronite Legplates
		[10] = {itemID = 40674, spellID = 54554 }; --Tempered Saronite Legplates
		[11] = {itemID = 40943, spellID = 54947 }; --Spiked Cobalt Legplates
		[12] = {itemID = 40958, spellID = 54980 }; --Reinforced Cobalt Legplates
		[13] = {itemID = 39086, spellID = 52567 }; --Cobalt Legplates
	};
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Shoulder";
		[1] = {itemID = 42727, spellID = 56550 }; --Ornate Saronite Pauldrons
		[2] = {itemID = 41351, spellID = 55306 }; --Savage Saronite Pauldrons
		[3] = {itemID = 43865, spellID = 59440 }; --Brilliant Saronite Pauldrons
		[4] = {itemID = 40675, spellID = 54556 }; --Tempered Saronite Shoulders
		[5] = {itemID = 40950, spellID = 54941 }; --Spiked Cobalt Shoulders
		[6] = {itemID = 40956, spellID = 54978 }; --Reinforced Cobalt Shoulders
		[7] = {itemID = 39083, spellID = 52572 }; --Cobalt Shoulders
	};
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Waist";
		[1] = {itemID = 45550, spellID = 63187 }; --Belt of the Titans
		[2] = {itemID = 45551, spellID = 63191 }; --Indestructible Plate Girdle
		[3] = {itemID = 45552, spellID = 63189 }; --Plate Girdle of Righteousness
		[4] = {itemID = 43587, spellID = 61009 }; --Icebane Girdle
		[5] = {itemID = 42729, spellID = 56551 }; --Ornate Saronite Waistguard
		[6] = {itemID = 41352, spellID = 55307 }; --Savage Saronite Waistguard
		[7] = {itemID = 43860, spellID = 59436 }; --Brilliant Saronite Belt
		[8] = {itemID = 40669, spellID = 54551 }; --Tempered Saronite Belt
		[9] = {itemID = 40953, spellID = 54946 }; --Spiked Cobalt Belt
		[10] = {itemID = 39087, spellID = 52568 }; --Cobalt Belt
	};
	{
		Name = BabbleInventory["Armor"] .. WHITE .. " - Wrist";
		[1] = {itemID = 47571, spellID = 67131 }; --Saronite Swordbreakers
		[2] = {itemID = 47570, spellID = 67092 }; --Saronite Swordbreakers
		[3] = {itemID = 47574, spellID = 67096 }; --Sunforged Bracers
		[4] = {itemID = 47575, spellID = 67135 }; --Sunforged Bracers
		[5] = {itemID = 47572, spellID = 67094 }; --Titanium Spikeguards
		[6] = {itemID = 47573, spellID = 67133 }; --Titanium Spikeguards
		[7] = {itemID = 42723, spellID = 56549 }; --Ornate Saronite Bracers
		[8] = {itemID = 41354, spellID = 55305 }; --Savage Saronite Bracers
		[9] = {itemID = 41355, spellID = 55298 }; --Vengeance Bindings
		[10] = {itemID = 41116, spellID = 55017 }; --Tempered Saronite Bracers
		[11] = {itemID = 43864, spellID = 59438 }; --Brilliant Saronite Bracers
		[12] = {itemID = 40954, spellID = 54948 }; --Spiked Cobalt Bracers
		[13] = {itemID = 41974, spellID = 55834 }; --Cobalt Bracers
	};
	{
		Name = "Weapon " .. WHITE .." - OneHanded";
		[1] = {itemID = 45085, spellID = 63182 }; --Titansteel Spellblade
		[2] = {itemID = 41383, spellID = 55370 }; --Titansteel Bonecrusher
		[3] = {itemID = 41384, spellID = 55371 }; --Titansteel Guardian
		[4] = {itemID = 42435, spellID = 56234 }; --Titansteel Shanker
		[5] = {itemID = 41186, spellID = 55183 }; --Corroded Saronite Edge
		[6] = {itemID = 41187, spellID = 55184 }; --Corroded Saronite Woundbringer
		[7] = {itemID = 42443, spellID = 56280 }; --Cudgel of Saronite Justice
		[8] = {itemID = 41185, spellID = 55182 }; --Furious Saronite Beatstick
		[9] = {itemID = 43871, spellID = 59442 }; --Saronite Spellblade
		[10] = {itemID = 41184, spellID = 55181 }; --Saronite Shiv
		[11] = {itemID = 41183, spellID = 55179 }; --Saronite Ambusher
		[12] = {itemID = 41182, spellID = 55177 }; --Savage Cobalt Slicer
		[13] = {itemID = 41243, spellID = 55204 }; --Notched Cobalt War Axe
		[14] = {itemID = 41240, spellID = 55201 }; --Cobalt Tenderizer
		[15] = {itemID = 41239, spellID = 55200 }; --Sturdy Cobalt Quickblade

	};
	{
		Name = "Weapon " .. WHITE .." - TwoHanded";
		[1] = {itemID = 41257, spellID = 55369 }; --Titansteel Destroyer
		[2] = {itemID = 41188, spellID = 55185 }; --Saronite Mindcrusher
		[3] = {itemID = 41181, spellID = 55174 }; --Honed Cobalt Cleaver
		[4] = {itemID = 41242, spellID = 55203 }; --Forged Cobalt Claymore
	};
	{
		Name = "Weapon " .. WHITE .." - Thrown";
		[1] = {itemID = 41245, spellID = 55206 }; --Deadly Saronite Dirk
		[2] = {itemID = 41241, spellID = 55202 }; --Sure-fire Shuriken
	};
	{
		Name = "Shield";
		[1] = {itemID = 42508, spellID = 56400 }; --Titansteel Shield Wall
		[2] = {itemID = 41113, spellID = 55014 }; --Saronite Bulwark
		[3] = {itemID = 40670, spellID = 54557 }; --Saronite Defender
		[4] = {itemID = 40668, spellID = 54550 }; --Cobalt Triangle Shield
		[5] = {itemID = 41117, spellID = 55013 }; --Saronite Protector
	};
	{
		Name = AL["Item Enhancements"];
		[1] = { spellID = 55628, icon = "INV_Jewelcrafting_ThoriumSetting" };
		[2] = { spellID = 55641, icon = "INV_GAUNTLETS_61" };
		[3] = {itemID = 41611, spellID = 55656 }; --Eternal Belt Buckle
		[4] = {itemID = 44936, spellID = 62202 }; --Titanium Plating
		[5] = {itemID = 42500, spellID = 56357 }; --Titanium Shield Spike
		[6] = {itemID = 41976, spellID = 55839 }; --Titanium Weapon Chain
	};
	{
		Name = AL["Miscellaneous"];
		[1] = {itemID = 43853, spellID = 59406 }; --Titanium Skeleton Key
		[2] = {itemID = 43854, spellID = 59405 }; --Cobalt Skeleton Key
		[3] = {itemID = 41745, spellID = 55732 }; --Titanium Rod
	};
	{
		Name = ARMORSMITH;
		[1] = {itemID = 41189, spellID = 55186 }; --Chestplate of Conquest
		[2] = {itemID = 41190, spellID = 55187 }; --Legplates of Conquest
		[3] = {itemID = 41189, spellID = 55186 }; --Chestplate of Conquest
		[4] = {itemID = 23564, spellID = 34530 }; --Twisting Nether Chain Shirt
		[5] = {itemID = 28484, spellID = 34534 }; --Bulwark of Kings
		[6] = {itemID = 28485, spellID = 36257 }; --Bulwark of the Ancient Kings
		[7] = {itemID = 23565, spellID = 36256 }; --Embrace of the Twisting Nether
		[8] = {itemID = 30074, spellID = 36129 }; --Heavy Earthforged Breastplate
		[9] = {itemID = 30076, spellID = 36130 }; --Stormforged Hauberk
		[10] = {itemID = 28483, spellID = 34533 }; --Breastplate of Kings
		[11] = {itemID = 23563, spellID = 34529 }; --Nether Chain Shirt
		[12] = {itemID = 30069, spellID = 36122 }; --Earthforged Leggings
		[13] = {itemID = 30070, spellID = 36124 }; --Windforged Leggings

	};
	{
		Name = WEAPONSMITH;
		[1] = {itemID = 30071, spellID = 36125 }; --Light Earthforged Blade
		[2] = {itemID = 30073, spellID = 36128 }; --Light Emberforged Hammer
		[3] = {itemID = 30072, spellID = 36126 }; --Light Skyforged Axe
		[4] = {itemID = 41186, spellID = 55183 }; --Corroded Saronite Edge
		[5] = {itemID = 41187, spellID = 55184 }; --Corroded Saronite Woundbringer
		[6] = {itemID = 41188, spellID = 55185 }; --Saronite Mindcrusher
	};
	{
		Name = AXESMITH;
		[1] = {itemID = 30088, spellID = 36135 }; --Skyforged Great Axe
		[2] = {itemID = 30087, spellID = 36134 }; --Stormforged Axe
		[3] = {itemID = 28434, spellID = 34543 }; --Lunar Crescent
		[4] = {itemID = 28431, spellID = 34541 }; --The Planar Edge
		[5] = {itemID = 28432, spellID = 34542 }; --Black Planar Edge
		[6] = {itemID = 28436, spellID = 36261 }; --Bloodmoon
		[7] = {itemID = 28435, spellID = 34544 }; --Mooncleaver
		[8] = {itemID = 28433, spellID = 36260 }; --Wicked Edge of the Planes
	};
	{
		Name = HAMMERSMITH;
		[1] = {itemID = 30093, spellID = 36137 }; --Great Earthforged Hammer
		[2] = {itemID = 30089, spellID = 36136 }; --Lavaforged Warhammer
		[3] = {itemID = 28437, spellID = 34545 }; --Drakefist Hammer
		[4] = {itemID = 28440, spellID = 34547 }; --Thunder
		[5] = {itemID = 28441, spellID = 34548 }; --Deep Thunder
		[6] = {itemID = 28438, spellID = 34546 }; --Dragonmaw
		[7] = {itemID = 28439, spellID = 36262 }; --Dragonstrike
		[8] = {itemID = 28442, spellID = 36263 }; --Stormherald
	};
	{
		Name = SWORDSMITH;
		[1] = {itemID = 30086, spellID = 36133 }; --Stoneforged Claymore
		[2] = {itemID = 30077, spellID = 36131 }; --Windforged Rapier
		[3] = {itemID = 28425, spellID = 34535 }; --Fireguard
		[4] = {itemID = 28428, spellID = 34538 }; --Lionheart Blade
		[5] = {itemID = 28427, spellID = 36258 }; --Blazefury
		[6] = {itemID = 28426, spellID = 34537 }; --Blazeguard
		[7] = {itemID = 28429, spellID = 34540 }; --Lionheart Champion
		[8] = {itemID = 28430, spellID = 36259 }; --Lionheart Executioner
	};
};

---------------
--- Cooking ---
---------------

AtlasLoot_Data["CookingWRATH"] = {
	Name = COOKING;
	Type = "Crafting";
	{
		Name = COOKING;
		[1] = {itemID = 43015, spellID = 57423 }; --Fish Feast
		[2] = {itemID = 43478, spellID = 58527 }; --Gigantic Feast
		[3] = {itemID = 43480, spellID = 58528 }; --Small Feast
		[4] = {itemID = 42999, spellID = 57441 }; --Blackened Dragonfin
		[5] = {itemID = 42997, spellID = 57438 }; --Blackened Worg Steak
		[6] = {itemID = 45932, spellID = 64358 }; --Black Jelly
		[7] = {itemID = 43004, spellID = 57435 }; --Critter Bites
		[8] = {itemID = 42998, spellID = 57439 }; --Cuttlesteak
		[9] = {itemID = 43000, spellID = 57442 }; --Dragonfin Filet
		[10] = {itemID = 34767, spellID = 45568 }; --Firecracker Salmon
		[11] = {itemID = 42995, spellID = 57436 }; --Hearty Rhino
		[12] = {itemID = 34769, spellID = 45570 }; --Imperial Manta Steak
		[13] = {itemID = 34754, spellID = 45555 }; --Mega Mammoth Meal
		[14] = {itemID = 34758, spellID = 45559 }; --Mighty Rhino Dogs
		[15] = {itemID = 34766, spellID = 45567 }; --Poached Northern Sculpin
		[16] = {itemID = 42994, spellID = 57434 }; --Rhinolicious Wyrmsteak
		[17] = {itemID = 42996, spellID = 57437 }; --Snapper Extreme
		[18] = {itemID = 43005, spellID = 57440 }; --Spiced Mammoth Treats
		[19] = {itemID = 34756, spellID = 45557 }; --Spiced Wyrm Burger
		[20] = {itemID = 34768, spellID = 45571 }; --Spicy Blue Nettlefish
		[21] = {itemID = 42993, spellID = 57433 }; --Spicy Fried Herring
		[22] = {itemID = 34755, spellID = 45556 }; --Tender Shoveltusk Steak
		[23] = {itemID = 43001, spellID = 57443 }; --Tracker Snacks
		[24] = {itemID = 34757, spellID = 45558 }; --Very Burnt Worg
		[25] = {itemID = 44953, spellID = 62350 }; --Worg Tartare
		[26] = {itemID = 34753, spellID = 45554 }; --Great Feast
		[27] = {itemID = 39520, spellID = 53056 }; --Kungaloosh
		[28] = {itemID = 43491, spellID = 58523 }; --Bad Clams" .. "
		[29] = {itemID = 42942, spellID = 45569 }; --Baked Manta Ray
		[30] = {itemID = 43268, spellID = 58065 }; --Dalaran Clam Chowder
	};
};

------------------
--- Enchanting ---
------------------

AtlasLoot_Data["EnchantingWRATH"] = {
	Name = ENCHANTING;
	{
		Name = AL["Enchant Boots"];
		[1] = {spellID = 60763, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Greater Assault
		[2] = {spellID = 47901, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Tuskarr's Vitality
		[3] = {spellID = 44589, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Superior Agility
		[4] = {spellID = 44508, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Greater Spirit
		[5] = {spellID = 44584, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Greater Vitality
		[6] = {spellID = 60606, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Assault
		[7] = {spellID = 44528, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Greater Fortitude
		[8] = {spellID = 60623, icon = "Spell_Holy_GreaterHeal" }; --Enchant Boots - Icewalker
	};
	{
		Name = AL["Enchant Bracer"];
		[1] = {spellID = 62256, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Major Stamina
		[2] = {spellID = 60767, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Superior Spellpower
		[3] = {spellID = 44575, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Greater Assault
		[4] = {spellID = 44593, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Major Spirit
		[5] = {spellID = 44598, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Expertise
		[6] = {spellID = 44616, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Greater Stats
		[7] = {spellID = 44635, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Greater Spellpower
		[8] = {spellID = 44555, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Exceptional Intellect
		[9] = {spellID = 60616, icon = "Spell_Holy_GreaterHeal" }; --Enchant Bracers - Striking
	};
	{
		Name = AL["Enchant Chest"];
		[1] = {spellID = 27958, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Exceptional Mana
		[2] = {spellID = 44588, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Exceptional Resilience
		[3] = {spellID = 60692, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Powerful Stats
		[4] = {spellID = 47900, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Super Health
		[5] = {spellID = 44509, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Greater Mana Restoration
		[6] = {spellID = 47766, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Greater Defense
		[7] = {spellID = 44492, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Mighty Health
		[8] = {spellID = 44623, icon = "Spell_Holy_GreaterHeal" }; --Enchant Chest - Super Stats
	};
	{
		Name = AL["Enchant Cloak"];
		[1] = {spellID = 60609, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Speed
		[2] = {spellID = 44631, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Shadow Armor
		[3] = {spellID = 47899, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Wisdom
		[4] = {spellID = 44591, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Titanweave
		[5] = {spellID = 47898, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Greater Speed
		[6] = {spellID = 47672, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Mighty Armor
		[7] = {spellID = 60663, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Major Agility
		[8] = {spellID = 44596, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Superior Arcane Resistance
		[9] = {spellID = 44556, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Superior Fire Resistance
		[10] = {spellID = 44483, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Superior Frost Resistance
		[11] = {spellID = 44494, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Superior Nature Resistance
		[12] = {spellID = 44590, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Superior Shadow Resistance
		[13] = {spellID = 44500, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Superior Agility
		[14] = {spellID = 44582, icon = "Spell_Holy_GreaterHeal" }; --Enchant Cloak - Spell Piercing
	};
	{
		Name = AL["Enchant Gloves"];
		[1] = {spellID = 71692, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Angler
		[2] = {spellID = 44625, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Armsman
		[3] = {spellID = 60668, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Crusher
		[4] = {spellID = 44529, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Major Agility
		[5] = {spellID = 44488, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Precision
		[6] = {spellID = 44484, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Expertise
		[7] = {spellID = 44513, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Greater Assault
		[8] = {spellID = 44506, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Gatherer
		[9] = {spellID = 44592, icon = "Spell_Holy_GreaterHeal" }; --Enchant Gloves - Exceptional Spellpower
	};
	{
		Name = AL["Enchant Ring"];
		[1] = {spellID = 44645, icon = "Spell_Holy_GreaterHeal" }; --Enchant Ring - Assault
		[2] = {spellID = 44636, icon = "Spell_Holy_GreaterHeal" }; --Enchant Ring - Greater Spellpower
		[3] = {spellID = 59636, icon = "Spell_Holy_GreaterHeal" }; --Enchant Ring - Stamina
	};
	{
		Name = AL["Enchant Shield"];
		[1] = {spellID = 44489, icon = "Spell_Holy_GreaterHeal" }; --Enchant Shield - Defense
		[2] = {spellID = 60653, icon = "Spell_Holy_GreaterHeal" }; --Enchant Shield - Greater Intellect
	};
	{
		Name = AL["Enchant 2H Weapon"];
		[1] = {spellID = 60691, icon = "Spell_Holy_GreaterHeal" }; --Enchant 2H Weapon - Massacre
		[2] = {spellID = 44595, icon = "Spell_Holy_GreaterHeal" }; --Enchant 2H Weapon - Scourgebane
		[3] = {spellID = 44630, icon = "Spell_Holy_GreaterHeal" }; --Enchant 2H Weapon - Greater Savagery
	};
	{
		Name = AL["Enchant Weapon"];
		[1] = {spellID = 64441, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Blade Ward
		[2] = {spellID = 64579, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Blood Draining
		[3] = {spellID = 59619, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Accuracy
		[4] = {spellID = 59621, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Berserking
		[5] = {spellID = 59625, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Black Magic
		[6] = {spellID = 44576, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Lifeward
		[7] = {spellID = 60714, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Mighty Spellpower
		[8] = {spellID = 60707, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Superior Potency
		[9] = {spellID = 44621, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Giant Slayer
		[10] = {spellID = 44524, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Icebreaker
		[11] = {spellID = 44633, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Exceptional Agility
		[12] = {spellID = 44510, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Exceptional Spirit
		[13] = {spellID = 44629, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Exceptional Spellpower
		[14] = {spellID = 60621, icon = "Spell_Holy_GreaterHeal" }; --Enchant Weapon - Greater Potency
	};
	{
		Name = "Enchant Staff";
		[1] = { spellID = 62948, icon = "Spell_Holy_GreaterHeal" }; --Enchant Staff - Greater Spellpower
		[2] = { spellID = 62959, icon = "Spell_Holy_GreaterHeal" }; --Enchant Staff - Spellpower
	};
	{
		Name = AL["Miscellaneous"];
		[1] = {itemID = 22459, spellID = 28028 }; --Void Sphere
		[2] = {itemID = 44452, spellID = 60619 }; --Runed Titanium Rod
	};
};

-------------------
--- Engineering ---
-------------------

AtlasLoot_Data["EngineeringWRATH"] = {
	Name = ENGINEERING;
	Type = "Crafting";
	{
		Name = "Ammo";
		[1] = {itemID = 52021, spellID = 72953 }; --Iceblade Arrow
		[2] = {itemID = 52020, spellID = 72952 }; --Shatter Rounds
		[3] = {itemID = 41165, spellID = 56475 }; --Saronite Arrow Maker
		[4] = {itemID = 41164, spellID = 56474 }; --Ultrasafe Bullet Machine
	};
	{
		Name = BabbleInventory["Armor"];
		[1] = {itemID = 42549, spellID = 56480 }; --Armored Titanium Goggles
		[2] = {itemID = 42552, spellID = 56483 }; --Charged Titanium Specs
		[3] = {itemID = 42555, spellID = 56487 }; --Electroflux Sight Enhancers
		[4] = {itemID = 42554, spellID = 56486 }; --Greensight Gogs
		[5] = {itemID = 42551, spellID = 56574 }; --Truesight Ice Blinders
		[6] = {itemID = 42553, spellID = 56484 }; --Visage Liquification Goggles
		[7] = {itemID = 42550, spellID = 56481 }; --Weakness Spectralizers
		[8] = {itemID = 44949, spellID = 62271 }; --Unbreakable Healing Amplifiers
		[9] = {itemID = 41121, spellID = 56469 }; --Gnomish Lightning Generator
		[10] = {itemID = 40895, spellID = 56473 }; --Gnomish X-Ray Specs
		[11] = {itemID = 44742, spellID = 61483 }; --Mechanized Snow Goggles
		[12] = {itemID = 40865, spellID = 56467 }; --Noise Machine
		[13] = {itemID = 40767, spellID = 56466 }; --Sonic Booster
	};
	{
		Name = AL["Explosives"];
		[1] = {itemID = 42641, spellID = 56514 }; --Global Thermal Sapper Charge
		[2] = {itemID = 44951, spellID = 56468 }; --Box of Bombs
		[3] = {itemID = 40536, spellID = 56463 }; --Explosive Decoy
		[4] = {itemID = 40771, spellID = 56460 }; --Cobalt Frag Bomb
		[5] = {itemID = 32413, spellID = 39973 }; --Frost Grenades
	};
	{
		Name = AL["Item Enhancements"];
		[1] = {itemID = 41167, spellID = 56478 }; --Heartseeker Scope
		[2] = {itemID = 41146, spellID = 56470 }; --Sun Scope
		[3] = {itemID = 44739, spellID = 61471 }; --Diamond-cut Refractor Scope
		[16] = {spellID = 55016, icon = "Trade_Engineering" }; --Nitro Boosts
		[17] = {spellID = 54998, icon = "Trade_Engineering" }; --Hand-Mounted Pyro Rocket
		[18] = {spellID = 54999, icon = "Trade_Engineering" }; --Hyperspeed Accelerators
		[19] = {spellID = 63770, icon = "Trade_Engineering" }; --Reticulated Armor Webbing
		[20] = {spellID = 54736, icon = "Trade_Engineering" }; --Personal Electromagnetic Pulse Generator
		[21] = {spellID = 54793, icon = "Trade_Engineering" }; --Belt-Clipped Spynoculars
		[22] = {spellID = 55002, icon = "Trade_Engineering" }; --Flexweave Underlay
		[23] = {spellID = 63765, icon = "Trade_Engineering" }; --Springy Arachnoweave
	};
	{
		Name = BabbleInventory["Weapon"];
		[1] = {itemID = 41168, spellID = 56479 }; --Armor Plated Combat Shotgun
		[2] = {itemID = 44504, spellID = 60874 }; --Nesingwary 4000
		[3] = {itemID = 39688, spellID = 54353 }; --Mark \"S\" Boomstick
	};
	{
		Name = AL["Miscellaneous"];
		[1] = {itemID = 49040, spellID = 68067 }; --Jeeves
		[2] = {itemID = 41508, spellID = 60866 }; --Mechano-hog
		[3] = {itemID = 44413, spellID = 60867 }; --Mekgineer's Chopper
		[4] = {itemID = 40768, spellID = 56472 }; --MOLL-E
		[5] = {itemID = 48933, spellID = 67920 }; --Wormhole Generator: Northrend
		[6] = {itemID = 23775, spellID = 30349 }; --Titanium Toolbox
		[7] = {itemID = 40892, spellID = 56459 }; --Hammer Pick
	};
	{
		Name = AL["Reagents"];
		[1] = {itemID = 39681, spellID = 56349 }; --Handful of Cobalt Bolts" .. "
		[2] = {itemID = 39683, spellID = 56471 }; --Froststeel Tube
		[3] = {itemID = 39682, spellID = 56464 }; --Overcharged Capacitor
		[4] = {itemID = 39690, spellID = 53281 }; --Volatile Blasting Trigger" .. "
	};
	{
		Name = GNOMISH;
		[1] = {itemID = 52021, spellID = 72953 }; --Iceblade Arrow
		[2] = {itemID = 23829, spellID = 30575 }; --Gnomish Battle Goggles
		[3] = {itemID = 23828, spellID = 30574 }; --Gnomish Power Goggles
		[4] = {itemID = 40895, spellID = 56473 }; --Gnomish X-Ray Specs
		[5] = {itemID = 23825, spellID = 30570 }; --Nigh-Invulnerability Belt
		[6] = {itemID = 23835, spellID = 30569 }; --Gnomish Poultryizer
		[7] = {itemID = 30544, spellID = 36955 }; --Ultrasafe Transporter - Toshley's Station
		[8] = {itemID = 18986, spellID = 23489 }; --Ultrasafe Transporter - Gadgetzan
		[9] = {itemID = 18660, spellID = 23129 }; --World Enlarger
		[10] = {itemID = 10726, spellID = 12907 }; --Gnomish Mind Control Cap
		[11] = {itemID = 10724, spellID = 12905 }; --Gnomish Rocket Boots
		[12] = {itemID = 10721, spellID = 12903 }; --Gnomish Harm Prevention Belt
		[13] = {itemID = 10545, spellID = 12897 }; --Gnomish Goggles
		[14] = {itemID = 23841, spellID = 30568 }; --Gnomish Flame Turret
		[15] = {itemID = 18645, spellID = 23096 }; --Alarm-O-Bot
		[16] = {itemID = 10645, spellID = 12759 }; --Gnomish Death Ray
		[17] = {itemID = 10725, spellID = 12906 }; --Gnomish Battle Chicken
		[18] = {itemID = 10720, spellID = 12902 }; --Gnomish Net-o-Matic Projector
		[19] = {itemID = 10716, spellID = 12899 }; --Gnomish Shrink Ray
		[20] = {itemID = 10713, spellID = 12895 }; --Inlaid Mithril Cylinder Plans
	};
	{
		Name = GOBLIN;
		[1] = {itemID = 52020, spellID = 72952 }; --Shatter Rounds
		[2] = {itemID = 23838, spellID = 30565 }; --Foreman's Enchanted Helmet
		[3] = {itemID = 23839, spellID = 30566 }; --Foreman's Reinforced Helmet
		[4] = {itemID = 23836, spellID = 30563 }; --Goblin Rocket Launcher
		[5] = {itemID = 30542, spellID = 36954 }; --Dimensional Ripper - Area 52
		[6] = {itemID = 18984, spellID = 23486 }; --Dimensional Ripper - Everlook
		[7] = {itemID = 10588, spellID = 12758 }; --Goblin Rocket Helmet
		[8] = {itemID = 7189, spellID = 8895 }; --Goblin Rocket Boots
		[9] = {itemID = 10543, spellID = 12718 }; --Goblin Construction Helmet
		[10] = {itemID = 10542, spellID = 12717 }; --Goblin Mining Helmet
		[11] = {itemID = 42641, spellID = 56514 }; --Global Thermal Sapper Charge
		[12] = {itemID = 23827, spellID = 30560 }; --Super Sapper Charge
		[13] = {itemID = 23826, spellID = 30558 }; --The Bigger One
		[14] = {itemID = 18587, spellID = 23078 }; --Goblin Jumper Cables XL
		[15] = {itemID = 10727, spellID = 12908 }; --Goblin Dragon Gun
		[16] = {itemID = 10586, spellID = 12754 }; --The Big One
		[17] = {itemID = 10587, spellID = 12755 }; --Goblin Bomb Dispenser
		[18] = {itemID = 10577, spellID = 12716 }; --Goblin Mortar
		[19] = {itemID = 10644, spellID = 12715 }; --Goblin Rocket Fuel Recipe
		[20] = {itemID = 10646, spellID = 12760 }; --Goblin Sapper Charge
		[21] = {itemID = 10577, spellID = 13240 }; --The Mortar: Reloaded
	};
};

---------------------
--- Jewelcrafting ---
---------------------


AtlasLoot_Data["JewelcraftingWRATH"] = {
	Name = JEWELCRAFTING;
	Type = "Crafting";
	{
		Name = AL["Red Gems"];
		[1] = {itemID = 40111, spellID = 66447 }; --Bold Cardinal Ruby
		[2] = {itemID = 40114, spellID = 66449 }; --Bright Cardinal Ruby
		[3] = {itemID = 40112, spellID = 66448 }; --Delicate Cardinal Ruby
		[4] = {itemID = 40116, spellID = 66453 }; --Flashing Cardinal Ruby
		[5] = {itemID = 40117, spellID = 66451 }; --Fractured Cardinal Ruby
		[6] = {itemID = 40118, spellID = 66450 }; --Precise Cardinal Ruby
		[7] = {itemID = 40113, spellID = 66446 }; --Runed Cardinal Ruby
		[8] = {itemID = 40115, spellID = 66452 }; --Subtle Cardinal Ruby
		[9] = {itemID = 39996, spellID = 53830 }; --Bold Scarlet Ruby
		[10] = {itemID = 39999, spellID = 53947 }; --Bright Scarlet Ruby
		[11] = {itemID = 39997, spellID = 53945 }; --Delicate Scarlet Ruby
		[12] = {itemID = 40001, spellID = 53949 }; --Flashing Scarlet Ruby
		[13] = {itemID = 40002, spellID = 53950 }; --Fractured Scarlet Ruby
		[14] = {itemID = 40003, spellID = 53951 }; --Precise Scarlet Ruby
		[15] = {itemID = 39998, spellID = 53946 }; --Runed Scarlet Ruby
		[16] = {itemID = 39907, spellID = 53843 }; --Subtle Bloodstone
		[17] = {itemID = 39900, spellID = 53831 }; --Bold Bloodstone
		[18] = {itemID = 39906, spellID = 53835 }; --Bright Bloodstone
		[19] = {itemID = 39905, spellID = 53832 }; --Delicate Bloodstone
		[20] = {itemID = 39908, spellID = 53844 }; --Flashing Bloodstone
		[21] = {itemID = 39909, spellID = 53845 }; --Fractured Bloodstone
		[22] = {itemID = 39910, spellID = 54017 }; --Precise Bloodstone
		[23] = {itemID = 39911, spellID = 53834 }; --Runed Bloodstone
	};
	{
		Name = AL["Blue Gems"];
		[1] = {itemID = 40121, spellID = 66500 }; --Lustrous Majestic Zircon
		[2] = {itemID = 40119, spellID = 66497 }; --Solid Majestic Zircon
		[3] = {itemID = 40120, spellID = 66498 }; --Sparkling Majestic Zircon
		[4] = {itemID = 40122, spellID = 66499 }; --Stormy Majestic Zircon
		[5] = {itemID = 40010, spellID = 53954 }; --Lustrous Sky Sapphire
		[6] = {itemID = 40008, spellID = 53952 }; --Solid Sky Sapphire
		[7] = {itemID = 40009, spellID = 53953 }; --Sparkling Sky Sapphire
		[8] = {itemID = 40011, spellID = 53955 }; --Stormy Sky Sapphire
		[9] = {itemID = 39927, spellID = 53941 }; --Lustrous Chalcedony
		[10] = {itemID = 39919, spellID = 53934 }; --Solid Chalcedony
		[11] = {itemID = 39920, spellID = 53940 }; --Sparkling Chalcedony
		[12] = {itemID = 39932, spellID = 53943 }; --Stormy Chalcedony
	};
	{
		Name = AL["Yellow Gems"];
		[1] = {itemID = 40123, spellID = 66503 }; --Brilliant King's Amber
		[2] = {itemID = 40127, spellID = 66505 }; --Mystic King's Amber
		[3] = {itemID = 40128, spellID = 66506 }; --Quick King's Amber
		[4] = {itemID = 40125, spellID = 66501 }; --Rigid King's Amber
		[5] = {itemID = 40124, spellID = 66502 }; --Smooth King's Amber
		[6] = {itemID = 40126, spellID = 66504 }; --Thick King's Amber
		[7] = {itemID = 40012, spellID = 53956 }; --Brilliant Autumn's Glow
		[8] = {itemID = 40016, spellID = 53960 }; --Mystic Autumn's Glow
		[9] = {itemID = 40017, spellID = 53961 }; --Quick Autumn's Glow
		[10] = {itemID = 40014, spellID = 53958 }; --Rigid Autumn's Glow
		[11] = {itemID = 40013, spellID = 53957 }; --Smooth Autumn's Glow
		[12] = {itemID = 40015, spellID = 53959 }; --Thick Autumn's Glow
		[16] = {itemID = 39912, spellID = 53852 }; --Brilliant Sun Crystal
		[17] = {itemID = 39917, spellID = 53857 }; --Mystic Sun Crystal
		[18] = {itemID = 39918, spellID = 53856 }; --Quick Sun Crystal
		[19] = {itemID = 39915, spellID = 53854 }; --Rigid Sun Crystal
		[20] = {itemID = 39914, spellID = 53853 }; --Smooth Sun Crystal
		[21] = {itemID = 39916, spellID = 53855 }; --Thick Sun Crystal
	};
	{
		Name = AL["Green Gems"];
		[1] = {itemID = 40175, spellID = 66430 }; --Dazzling Eye of Zul
		[2] = {itemID = 40167, spellID = 66338 }; --Enduring Eye of Zul
		[3] = {itemID = 40179, spellID = 66442 }; --Energized Eye of Zul
		[4] = {itemID = 40169, spellID = 66434 }; --Forceful Eye of Zul
		[5] = {itemID = 40174, spellID = 66440 }; --Intricate Eye of Zul
		[6] = {itemID = 40165, spellID = 66431 }; --Jagged Eye of Zul
		[7] = {itemID = 40177, spellID = 66439 }; --Lambent Eye of Zul
		[8] = {itemID = 40171, spellID = 66435 }; --Misty Eye of Zul
		[9] = {itemID = 40178, spellID = 66444 }; --Opaque Eye of Zul
		[10] = {itemID = 40180, spellID = 66441 }; --Radiant Eye of Zul
		[11] = {itemID = 40170, spellID = 66433 }; --Seer's Eye of Zul
		[12] = {itemID = 40182, spellID = 66443 }; --Shattered Eye of Zul
		[13] = {itemID = 40172, spellID = 66437 }; --Shining Eye of Zul
		[14] = {itemID = 40168, spellID = 66428 }; --Steady Eye of Zul
		[15] = {itemID = 40176, spellID = 66436 }; --Sundered Eye of Zul
		[16] = {itemID = 40181, spellID = 66438 }; --Tense Eye of Zul
		[17] = {itemID = 40164, spellID = 66432 }; --Timeless Eye of Zul
		[18] = {itemID = 40173, spellID = 66445 }; --Turbid Eye of Zul
		[19] = {itemID = 40166, spellID = 66429 }; --Vivid Eye of Zul
		[20] = {itemID = 40094, spellID = 54007 }; --Dazzling Forest Emerald
		[21] = {itemID = 40089, spellID = 53998 }; --Enduring Forest Emerald
		[22] = {itemID = 40105, spellID = 54011 }; --Energized Forest Emerald
		[23] = {itemID = 40091, spellID = 54001 }; --Forceful Forest Emerald
		[24] = {itemID = 40104, spellID = 54006 }; --Intricate Forest Emerald
		[25] = {itemID = 40086, spellID = 53996 }; --Jagged Forest Emerald
		[26] = {itemID = 40100, spellID = 54009 }; --Lambent Forest Emerald
		[27] = {itemID = 40095, spellID = 54003 }; --Misty Forest Emerald" .. "
		[28] = {itemID = 40103, spellID = 54010 }; --Opaque Forest Emerald
		[29] = {itemID = 40098, spellID = 54012 }; --Radiant Forest Emerald
		[30] = {itemID = 40092, spellID = 54002 }; --Seer's Forest Emerald
	};
	{
		Name = AL["Green Gems"];
		[1] = {itemID = 40106, spellID = 54014 }; --Shattered Forest Emerald
		[2] = {itemID = 40099, spellID = 54004 }; --Shining Forest Emerald" .. "
		[3] = {itemID = 40090, spellID = 54000 }; --Steady Forest Emerald
		[4] = {itemID = 40096, spellID = 54008 }; --Sundered Forest Emerald
		[5] = {itemID = 40101, spellID = 54013 }; --Tense Forest Emerald
		[6] = {itemID = 40085, spellID = 53995 }; --Timeless Forest Emerald
		[7] = {itemID = 40102, spellID = 54005 }; --Turbid Forest Emerald
		[8] = {itemID = 40088, spellID = 53997 }; --Vivid Forest Emerald
		[9] = {itemID = 39984, spellID = 53926 }; --Dazzling Dark Jade
		[10] = {itemID = 39976, spellID = 53918 }; --Enduring Dark Jade
		[11] = {itemID = 39989, spellID = 53930 }; --Energized Dark Jade
		[12] = {itemID = 39978, spellID = 53920 }; --Forceful Dark Jade
		[13] = {itemID = 39983, spellID = 53925 }; --Intricate Dark Jade
		[14] = {itemID = 39974, spellID = 53916 }; --Jagged Dark Jade
		[15] = {itemID = 39986, spellID = 53928 }; --Lambent Dark Jade
		[16] = {itemID = 39980, spellID = 53922 }; --Misty Dark Jade
		[17] = {itemID = 39988, spellID = 53929 }; --Opaque Dark Jade
		[18] = {itemID = 39990, spellID = 53931 }; --Radiant Dark Jade
		[19] = {itemID = 39979, spellID = 53921 }; --Seer's Dark Jade
		[20] = {itemID = 39992, spellID = 53933 }; --Shattered Dark Jade
		[21] = {itemID = 39981, spellID = 53923 }; --Shining Dark Jade
		[22] = {itemID = 39977, spellID = 53919 }; --Steady Dark Jade
		[23] = {itemID = 39985, spellID = 53927 }; --Sundered Dark Jade
		[24] = {itemID = 39991, spellID = 53932 }; --Tense Dark Jade
		[25] = {itemID = 39968, spellID = 53894 }; --Timeless Dark Jade
		[26] = {itemID = 39982, spellID = 53924 }; --Turbid Dark Jade
		[27] = {itemID = 39975, spellID = 53917 }; --Vivid Dark Jade
	};
	{
		Name = AL["Orange Gems"];
		[1] = {itemID = 40162, spellID = 66576 }; --Accurate Ametrine
		[2] = {itemID = 40144, spellID = 66579 }; --Champion's Ametrine
		[3] = {itemID = 40147, spellID = 66568 }; --Deadly Ametrine
		[4] = {itemID = 40150, spellID = 66584 }; --Deft Ametrine
		[5] = {itemID = 40154, spellID = 66571 }; --Durable Ametrine
		[6] = {itemID = 40158, spellID = 66580 }; --Empowered Ametrine
		[7] = {itemID = 40143, spellID = 66572 }; --Etched Ametrine
		[8] = {itemID = 40146, spellID = 66583 }; --Fierce Ametrine
		[9] = {itemID = 40161, spellID = 66578 }; --Glimmering Ametrine
		[10] = {itemID = 40148, spellID = 66575 }; --Glinting Ametrine
		[11] = {itemID = 40142, spellID = 66567 }; --Inscribed Ametrine
		[12] = {itemID = 40149, spellID = 66585 }; --Lucent Ametrine
		[13] = {itemID = 40151, spellID = 66566 }; --Luminous Ametrine
		[14] = {itemID = 40152, spellID = 66569 }; --Potent Ametrine
		[15] = {itemID = 40157, spellID = 66573 }; --Pristine Ametrine
		[16] = {itemID = 40155, spellID = 66574 }; --Reckless Ametrine
		[17] = {itemID = 40163, spellID = 66586 }; --Resolute Ametrine
		[18] = {itemID = 40145, spellID = 66582 }; --Resplendent Ametrine
		[19] = {itemID = 40160, spellID = 66581 }; --Stalwart Ametrine
		[20] = {itemID = 40159, spellID = 66587 }; --Stark Ametrine
		[21] = {itemID = 40153, spellID = 66570 }; --Veiled Ametrine
		[22] = {itemID = 40156, spellID = 66577 }; --Wicked Ametrine
	};
	{
		Name = AL["Orange Gems"];
		[1] = {itemID = 40058, spellID = 53994 }; --Accurate Monarch Topaz
		[2] = {itemID = 40039, spellID = 53977 }; --Champion's Monarch Topaz" .. "
		[3] = {itemID = 40043, spellID = 53979 }; --Deadly Monarch Topaz
		[4] = {itemID = 40046, spellID = 53982 }; --Deft Monarch Topaz
		[5] = {itemID = 40050, spellID = 53986 }; --Durable Monarch Topaz
		[6] = {itemID = 40054, spellID = 53990 }; --Empowered Monarch Topaz
		[7] = {itemID = 40038, spellID = 53976 }; --Etched Monarch Topaz" .. "
		[8] = {itemID = 40041, spellID = 54019 }; --Fierce Monarch Topaz
		[9] = {itemID = 40057, spellID = 53993 }; --Glimmering Monarch Topaz
		[10] = {itemID = 40044, spellID = 53980 }; --Glinting Monarch Topaz
		[11] = {itemID = 40037, spellID = 53975 }; --Inscribed Monarch Topaz" .. "
		[12] = {itemID = 40045, spellID = 53981 }; --Lucent Monarch Topaz
		[13] = {itemID = 40047, spellID = 53983 }; --Luminous Monarch Topaz
		[14] = {itemID = 40048, spellID = 53984 }; --Potent Monarch Topaz
		[15] = {itemID = 40053, spellID = 53989 }; --Pristine Monarch Topaz
		[16] = {itemID = 40051, spellID = 53987 }; --Reckless Monarch Topaz
		[17] = {itemID = 40059, spellID = 54023 }; --Resolute Monarch Topaz" .. "
		[18] = {itemID = 40040, spellID = 53978 }; --Resplendent Monarch Topaz
		[19] = {itemID = 40056, spellID = 53992 }; --Stalwart Monarch Topaz" .. "
		[20] = {itemID = 40055, spellID = 53991 }; --Stark Monarch Topaz
		[21] = {itemID = 40049, spellID = 53985 }; --Veiled Monarch Topaz
		[22] = {itemID = 40052, spellID = 53988 }; --Wicked Monarch Topaz
	};
	{
		Name = AL["Orange Gems"];
		[1] = {itemID = 39965, spellID = 53891 }; --Glimmering Huge Citrine
		[2] = {itemID = 39966, spellID = 53892 }; --Accurate Huge Citrine
		[3] = {itemID = 39949, spellID = 53874 }; --Champion's Huge Citrine
		[4] = {itemID = 39952, spellID = 53877 }; --Deadly Huge Citrine
		[5] = {itemID = 39955, spellID = 53880 }; --Deft Huge Citrine
		[6] = {itemID = 39958, spellID = 53884 }; --Durable Huge Citrine
		[7] = {itemID = 39962, spellID = 53888 }; --Empowered Huge Citrine
		[8] = {itemID = 39948, spellID = 53873 }; --Etched Huge Citrine
		[9] = {itemID = 39951, spellID = 53876 }; --Fierce Huge Citrine
		[10] = {itemID = 39953, spellID = 53878 }; --Glinting Huge Citrine
		[11] = {itemID = 39947, spellID = 53872 }; --Inscribed Huge Citrine
		[12] = {itemID = 39954, spellID = 53879 }; --Lucent Huge Citrine
		[13] = {itemID = 39946, spellID = 53881 }; --Luminous Huge Citrine
		[14] = {itemID = 39956, spellID = 53882 }; --Potent Huge Citrine
		[15] = {itemID = 39961, spellID = 53887 }; --Pristine Huge Citrine
		[16] = {itemID = 39959, spellID = 53885 }; --Reckless Huge Citrine
		[17] = {itemID = 39967, spellID = 53893 }; --Resolute Huge Citrine
		[18] = {itemID = 39950, spellID = 53875 }; --Resplendent Huge Citrine
		[19] = {itemID = 39964, spellID = 53890 }; --Stalwart Huge Citrine
		[20] = {itemID = 39963, spellID = 53889 }; --Stark Huge Citrine
		[21] = {itemID = 39957, spellID = 53883 }; --Veiled Huge Citrine
		[22] = {itemID = 39960, spellID = 53886 }; --Wicked Huge Citrine
	};
	{
		Name = AL["Purple Gems"];
		[1] = {itemID = 40136, spellID = 66553 }; --Balanced Dreadstone
		[2] = {itemID = 40139, spellID = 66560 }; --Defender's Dreadstone
		[3] = {itemID = 40132, spellID = 66555 }; --Glowing Dreadstone
		[4] = {itemID = 40141, spellID = 66561 }; --Guardian's Dreadstone
		[5] = {itemID = 40137, spellID = 66564 }; --Infused Dreadstone
		[6] = {itemID = 40135, spellID = 66562 }; --Mysterious Dreadstone
		[7] = {itemID = 40140, spellID = 66563 }; --Puissant Dreadstone
		[8] = {itemID = 40133, spellID = 66556 }; --Purified Dreadstone
		[9] = {itemID = 40138, spellID = 66559 }; --Regal Dreadstone
		[10] = {itemID = 40134, spellID = 66558 }; --Royal Dreadstone
		[11] = {itemID = 40130, spellID = 66557 }; --Shifting Dreadstone
		[12] = {itemID = 40129, spellID = 66554 }; --Sovereign Dreadstone
		[13] = {itemID = 40131, spellID = 66565 }; --Tenuous Dreadstone
		[27] = {itemID = 40029, spellID = 53969 }; --Balanced Twilight Opal
		[28] = {itemID = 40032, spellID = 53972 }; --Defender's Twilight Opal
		[16] = {itemID = 40025, spellID = 53965 }; --Glowing Twilight Opal
		[17] = {itemID = 40034, spellID = 53974 }; --Guardian's Twilight Opal
		[18] = {itemID = 40030, spellID = 53970 }; --Infused Twilight Opal
		[19] = {itemID = 40028, spellID = 53968 }; --Mysterious Twilight Opal
		[20] = {itemID = 40033, spellID = 53973 }; --Puissant Twilight Opal
		[21] = {itemID = 40026, spellID = 53966 }; --Purified Twilight Opal" .. "
		[22] = {itemID = 40031, spellID = 53971 }; --Regal Twilight Opal
		[23] = {itemID = 40027, spellID = 53967 }; --Royal Twilight Opal
		[24] = {itemID = 40023, spellID = 53963 }; --Shifting Twilight Opal
		[25] = {itemID = 40022, spellID = 53962 }; --Sovereign Twilight Opal
		[26] = {itemID = 40024, spellID = 53964 }; --Tenuous Twilight Opal" .. "
	};
	{
		Name = AL["Purple Gems"];
		[1] = {itemID = 39940, spellID = 53871 }; --Guardian's Shadow Crystal
		[2] = {itemID = 39944, spellID = 53867 }; --Infused Shadow Crystal
		[3] = {itemID = 39945, spellID = 53865 }; --Mysterious Shadow Crystal
		[4] = {itemID = 39933, spellID = 53870 }; --Puissant Shadow Crystal
		[5] = {itemID = 39941, spellID = 53863 }; --Purified Shadow Crystal
		[6] = {itemID = 39943, spellID = 53864 }; --Royal Shadow Crystal
		[7] = {itemID = 39935, spellID = 53860 }; --Shifting Shadow Crystal
		[8] = {itemID = 39934, spellID = 53859 }; --Sovereign Shadow Crystal
		[9] = {itemID = 39942, spellID = 53861 }; --Tenuous Shadow Crystal
		[10] = {itemID = 39938, spellID = 53868 }; --Regal Shadow Crystal
		[11] = {itemID = 39937, spellID = 53866 }; --Balanced Shadow Crystal
		[12] = {itemID = 39939, spellID = 53869 }; --Defender's Shadow Crystal
		[13] = {itemID = 39936, spellID = 53862 }; --Glowing Shadow Crystal
		[14] = {itemID = 32833, spellID = 41420 }; --Purified Jaggal Pearl
	};
	{
		Name = AL["Meta Gems"];
		[1] = {itemID = 41285, spellID = 55389 }; --Chaotic Skyflare Diamond
		[2] = {itemID = 41307, spellID = 55390 }; --Destructive Skyflare Diamond" .. "
		[3] = {itemID = 41377, spellID = 55384 }; --Effulgent Skyflare Diamond
		[4] = {itemID = 41333, spellID = 55392 }; --Ember Skyflare Diamond
		[5] = {itemID = 41335, spellID = 55393 }; --Enigmatic Skyflare Diamond
		[6] = {itemID = 41378, spellID = 55387 }; --Forlorn Skyflare Diamond
		[7] = {itemID = 41379, spellID = 55388 }; --Impassive Skyflare Diamond
		[8] = {itemID = 41339, spellID = 55394 }; --Swift Skyflare Diamond
		[9] = {itemID = 41400, spellID = 55395 }; --Thundering Skyflare Diamond" .. "
		[10] = {itemID = 41375, spellID = 55386 }; --Tireless Skyflare Diamond
		[16] = {itemID = 41380, spellID = 55401 }; --Austere Earthsiege Diamond
		[17] = {itemID = 41389, spellID = 55405 }; --Beaming Earthsiege Diamond" .. "
		[18] = {itemID = 41395, spellID = 55397 }; --Bracing Earthsiege Diamond
		[19] = {itemID = 41396, spellID = 55398 }; --Eternal Earthsiege Diamond
		[20] = {itemID = 41401, spellID = 55396 }; --Insightful Earthsiege Diamond
		[21] = {itemID = 41385, spellID = 55404 }; --Invigorating Earthsiege Diamond
		[22] = {itemID = 41381, spellID = 55402 }; --Persistant Earthsiege Diamond
		[23] = {itemID = 41397, spellID = 55399 }; --Powerful Earthsiege Diamond
		[24] = {itemID = 41398, spellID = 55400 }; --Relentless Earthsiege Diamond
		[25] = {itemID = 41382, spellID = 55403 }; --Trenchant Earthsiege Diamond
	};
	{
		Name = AL["Prismatic Gems"];
		[1] = {itemID = 49110, spellID = 68253 }; --Nightmare Tear
		[2] = {itemID = 22459, spellID = 28028 }; --Void Sphere
		[3] = {itemID = 42702, spellID = 56531 }; --Enchanted Tear
		[4] = {itemID = 22460, spellID = 28027 }; --Prismatic Sphere
		[5] = {itemID = 42701, spellID = 56530 }; --Enchanted Pearl
		[6] = {itemID = 42701, spellID = 62941 }; --Prismatic Black Diamond
	};
	{
		Name = "Dragon's Eyes";
		[1] = {itemID = 42142, spellID = 56049 }; --Bold Dragon's Eye
		[2] = {itemID = 36766, spellID = 56054 }; --Bright Dragon's Eye
		[3] = {itemID = 42148, spellID = 56074 }; --Brilliant Dragon's Eye
		[4] = {itemID = 42143, spellID = 56052 }; --Delicate Dragon's Eye
		[5] = {itemID = 42152, spellID = 56056 }; --Flashing Dragon's Eye
		[6] = {itemID = 42153, spellID = 56076 }; --Fractured Dragon's Eye
		[7] = {itemID = 42146, spellID = 56077 }; --Lustrous Dragon's Eye
		[8] = {itemID = 42158, spellID = 56079 }; --Mystic Dragon's Eye
		[9] = {itemID = 42154, spellID = 56081 }; --Precise Dragon's Eye
		[10] = {itemID = 42150, spellID = 56083 }; --Quick Dragon's Eye
		[11] = {itemID = 42156, spellID = 56084 }; --Rigid Dragon's Eye
		[12] = {itemID = 42144, spellID = 56053 }; --Runed Dragon's Eye
		[13] = {itemID = 42149, spellID = 56085 }; --Smooth Dragon's Eye
		[14] = {itemID = 36767, spellID = 56086 }; --Solid Dragon's Eye
		[15] = {itemID = 42145, spellID = 56087 }; --Sparkling Dragon's Eye
		[16] = {itemID = 42155, spellID = 56088 }; --Stormy Dragon's Eye
		[17] = {itemID = 42151, spellID = 56055 }; --Subtle Dragon's Eye
		[18] = {itemID = 42157, spellID = 56089 }; --Thick Dragon's Eye
		[20] = {itemID = 42225 }; --Dragon's Eye
	};
	{
		Name = AL["Trinkets"];
		[1] = {itemID = 42418, spellID = 56203 }; --Figurine - Emerald Boar
		[2] = {itemID = 44063, spellID = 59759 }; --Figurine - Monarch Crab
		[3] = {itemID = 42341, spellID = 56199 }; --Figurine - Ruby Hare
		[4] = {itemID = 42413, spellID = 56202 }; --Figurine - Sapphire Owl
		[5] = {itemID = 42395, spellID = 56201 }; --Figurine - Twilight Serpent
	};
	{
		Name = AL["Rings"];
		[1] = {itemID = 42643, spellID = 56497 }; --Titanium Earthguard Ring
		[2] = {itemID = 42642, spellID = 56496 }; --Titanium Impact Band
		[3] = {itemID = 42644, spellID = 56498 }; --Titanium Spellshock Ring
		[4] = {itemID = 43582, spellID = 58954 }; --Titanium Frostguard Ring
		[5] = {itemID = 31398, spellID = 38503 }; --The Frozen Eye
		[6] = {itemID = 31399, spellID = 38504 }; --The Natural Ward
		[7] = {itemID = 34361, spellID = 46124 }; --Hard Khorium Band", "=ds=#sr# 365
		[8] = {itemID = 34362, spellID = 46122 }; --Loop of Forged Power", "=ds=#sr# 365
		[9] = {itemID = 34363, spellID = 46123 }; --Ring of Flowing Life", "=ds=#sr# 365
		[10] = {itemID = 45808, spellID = 64727 }; --Runed Mana Band
		[11] = {itemID = 45809, spellID = 64728 }; --Scarlet Signet
		[12] = {itemID = 43250, spellID = 58147 }; --Ring of Earthern Might
		[13] = {itemID = 43253, spellID = 58150 }; --Ring of Northern Tears
		[14] = {itemID = 43251, spellID = 58148 }; --Ring of Scarlet Shadows
		[15] = {itemID = 43498, spellID = 58507 }; --Savage Titanium Band
		[16] = {itemID = 43482, spellID = 58492 }; --Savage Titanium Ring
		[17] = {itemID = 43252, spellID = 58149 }; --Windfire Band
		[18] = {itemID = 42340, spellID = 56197 }; --Dream Signet
		[19] = {itemID = 43246, spellID = 58143 }; --Earthshadow Ring
		[20] = {itemID = 43247, spellID = 58144 }; --Jade Ring of Slaying
	};
	{
		Name = AL["Necks"];
		[1] = {itemID = 42646, spellID = 56500 }; --Titanium Earthguard Chain
		[2] = {itemID = 42645, spellID = 56499 }; --Titanium Impact Choker
		[3] = {itemID = 42647, spellID = 56501 }; --Titanium Spellshock Necklace
		[4] = {itemID = 34360, spellID = 46126 }; --Amulet of Flowing Life", "=ds=#sr# 365
		[5] = {itemID = 34358, spellID = 46127 }; --Hard Khorium Choker", "=ds=#sr# 365
		[6] = {itemID = 34359, spellID = 46125 }; --Pendant of Sunfire", "=ds=#sr# 365
		[7] = {itemID = 45812, spellID = 64725 }; --Emerald Choker
		[8] = {itemID = 45813, spellID = 64726 }; --Sky Sapphire Amulet
		[9] = {itemID = 42339, spellID = 56196 }; --Blood Sun Necklace
		[10] = {itemID = 42338, spellID = 56195 }; --Jade Dagger Pendant
	};
	{
		Name = AL["Miscellaneous"];
		[1] = {itemID = 24123, spellID = 31078 }; --Circlet of Arcane Might", "=ds=#sr# 370
		[2] = {itemID = 24122, spellID = 31077 }; --Coronet of the Verdant Flame", "=ds=#sr# 370
		[3] = {itemID = 44943, spellID = 62242 }; --Icy Prism
	};
};


----------------------
--- Leatherworking ---
----------------------

AtlasLoot_Data["LeatherworkingWRATH"] = {
	Name = LEATHERWORKING;
	Type = "Crafting";
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Back";
		[1] = {itemID = 43565, spellID = 60640 }; --Durable Nerubhide Cape
		[2] = {itemID = 43566, spellID = 60637 }; --Ice Striker's Cloak
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Chest";
		[1] = {itemID = 47600, spellID = 67142 }; --Knightbane Carapace
		[2] = {itemID = 47599, spellID = 67086 }; --Knightbane Carapace
		[3] = {itemID = 47602, spellID = 67084 }; --Lunar Eclipse Chestguard
		[4] = {itemID = 47601, spellID = 67140 }; --Lunar Eclipse Chestguard
		[5] = {itemID = 43590, spellID = 60996 }; --Polar Vest
		[6] = {itemID = 43434, spellID = 60703 }; --Eviscerator's Chestguard
		[7] = {itemID = 43263, spellID = 60718 }; --Overcast Chestguard
		[8] = {itemID = 43257, spellID = 60669 }; --Wildscale Breastplate
		[9] = {itemID = 38592, spellID = 51570 }; --Dark Arctic Chestpiece
		[10] = {itemID = 44441, spellID = 60613 }; --Dark Iceborne Chestguard
		[11] = {itemID = 38400, spellID = 50944 }; --Arctic Chestpiece
		[12] = {itemID = 38408, spellID = 50938 }; --Iceborne Chestguard
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Feet";
		[1] = {itemID = 49894, spellID = 70555 }; --Blessed Cenarion Boots
		[2] = {itemID = 49895, spellID = 70557 }; --Footpads of Impending Death
		[3] = {itemID = 45565, spellID = 63201 }; --Boots of Wintry Endurance
		[4] = {itemID = 45564, spellID = 63199 }; --Footpads of Silence
		[5] = {itemID = 43502, spellID = 60761 }; --Earthgiving Boots
		[6] = {itemID = 43592, spellID = 60998 }; --Polar Boots
		[7] = {itemID = 44930, spellID = 62176 }; --Windripper Boots
		[8] = {itemID = 43439, spellID = 60712 }; --Eviscerator's Treads
		[9] = {itemID = 43273, spellID = 60727 }; --Overcast Boots
		[10] = {itemID = 43256, spellID = 60666 }; --Jormscale Footpads
		[11] = {itemID = 38590, spellID = 51568 }; --Black Chitinguard Boots
		[12] = {itemID = 44442, spellID = 60620 }; --Bugsquashers
		[13] = {itemID = 38404, spellID = 50948 }; --Arctic Boots
		[14] = {itemID = 38407, spellID = 50942 }; --Iceborne Boots
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Hands";
		[1] = {itemID = 43436, spellID = 60705 }; --Eviscerator's Gauntlets
		[2] = {itemID = 43265, spellID = 60721 }; --Overcast Handwraps
		[3] = {itemID = 43255, spellID = 60665 }; --Seafoam Gauntlets
		[4] = {itemID = 38403, spellID = 50947 }; --Arctic Gloves
		[5] = {itemID = 38409, spellID = 50941 }; --Iceborne Gloves
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Head";
		[1] = {itemID = 43260, spellID = 60697 }; --Eviscerator's Facemask
		[2] = {itemID = 43261, spellID = 60715 }; --Overcast Headguard
		[3] = {itemID = 38437, spellID = 51572 }; --Arctic Helm
		[4] = {itemID = 38438, spellID = 60608 }; --Iceborne Helm
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Legs";
		[1] = {itemID = 49899, spellID = 70556 }; --Bladeborn Leggings
		[2] = {itemID = 49898, spellID = 70554 }; --Legwraps of Unleashed Nature
		[3] = {itemID = 43495, spellID = 60760 }; --Earthgiving Legguards
		[4] = {itemID = 44931, spellID = 62177 }; --Windripper Leggings
		[5] = {itemID = 43438, spellID = 60711 }; --Eviscerator's Legguards
		[6] = {itemID = 43271, spellID = 60725 }; --Overcast Leggings
		[7] = {itemID = 42731, spellID = 60660 }; --Leggings of Visceral Strikes
		[8] = {itemID = 38591, spellID = 51569 }; --Dark Arctic Leggings
		[9] = {itemID = 44440, spellID = 60611 }; --Dark Iceborne Leggings
		[10] = {itemID = 38401, spellID = 50945 }; --Arctic Leggings
		[11] = {itemID = 38410, spellID = 50939 }; --Iceborne Leggings
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Shoulder";
		[1] = {itemID = 43481, spellID = 60758 }; --Trollwoven Spaulders
		[2] = {itemID = 43433, spellID = 60702 }; --Eviscerator's Shoulderpads
		[3] = {itemID = 43262, spellID = 60716 }; --Overcast Spaulders
		[4] = {itemID = 43258, spellID = 60671 }; --Purehorn Spaulders
		[5] = {itemID = 38402, spellID = 50946 }; --Arctic Shoulderpads
		[6] = {itemID = 38411, spellID = 50940 }; --Iceborne Shoulderpads
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Waist";
		[1] = {itemID = 45556, spellID = 63200 }; --Belt of Arctic Life
		[2] = {itemID = 45555, spellID = 63198 }; --Death-warmed Belt
		[3] = {itemID = 43484, spellID = 60759 }; --Trollwoven Girdle
		[4] = {itemID = 43591, spellID = 60997 }; --Polar Cord
		[5] = {itemID = 43437, spellID = 60706 }; --Eviscerator's Waistguard
		[6] = {itemID = 43266, spellID = 60723 }; --Overcast Belt
		[7] = {itemID = 38405, spellID = 50949 }; --Arctic Belt
		[8] = {itemID = 38406, spellID = 50943 }; --Iceborne Belt
	};
	{
		Name = AL["Leather Armor"] .. WHITE .. " - Wrist";
		[1] = {itemID = 47581, spellID = 67087 }; --Bracers of Swift Death
		[2] = {itemID = 47582, spellID = 67139 }; --Bracers of Swift Death
		[3] = {itemID = 47583, spellID = 67085 }; --Moonshadow Armguards
		[4] = {itemID = 47584, spellID = 67141 }; --Moonshadow Armguards
		[5] = {itemID = 43435, spellID = 60704 }; --Eviscerator's Bindings
		[6] = {itemID = 38434, spellID = 60607 }; --Iceborne Wristguards
		[7] = {itemID = 43264, spellID = 60720 }; --Overcast Bracers
		[8] = {itemID = 38433, spellID = 51571 }; --Arctic Wristguards
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Chest";
		[1] = {itemID = 47596, spellID = 67138 }; --Crusader's Dragonscale Breastplate
		[2] = {itemID = 47595, spellID = 67082 }; --Crusader's Dragonscale Breastplate
		[3] = {itemID = 47597, spellID = 67080 }; --Ensorcelled Nerubian Breastplate
		[4] = {itemID = 47598, spellID = 67136 }; --Ensorcelled Nerubian Breastplate
		[5] = {itemID = 43461, spellID = 60756 }; --Revenant's Breastplate
		[6] = {itemID = 43593, spellID = 60999 }; --Icy Scale Chestguard
		[7] = {itemID = 43445, spellID = 60730 }; --Swiftarrow Hauberk
		[8] = {itemID = 43453, spellID = 60747 }; --Stormhide Hauberk
		[9] = {itemID = 43129, spellID = 60649 }; --Razorstrike Breastplate
		[10] = {itemID = 44437, spellID = 60604 }; --Dark Frostscale Breastplate
		[11] = {itemID = 44444, spellID = 60629 }; --Dark Nerubian Chestpiece
		[12] = {itemID = 38414, spellID = 50950 }; --Frostscale Chestguard
		[13] = {itemID = 38420, spellID = 50956 }; --Nerubian Chestguard
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Feet";
		[1] = {itemID = 49896, spellID = 70559 }; --Earthsoul Boots
		[2] = {itemID = 49897, spellID = 70561 }; --Rock-Steady Treads
		[3] = {itemID = 45562, spellID = 63195 }; --Boots of Living Scale
		[4] = {itemID = 45563, spellID = 63197 }; --Lightning Grounded Boots
		[5] = {itemID = 43595, spellID = 61002 }; --Icy Scale Boots
		[6] = {itemID = 43443, spellID = 60737 }; --Swiftarrow Boots
		[7] = {itemID = 43451, spellID = 60752 }; --Stormhide Stompers
		[8] = {itemID = 43469, spellID = 60757 }; --Revenant's Treads
		[9] = {itemID = 44438, spellID = 60605 }; --Dragonstompers
		[10] = {itemID = 44445, spellID = 60630 }; --Scaled Icewalkers
		[11] = {itemID = 38413, spellID = 50954 }; --Frostscale Boots
		[12] = {itemID = 38419, spellID = 50960 }; --Nerubian Boots
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Hands";
		[1] = {itemID = 43446, spellID = 60732 }; --Swiftarrow Gauntlets
		[2] = {itemID = 43454, spellID = 60749 }; --Stormhide Grips
		[3] = {itemID = 38415, spellID = 50953 }; --Frostscale Gloves
		[4] = {itemID = 38421, spellID = 50959 }; --Nerubian Gloves

	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Head";
		[1] = {itemID = 43447, spellID = 60728 }; --Swiftarrow Helm
		[2] = {itemID = 43455, spellID = 60743 }; --Stormhide Crown
		[3] = {itemID = 43132, spellID = 60655 }; --Nightshock Hood
		[4] = {itemID = 38440, spellID = 60600 }; --Frostscale Helm
		[5] = {itemID = 38439, spellID = 60624 }; --Nerubian Helm
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Legs";
		[1] = {itemID = 49901, spellID = 70560 }; --Draconic Bonesplinter Legguards
		[2] = {itemID = 49900, spellID = 70558 }; --Lightning-Infused Leggings
		[3] = {itemID = 43458, spellID = 60754 }; --Giantmaim Legguards
		[4] = {itemID = 43448, spellID = 60735 }; --Swiftarrow Leggings
		[5] = {itemID = 43456, spellID = 60751 }; --Stormhide Legguards
		[6] = {itemID = 44436, spellID = 60601 }; --Dark Frostscale Leggings
		[7] = {itemID = 44443, spellID = 60627 }; --Dark Nerubian Leggings
		[8] = {itemID = 38416, spellID = 50951 }; --Frostscale Leggings
		[9] = {itemID = 38422, spellID = 50957 }; --Nerubian Legguards
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Shoulder";
		[1] = {itemID = 43449, spellID = 60729 }; --Swiftarrow Shoulderguards
		[2] = {itemID = 43457, spellID = 60746 }; --Stormhide Shoulders
		[3] = {itemID = 43130, spellID = 60651 }; --Virulent Spaulders
		[4] = {itemID = 38424, spellID = 50952 }; --Frostscale Shoulders
		[5] = {itemID = 38417, spellID = 50958 }; --Nerubian Shoulders
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Waist";
		[1] = {itemID = 45553, spellID = 63194 }; --Belt of Dragons
		[2] = {itemID = 45554, spellID = 63196 }; --Blue Belt of Chaos
		[3] = {itemID = 43594, spellID = 61000 }; --Icy Scale Belt
		[4] = {itemID = 43442, spellID = 60734 }; --Swiftarrow Belt
		[5] = {itemID = 43450, spellID = 60750 }; --Stormhide Belt
		[6] = {itemID = 43133, spellID = 60658 }; --Nightshock Girdle
		[7] = {itemID = 38412, spellID = 50955 }; --Frostscale Belt
		[8] = {itemID = 38418, spellID = 50961 }; --Nerubian Belt
	};
	{
		Name = AL["Mail Armor"] .. WHITE .. " - Wrist";
		[1] = {itemID = 47580, spellID = 67137 }; --Black Chitin Bracers
		[2] = {itemID = 47579, spellID = 67081 }; --Black Chitin Bracers
		[3] = {itemID = 47576, spellID = 67083 }; --Crusader's Dragonscale Bracers
		[4] = {itemID = 47577, spellID = 67143 }; --Crusader's Dragonscale Bracers
		[5] = {itemID = 43459, spellID = 60755 }; --Giantmaim Bracers
		[6] = {itemID = 43444, spellID = 60731 }; --Swiftarrow Bracers
		[7] = {itemID = 43452, spellID = 60748 }; --Stormhide Wristguards
		[8] = {itemID = 43131, spellID = 60652 }; --Eaglebane Bracers
		[9] = {itemID = 38436, spellID = 60599 }; --Frostscale Bracers
		[10] = {itemID = 38435, spellID = 60622 }; --Nerubian Bracers
	};
	{
		Name = AL["Item Enhancements"];
		[1] = {itemID = 44963, spellID = 62448 }; --Earthen Leg Armor
		[2] = {itemID = 38373, spellID = 50965 }; --Frosthide Leg Armor
		[3] = {itemID = 38374, spellID = 50967 }; --Icescale Leg Armor
		[4] = {itemID = 29536, spellID = 35557 }; --Nethercleft Leg Armor", "=ds=#sr# 365
		[5] = {itemID = 29535, spellID = 35554 }; --Nethercobra Leg Armor", "=ds=#sr# 365
		[6] = {itemID = 38371, spellID = 50964 }; --Jormungar Leg Armor
		[7] = {itemID = 38372, spellID = 50966 }; --Nerubian Leg Armor
		[8] = {itemID = 29534, spellID = 35555 }; --Clefthide Leg Armor
		[9] = {itemID = 29533, spellID = 35549 }; --Cobrahide Leg Armor
		[10] = {itemID = 18251, spellID = 22727 }; --Core Armor Kit", "=ds=#sr# 300
		[11] = {itemID = 38376, spellID = 50963 }; --Heavy Borean Armor Kit
		[16] = {spellID = 57683, icon = "Trade_LeatherWorking" }; --Fur Lining - Attack Power
		[17] = {spellID = 57701, icon = "Trade_LeatherWorking" }; --Fur Lining - Arcane Resist
		[18] = {spellID = 57692, icon = "Trade_LeatherWorking" }; --Fur Lining - Fire Resist
		[19] = {spellID = 57694, icon = "Trade_LeatherWorking" }; --Fur Lining - Frost Resist
		[20] = {spellID = 57699, icon = "Trade_LeatherWorking" }; --Fur Lining - Nature Resist
		[21] = {spellID = 57696, icon = "Trade_LeatherWorking" }; --Fur Lining - Shadow Resist
		[22] = {spellID = 57691, icon = "Trade_LeatherWorking" }; --Fur Lining - Spell Power
		[23] = {spellID = 57690, icon = "Trade_LeatherWorking" }; --Fur Lining - Stamina
		[24] = {spellID = 60583, icon = "Trade_LeatherWorking" }; --Jormungar Leg Reinforcements
		[25] = {spellID = 60584, icon = "Trade_LeatherWorking" }; --Nerubian Leg Reinforcements
	};
	{
		Name = AL["Quivers and Ammo Pouches"];
		[1] = {itemID = 44447, spellID = 60645 }; --Dragonscale Ammo Pouch
		[2] = {itemID = 44448, spellID = 60647 }; --Nerubian Reinforced Quiver
	};
	{
		Name = AL["Drums, Bags and Misc."];
		[1] = {itemID = 44446, spellID = 60643 }; --Pack of Endless Pockets
		[2] = {itemID = 38399, spellID = 50970 }; --Trapper's Traveling Pack
		[3] = {itemID = 38347, spellID = 50971 }; --Mammoth Mining Bag
		[4] = {itemID = 49633, spellID = 69386 }; --Drums of Forgotten Kings
		[5] = {itemID = 49634, spellID = 69388 }; --Drums of the Wild

	};
	{
		Name = BabbleInventory["Leather"];
		[1] = {itemID = 38425, spellID = 50936 }; --Heavy Borean Leather
		[2] = {itemID = 33568, spellID = 64661 }; --Borean Leather
	};
};


AtlasLoot_Data["MiningWRATH"] = {
	Name = MINING;
	{
		Name = MINING;
		[1] = {itemID = 37663, spellID = 55208 }; --Smelt Titansteel
		[2] = {itemID = 41163, spellID = 55211 }; --Smelt Titanium
		[3] = {itemID = 36913, spellID = 49258 }; --Smelt Saronite
		[4] = {itemID = 36916, spellID = 49252 }; --Smelt Cobalt
	};
};

AtlasLoot_Data["FirstAidWRATH"] = {
	Name = FIRSTAID;
	{
		Name = FIRSTAID;
		[1] = {itemID = 34722, spellID = 45546 }; --Heavy Frostweave Bandage
		[2] = {itemID = 34721, spellID = 45545 }; --Frostweave Bandage
	};
};
-----------------
--- Tailoring ---
-----------------

AtlasLoot_Data["TailoringWRATH"] = {
	Name = TAILORING;
	Type = "Crafting";
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Back";
		[1] = {itemID = 41610, spellID = 56017 }; --Deathchill Cloak
		[2] = {itemID = 41609, spellID = 56016 }; --Wispcloak
		[3] = {itemID = 45810, spellID = 64730 }; --Cloak of Crimson Snow
		[4] = {itemID = 45811, spellID = 64729 }; --Frostguard Drape
		[5] = {itemID = 41608, spellID = 56015 }; --Cloak of Frozen Spirits
		[6] = {itemID = 41607, spellID = 56014 }; --Cloak of the Moon
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Chest";
		[1] = {itemID = 47603, spellID = 67066 }; --Merlin's Robe
		[2] = {itemID = 47604, spellID = 67146 }; --Merlin's Robe
		[3] = {itemID = 47605, spellID = 67064 }; --Royal Moonshroud Robe
		[4] = {itemID = 47606, spellID = 67144 }; --Royal Moonshroud Robe
		[5] = {itemID = 42101, spellID = 56026 }; --Ebonweave Robe
		[6] = {itemID = 42100, spellID = 56024 }; --Moonshroud Robe
		[7] = {itemID = 42102, spellID = 56028 }; --Spellweave Robe
		[8] = {itemID = 43583, spellID = 60993 }; --Glacial Robe
		[9] = {itemID = 43972, spellID = 59587 }; --Frostsavage Robe
		[10] = {itemID = 41554, spellID = 55941 }; --Black Duskweave Robe
		[11] = {itemID = 41525, spellID = 55911 }; --Mystic Frostwoven Robe
		[12] = {itemID = 41549, spellID = 55921 }; --Duskweave Robe
		[13] = {itemID = 41515, spellID = 55903 }; --Frostwoven Robe
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Feet";
		[1] = {itemID = 49890, spellID = 70551 }; --Deathfrost Boots
		[2] = {itemID = 49893, spellID = 70553 }; --Sandals of Consecration
		[3] = {itemID = 45567, spellID = 63206 }; --Savior's Slippers
		[4] = {itemID = 45566, spellID = 63204 }; --Spellslinger's Slippers
		[5] = {itemID = 43585, spellID = 60994 }; --Glacial Slippers
		[6] = {itemID = 42096, spellID = 56023 }; --Aurora Slippers
		[7] = {itemID = 43970, spellID = 59585 }; --Frostsavage Boots
		[8] = {itemID = 41544, spellID = 55924 }; --Duskweave Boots
		[9] = {itemID = 41520, spellID = 55906 }; --Frostwoven Boots
		[10] = {itemID = 41985, spellID = 56019 }; --Silky Iceshard Boots

	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Hands";
		[1] = {itemID = 42111, spellID = 56027 }; --Ebonweave Gloves
		[2] = {itemID = 42103, spellID = 56025 }; --Moonshroud Gloves
		[3] = {itemID = 42113, spellID = 56029 }; --Spellweave Gloves
		[4] = {itemID = 41516, spellID = 59586 }; --Frostsavage Gloves
		[5] = {itemID = 42095, spellID = 56022 }; --Light Blessed Mittens
		[6] = {itemID = 41545, spellID = 55922 }; --Duskweave Gloves
		[7] = {itemID = 44211, spellID = 55904 }; --Frostwoven Gloves
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Head";
		[1] = {itemID = 41984, spellID = 56018 }; --Hat of Wintry Doom
		[2] = {itemID = 43971, spellID = 59589 }; --Frostsavage Cowl
		[3] = {itemID = 41546, spellID = 55919 }; --Duskweave Cowl
		[4] = {itemID = 41521, spellID = 55907 }; --Frostwoven Cowl
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Legs";
		[1] = {itemID = 49891, spellID = 70550 }; --Leggings of Woven Death
		[2] = {itemID = 49892, spellID = 70552 }; --Lightweave Leggings
		[3] = {itemID = 42093, spellID = 56021 }; --Frostmoon Pants
		[4] = {itemID = 43975, spellID = 59588 }; --Frostsavage Leggings
		[5] = {itemID = 41553, spellID = 55925 }; --Black Duskweave Leggings
		[6] = {itemID = 41548, spellID = 55901 }; --Duskweave Leggings
		[7] = {itemID = 41519, spellID = 56030 }; --Frostwoven Leggings
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Shoulder";
		[1] = {itemID = 43973, spellID = 59584 }; --Frostsavage Shoulders
		[2] = {itemID = 41523, spellID = 55910 }; --Mystic Frostwoven Shoulders
		[3] = {itemID = 41550, spellID = 55923 }; --Duskweave Shoulders
		[4] = {itemID = 41513, spellID = 55902 }; --Frostwoven Shoulders
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Waist";
		[1] = {itemID = 45558, spellID = 63205 }; --Cord of the White Dawn
		[2] = {itemID = 45557, spellID = 63203 }; --Sash of Ancient Power
		[3] = {itemID = 43584, spellID = 60990 }; --Glacial Waistband
		[4] = {itemID = 41986, spellID = 56020 }; --Deep Frozen Cord
		[5] = {itemID = 43969, spellID = 59582 }; --Frostsavage Belt
		[6] = {itemID = 41543, spellID = 55914 }; --Duskweave Belt
		[7] = {itemID = 41522, spellID = 55908 }; --Frostwoven Belt
	};
	{
		Name = AL["Cloth Armor"] .. WHITE .. " - Wrist";
		[1] = {itemID = 47586, spellID = 67145 }; --Bejeweled Wizard's Bracers
		[2] = {itemID = 47585, spellID = 67079 }; --Bejeweled Wizard's Bracers
		[3] = {itemID = 47587, spellID = 67065 }; --Royal Moonshroud Bracers" ..", " .. BabbleZone["Trial of the Crusader"]
		[4] = {itemID = 47588, spellID = 67147 }; --Royal Moonshroud Bracers" ..", " .. BabbleZone["Trial of the Crusader"]
		[5] = {itemID = 41555, spellID = 55943 }; --Black Duskweave Wristwraps
		[6] = {itemID = 43974, spellID = 59583 }; --Frostsavage Bracers
		[7] = {itemID = 41528, spellID = 55913 }; --Mystic Frostwoven Wriststraps
		[8] = {itemID = 41551, spellID = 55920 }; --Duskweave Wriststraps
		[9] = {itemID = 41512, spellID = 56031 }; --Frostwoven Wriststraps
	};
	{
		Name = AL["Bags"];
		[1] = {itemID = 41600, spellID = 56005 }; --Glacial Bag
		[2] = {itemID = 41598, spellID = 56006 }; --Mysterious Bag
		[3] = {itemID = 41597, spellID = 56004 }; --Abyssal Bag
		[4] = {itemID = 45773, spellID = 63924 }; --Emerald Bag
	};
	{
		Name = AL["Item Enhancements"];
		[1] = {itemID = 41602, spellID = 56009 }; --Brilliant Spellthread
		[2] = {itemID = 41604, spellID = 56011 }; --Sapphire Spellthread
		[3] = {itemID = 41603, spellID = 56010 }; --Azure Spellthread
		[4] = {itemID = 41601, spellID = 56008 }; --Shining Spellthread
		[16] = {spellID = 56034, icon = "Spell_Nature_AstralRecalGroup" }; --Master's Spellthread
		[17] = {spellID = 56039, icon = "Spell_Nature_AstralRecalGroup" }; --Sanctified Spellthread
		[19] = {spellID = 55769, icon = "INV_Misc_Thread_01" }; --Darkglow Embroidery
		[20] = {spellID = 55642, icon = "INV_Misc_Thread_01" }; --Lightweave Embroidery
		[21] = {spellID = 55777, icon = "INV_Misc_Thread_01" }; --Swordguard Embroidery
	};
	{
		Name = "Cloth/" .. AL["Miscellaneous"];
		[1] = {itemID = 41593, spellID = 56002 }; --Ebonweave
		[2] = {itemID = 41594, spellID = 56001 }; --Moonshroud
		[3] = {itemID = 41595, spellID = 56003 }; --Spellweave
		[4] = {itemID = 41511, spellID = 55900 }; --Bolt of Imbued Frostweave
		[5] = {itemID = 41510, spellID = 55899 }; --Bolt of Frostweave
		[7] = {itemID = 54797, spellID = 75597 }; --Frosty Flying Carpet
		[8] = {itemID = 44558, spellID = 60971 }; --Magnificent Flying Carpet
		[10] = {itemID = 41509, spellID = 55898 }; --Frostweave Net
	};
	{
		Name = AL["Shirts"];
		[1] = {itemID = 41249, spellID = 55994 }; --Blue Lumberjack Shirt
		[2] = {itemID = 41253, spellID = 55998 }; --Blue Workman's Shirt
		[3] = {itemID = 41250, spellID = 55996 }; --Green Lumberjack Shirt
		[4] = {itemID = 41255, spellID = 56000 }; --Green Workman's Shirt
		[5] = {itemID = 41248, spellID = 55993 }; --Red Lumberjack Shirt
		[6] = {itemID = 41252, spellID = 55997 }; --Red Workman's Shirt
		[7] = {itemID = 41254, spellID = 55999 }; --Rustic Workman's Shirt
		[8] = {itemID = 41251, spellID = 55995 }; --Yellow Lumberjack Shirt
		[9] = {itemID = 10034, spellID = 12085 }; --Tuxedo Shirt
		[10] = {itemID = 10055, spellID = 12080 }; --Pink Mageweave Shirt
		[11] = {itemID = 10054, spellID = 12075 }; --Lavender Mageweave Shirt
		[12] = {itemID = 10052, spellID = 12064 }; --Orange Martial Shirt
		[13] = {itemID = 10056, spellID = 12061 }; --Orange Mageweave Shirt
		[14] = {itemID = 4336, spellID = 3873 }; --Black Swashbuckler's Shirt
		[15] = {itemID = 17723, spellID = 21945 }; --Green Holiday Shirt
		[16] = {itemID = 4335, spellID = 3872 }; --Rich Purple Silk Shirt
		[17] = {itemID = 6796, spellID = 8489 }; --Red Swashbuckler's Shirt
		[18] = {itemID = 4334, spellID = 3871 }; --Formal White Shirt
		[19] = {itemID = 6795, spellID = 8483 }; --White Swashbuckler's Shirt
		[20] = {itemID = 4333, spellID = 3870 }; --Dark Silk Shirt
		[21] = {itemID = 4332, spellID = 3869 }; --Bright Yellow Shirt
		[22] = {itemID = 6384, spellID = 7892 }; --Stylish Blue Shirt
		[23] = {itemID = 6385, spellID = 7893 }; --Stylish Green Shirt
		[24] = {itemID = 4330, spellID = 3866 }; --Stylish Red Shirt
		[25] = {itemID = 2587, spellID = 2406 }; --Gray Woolen Shirt
		[26] = {itemID = 2579, spellID = 2396 }; --Green Linen Shirt
		[27] = {itemID = 2577, spellID = 2394 }; --Blue Linen Shirt
		[28] = {itemID = 2575, spellID = 2392 }; --Red Linen Shirt
		[29] = {itemID = 2576, spellID = 2393 }; --White Linen Shirt
		[30] = {itemID = 4344, spellID = 3915 }; --Brown Linen Shirt
	};
};
