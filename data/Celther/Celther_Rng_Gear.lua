-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	
	DefaultAmmo = {['Annihilator'] = "Eradicating Bullet"}
	U_Shot_Ammo = {['Annihilator'] = "Eradicating Bullet"}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle Rnghelper')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}


	-- Fast cast sets for spells

	sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Orion Beret +3", --R:18
		body="Arcadian Jerkin +1", --R:12 S:10
		hands="Carmine Fin. Ga. +1",--S:8 R:11
		waist="Yemaya Belt",--R:5
		legs="Adhemar Kecks",--S:9 R:10
		feet="Meghanada Jambeaux +1",--S:8
		back=gear.cape_rng_Snap,} --S:10
		--Snapshot: 55
		--Rapid Shot: 56

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
    range="Annihilator",
    ammo="Eradicating Bullet",
    head="Orion Beret +3",
    body=gear.herculean_ranged_ws_body,
    hands="Meghanada Gloves +2",
    legs=gear.herculean_ranged_ws_legs,
    feet=gear.herculean_ranged_ws_feet,
    neck="Ocachi Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Garuda Ring +1",
    right_ring="Ilabrat Ring",
    back=gear.cape_rng_WS,}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
		
	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
		
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS["Last Stand"], {})
	
	sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
		
	sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS["Coronach"], {})
	
	sets.precast.WS['Trueflight'] =     {ammo="Eradicating Bullet",
    head="Orion Beret +3",
    body="Samnuha Coat",
    hands=gear.herculean_melee_WS_hands,
    legs=gear.herculean_magic_legs,
    feet=gear.herculean_melee_WS_feet,
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Moonshade Earring",
    left_ring="Weather. Ring",
    right_ring="Arvina Ringlet +1",
    back=gear.cape_rng_WS,}
		
	sets.precast.WS["Trueflight"].Acc = set_combine(sets.precast.WS["Trueflight"], {})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {left_ear="Telos Earring"}
	sets.precast.AccMaxTP = {left_ear="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {}
		
	-- Ranged sets

	sets.midcast.RA ={
    range="Annihilator",
    ammo="Eradicating Bullet",
    head="Orion Beret +3",
    body="Orion Jerkin +2",
    hands=gear.adhemar_hands_ranged,
    legs="Adhemar Kecks",
    feet="Adhemar Gamashes",
    neck="Anu Torque",
    waist="Yemaya Belt",
    left_ear="Telos Earring",
    right_ear="Enervating Earring",
    left_ring="Rajas Ring",
    right_ring="Ilabrat Ring",
    back=gear.cape_rng_tp,}

	sets.midcast.RA.Acc = {
    head="Meghanada Visor +1",
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Marked Gorget",
    waist="Yemaya Belt",
    left_ear="Telos Earring",
    right_ear="Enervating Earring",
    left_ring="Rajas Ring",
    right_ring="Ilabrat Ring",
    back=gear.cape_rng_tp,}
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {ring1="Defending Ring",ring2="Sheltered Ring"}

	-- Idle sets
	sets.idle = {
    range="Annihilator",
    ammo="Eradicating Bullet",
    head="Meghanada Visor +1",
    body="Meghanada Cuirie +1",
    hands="Meg. Gloves +2",
    legs="Carmine Cuisses +1",
    feet="Meghanada Jambeaux +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring=gear.dark_ring,
    back="Solemnity Cape",}
		
	sets.idle.PDT = sets.idle
	
	-- Defense sets
	sets.defense.PDT = {
    range="Annihilator",
    ammo="Eradicating Bullet",
    head="Meghanada Visor +1",
    body="Meghanada Cuirie +1",
    hands="Meg. Gloves +2",
    legs="Carmine Cuisses +1",
    feet="Meghanada Jambeaux +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring=gear.dark_ring,
    back="Solemnity Cape",}

	sets.defense.MDT = {}
		
	sets.defense.MEVA = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Weapons = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
    head="Adhemar Bonnet",
    body="Adhemar Jacket",
    hands="Meg. Gloves +2",
    legs="Samnuha Tights",
    feet=gear.herculean_melee_TP_feet,
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Mache Earring",
    right_ear="Mache Earring",
    left_ring="Chirich Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle"}

	sets.engaged.Acc = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +1"})
	sets.buff.Camouflage = {body="Orion Jerkin +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end
