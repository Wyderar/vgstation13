
/datum/artifact_effect/gasnitro
	effecttype = "gasnitro"
	var/max_pressure
	var/target_percentage
	copy_for_battery = list("max_pressure")

/datum/artifact_effect/gasnitro/New()
	..()
	effect = pick(EFFECT_TOUCH, EFFECT_AURA)
	effect_type = pick(6,7)
	max_pressure = rand(115,1000)

/datum/artifact_effect/gasnitro/DoEffectTouch(var/mob/user)
	if(holder)
		var/datum/gas_mixture/env = holder.loc.return_air()
		if(env)
			env.adjust_gas(GAS_NITROGEN, rand(2,15))

/datum/artifact_effect/gasnitro/DoEffectAura()
	if(holder)
		var/datum/gas_mixture/env = holder.loc.return_air()
		if(env && env.return_pressure() < max_pressure)
			env.adjust_gas(GAS_NITROGEN, pick(0, 0, 0.1, rand()))
