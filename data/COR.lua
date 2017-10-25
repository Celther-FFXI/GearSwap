-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	
	-- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Leaden Salute','Wildfire','Last Stand'}
	
	autows = 'Leaden Salute'
	autofood = 'Sublime Sushi'

    define_roll_values()
	update_combat_form()
	
	state.AutoBulletMode = M(true,'Auto Bullet Mode')
	
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoFoodMode","RngHelper","AutoStunMode","AutoDefenseMode","LuzafRing","AutoBuffMode",},{"OffenseMode","RangedMode","WeaponskillMode","ElementalMode","IdleMode","Passive","RuneElement","TreasureMode",})
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if (spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill') and player.equipment.ammo == 'Animikii Bullet' then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t shoot your good ammo!')
    end
end

function job_precast(spell, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.type == 'CorsairShot' and not player.inventory['Trump Card'] and player.satchel['Trump Card'] then
		send_command('get "Trump Card" satchel')
		cast_delay(1.1)
		return
    end
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end
end

function job_post_midcast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] and sets.buff['Triple Shot'] then
        equip(sets.buff['Triple Shot'])
	end
end

function job_self_command(commandArgs, eventArgs)
		if commandArgs[1]:lower() == 'elemental' and commandArgs[2]:lower() == 'quickdraw' then
			if state.ElementalMode.value == 'Fire' then
				windower.chat.input('/ma "Fire Shot" <t>')
			elseif state.ElementalMode.value == 'Wind' then
				windower.chat.input('/ma "Wind Shot" <t>')
			elseif state.ElementalMode.value == 'Lightning' then
				windower.chat.input('/ma "Thunder Shot" <t>')
			elseif state.ElementalMode.value == 'Earth' then
				windower.chat.input('/ma "Earth Shot" <t>')
			elseif state.ElementalMode.value == 'Ice' then
				windower.chat.input('/ma "Ice Shot" <t>')
			elseif state.ElementalMode.value == 'Water' then
				windower.chat.input('/ma "Water Shot" <t>')
			elseif state.ElementalMode.value == 'Light' then
				windower.chat.input('/ma "Light Shot" <t>')
			elseif state.ElementalMode.value == 'Dark' then
				windower.chat.input('/ma "Dark Shot" <t>')
			end

			eventArgs.handled = true			
		end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
	elseif spell.type == 'CorsairShot' then
		equip({ammo=gear.RAbullet})
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end

function job_buff_change(buff, gain)

end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
    if state.ExtraMeleeMode and state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end

    return meleeSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function update_combat_form()
	if player.equipment.main and not (player.equipment.sub == 'empty' or player.equipment.sub:contains('Grip') or player.equipment.sub:contains('Strap')) and not player.equipment.sub:contains('Shield') then
			state.CombatForm:set('DW')
	else
			state.CombatForm:reset()
	end
