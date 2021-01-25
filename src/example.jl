using TensorToolbox
using Plots
include("params.jl")
include("LD.jl")
include("newton_update.jl")

function main()
    T = normalize(rand( 100,100, 100),1)

    T_sugi  = TLD(T)
    T_sugiN = TLD_newton(T)
end

main()
