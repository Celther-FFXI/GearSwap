function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'TPEat', 'Regain', 'DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +1"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Estq. Earring",ear2="Enchntr. Earring +1",
		body="Viti. Tabard +1",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet=gear.merlinic_aspir_feet}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Hasty Pinion +1",
		head="Taeon Chapeau",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Vanya Robe",hands="Taeon Gloves",ring1="Rajas Ring",ring2="Oneiros Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Taeon Tights",feet="Battlecast Gaiters"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Sucellos's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	
	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +1"}
	
	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}
	sets.IceNuke = {main="Ngqoqwanb"}

	sets.midcast.FastRecast = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Estq. Earring",ear2="Enchntr. Earring +1",
		body="Viti. Tabard +1",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Haoma's Ring",ring2="Sirona's Ring",
        back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Haoma's Ring",ring2="Sirona's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Haoma's Ring",ring2="Sirona's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Haoma's Ring",back="Tempered Cape +1",waist="Witful Belt",feet="Gende. Galosh. +1"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_nuke_staff,sub="Clemency Grip"})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] = {main=gear.grioavolr_enhance_staff,sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Atrophy Gloves +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Leth. Houseaux +1"}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast['Enfeebling Magic'] = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Lethargy Sayon +1",hands="Leth. Gantherots +1",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Vanya Robe",hands="Leth. Gantherots +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Luminary Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1",waist="Chaac Belt",feet=gear.chironic_treasure_feet})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1",waist="Chaac Belt",feet=gear.chironic_treasure_feet})

	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Viti. Chapeau +1"})
	
    sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Sucellos's Cape",waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Sucellos's Cape",waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Elemental Magic'].Fodder = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Sucellos's Cape",waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast['Elemental Magic'].Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Helios Jacket",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap",ammo="Pemphredo Tathlum"})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Niobid Strap",ammo="Pemphredo Tathlum"})
		
	sets.midcast.Impact = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Twilight Cloak",hands="Leth. Gantherots +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Luminary Sash",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Vanya Robe",hands="Leth. Gantherots +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Luminary Sash",legs="Psycloth Lappas",feet=gear.merlinic_nuke_feet}

    sets.midcast.Drain = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Merlinic Jubbah",hands=gear.chironic_enfeeble_hands,ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Estq. Earring",ear2="Enchntr. Earring +1",
		body="Viti. Tabard +1",hands="Gende. Gages +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Witful Belt",legs="Psycloth Lappas",feet=gear.merlinic_aspir_feet}
		
	sets.midcast.Stun.Resistant = {main="Serenity",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
		body="Viti. Tabard +1",hands="Gende. Gages +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Sucellos's Cape",waist="Acuity Belt +1",legs="Psycloth Lappas",feet=gear.merlinic_aspir_feet}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	-- Sets for special buff conditions on spells.
		
	sets.buff.ComposureOther = {head="Leth. Chappel +1",
		body="Lethargy Sayon +1",hands="Leth. Gantherots +1",
		legs="Leth. Fuseau +1",feet="Leth. Houseaux +1"}

	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main="Bolelabunga",sub="Genmei Shield",ammo="Impatiens",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet=gear.chironic_refresh_feet}
	

	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet=gear.chironic_refresh_feet}
		
	sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",ammo="Impatiens",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}
		
	sets.idle.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Impatiens",
		head="Viti. Chapeau +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}
		
	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Jhakri Robe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet=gear.chironic_refresh_feet}
	
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {back="Umbra Cape",legs="Carmine Cuisses +1",feet="Hippo. Socks +1"})
	
	-- Defense sets
	sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Impatiens",
		head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Impatiens",
		head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}
		
    sets.defense.MEVA = {main="Terra's Staff",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Sucellos's Cape",waist="Luminary Sash",legs="Leth. Fuseau +1",feet="Telchine Pigaches"}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {ring2="Karieyh Ring"})

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Ginsen",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Vanya Robe",hands="Taeon Gloves",ring1="Raja's Ring",ring2="Oneiros Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Taeon Tights",feet="Battlecast Gaiters"}
		
	sets.engaged.PhysicalDef = {ammo="Ginsen",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.MagicalDef = {ammo="Ginsen",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(3, 8)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 8)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 8)
	else
		set_macro_page(3, 8)
	end
end