end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] and sets.buff['Triple Shot'] then
			equip(sets.buff['Triple Shot'])
		end
	elseif spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 and moonshade_ws:contains(spell.english) then
			if state.WeaponskillMode.Current:contains('Acc') then
				if sets.precast.AccMaxTP then
					equip(sets.precast.AccMaxTP)
				end
			elseif sets.precast.MaxTP then
					equip(sets.precast.MaxTP)
			end
		end
	elseif spell.type == 'CorsairShot' then
		if state.WeaponskillMode.value == "Proc" and sets.precast.CorsairShot.Proc then
			equip(sets.precast.CorsairShot.Proc)
		elseif state.CastingMode.value == 'Resistant' then
			classes.CustomClass = 'Acc'
		end
	elseif (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
		equip(sets.precast.LuzafRing)
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 and sets.precast.FoldDoubleBust then
		equip(sets.precast.FoldDoubleBust)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=3, unlucky=7, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=4, unlucky=8, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(217, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(217, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if elemental_obi_weaponskills:contains(spell.name) then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
				-- physical weaponskills
				bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
  
	local available_bullets = count_available_bullets(bullet_name)
	
  -- If no ammo is available, give appropriate warning and cancel.
    if not (available_bullets > 0) then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(217, 'No Quick Draw ammo available, using equipped ammo: ('..player.equipment.ammo..')')
            return
        elseif spell.type == 'WeaponSkill' and (player.equipment.ammo == gear.RAbullet or player.equipment.ammo == gear.WSbullet or player.equipment.ammo == gear.MAbullet) then
            add_to_chat(217, 'No weaponskill ammo available, using equipped ammo: ('..player.equipment.ammo..')')
            return
        else
            add_to_chat(217, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and (available_bullets <= bullet_min_count) then
        add_to_chat(217, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and (available_bullets > 0) and (available_bullets <= options.ammo_warning_limit) then
        local msg = '****  LOW AMMO WARNING: '..bullet_name..' ****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(217, border)
        add_to_chat(217, msg)
        add_to_chat(217, border)
    end
end

function job_tick()
	if check_bullets() then return true end
	return false
end

function check_bullets()
	if state.AutoBulletMode.value and player.equipment.range then
			if player.equipment.range == 'Fomalhaut' and get_item_next_use(player.equipment.range).usable then
				if count_total_bullets('Chrono Bullet') < 200 then
					windower.chat.input('/item "Fomalhaut" <me>')
					add_to_chat(217,"You're low on Chrono Bullets, using Fomalhaut.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Death Penalty' and get_item_next_use(player.equipment.range).usable then
				if count_total_bullets('Living Bullet') < 200 then
					windower.chat.input('/item "Death Penalty" <me>')
					add_to_chat(217,"You're low on Living Bullets, using Death Penalty.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Armageddon' and get_item_next_use(player.equipment.range).usable then
				if count_total_bullets('Devastating Bullet') < 200 then
					windower.chat.input('/item "Armageddon" <me>')
					add_to_chat(217,"You're low on Devastating Bullets, using Armageddon.")
					tickdelay = 120
				end
			end
	end
	return false
end

function count_available_bullets(bullet_name)
	local bullet_count = 0
	
	if player.inventory[bullet_name] then
		bullet_count = bullet_count + player.inventory[bullet_name].count
	end
	
	if player.wardrobe[bullet_name] then
		bullet_count = bullet_count + player.wardrobe[bullet_name].count
	end

	if player.wardrobe2[bullet_name] then
		bullet_count = bullet_count + player.wardrobe2[bullet_name].count
	end
	
	if player.wardrobe3[bullet_name] then
		bullet_count = bullet_count + player.wardrobe3[bullet_name].count
	end
	
	if player.wardrobe4[bullet_name] then
		bullet_count = bullet_count + player.wardrobe4[bullet_name].count
	end
	
	return bullet_count
end

function count_total_bullets(bullet_name)
	local bullet_count = 0
	
	if player.inventory[bullet_name] then
		bullet_count = bullet_count + player.inventory[bullet_name].count
	end
	
	if player.wardrobe[bullet_name] then
		bullet_count = bullet_count + player.wardrobe[bullet_name].count
	end
	
	if player.wardrobe3[bullet_name] then
		bullet_count = bullet_count + player.wardrobe3[bullet_name].count
	end
	
	if player.wardrobe4[bullet_name] then
		bullet_count = bullet_count + player.wardrobe4[bullet_name].count
	end
	
	if player.wardrobe4[bullet_name] then
		bullet_count = bullet_count + player.wardrobe4[bullet_name].count
	end
	
	if player.satchel[bullet_name] then
		bullet_count = bullet_count + player.satchel[bullet_name].count
	end
	
	if player.sack[bullet_name] then
		bullet_count = bullet_count + player.sack[bullet_name].count
	end
	
	if player.case[bullet_name] then
		bullet_count = bullet_count + player.case[bullet_name].count
	end
	
	return bullet_count
end