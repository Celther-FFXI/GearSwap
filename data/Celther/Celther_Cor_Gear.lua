-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Eminent Bullet"
    gear.WSbullet = "Eminent Bullet"
    gear.MAbullet = "Eminent Bullet"
    gear.QDbullet = "Eminent Bullet"
    options.ammo_warning_limit = 15

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
	send_command('bind @f7 gs c toggle AutoShootMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1",back="Camulus's Mantle"}
	
	sets.buff['Triple Shot'] = {body="Navarch's Frac +2"}

    
    sets.precast.CorsairRoll = {ring1="Barataria Ring",head="Lanun Tricorne",hands="Chasseur's Gants +1",back="Camulus's Mantle"} --hands="Navarch's Gants +2"
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +1"})
    --sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, (body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
    
    sets.precast.CorsairShot = {head="Blood Mask"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    sets.precast.RA = {ammo=gear.RAbullet,
        head="Chasseur's Tricorne +1",body="Pursuer's Doublet",hands="Carmine Finger Gauntlets",
		waist="Impulse Belt",legs="Adhemar Kecks",feet="Adhemar Gamashes"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {	
    head="Carmine Mask +1",
    body="Adhemar Jacket",
    hands=gear.herculean_melee_WS_hands,
    legs="Carmine Cuisses +1",
    feet=gear.herculean_melee_WS_feet,
    neck="Light Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Ishvara Earring",
    left_ring="Begrudging Ring",
    right_ring="Epona's Ring",
}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = sets.precast.WS

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Adhemar Kecks"})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Adhemar Kecks"})

    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
    head="Meghanada Visor +1",
    body=gear.herculean_ranged_ws_body,
    hands="Meg. Gloves +2",
    legs=herculean_ranged_ws_legs,
    feet=herculean_ranged_ws_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Garuda Ring +1",
    right_ring="Ilabrat Ring",
    back="Gunslinger's Cape",}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Laksamana's Hat",neck=gear.ElementalGorget,ear1="Clearview Earring",ear2="Moonshade Earring",
        body="Laksamana's Frac",hands="Buremte Gloves",ring1="Hajduk Ring",ring2="Stormsoul Ring",
        back="Libeccio Mantle",waist=gear.ElementalBelt,legs="Thurandaut Tights +1",feet="Laksamana's Bottes"}


    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
    head=herculean_magic_head,
    body={ name="Samnuha Coat", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+6',}},
    hands=herculean_melee_WS_hands,
    legs=herculean_magic_legs,
    feet=herculean_ranged_ws_feet,
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Crematio Earring",
    left_ring="Garuda Ring +1",
    right_ring="Ilabrat Ring",
    back="Gunslinger's Cape",}

    sets.precast.WS['Wildfire'].Brew = {ammo=gear.MAbullet,
        head="Wayfarer Circlet",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Stormsoul Ring",ring2="Demon's Ring",
        back="Toro Cape",waist=gear.ElementalBelt,legs="Iuitl Tights",feet="Iuitl Gaiters +1"}
    
    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {head="Pixie Hairpin +1", left_ring="Archon Ring", right_ear="Moonshade Earring"})
	
	sets.precast.WS['Savage Blade'] =     {head={ name="Herculean Helm", augments={'Attack+25','"Triple Atk."+3','AGI+4','Accuracy+10',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4','STR+7',}},
    hands={ name="Herculean Gloves", augments={'Pet: CHR+5','Attack+9','Weapon skill damage +9%','Accuracy+17 Attack+17','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    legs={ name="Herculean Trousers", augments={'Weapon skill damage +4%','DEX+2','Accuracy+11','Attack+9',}},
    feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','Weapon skill damage +5%','Accuracy+11','Attack+6',}},
    neck="Light Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Moonshade Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle"
	}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Whirlpool Mask",
        body="Iuitl Vest",hands="Iuitl Wristbands",
        legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}	
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head="Blood Mask",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Lanun Frac",hands="Schutzen Mittens",ring1="Hajduk Ring",ring2="Demon's Ring",
        back="Toro Cape",waist="Aquiline Belt",legs="Iuitl Tights",feet="Lanun Bottes"}

    sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
        head="Laksamana's Hat",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Lanun Frac",hands="Schutzen Mittens",ring1="Stormsoul Ring",ring2="Mephitas's Ring +1",
        back="Navarch's Mantle",waist="Aquiline Belt",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Laksamana's Hat",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Lanun Frac",hands="Schutzen Mittens",ring1="Stormsoul Ring",ring2="Mephitas's Ring +1",
        back="Navarch's Mantle",waist="Aquiline Belt",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Lanun Tricorne",neck="Ocachi Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Laksamana's Frac",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Stormsoul Ring",
        back="Terebellum Mantle",waist="Commodore Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
    head="Meghanada Visor +1",
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +1",
    feet=gear.herculean_ranged_ws_feet,
    neck="Marked Gorget",
    waist="Yemaya Belt",
    left_ear="Telos Earring",
    right_ear="Enervating Earring",
    left_ring="Hajduk Ring",
    right_ring="Hajduk Ring",
    back="Gunslinger's Cape",}

    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {    ammo="Animikii Bullet",
    head="Meghanada Visor +1",
    body="Meghanada Cuirie +1",
    hands="Meghanada Gloves +1",
    legs="Carmine Cuisses +1",
    feet="Meghanada Jambeaux +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Dark Ring",
    back="Xucau Mantle",
	}
    
    -- Defense sets
    sets.defense.PDT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.defense.MDT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}
    

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {ammo=gear.RAbullet,
    head={ name="Herculean Helm", augments={'Attack+25','"Triple Atk."+3','AGI+4','Accuracy+10',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4','STR+7',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Lissome Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",}
    
    sets.engaged.Acc =     {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4','STR+7',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring",
    left_ring="Chirich Ring",
    right_ring="Chirich Ring",
    back="Letalis Mantle",
}

    sets.engaged.Melee.DW = {ammo=gear.RAbullet,
    head={ name="Herculean Helm", augments={'Attack+25','"Triple Atk."+3','AGI+4','Accuracy+10',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4','STR+7',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",}
    
    sets.engaged.Acc.DW = {ammo=gear.RAbullet,
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}


    sets.engaged.Ranged = {ammo=gear.RAbullet,
    head={ name="Herculean Helm", augments={'Attack+25','"Triple Atk."+3','AGI+4','Accuracy+10',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4','STR+7',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Anu Torque",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 13)
end