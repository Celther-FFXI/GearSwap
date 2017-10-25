-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff.Sentinel = buffactive.Sentinel or false
    state.Buff.Cover = buffactive.Cover or false
	state.Stance = M{['description']='Stance','Hasso','Seigan','None'}

	state.EquipShield = M(false, 'Shield Swapping Defense Mode')
	
	state.CurrentStep = M{['description']='Current Step', 'Box Step', 'Quickstep'}

	--List of which WS you plan to use TP bonus WS with. (Atonement uses but doesn't need to switch out.)
	moonshade_ws = S{'Savage Blade', 'Chant du Cygne'}
	
	autows = 'Savage Blade'
	autofood = 'Miso Ramen'
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoTankMode","AutoWSMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode","AutoBuffMode","EquipShield",},{"OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","PhysicalDefenseMode","MagicalDefenseMode","ResistDefenseMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)
	if spell.type == 'WeaponSkill' then
        if player.equipment.main == 'Nibiru Cudgel' then
            if spell.english == "Chant du Cygne" then
                cancel_spell()
				send_command('@input /ws "Realmrazer" '..spell.target.raw)
				eventArgs.cancel = true
            elseif spell.english == "Sanguine Blade" then
                cancel_spell()
				send_command('@input /ws "Flash Nova" '..spell.target.raw)
				eventArgs.cancel = true
            end
        end
	end
end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_precast(spell, spellMap, eventArgs)

	if spell.name == 'Flash' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if abil_recasts[80] == 0 and spell_recasts[112] == 0 then
			cast_delay(1.1)
			send_command('@input /ja "Divine Emblem" <me>')
		end
	end

