using TensorToolbox
using Plots
include("params.jl")
include("TL1RR.jl")
include("TLD.jl")
include("newton_update.jl")

function main()
    T = normalize(rand( 500, 500, 500),1)

    T_sugi, dkls = TLD(T)
    T_sugiN, dklsN = TLD_newton(T)

end

main()
