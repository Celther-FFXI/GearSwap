function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal','DualWield')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 276
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back=gear.cape_geo_indi,}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +1"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
    head="Amalric Coif",
	neck="Voltsurge Torque",
    body="Shango Robe",
	legs="Geomancy Pants",
    feet=gear.merlinic_burst_feet,
    left_ear="Etiolation Earring",
	left_ring="Weatherspoon Ring",
    right_ring="Kishar Ring",
    back="Swith Cape",}
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {legs="Amalric Slops",hands="Bagua Mitaines +1"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",body="Vanya Robe"})
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",}
	sets.Self_Refresh = {}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {}
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +1"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.Geomancy = {main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Azimuth Coat +1",
    hands="Azimuth Gloves +1",
    legs="Azimuth Tights +1",
    feet="Azimuth Gaiters +1",
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Mendi. Earring",
    right_ear="Lempo Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Thaumaturge's Cape",}


	--Extra Indi duration on any slot you can't get skill on here.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {legs="Bagua Pants +1",back=gear.cape_geo_indi,})
		
    sets.midcast.Cure = {"Serenity",
    sub="Niobid Strap",
    range="Dunna",
    head="Vanya Hood",
    body="Vanya Robe",
    hands="Bagua Mitaines +1",
    legs="Assid. Pants +1",
    feet="Medium's Sabots",
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi",
    left_ear="Mendi. Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Twilight Cape",}
		
    sets.midcast.LightWeatherCure = {"Serenity",
    sub="Niobid Strap",
    range="Dunna",
    head="Vanya Hood",
    body="Vanya Robe",
    hands="Bagua Mitaines +1",
    legs="Assid. Pants +1",
    feet="Medium's Sabots",
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi",
    left_ear="Mendi. Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Twilight Cape",}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Serenity",
	sub="Curatio Grip",
	ammo="Hasty Pinion +1",
    head="Nahtirah Hat",
	neck="Phalaina Locket",
	ear1="Gifted Earring",
	ear2="Etiolation Earring",
    body="Vanir Cotehardie",
	hands="Telchine Gloves",
	ring1="Sirona's Ring",
	ring2="Lebeche Ring",
    back="Twilight Cape",
	waist="Hachirin-no-Obi",
	legs="Geo. Pants +1",
	feet="Regal Pumps +1"}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
    -- sets.midcast['Elemental Magic'] = {
    -- main=gear.grioavolr_enbfeeble,
    -- sub="Niobid Strap",
    -- ammo="Pemphredo Tathlum",
    -- head=gear.merlinic_burst_head,
    -- body="Jhakri Robe +1",
    -- hands="Amalric Gages",
    -- legs=gear.merlinic_burst_legs,
    -- feet=gear.merlinic_burst_feet,
    -- neck="Mizu. Kubikazari",
    -- waist="Eschan Stone",
    -- left_ear="Novio Earring",
    -- right_ear="Friomisi Earring",
    -- left_ring="Mujin Band",
    -- right_ring="Locus Ring",
    -- back="Seshaw Cape"}

    sets.midcast['Elemental Magic'] = {
    main=gear.grioavolr_enbfeeble,
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Mallquis Chapeau +1",
    body="Jhakri Robe +1",
    hands="Mallquis Cuffs +1",
    legs="Mallquis Trews +1",
    feet="Mallquis Clogs +1",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Novio Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring",
    right_ring="Acumen Ring",
    back="Toro Cape"}

    sets.midcast['Elemental Magic'].Resistant = {}
		
    sets.midcast['Elemental Magic'].Fodder = {}

	sets.midcast['Elemental Magic'].HighTierNuke = {
    main=gear.grioavolr_enbfeeble,
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +1",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs=gear.merlinic_burst_legs,
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Novio Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring",
    right_ring="Acumen Ring",
    back="Toro Cape"}
	
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
    sets.midcast['Dark Magic'] = {}
		
    sets.midcast.Drain = {
    main="Rubicundity",
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Merlinic Jubbah",
    hands=gear.merlinic_aspir_hands,
    legs=gear.merlinic_aspir_legs,
    feet=gear.merlinic_aspir_feet,
    neck="Erra Pendant",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Etoioation Earring",
    left_ring="Evanescence Ring",
    right_ring="Archon Ring",
    back="Perimede Cape"}
    
    sets.midcast.Aspir = set_combine (sets.midcast.Drain,{})
		
	sets.midcast.Stun = {}
		
	sets.midcast.Stun.Resistant = {}

		
	sets.midcast.Impact = {}
		
	sets.midcast['Enfeebling Magic'] = {
    main="Oranyan",
	sub="Mephitis Grip",
    ammo="Pemphredo Tathlum",
    head="Amalric Coif",
    body="Vanya Robe",
    hands="Azimuth Gloves +1",
    legs="Psycloth Lappas",	
    feet="Medium's Sabots",
    neck="Imbodla Necklace",
    waist="Luminary Sash",
    left_ear="Enchanter Earring +1",
    right_ear="Dignitary's Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back="Lifestream Cape"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {
    main="Oranyan",
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head="Amalric Coif",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Jhakri Slops +1",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Hermetic Earring",
    right_ear="Dignitary's Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back=gear.cape_geo_indi,}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring1="Stikini Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring1="Stikini Ring"})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring"})
		
	sets.midcast['Enhancing Magic'] = {}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})

	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}
	sets.IceNuke = {main="Ngqoqwanb"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	-- Idle sets

	sets.idle = {
    main="Idris",
    sub="Genmei Shield",
	range="Dunna",
    head="Azimuth Hood +1",
    body="Jhakri Robe +1",
    hands="Bagua Mitaines +1",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +1",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    right_ear="Etiolation Earring",
    left_ear="Mendi. Earring",
    left_ring="Defending Ring",
    right_ring="Dark Ring",	
    back=gear.cape_geo_regen,}
		
	sets.idle.PDT = {
    main="Idris",
    sub="Genmei Shield",
    ammo="Staunch Tathlum",
    head="Azimuth Hood +1",
    body="Mallquis Saio +1",
    hands="Geo. Mitaines +1",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +1",
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring=gear.dark_ring,
    back="Moonbeam Cape"}
		
	sets.idle.TPEat = set_combine(sets.idle, {})
	sets.idle.Regain = set_combine(sets.idle, {})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = set_combine(sets.idle, {range="Dunna",hands="Geomancy Mitaines +1",feet="Bagua Sandals +1",back=gear.cape_geo_regen,head="Azimuth Hood +1",})

	

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Weak = {}

	-- Defense sets
	
	sets.defense.PDT = {}

	sets.defense.MDT = {}
		
    sets.defense.MEVA = {}
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Geomancy Sandals +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {feet="Serpentes Sabots"}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {}
		
	sets.engaged.DualWield = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
    head=gear.merlinic_burst_head,
    hands="Amalric Gages",
    legs=gear.merlinic_burst_legs,
    feet=gear.merlinic_burst_feet,
    neck="Mizu. Kubikazari",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Seshaw Cape"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 2)
end