end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then
	
		local WSset = get_precast_set(spell, spellMap)
		if not WSset.ear1 then WSset.ear1 = WSset.left_ear or '' end
		if not WSset.ear2 then WSset.ear2 = WSset.right_ear or '' end
        -- Replace Moonshade Earring if we're at cap TP
		if player.tp > 2950 and (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			if state.WeaponskillMode.Current:contains('Acc') and not buffactive['Sneak Attack'] and sets.precast.AccMaxTP then
				sets.precast.AccMaxTP.ear1 = sets.precast.AccMaxTP.left_ear or ''
				sets.precast.AccMaxTP.ear2 = sets.precast.AccMaxTP.right_ear or ''
				if (sets.precast.AccMaxTP.ear1:startswith("Lugra Earring") or sets.precast.AccMaxTP.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayMaxTPWSEars then
					equip(sets.AccDayMaxTPWSEars)
				else
					equip(sets.precast.AccMaxTP)
				end
			elseif sets.precast.MaxTP then
				if not sets.precast.MaxTP.ear1 then sets.precast.MaxTP.ear1 = sets.precast.MaxTP.left_ear or '' end
				if not sets.precast.MaxTP.ear2 then sets.precast.MaxTP.ear2 = sets.precast.MaxTP.right_ear or '' end
				if (sets.precast.MaxTP.ear1:startswith("Lugra Earring") or sets.precast.MaxTP.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayMaxTPWSEars then
					equip(sets.DayMaxTPWSEars)
				else
					equip(sets.precast.MaxTP)
				end
			else
			end
		else
			if state.WeaponskillMode.Current:contains('Acc') and not buffactive['Sneak Attack'] and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
				equip(sets.AccDayWSEars)
			elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
				equip(sets.DayWSEars)
			end
		end
		
	end

end

function job_post_midcast(spell, spellMap, eventArgs)

end

function job_aftercast(spell, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
		if spell.english:lower():contains('step') then
			state.CurrentStep:cycle()
		end
	end
end

function job_buff_change(buff, gain)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
		enable('main','sub','range')
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)

	if commandArgs[1] == 'RuneElement' then
		send_command('input /ja "'..state.RuneElement.value..'" <me>')

	elseif commandArgs[1] == 'SubJobEnmity' then

		if player.sub_job == 'RUN' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if abil_recasts[24] == 0 then
				send_command('input /ja "Swordplay" <me>')
			end

		elseif player.sub_job == 'BLU' and not moving then
			local spell_recasts = windower.ffxi.get_spell_recasts()
					
			if player.target.type ~= "MONSTER" then
				add_to_chat(123,'Abort: You are not targeting a monster.')
				return
			elseif spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <t>')
			elseif spell_recasts[598] == 0 then
				send_command('input /ma "Soporific" <t>')
			elseif spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <t>')
			elseif spell_recasts[575] == 0 then
				send_command('input /ma "Jettatura" <t>')
			elseif spell_recasts[592] == 0 then
				send_command('input /ma "Blank Gaze" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Blue Magic on cooldown.') end
			end
					
		elseif player.sub_job == 'WAR' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if state.HybridMode.value:contains('DD') then
				if buffactive['Defender'] then send_command('cancel defender') end
			elseif state.HybridMode.value ~= 'Normal' and not state.HybridMode.value:contains('DD') then
				if buffactive['Berserk'] then send_command('cancel berserk') end
			end
			
			if abil_recasts[5] == 0 and player.target.type == "MONSTER" then
				send_command('input /ja "Provoke" <t>')
			elseif abil_recasts[2] == 0 then
				send_command('input /ja "Warcry" <me>')
			elseif abil_recasts[3] == 0 then
				send_command('input /ja "Defender" <me>')
			elseif abil_recasts[4] == 0 then
				send_command('input /ja "Aggressor" <me>')
			elseif abil_recasts[1] == 0 then
				send_command('input /ja "Berserk" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Warrior Job Abilities on cooldown.') end
			end
			
		elseif player.sub_job == 'DNC' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
			if under3FMs then
				if abil_recasts[220] == 0 then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				return
				end
			elseif abil_recasts[221] == 0 then
				send_command('input /ja "Animated Flourish" <t>')
				return
			elseif abil_recasts[220] == 0 and not buffactive['Finishing Move 5'] then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				return
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'Dancer job abilities not needed.') end
			end
		end

	end

end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
	update_melee_groups()
	
    if state.RuneElement.value == 'Ignis' then
		RuneResist = "Ice"
		RuneDamage = 'Fire'
	elseif state.RuneElement.value == 'Gelus' then
		RuneResist = "Wind"
        RuneDamage = 'Ice'
	elseif state.RuneElement.value == 'Flabra' then
		RuneResist = "Earth"
        RuneDamage = 'Wind'
	elseif state.RuneElement.value == 'Tellus' then
		RuneResist = "Lightning"
		RuneDamage = 'Earth'
	elseif state.RuneElement.value == 'Sulpor' then
		RuneResist = "Water"
        RuneDamage = 'Lightning'
	elseif state.RuneElement.value == 'Unda' then
		RuneResist = "Fire"
		RuneDamage = 'Water'
	elseif state.RuneElement.value == 'Lux' then
		RuneResist = "Darkness"
		RuneDamage = 'Light'
	elseif state.RuneElement.value == 'Tenebrae' then
		RuneResist = "Light"
		RuneDamage = 'Darkness'
	end
	
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)

    if (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
		if player.mpp < 51 then
			idleSet = set_combine(idleSet, sets.latent_refresh)
		end
		
		if player.hpp < 71 then
			idleSet = set_combine(idleSet, sets.latent_regen)
		end
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.ExtraDefenseMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraDefenseMode.value])
    end
   
    return meleeSet

end

function job_customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
	
    if state.AutoDefenseMode.value == true then
        msg = msg .. ', Auto Defense: On'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' and player.equipment.sub ~= 'Svalinn' and player.equipment.sub ~= 'Priwen' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

function job_tick()
	if check_hasso() then return true end
	if state.AutoTankMode.value and player.target.type == "MONSTER" and not moving then
		if check_flash() then return true
		else 
			windower.send_command('gs c SubJobEnmity')
			tickdelay = 110
			return true
		end
	end
	return false
end

function check_flash()
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if spell_recasts[112] == 0 then
		send_command('input /ma "Flash" <t>')
		tickdelay = 120
		return true
	else
		return false
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()
		
		if player.equipment.main == "Burtgang" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end

function check_hasso()
	if not (state.Stance.value == 'None' or state.Buff.Hasso or state.Buff.Seigan) and player.sub_job == 'SAM' and player.in_combat then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if state.Stance.value == 'Hasso' and abil_recasts[138] == 0 then
			windower.chat.input('/ja "Hasso" <me>')
			tickdelay = 110
			return true
		elseif state.Stance.value == 'Seigan' and abil_recasts[139] == 0 then
			windower.chat.input('/ja "Seigan" <me>')
			tickdelay = 110
			return true
		end
	
	end
		
	return false
end