-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT', 'Refresh', 'Regen', 'Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP', 'Twilight'}
	
    update_combat_form()

    select_default_macro_book()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Ptero. Fin. G. +1"}
	sets.precast.JA.Jump = {ammo="Hagneia Stone",
		head="Flam. Zucchetto +1",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Tripuido Earring",
		body="Vishap Mail",hands="Vish. Fin. Gaunt",ring1="Rajas Ring",ring2="Meridian Ring",
		back="Atheling Mantle",waist="Olseni Belt",legs="Xaddi Cuisses",feet="Cizin Greaves"}
	sets.precast.JA['Ancient Circle'] = {} --legs="Vishap Brais"
	sets.precast.JA['High Jump'] = {ammo="Hagneia Stone",
		head="Flam. Zucchetto +1",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Tripuido Earring",
		body="Vishap Mail",hands="Vish. Fin. Gaunt",ring1="Rajas Ring",ring2="Meridian Ring",
		back="Atheling Mantle",waist="Olseni Belt",legs="Xaddi Cuisses",feet="Cizin Greaves"}
	sets.precast.JA['Soul Jump'] = {ammo="Hagneia Stone",
		head="Flam. Zucchetto +1",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Tripuido Earring",
		body="Lncr. Plackart +2",hands="Xaddi Gauntlets",ring1="Rajas Ring",ring2="Meridian Ring",
		back="Atheling Mantle",waist="Olseni Belt",legs="Lncr. Cuissots +2",feet="Cizin Greaves"}
	sets.precast.JA['Spirit Jump'] = {ammo="Hagneia Stone",
		head="Flam. Zucchetto +1",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Tripuido Earring",
		body="Lncr. Plackart +2",hands="Xaddi Gauntlets",ring1="Rajas Ring",ring2="Meridian Ring",
		back="Atheling Mantle",waist="Olseni Belt",legs="Lncr. Cuissots +2",feet="Lncr. Schynbld. +2"}
	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {head="Vishap Armet",hands="Lnc. Vmbrc. +2"}
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +1"}
	sets.precast.JA['Deep Breathing'] = {hands="Ptero. Armet +1"}
	sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +1"}

	
	-- Healing Breath sets
	sets.HealingBreath = {ammo="Hagneia Stone",
		head="Ptero. Armet +1",neck="Lancer's Torque",
		back="Merciful Cape",waist="Glassblower's Belt",legs="Drachen Brais"}
		
	sets.SmitingBreath = {ammo="Hagneia Stone",
		head="Ptero. Armet +1",neck="Lancer's Torque",
		back="Bleating Mantle",waist="Glassblower's Belt",legs="Drachen Brais"}
		
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Flam. Zucchetto +1",
		body="Ptero. Mail +1",hands="Ptero. Fin. G. +1",
		legs="Cizin Breeches",feet="Gor. Sollerets +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap Armet +1" })
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {head="Vishap Armet +1", neck="Voltsurge Torque", ear2="Loquacious Earring"}
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Vishap Armet",
		body="Ptero. Mail +1",hands="Ptero. Fin. G. +1",
		legs="Cizin Breeches",feet="Gor. Sollerets +1"}	
		
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Flam. Zucchetto +1",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Ptero. Mail +1",hands="Xaddi Gauntlets",ring1="Rajas Ring",ring2="Meridian Ring",
		back="Atheling Mantle",waist="Fotia Belt",legs="Xaddi Cuisses",feet="Gor. Sollerets +1"}
		
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {ammo="Hasty Pinion +1",body="Acro Surcoat"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Hasty Pinion +1",body="Acro Surcoat",hands="Xaddi Gauntlets"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Stardiver'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {legs="Lncr. Cuissots +2"})
	sets.precast.WS['Drakesbane'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].Fodder = set_combine(sets.precast.WS.Fodder, {legs="Lncr. Cuissots +2"})


	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets
	
	sets.idle = {
		head="Flam. Zucchetto +1",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Ares' cuirass +1",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Blood Cuisses",feet="Ejekamal Boots"}

	sets.idle.Weak = {
		head="Twilight Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
		
	sets.idle.Reraise = {
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Hagneia Stone",
		head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}

	sets.defense.Reraise = {
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Engulfer Cape",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
		
	sets.defense.MEVA = {
		head="Gavialis Helm",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Ethereal Earring",
		body="Emet Harness +1",hands="Regimen Mittens",ring1="Vengeful Ring",ring2="Purity Ring",
		back="Toro Cape",waist="Flume Belt",legs="Acro Breeches",feet="Ostro Greaves"}

	sets.Kiting = {legs="Blood Cuisses"}
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Weapons = {}
    sets.Knockback = {}
    sets.MP = {ear2="Ethereal Earring",waist="Flume Belt"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

		-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {}
    sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
    sets.engaged.FullAcc = {}
    sets.engaged.Fodder = {}

    sets.engaged.AM = {}
    sets.engaged.AM.SomeAcc = {}
	sets.engaged.AM.Acc = {}
    sets.engaged.AM.FullAcc = {}
    sets.engaged.AM.Fodder = {}
	
    sets.engaged.PDT = {}
    sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
    sets.engaged.FullAcc.PDT = {}
    sets.engaged.Fodder.PDT = {}
	
    sets.engaged.AM.PDT = {}
    sets.engaged.AM.SomeAcc.PDT = {}
	sets.engaged.AM.Acc.PDT = {}
    sets.engaged.AM.FullAcc.PDT = {}
    sets.engaged.AM.Fodder.PDT = {}
		
	-- Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.
	
    sets.engaged.Adoulin = {}
    sets.engaged.Adoulin.SomeAcc = {}
	sets.engaged.Adoulin.Acc = {}
    sets.engaged.Adoulin.FullAcc = {}
    sets.engaged.Adoulin.Fodder = {}

    sets.engaged.Adoulin.AM = {}
    sets.engaged.Adoulin.AM.SomeAcc = {}
	sets.engaged.Adoulin.AM.Acc = {}
    sets.engaged.Adoulin.AM.FullAcc = {}
    sets.engaged.Adoulin.AM.Fodder = {}
	
    sets.engaged.Adoulin.PDT = {}
    sets.engaged.Adoulin.SomeAcc.PDT = {}
	sets.engaged.Adoulin.Acc.PDT = {}
    sets.engaged.Adoulin.FullAcc.PDT = {}
    sets.engaged.Adoulin.Fodder.PDT = {}
	
    sets.engaged.Adoulin.AM.PDT = {}
    sets.engaged.Adoulin.AM.SomeAcc.PDT = {}
	sets.engaged.Adoulin.AM.Acc.PDT = {}
    sets.engaged.Adoulin.AM.FullAcc.PDT = {}
    sets.engaged.Adoulin.AM.Fodder.PDT = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'DNC' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'RDM' then
        set_macro_page(10, 5)
    else
        set_macro_page(10, 12)
    end
end