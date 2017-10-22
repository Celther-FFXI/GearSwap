--Place you can overwrite specific functions and settings with your preferences.

state.DisplayMode.value = true --Set this to false if you don't want to display modes at the bottom of your screen.
state.ReEquip.value = true --Set this to false if you don't want it to reequip sets.Weapons when you aren't wearing any weapons.
state.AutoArts.value = true --Set this to false if you don't want it to automatically try to keep up Solace/Arts.

--Extra user functions to change how gearswap functions across jobs.

--Global binds you may want to change.
send_command('bind !@^f7 gs c toggle AutoWSMode') --Turns auto-ws mode on and off.
send_command('bind @f8 gs c toggle AutoNukeMode') --Turns auto-nuke mode on and off.
send_command('bind ^f8 gs c toggle AutoStunMode') --Turns auto-stun mode off and on.
send_command('bind !f8 gs c toggle AutoDefenseMode') --Turns auto-defense mode off and on.
send_command('bind ^@!f8 gs c toggle AutoTrustMode') --Summons trusts automatically.
send_command('bind @pause gs c toggle AutoBuffMode') --Automatically keeps certain buffs up, job-dependant.
send_command('bind f9 gs c cycle OffenseMode') --Changes offense settings such as accuracy.
send_command('bind ^f9 gs c cycle HybridMode') --Changes defense settings for melee such as PDT.
send_command('bind @f9 gs c cycle RangedMode') --Changes ranged offense settings such as accuracy.
send_command('bind !f9 gs c cycle WeaponskillMode') --Allows automatic weaponskilling if the job is setup to handle it.
send_command('bind f10 gs c set DefenseMode Physical') --Turns your physical defense set on.
send_command('bind ^f10 gs c cycle PhysicalDefenseMode') --Changes your physical defense set.
send_command('bind !f10 gs c toggle Kiting') --Keeps your kiting gear on..
send_command('bind f11 gs c set DefenseMode Magical') --Turns your magical defense set on.
send_command('bind ^f11 gs c cycle MagicalDefenseMode') --Changes your magical defense set.
send_command('bind @f11 gs c cycle CastingMode') --Changes your castingmode options such as magic accuracy.
send_command('bind ^f12 gs c cycle ResistDefenseMode') --Changes your resist defense set.
send_command('bind f12 gs c set DefenseMode Resist') --Turns your resist defense set on.
send_command('bind @f12 gs c cycle IdleMode') --Changes your idle mode options such as refresh.
send_command('bind !f12 gs c reset DefenseMode') --Turns your defensive mode off.
send_command('bind ^@!f12 gs reload') --Reloads gearswap.
send_command('bind pause gs c update user') --Runs a quick check to make sure you have the right gear on and checks variables.
send_command('bind ^@!pause gs org') --Runs organizer.
send_command('bind ^@!backspace gs c warpall') --Warps everyone home.
send_command('bind ^- gs c toggle selectnpctargets') --Change targets automatically.
send_command('bind ^= gs c cycle pctargetmode') --Change targets automatically.
send_command('bind ^r gs c weapons;gs c update') --Requips weapons and gear.
send_command('bind ^z gs c toggle Capacity') --Keeps capacity mantle on and uses capacity rings.
send_command('bind ^y gs c toggle AutoCleanupMode') --Uses certain items and tries to clean up inventory.
send_command('bind ^t gs c cycle treasuremode') --Toggles hitting htings with your treasure hunter set.
send_command('bind !t input /target <bt>') --Targets the battle target.
send_command('bind ^o fillmode') --Lets you see through walls.
send_command('bind @p gs equip sets.Sheltered') --Equip sheltered ring, for when being Pro/Shelled.
send_command('bind !p gs equip sets.Cure_Recieved') --Equip Cure Potency Recieved set for when being cured.
send_command('bind @m input /mount Crab') --Because I like Fenrir.

--Usable item binds.

--Warp ring binds.
send_command('bind ^@!h get "Warp Ring" satchel')
send_command('bind ^h gs c forceequip Warp ring2')
send_command('bind !h input /item "Warp Ring" <me>')
send_command('bind ^!h gs c quietenable ring2;put "Warp Ring" satchel')

--Nexus Cape binds.
send_command('bind ^@!n get "Nexus Cape" satchel')
send_command('bind ^n gs c forceequip Nexus back')
send_command('bind !n input /item "Nexus Cape" <me>')
send_command('bind ^!n gs c quietenable back;put "Nexus Cape" satchel')

--Dimensional Ring (Holla) binds.
send_command('bind ^@!, get "Dim. Ring (Holla)" satchel')
send_command('bind ^, gs c forceequip HollaRing ring2')
send_command('bind !, input /item "Dim. Ring (Holla)" <me>')
send_command('bind ^!, gs c quietenable ring2;put "Dim. Ring (Holla)" satchel')

--Dimensional Ring (Dem) binds.
send_command('bind ^@!. get "Dim. Ring (Dem)" satchel')
send_command('bind ^. gs c forceequip DemRing ring2')
send_command('bind !. input /item "Dim. Ring (Dem)" <me>')
send_command('bind ^!. gs c quietenable ring2;put "Dim. Ring (Dem)" satchel')

--Dimensional Ring (Mea) binds.
send_command('bind ^@!/ get "Dim. Ring (Mea)" satchel')
send_command('bind ^/ gs c forceequip MeaRing ring2')
send_command('bind !/ input /item "Dim. Ring (Mea)" <me>')
send_command('bind ^!/ gs c quietenable ring2;put "Dim. Ring (Mea)" satchel')

--Reraise Earring binds.
send_command('bind ^@!u get "Reraise Earring" satchel')
send_command('bind ^u gs c forceequip RREar ear2')
send_command('bind !u input /item "Reraise Earring" <me>')
send_command('bind ^!u gs c quietenable ear2;put "Reraise Earring" satchel')

--Capacity item binds.
send_command('bind ^@!z get "Mecisto. Mantle" satchel;get "Capacity Ring" satchel;wait 1;get "Trizek Ring" satchel;wait 1;get "Vocation Ring" satchel;wait 1;get "Facility Ring" satchel')
send_command('bind ^!z put "Mecisto. Mantle" satchel;put "Capacity Ring" satchel;wait 1;put "Trizek Ring" satchel;wait 1;put "Vocation Ring" satchel;wait 1;put "Facility Ring" satchel')