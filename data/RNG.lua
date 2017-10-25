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

	state.AutoAmmoMode = M(true,'Auto Ammo Mode')
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Jishnu\'s Radiance','Empyreal Arrow','Last Stand'}
	
	autows = "Last Stand"
	autofood = 'Soy Ramen'
	
	update_combat_form()
	
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoFoodMode","RngHelper","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"OffenseMode","RangedMode","WeaponskillMode","IdleMode","Passive","RuneElement","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_precast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end

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
        if buffactive['Double Shot'] and sets.buff['Double Shot'] then
			equip(sets.buff['Double Shot'])
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
	
	end
	
end

function job_self_command(commandArgs, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if buffactive['Double Shot'] and sets.buff['Double Shot'] then
			equip(sets.buff['Double Shot'])
		end

		if state.Buff.Barrage and sets.buff.Barrage then
			equip(sets.buff.Barrage)
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        if not buffactive['Velocity Shot'] then
            send_command('@input /ja "Velocity Shot" <me>')
        end
    end
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] or player.wardrobe2[U_Shot_Ammo[player.equipment.range]] or player.wardrobe3[U_Shot_Ammo[player.equipment.range]] or player.wardrobe4[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] or player.wardrobe2[DefaultAmmo[player.equipment.range]] or player.wardrobe3[DefaultAmmo[player.equipment.range]] or player.wardrobe4[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] or player.wardrobe2[DefaultAmmo[player.equipment.range]] or player.wardrobe3[DefaultAmmo[player.equipment.range]] or player.wardrobe4[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] or player.wardrobe2[DefaultAmmo[player.equipment.range]] or player.wardrobe3[DefaultAmmo[player.equipment.range]] or player.wardrobe4[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		else
			if ammo_left() < 15 then
				add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname:ucfirst().."' running low: ("..ammo_left()..") remaining.")
			end
		end
	end
end

function job_tick()
	if check_ammo_makers() then return true end
	return false
end

function check_ammo_makers()
	if state.AutoAmmoMode.value and player.equipment.range then
			if player.equipment.range == 'Fomalhaut' and get_item_next_use(player.equipment.range).usable then
				if count_total_ammo('Chrono Bullet') < 200 then
					windower.chat.input('/item "Fomalhaut" <me>')
					add_to_chat(217,"You're low on Chrono Bullets, using Fomalhaut.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Fail-Not' and get_item_next_use(player.equipment.range).usable then
				if count_total_ammo('Chrono Arrow') < 200 then
					windower.chat.input('/item "Fail-Not" <me>')
					add_to_chat(217,"You're low on Chrono Arrows, using Fail-Not.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Gandiva' and get_item_next_use(player.equipment.range).usable then
				if count_total_ammo("Artemis's Arrow") < 200 then
					windower.chat.input('/item "Gandiva" <me>')
					add_to_chat(217,"You're low on Artemis's Arrows, using Gandiva.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Yoichinoyumi' and get_item_next_use(player.equipment.range).usable then
				if count_total_ammo("Yoichi's Arrow") < 200 then
					windower.chat.input('/item "Yoichinoyumi" <me>')
					add_to_chat(217,"You're low on Yoichi's Arrows, using Yoichinoyumi.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Annihilator' and get_item_next_use(player.equipment.range).usable then
				if count_total_ammo("Eradicating Bullet") < 200 then
					windower.chat.input('/item "Annihilator" <me>')
					add_to_chat(217,"You're low on Eradicating Bullets, using Annihilator.")
					tickdelay = 120
				end
			elseif player.equipment.range == 'Armageddon' and get_item_next_use(player.equipment.range).usable then
				if count_total_ammo("Devastating Bullet") < 200 then
					windower.chat.input('/item "Armageddon" <me>')
					add_to_chat(217,"You're low on Devastating Bullets, using Armageddon.")
					tickdelay = 120
				end
			end
	end
	return false
end

function count_total_ammo(bullet_name)
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