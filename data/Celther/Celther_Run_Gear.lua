function user_setup()

	state.OffenseMode:options('Normal', 'Acc', 'HighAcc', 'Fodder')
	state.HybridMode:options('Tank', 'Normal', 'NoShellTank', 'Turms', 'Resist')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA', 'Death','Charm')
	state.IdleMode:options('Normal', 'Refresh')
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP'}
	
	-- Additional local binds
	-- @ = Windows 
	-- ! = Alt
	-- ^ = CTRL
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind !backspace gs c RuneElement')
	send_command('bind @backspace gs c Buff')
	send_command('bind ^backspace input /ja "Vivacious Pulse" <me>')
	send_command('bind ~backspace gs c Shadow')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @!backspace input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @end gs c toggle AutoBuffMode')
	send_command('bind @delete gs c toggle AutoRuneMode')
	send_command('bind ^delete gs c toggle AutoDefenseMode')
	send_command('bind ^end gs c toggle AutoTankMode')	
	send_command('bind !delete gs c toggle AutoWSMode')	
	send_command('bind ^= input /ja "Lunge" <me>')
	send_command('bind @= input /ja "Gambit" <t>')
	send_command('bind != input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()

    sets.Enmity = {head="Halitus Helm",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    legs="Eri. Leg Guards +1",
    feet="Rager Ledel. +1",
    neck="Unmoving Collar +1",
    waist="Kasiri Belt",
    left_ear="Friomisi Earring",
    left_ring="Eihwaz Ring",
    right_ring="Provocare Ring",
    back=gear.cape_run_Tank,}
	
	sets.Enmity.DT = {}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {body="Runeist's Coat +2", legs="Futhark trousers +1", back="Ogma's Cape"})
    sets.precast.JA['Valiance'] = set_combine(sets.Enmity, sets.precast.JA['Vallation'])
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {feet="Runeist Boots +2"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head="Futhark Bandeau +1"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity, {body="Futhark Coat +1"})
    sets.precast.JA['Lunge'] = {ammo="Pemphredo Tathlum",
    head=gear.herculean_magic_head,
    body="Count's Garb",
    hands="Carmine Fin. Ga. +1",
    legs=gear.herculean_magic_legs,
    feet="Adhemar Gamashes",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Novio Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Evasionist's Cape",}
	
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity, {hands="Runeist Mitons +1"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity, {feet="Futhark Boots"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body="Futhark Coat +1"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands="Futhark Mitons +1"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity, {back="Evasionist's Cape"})
    sets.precast.JA['One For All'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",legs="Runeist Trousers +1",ring1="Stikini Ring",ring2="Stikini Ring"}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	-- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens", 
	head="Carmine Mask +1", 
	body="Foppish Tunica", 
	hands="Leyline Gloves", 
	legs="Rawhide Trousers",
    feet="Carmine Greaves +1", 
	neck="Voltsurge Torque", 
	waist="Eschan Stone", 
	left_ear="Odnowa Earring +1", 
	right_ear="Enchntr. Earring +1",
    left_ring="Weather. Ring", 
	right_ring="Kishar Ring", 
	back="Moonbeam Cape",}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {ammo="Seething Bomblet", 
	head=gear.herculean_melee_TP_head, 
	body=gear.herculean_melee_TP_body, 
	hands=gear.adhemar_hands_melee,
    legs="Meghanada Chausses +1", 
	feet=gear.herculean_melee_TP_feet, 
	neck="Fotia Gorget", 
	waist="Fotia Belt",
    left_ear="Brutal Earring", 
	right_ear="Moonshade Earring", 
	left_ring="Hetairoi Ring", 
	right_ring="Epona's Ring", 
	back=gear.cape_run_DA,}
	
	sets.precast.WS.Acc = {ammo="Seething Bomblet",
    head=gear.herculean_melee_TP_head,
    body=gear.herculean_melee_TP_body,
    hands=gear.adhemar_hands_melee,
    legs="Meghanada Chausses +1",
    feet=gear.herculean_melee_TP_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Moonshade Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back=gear.cape_run_DA,}		
	
    sets.precast.WS['Resolution'] = {ammo="Seething Bomblet",
    head=gear.herculean_melee_TP_head,
    body=gear.herculean_melee_TP_body,
    hands=gear.adhemar_hands_melee,
    legs="Meghanada Chausses +1",
    feet=gear.herculean_melee_TP_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Moonshade Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back=gear.cape_run_DA,}
	
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, {})
	
    sets.precast.WS['Dimidiation'] = {ammo="Seething Bomblet",
    head=gear.herculean_melee_TP_head,
    body="Adhemar Jacket",
    hands=gear.herculean_melee_WS_hands,
    legs="Lustratio Subligar",
    feet=gear.herculean_melee_WS_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Moonshade Earring",
    left_ring="Begrudging Ring",
    right_ring="Epona's Ring",
    back=gear.cape_run_WS,
}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, {})
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {neck="Enhancing torque", 
	hands="Runeist mitons +1",
	legs="Futhark Trousers +1",
	head="Erilaz Galea +1",
	ear1="Andoaa Earring",
	waist="Olympus Sash",
	back="Merciful Cape",
	ring1="Stikini Ring",
	ring2="Stikini Ring"}
	
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {head="Runeist Bandeau",legs="Futhark Trousers +1"}
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {head="Erilaz Galea +1"})
	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {head="Carmine Mask +1",legs="Carmine Cuisses +1"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Aspir = set_combine(sets.Enmity, {})
	sets.midcast.Absorb = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = sets.Enmity
	
    sets.midcast.Cure = {
    body="Vrikodara Jupon",
    neck="Phalaina Locket",
    waist="Chuq'aba Belt",
    left_ear="Mendi. Earring",
    right_ear="Roundel Earring",
    right_ring="Meridian Ring",
    back="Solemnity Cape"}
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Chuq'aba Belt"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Chuq'aba Belt"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Protect = {ring2=="Sheltered Ring"}
    sets.midcast.Shell = {ring2=="Sheltered Ring"}
	sets.midcast.BarElement = sets.midcast['Temper']

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = sets.idle
	
    sets.idle = {ammo="Staunch Tathlum",
            head="Futhark Bandeau +1", 
			neck="Loricate Torque +1", 
			ear1="Odnowa Earring", 
			ear2="Odnowa Earring +1",
            body="Futhark Coat +1", 
			hands=gear.herculean_tank_hands, 
			ring1="Defending Ring", 
			ring2="Moonbeam Ring",
            back="Moonbeam Cape", 
			waist="Flume Belt +1", 
			legs="Futhark Trousers +1", 
			feet="Erilaz Greaves +1"}
			
	sets.idle.PDT = sets.idle
	
	sets.idle.MDT = sets.idle
    
	sets.idle.Refresh = {ammo="Homiliary",
    head="Rawhide Mask",
    body="Runeist's Coat +2",
    hands="Turms Mittens",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Turms Leggings",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back="Xucau Mantle"}
           
	sets.idle.Weak = sets.idle
		   
	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Weapons = {}
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt +1"}
    sets.MP_Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Defense Sets
	
	sets.defense.PDT = {ammo="Staunch Tathlum",
    head="Fu. Bandeau +1",
    body="Erilaz Surcoat +1",
    hands=gear.herculean_tank_hands,
    legs="Eri. Leg Guards +1",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back="Xucau Mantle",
}
	sets.defense.PDT_HP = {sub="Utu Grip",
    ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    body="Runeist's Coat +2",
    hands=gear.herculean_tank_hands,
    legs="Eri. Leg Guards +1",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"}

	sets.defense.MDT = {ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    body="Runeist's Coat +2",
    hands="Erilaz Gauntlets +1",
    legs="Eri. Leg Guards +1",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
}
	sets.defense.MDT_HP = {}
	
	sets.defense.BDT = {ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    body="Futhark Coat +1",
    hands=gear.herculean_tank_hands,
    legs="Eri. Leg Guards +1",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape",
}
	sets.defense.BDT_HP = {}
	
	sets.defense.MEVA = {ammo="Staunch Tathlum",
    head="Erilaz Galea +1",
    body="Runeist's Coat +2",
    hands="Erilaz Gauntlets +1",
    legs="Rune. Trousers +2",
    feet="Turms Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring=gear.dark_ring,
    back=gear.cape_run_Tank,
}
		
	sets.defense.Death = set_combine (sets.defense.MEVA, {ring2="Warden's Ring"})
		
	sets.defense.Charm = set_combine (sets.defense.MEVA, {back="Solemnity Cape",neck="Unmoving Collar +1", right_ring="Wuji Ring"})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Ginsen",
    head=gear.herculean_melee_TP_head,
    body=gear.herculean_melee_TP_body,
    hands=gear.adhemar_hands_melee,
    legs="Samnuha Tights",
    feet=gear.herculean_melee_TP_feet,
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back=gear.cape_run_STP,
}
    sets.engaged.Acc = set_combine(sets.engaged, {legs="Meghanada Chausses +1",head="Carmine Mask +1"})
	sets.engaged.HighAcc = {}
	sets.engaged.Fodder = {}
	
    sets.engaged.Tank = {ammo="Staunch Tathlum",
            head="Futhark Bandeau +1", 
			neck="Loricate Torque +1", 
			ear1="Odnowa Earring", 
			ear2="Odnowa Earring +1",
            body="Erilaz Surcoat +1", 
			hands=gear.herculean_tank_hands, 
			ring1="Defending Ring", 
			ring2="Moonbeam Ring",
            back=gear.cape_run_Tank, 
			waist="Flume Belt +1", 
			legs="Erilaz Leg Guards +1", 
			feet="Erilaz Greaves +1"}
			
    sets.engaged.Acc.Tank = {ammo="Ginsen",
    head="Adhemar Bonnet",
    body="Ayanmo Corazza +2",
    hands=gear.adhemar_hands_melee,
    legs="Samnuha Tights",
    feet=gear.herculean_melee_TP_feet,
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Defending Ring",
    right_ring="Epona's Ring",
    back=gear.cape_run_STP,}
	
	sets.engaged.Turms = {ammo="Staunch Tathlum",
    head="Fu. Bandeau +1",
    body="Futhark Coat +1",
    hands="Turms Mittens",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back=gear.cape_run_Tank,}
	
	sets.engaged.Resist = {ammo="Staunch Tathlum",
    head="Fu. Bandeau +1",
    body="Futhark Coat +1",
    hands="Erilaz Gauntlets +1",
    legs="Rune. Trousers +2",
    feet="Erilaz Greaves +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back=gear.cape_run_Tank,}
	
	sets.engaged.HighAcc.Tank = set_combine(sets.engaged.Acc, {ring1="Defending Ring",ring2="Dark Ring",neck="Loricate Torque +1"})
	sets.engaged.Fodder.Tank = {}
	
    sets.engaged.NoShellTank = set_combine(sets.engaged.Tank, {body="Futhark Coat +1",back="Xucau Mantle"})
    sets.engaged.Acc.NoShellTank = {}
	sets.engaged.HighAcc.NoShellTank = {}
	sets.engaged.Fodder.NoShellTank = {}
	
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}
	sets.engaged.HighAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}
	
    sets.engaged.MDT = {}
    sets.engaged.Acc.MDT = {}
	sets.engaged.HighAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {ring1="Eshmun's Ring",ring2="Purity Ring"})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
