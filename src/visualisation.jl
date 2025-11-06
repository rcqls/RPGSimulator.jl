module Visualisation

using CSV, DataFrames

# déclaration globale
const has_makie = Ref(false)

try
    using CairoMakie
    has_makie[] = true
catch
    @warn "Makie non installé — visualisation désactivée."
end

export plot_pv_timeline

function plot_pv_timeline(file::String)
    if !has_makie[] 
        println("Makie non disponible.") 
        return 
    end
    df = CSV.read(file, DataFrame)
    fig = Figure(size=(900,500))
    ax = Axis(fig[1,1], title="PV moyen par round", xlabel="Round", ylabel="PV")
    for name in unique(df.actor)
        sub = filter(:actor => ==(name), df)
        rounds = sort(unique(sub.round))
        mean_pv = [mean(filter(r -> r.round == R, sub).pv) for R in rounds]
        lines!(ax, rounds, mean_pv, label=name)
    end
    axislegend(ax)
    save("data/pv_vs_round.png", fig)
end

end # module Visualisation