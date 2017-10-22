-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')
	state.IdleMode:options('Normal', 'PDT')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }

    select_default_macro_book()
	
	send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    
    sets.precast.JA['Repair'] = {feet="Foire Babouches"}

    sets.precast.JA.Maneuver = {neck="Buffoon's Collar",body="Cirque Farsetto +2",hands="Foire Dastanas",back="Dispersal Mantle"}



    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Whirlpool Mask",ear1="Roundel Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",
        ring1="Spiral Ring",waist="Soil Belt"})
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {legs="Nahtirah Trousers"})

    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",
        waist="Thunder Belt"})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})

    
    -- Midcast Sets

    sets.midcast.FastRecast = {
        head="Haruspex Hat",ear2="Loquacious Earring",
        body="Otronif Harness +1",hands="Regimen Mittens",
        legs="Manibozho Brais",feet="Otronif Boots +1"}
        
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
		
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {legs="Foire Churidars"}
	sets.midcast.Pet['Enfeebling Magic'] = {feet="Pitre Babouches"}
    sets.midcast.Pet['Elemental Magic'] = {feet="Pitre Babouches"}
    sets.midcast.Pet.WeaponSkill = {head="Cirque Cappello +2", hands="Cirque Guanti +2", legs="Cirque Pantaloni +2"}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Pitre Taj",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets

    sets.idle = {range="Divinator",
        head="Pitre Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}
		
    sets.idle.PDT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}
		
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
        body="Foire Tobe",hands="Regimen Mittens",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Dispersal Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Foire Babouches"}

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {hands="Cirque Guanti +2",legs="Cirque Pantaloni +2"})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {hands="Cirque Guanti +2",legs="Cirque Pantaloni +2"})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {hands="Cirque Guanti +2",legs="Cirque Pantaloni +2"})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {legs="Cirque Pantaloni +2",feet="Cirque Scarpe +2"})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
	sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic


    -- Defense sets

    sets.defense.Evasion = {
        head="Whirlpool Mask",neck="Loricate Torque +1",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Beeline Ring",
        back="Ik Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.PDT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.MDT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Adhemar Jacket",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
    sets.engaged.Acc = {
        head="Whirlpool Mask",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Adhemar Jacket",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots +1"}
    sets.engaged.DT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Regimen Mittens",ring1="Defending Ring",ring2="Epona's Ring",
        back="Iximulew Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
    sets.engaged.Acc.DT = {
        head="Whirlpool Mask",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Regimen Mittens",ring1="Defending Ring",ring2="Beeline Ring",
        back="Iximulew Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 9)
    else
        set_macro_page(1, 9)
    end
end