end

function user_job_tick()
    if state.AutoBuffMode.value then
		
		if player.sub_job == 'BLU' then
        local spell_recasts = windower.ffxi.get_spell_recasts()
		
        if not buffactive.Phalanx and spell_recasts[106] == 0 then
            windower.chat.input('/ma "Phalanx" <me>')
            tickdelay = 200
            return true
        elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 then
            windower.chat.input('/ma "Cocoon" <me>')
            tickdelay = 200
            return true
	    elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
            windower.chat.input('/ma "Crusade" <me>')
            tickdelay = 200
            return true		
	    elseif not buffactive.Haste and spell_recasts [530] == 0 then
            windower.chat.input('/ma "Refueling" <me>')
            tickdelay = 200
            return true	
		elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
            windower.chat.input('/ma "Aquaveil" <me>')
            tickdelay = 200
            return true	
		elseif not buffactive.Refresh and spell_recasts [109] == 0 then
            windower.chat.input('/ma "Refresh" <me>')
            tickdelay = 200
            return true		
        end
    end
	
		if player.sub_job == 'DRK' then
        local spell_recasts = windower.ffxi.get_spell_recasts()
		
        if not buffactive.Phalanx and spell_recasts[106] == 0 then
            windower.chat.input('/ma "Phalanx" <me>')
            tickdelay = 200
            return true
	    elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
            windower.chat.input('/ma "Crusade" <me>')
            tickdelay = 200
            return true		
		elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
            windower.chat.input('/ma "Aquaveil" <me>')
            tickdelay = 200
            return true	
		elseif not buffactive.Refresh and spell_recasts [109] == 0 then
            windower.chat.input('/ma "Refresh" <me>')
            tickdelay = 200
            return true		
        end
    end
	
		if player.sub_job == 'NIN' then
        local spell_recasts = windower.ffxi.get_spell_recasts()
		
        if not buffactive['Copy Image'] and not buffactive ['Copy Image (2)'] and not buffactive ['Copy Image (3)'] then
            windower.chat.input('//gs c Shadow')
            tickdelay = 200
            return true
		elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
            windower.chat.input('/ma "Aquaveil" <me>')
            tickdelay = 200
            return true	   
		elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
            windower.chat.input('/ma "Crusade" <me>')
            tickdelay = 200
            return true		
		elseif not buffactive.Phalanx and spell_recasts[106] == 0 then
            windower.chat.input('/ma "Phalanx" <me>')
            tickdelay = 200
            return true

		elseif not buffactive.Refresh and spell_recasts [109] == 0 then
            windower.chat.input('/ma "Refresh" <me>')
            tickdelay = 200
            return true		
        end
    end
	end
	
    return false
