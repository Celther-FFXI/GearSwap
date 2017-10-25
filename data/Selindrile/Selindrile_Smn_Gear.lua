-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TPEat', 'Regain')

    gear.perp_staff = {name="Gridarvor"}
	
	gear.magic_jse_back = {name="Campestres's Cape",augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
	gear.phys_jse_back = {name="Campestres's Cape",augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}}
	
    send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
        body="Telchine Chasuble",hands="Baayami Cuffs",ring1="Evoker's Ring",ring2="Stikini Ring",
        back="Conveyance Cape",waist="Kobo Obi",legs="Telchine Braconi",feet="Beck. Pigaches +1"}

    sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Evans Earring",
        body="Con. Doublet +3",hands="Baayami Cuffs",ring1="Evoker's Ring",ring2="Stikini Ring",
        back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops",feet="Baayami Sabots"}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",hands="Helios Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap +1"})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Gifted Earring",
        body="Con. Doublet +3",hands="Helios Gloves",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back="Conveyance Cape",waist="Luminary Sash",legs="Psycloth Lappas",feet="Beck. Pigaches +1"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",hands="Helios Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}
	
    sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Mendicant's Earring",ear2="Gifted Earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Haoma's Ring",ring2="Sirona's Ring",
        back="Tempered Cape +1",waist="Austerity Belt +1",legs="Gyve Trousers",feet="Vanya Clogs"}
		
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back="Tempered Cape +1",waist="Witful Belt"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast['Divine Magic'] = {main="Oranyan",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Aurist's Cape +1",waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
	
	sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages",ring1="Archon Ring",ring2="Evanescence Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {main="Oranyan",sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",hands="Helios Gloves",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Oranyan",sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Gwati Earring",
		body="Inyanga Jubbah +1",hands="Helios Gloves",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast['Enfeebling Magic'] = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body=gear.merlinic_nuke_body,hands="Lurid Mitts",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Oranyan",sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body=gear.merlinic_nuke_body,hands="Lurid Mitts",ring1="Stikini Ring",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
	sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
        body="Beck. Doublet +1",hands="Baayami Cuffs",ring1="Evoker's Ring",ring2="Stikini Ring",
        back="Conveyance Cape",waist="Kobo Obi",legs="Baayami Slops",feet="Baayami Sabots"}

    sets.midcast.Pet.DebuffBloodPactWard = {main="Espiritus",sub="Vox Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Adad Amulet",ear1="Andoaa Earring",ear2="Enmerkar Earring",
        body="Beck. Doublet +1",hands=gear.merlinic_magpact_hands,ring1="Evoker's Ring",ring2="Stikini Ring",
        back=gear.magic_jse_back,waist="Incarnation Sash",legs="Tali'ah Sera. +1",feet="Beck. Pigaches +1"}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {main="Gridarvor",sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Helios Band",neck="Shulmanu Collar",ear1="Gelos Earring",ear2="Lugalbanda Earring",
        body="Con. Doublet +3",hands=gear.merlinic_physpact_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.phys_jse_back,waist="Incarnation Sash",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = {feet="Convo. Pigaches +3"}

    sets.midcast.Pet.MagicalBloodPactRage = {main=gear.grioavolr_pet_staff,sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Apogee Crown +1",neck="Adad Amulet",ear1="Gelos Earring",ear2="Lugalbanda Earring",
        body="Con. Doublet +3",hands=gear.merlinic_magpact_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.magic_jse_back,waist="Regal Belt",legs="Enticer's Pants",feet="Apogee Pumps +1"}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = {feet="Convo. Pigaches +3"}

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
	sets.midcast.Pet['Flaming Crush'] = {main=gear.grioavolr_pet_staff,sub="Elan Strap +1",ammo="Sancus Sachet +1",
        head="Apogee Crown +1",neck="Adad Amulet",ear1="Gelos Earring",ear2="Lugalbanda Earring",
        body="Con. Doublet +3",hands=gear.merlinic_magpact_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.phys_jse_back,waist="Regal Belt",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",ammo="Staunch Tathlum",
        head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Shomonjijoe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet="Baayami Sabots"}
    
    -- Idle sets
    sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
        head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Shomonjijoe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Regal Belt",legs="Assid. Pants +1",feet="Baayami Sabots"}

    sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Regal Belt",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {ring2="Karieyh Ring"})

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Con. Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {main="Gridarvor",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Caller's Pendant",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands=gear.merlinic_refresh_hands,ring1="Evoker's Ring",ring2="Dark Ring",
        back="Conveyance Cape",waist="Lucidity Sash",legs="Assid. Pants +1",feet="Convo. Pigaches +3"}
		
    sets.idle.PDT.Avatar = {main="Terra's Staff",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Regal Belt",legs="Assid. Pants +1",feet="Convo. Pigaches +3"}

    sets.idle.Spirit = {main="Gridarvor",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Caller's Pendant",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Shomonjijoe +1",hands=gear.merlinic_refresh_hands,ring1="Evoker's Ring",ring2="Sheltered Ring",
        back="Conveyance Cape",waist="Lucidity Sash",legs="Assid. Pants +1",feet="Convo. Pigaches +3"}
		
    sets.idle.PDT.Spirit = {main="Terra's Staff",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Lucidity Sash",legs="Assid. Pants +1",feet="Battlecast Gaiters"}
		
	sets.idle.TPEat.Avatar = set_combine(sets.idle.Avatar, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain.Avatar = set_combine(sets.idle.Avatar, {ring2="Karieyh Ring"})
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Melee = {}
	
	sets.idle.Avatar.Melee.Carbuncle = {}
	sets.idle.Avatar.Melee['Cait Sith'] = {}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
	
	sets.perp.Carbuncle = {}
    sets.perp.Diabolos = {}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

	-- Not really used anymore, was for the days of specific staves for specific avatars.
    sets.perp.staff_and_grip = {}
    
    -- Defense sets
    sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Regal Belt",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Lugalbanda Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Regal Belt",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MEVA = {main="Terra's Staff",sub="Enki Strap",ammo="Sancus Sachet +1",
        head="Amalric Coif",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body="Inyanga Jubbah +1",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {head="Apogee Crown +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Seidr Cotehardie",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Apogee Slacks +1",feet="Apogee Pumps +1"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}
	sets.Weapons = {main="Gridarvor", sub="Elan Strap +1"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {main="Gridarvor",sub="Bloodrain Strap",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Shulmanu Collar",ear1="Digni. Earring",ear2="Telos Earring",
        body="Con. Doublet +3",hands="Gazu Bracelet +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.phys_jse_back,waist="Olseni Belt",legs="Assid. Pants +1",feet="Convo. Pigaches +3"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(4, 17)
end
