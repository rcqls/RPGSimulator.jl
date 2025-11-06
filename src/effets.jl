module Effets

using ..Classes

export StatusEffect, Poison, Shield, Stun, Regen, Bleed, apply_effects_round!, apply_effect!

abstract type StatusEffect end

mutable struct Poison <: StatusEffect
    remaining::Int
    dmg_per_turn::Int
end

mutable struct Shield <: StatusEffect
    remaining::Int
    flat_block::Int
end

mutable struct Stun <: StatusEffect
    remaining::Int
end

mutable struct Regen <: StatusEffect
    remaining::Int
    heal_per_turn::Int
end

mutable struct Bleed <: StatusEffect
    remaining::Int
    dmg_per_turn::Int
end

function apply_effects_round!(c::Classes.Classe)
    new_effects = Any[]
    total_shield, total_poison, total_bleed, regen_amount = 0, 0, 0, 0
    stunned = false

    for e in c.effects
        if e isa Poison
            total_poison += e.dmg_per_turn
            e.remaining -= 1
        elseif e isa Shield
            total_shield += e.flat_block
            e.remaining -= 1
        elseif e isa Bleed
            total_bleed += e.dmg_per_turn
            e.remaining -= 1
        elseif e isa Stun
            stunned = true
            e.remaining -= 1
        elseif e isa Regen
            regen_amount += e.heal_per_turn
            e.remaining -= 1
        end
        if e.remaining > 0
            push!(new_effects, e)
        end
    end

    c.effects = new_effects

    if regen_amount > 0
        c.stats.PV += regen_amount
        println("$(c.nom) regenère $regen_amount PV.")
    end

    total_damage = total_poison + total_bleed
    if total_damage > 0
        c.stats.PV = max(c.stats.PV - total_damage, 0)
        println("$(c.nom) subit $total_damage dégâts (poison/bleed).")
    end

    return (total_shield, stunned, regen_amount, total_damage)
end

apply_effect!(c::Classe) = apply_effects_round!(c)[1]

end # module Effets