end


function user_job_self_command(commandArgs, eventArgs)
	if commandArgs[1] == 'Buff' then
	
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if player.sub_job == 'BLU' then
		

            if not buffactive.Phalanx and spell_recasts[106] == 0 then
				send_command('input /ma "Phalanx" <me>')
			elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 then
				send_command('input /ma "Cocoon" <me>')
			elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
				send_command('input /ma "Crusade" <me>')
			elseif not buffactive.Haste and spell_recasts [530] == 0 then
				send_command('input /ma "Refueling" <me>')
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				send_command('input /ma "Aquaveil" <me>')
			elseif not buffactive.Regen and spell_recasts [477] == 0 then
				send_command('input /ma "Regen IV" <me>')
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				send_command('input /ma "Refresh" <me>')			
			elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 then
				send_command('input /ma "Shock Spikes" <me>')
			else add_to_chat(123,'All buffs are applied.')
			end	
			
		elseif player.sub_job == 'DRK' then		

            if not buffactive.Phalanx and spell_recasts[106] == 0 then
				send_command('input /ma "Phalanx" <me>')
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				send_command('input /ma "Aquaveil" <me>')
			elseif not buffactive.Regen and spell_recasts [477] == 0 then
				send_command('input /ma "Regen IV" <me>')
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				send_command('input /ma "Refresh" <me>')			
			elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 then
				send_command('input /ma "Shock Spikes" <me>')
			else add_to_chat(123,'All buffs are applied.')
			end	
			
		else	
			
            if not buffactive.Phalanx and spell_recasts[106] == 0 then
				send_command('input /ma "Phalanx" <me>')
			elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
				send_command('input /ma "Crusade" <me>')
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				send_command('input /ma "Aquaveil" <me>')
			elseif not buffactive.Regen and spell_recasts [477] == 0 then
				send_command('input /ma "Regen IV" <me>')
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				send_command('input /ma "Refresh" <me>')			
			elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 then
				send_command('input /ma "Shock Spikes" <me>')
			else add_to_chat(123,'All buffs are applied.')end
			end
		end
		
	if commandArgs[1] == 'Enmity' then
		  
			if player.target.type ~= "MONSTER" then
				add_to_chat(123,'Abort: You are not targeting a monster.')
				return
			
			elseif player.sub_job == 'DRK' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
            if spell_recasts[112] == 0 then
				send_command('input /ma "Flash" <t>')
			elseif spell_recasts[840] == 0 then
				send_command('input /ma "Stun" <t>')
			elseif spell_recasts[247] == 0 then
				send_command('input /ma "Foil" <me>')
			elseif spell_recasts[252] == 0 then
				send_command('input /ma "Aspir" <t>')
			elseif spell_recasts[275] == 0 then
				send_command('input /ma "Absorb-TP" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity spells on cooldown.') end
			end
			
						elseif player.sub_job == 'BLU' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
            if spell_recasts[112] == 0 then
				send_command('input /ma "Flash" <t>')
			elseif spell_recasts[840] == 0 then
				send_command('input /ma "Foil" <me>')
			elseif spell_recasts[592] == 0 then
				send_command('input /ma "Blank Gaze" <t>')
			elseif spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <t>')
			elseif spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity spells on cooldown.') end
			end
			
			elseif player.sub_job == 'WAR' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
            if spell_recasts[112] == 0 then
				send_command('input /ma "Flash" <t>')
			elseif spell_recasts[840] == 0 then
				send_command('input /ma "Foil" <me>')
			elseif spell_recasts[592] == 0 then
				send_command('input /ma "Blank Gaze" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity spells on cooldown.') end
			end
			
			elseif player.sub_job == 'NIN' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
			
            if spell_recasts[112] == 0 then
				send_command('input /ma "Flash" <t>')
			elseif spell_recasts[840] == 0 then
				send_command('input /ma "Foil" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity spells on cooldown.') end
			end
			
	end
