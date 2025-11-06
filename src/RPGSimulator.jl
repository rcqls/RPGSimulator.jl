module RPGSimulator

using Random, Dates, CSV, DataFrames, Distributions, StatsBase, Chain

include("classes.jl")
include("effets.jl")
include("attaques.jl")
include("skills.jl")
include("combat.jl")
include("simulation.jl")
include("visualisation.jl")

using .Classes
using .Effets
using .Attaques
using .Skills
using .Combat
using .Simulation
using .Visualisation

export simulate_many!, combat, attaquer, use_skill, afficher_stats,
       Stats, Classe, Archer, Mage, Chevalier, Gobelin

end
