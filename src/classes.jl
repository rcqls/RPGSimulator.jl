module Classes

export Stats, Classe, Archer, Mage, Chevalier, Gobelin

mutable struct Stats
    PV::Int
    PM::Int
    ATK::Int
    VITESSE::Int
    DEFENSE::Int
end
Stats(; PV=100, PM=50, ATK=10, VITESSE=10, DEFENSE=10) = Stats(PV, PM, ATK, VITESSE, DEFENSE)

abstract type Classe end

mutable struct Archer <: Classe
    nom::String
    stats::Stats
    effects::Vector{Any}
end
Archer(; nom="Robin") = Archer(nom, Stats(PV=90, PM=30, ATK=15, VITESSE=20, DEFENSE=8), [])

mutable struct Mage <: Classe
    nom::String
    stats::Stats
    effects::Vector{Any}
end
Mage(; nom="Gandalf") = Mage(nom, Stats(PV=70, PM=100, ATK=25, VITESSE=12, DEFENSE=6), [])

mutable struct Chevalier <: Classe
    nom::String
    stats::Stats
    effects::Vector{Any}
end
Chevalier(; nom="Arthur") = Chevalier(nom, Stats(PV=120, PM=20, ATK=18, VITESSE=10, DEFENSE=20), [])

mutable struct Gobelin <: Classe
    nom::String
    stats::Stats
    effects::Vector{Any}
end
Gobelin(; nom="Gabimarou") = Gobelin(nom, Stats(PV=60, PM=10, ATK=12, VITESSE=14, DEFENSE=5), [])

function Base.show(io::IO, perso::Classe)
    cls = typeof(perso).name.name
    st = perso.stats
    println(io, "$(perso.nom) le $cls")
    println(io, "  PV: $(st.PV) | PM: $(st.PM) | ATK: $(st.ATK) | VIT: $(st.VITESSE) | DEF: $(st.DEFENSE)")
end

end # module Classes
