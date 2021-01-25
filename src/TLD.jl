using TensorToolbox
using LinearAlgebra
using Plots
include("params.jl")
include("TL1RR.jl")
include("newton_update.jl")

function D_KL(A, B)
    return sum(A .* log.( A ./ B ) ) - sum(A) + sum(B)
end

function TLD_newton(T, cnt_max=20, tol = 1.0e-5)
    tensor_shape = size(T)
    sumt = sum(T)
    T .= T ./ sumt

    theta = get_uniform_theta( tensor_shape )
    eta = get_uniform_eta( tensor_shape )
    eta_beta = rapid_eta_from_tensor(T)

    dkls = []
    cnt = 0
    R = undef
    prev_eta = undef
    while cnt < cnt_max
        prev_eta = eta

        theta = newton_update_theta(eta, eta_beta, theta)
        R = rapid_tensor_from_theta(theta)
        normalize!(R,1)
        eta = rapid_eta_from_tensor(R)

        dif = norm(eta - eta_beta)
        cnt += 1
        dkl = D_KL(T, R)
        append!(dkls, dkl)
        println("step $cnt newton error $dkl cost $dif")
        if dif < tol
            break
        end
    end

    R = sumt * R
    return R, dkls
end


function TLD(T, cnt_max=100, lr=0.01, tol = 1.0e-5)
    tensor_shape = size(T)
    d = ndims(T)
    sumt = sum(T)
    T .= T ./ sumt

    theta = get_uniform_theta( tensor_shape )
    eta = get_uniform_eta( tensor_shape )
    eta_beta = rapid_eta_from_tensor(T)

    dkls = []
    cnt = 0
    R = undef
    previous_eta = undef
    while cnt < cnt_max

        for k = 1:d
            for j = 1:tensor_shape[k]
                idxs = ones(Int, d)
                idxs[k] = j
                theta[ idxs... ] -= lr * (eta[idxs...] - eta_beta[idxs...])
            end
        end

        R = rapid_tensor_from_theta(theta)
        normalize!(R,1)
        eta = rapid_eta_from_tensor(R)

        cnt += 1
        dkl = D_KL(T,R)
        append!(dkls, dkl)
        println("step $cnt grad_decent error $dkl")

        dif = norm(eta - eta_beta)
        if dif < tol
            break
        end
    end

    R = sumt * R
    return R, dkls
end
