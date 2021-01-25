using TensorToolbox
using Plots
include("params.jl")
include("TL1RR.jl")
include("TLD.jl")
include("newton_update.jl")

function main()
    T_input = normalize(rand( 500, 500, 500),1)

    T_sugi, dkls = TLD(T_input)
    T_sugiN, dklsN = TLD_newton(T_input)

    T_kazu = TL1RR(T_input)
    dkl_exact = D_KL(normalize(T_input,1), normalize(T_kazu,1))
    display(dkl_exact)


    fnt1 = font(14)
    fnt2 = font(12)
    plt = plot([1:length(dkls);], dkls,
        size = (600,600),
        yguidefont  = fnt1,
        xguidefont  = fnt1,
        ytickfont   = fnt1,
        xtickfont   = fnt1,
        legendfont = fnt2,
        ylabel = "D_KL( T, Tt )",
        xlabel = "Step t",
        label = "LDT(Sugiyama,2018)",
        linewidth = 3)

    hline!(plt, [dklsN[end]],
        label = "LDT Newton(Sugiyama,2018)",
        color = :green,
        linewidth = 3,
        linestyle = :dashdotdot
       )

    hline!(plt, [dkl_exact],
        label = "D_KL( T, TL1RR(T) )",
        color = :red,
        linewidth = 3,
        linestyle = :dash
       )

    savefig("dkls.png")
end

main()
