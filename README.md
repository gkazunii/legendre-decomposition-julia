legendre-decomposition-julia
====

An implementation of Legendre Decomposition for CP_rank-1 approximation in Julia.

## Description

An implementation of the Legendre Decomposition[[1]](https://papers.nips.cc/paper/8097-legendre-decomposition-for-tensors) in Julia(>=1.5), which is non-negative tensor decomposition method using information geometric formulation of the log-linear model. This implementation is only for CP_rank-1 approximation.

This is not an official implementation and the author's implementation in C++ is available here [[2]](https://github.com/mahito-sugiyama/Legendre-decomposition).
Implementation in python is also available here [[3]](https://github.com/Yhkwkm/legendre-decomposition-python)



## Usage
```julia
include("LD.jl")

# generate any-order non-negative tensor.
T = rand(8, 5, 3, 2)

# run Legendre Decomposition in newton method
R = TLD_newton(T)

# compute reconstruction error in Fnorm.
reconst_error = norm( R - T )
```

`TLD_newton` offers some options including the following:

- `tol` : float, default: 1e-5
  - Tolerance of the stopping condition.

- `cnt_max` : integer, default: 20
  - Maximum number of iterations before timing out.

- `verbose` : bool, default: true


`TLD` offers some options including the following:

- `tol` : float, default: 1e-5
  - Tolerance of the stopping condition.

- `cnt_max` : integer, default: 100
  - Maximum number of iterations before timing out.

- `learning_rate` : float, default: 0.01
  - The learning rate used in gradient descent method.



## Licence

[MIT](https://github.com/Yhkwkm/legendre-decomposition-python/blob/master/LICENSE)

## References
[[1] M. Sugiyama, H. Nakahara, K. Tsuda. Legendre Decomposition for Tensors. Advances in Neural Information Processing Systems 31(NeurIPS2018), pages 8825-8835, 2018.](https://papers.nips.cc/paper/8097-legendre-decomposition-for-tensors)