end

    if commandArgs[1] == 'SubJobEnmity' then

        if player.target.type ~= "MONSTER" then
            add_to_chat(123,'Abort: You are not targeting a monster.')
            return

        elseif player.sub_job == 'BLU' then
            local spell_recasts = windower.ffxi.get_spell_recasts()

            if spell_recasts[584] == 0 then
                send_command('input /ma "Sheep Song" <t>')
            elseif spell_recasts[605] == 0 then
                send_command('input /ma "Geist Wall" <t>')
            elseif spell_recasts[592] == 0 then
                send_command('input /ma "Blank Gaze" <t>')
            elseif not check_auto_tank_ws() then
                if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Blue Magic on cooldown.') end

        elseif player.sub_job == 'DRK' then
            local spell_recasts = windower.ffxi.get_spell_recasts()

            if spell_recasts[225] == 0 then
                send_command('input /ma "Poisonga" <t>')
            elseif not check_auto_tank_ws() then
                if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Dark Magic on cooldown.') end
            end
     end
end
end
	if commandArgs[1] == 'Shadow' then
            local spell_recasts = windower.ffxi.get_spell_recasts()

            if player.sub_job == 'NIN' then
                if spell_recasts[339] == 0 then
                    send_command('input /ma "Utsusemi: Ni" <me>')
                    return
                elseif spell_recasts[338] == 0 then
                    send_command('input /ma "Utsusemi: Ichi" <me>')
                    return
            end

           elseif player.sub_job == 'DRK' then
                if spell_recasts[53] == 0 then
                    send_command('input /ma "Blink" <me>')
                    return
			end	

			elseif player.sub_job == 'BLU' then
                if spell_recasts[53] == 0 then
                    send_command('input /ma "Blink" <me>')
                    return
			end	
end
end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end