-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Suppa', 'DWEarrings', 'DWMax'}

	gear.stp_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.wsd_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
    -- Additional local binds
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind @` gs c cycle SkillchainMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.herculean_treasure_feet})
	
	
    -- Extra Melee sets.  Apply these on top of melee sets.
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.Weapons = {main="Aeneas",sub="Taming Sari"}
	sets.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",hands="Floral Gauntlets",waist="Shetal Stone"}
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {} --body="Horos Casaque +1"

    sets.precast.JA['Trance'] = {} --head="Horos Tiara +1"
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +1",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Toetapper Mantle",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	sets.Self_Waltz = {head="Mummu Bonnet +1",body="Passion Jacket",ring1="Asklepian Ring"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {back=gear.stp_jse_back} --head="Maxixi Tiara"

    sets.precast.Jig = {} --legs="Horos Tights", feet="Maxixi Toe Shoes"

    sets.precast.Step = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}
		
    sets.Enmity = {ammo="Paeapua",
        head="Genmei Kabuto",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Trux Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Petrov Ring",ring2="Vengeful Ring",
        back="Solemnity Cape",waist="Goading Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}
		
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
		
    sets.precast.Flourish1['Desperate Flourish'] = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {back="Toetapper Mantle"} --hands="Charis Bangles +2"

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {} --body="Charis Casaque +2"
    sets.precast.Flourish3['Climactic Flourish'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		legs="Rawhide Trousers"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Adhemar Jacket",hands="Meg. Gloves +2",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Samnuha Tights",feet=gear.herculean_wsd_feet}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",body="Meg. Cuirie +2",waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",body="Meg. Cuirie +2",waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body=gear.herculean_wsd_body,legs=gear.herculean_wsd_legs})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",legs=gear.herculean_wsd_legs})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2"})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body=gear.herculean_wsd_body,legs=gear.herculean_wsd_legs})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",legs=gear.herculean_wsd_legs})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2"})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",neck="Fotia Gorget",body="Abnoba Kaftan",hands="Mummu Wrists +1",ring1="Begrudging Ring",waist="Fotia Belt",legs="Darraigner's Brais",feet="Mummu Gamash. +1"})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet",neck="Fotia Gorget",body="Abnoba Kaftan",hands="Mummu Wrists +1",ring1="Begrudging Ring",waist="Fotia Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +1",ring1="Begrudging Ring",neck="Fotia Gorget",body="Mummu Jacket +1",hands="Mummu Wrists +1",waist="Fotia Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +1",body="Mummu Jacket +1",hands="Mummu Wrists +1",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet",hands="Adhemar Wristbands",feet=gear.herculean_ta_feet})
    sets.precast.WS['Pyrrhic Kleos'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet",hands="Adhemar Wristbands",})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
    
    sets.precast.WS['Aeolian Edge'] = {ammo="Seeth. Bomblet +1",
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Karieyh Ring",ring2="Shiva Ring +1",
        back=gear.wsd_jse_back,waist="Chaac Belt",legs=gear.herculean_wsd_legs,feet=gear.herculean_nuke_feet}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Sherida Earring"}
	
    sets.Skillchain = {} --hands="Charis Bangles +2"
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",waist="Hurch'lan Sash",legs="Rawhide Trousers",feet=gear.herculean_dt_feet}
        
    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
    

    -- Idle sets

    sets.idle = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})
    
    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}

    sets.defense.MDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Dark Ring",
        back="Engulfer Cape +1",waist="Engraved Belt",legs=gear.herculean_dt_legs,feet="Ahosi Leggings"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head=gear.herculean_fc_head,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Adhemar Jacket",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
		back="Mujin Mantle",waist="Engraved Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Yamarang",
        head="Dampening Tam",neck="Anu Torque",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
		
    sets.engaged.SomeAcc = {ammo="Yamarang",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
	sets.engaged.Acc = {ammo="Yamarang",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Mummu Jacket +1",hands="Floral Gauntlets",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=gear.stp_jse_back,waist="Reiki Yotai",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}
		
    sets.engaged.FullAcc = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet}

    sets.engaged.Fodder = {ammo="Yamarang",
        head="Dampening Tam",neck="Ainia Collar",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}

    sets.engaged.SomeAcc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
		
    sets.engaged.Acc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}

    sets.engaged.FullAcc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Olseni Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}
		
    sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet=gear.herculean_dt_feet}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {} --legs="Horos Tights"
    sets.buff['Climactic Flourish'] = {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",body="Meg. Cuirie +2"} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(10, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 9)
    else
        set_macro_page(10, 9)
    end
end