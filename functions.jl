
using Symbolics

function nTHzo(omega, T)

    nTHz = real.(sqrt.(er(omega, T)))

end

function er(omega, T)

    A = [4.262e-2, 1.193e-2, 3, 0.008, 0.0029, 0.005]
    oi = [56, 94.82, 182, 239, 299, 351]
    gi = [13.06, 8.18, 0.9, 6.7, 9.3, 10.3]
    es = 6.8

    tsc = 200e-15
    meff = 0.11 * 9.109e-31
    q = 1.602e-19
    e0 = 8.8541878e-12
    Nc = 0
    op2 = q^2 * Nc / e0 / meff

    er_ = @. es + A[1] * oi[1] .^ 2 ./ (oi[1] .^ 2 - omega .^ 2 * 0.01^2 / (2 * pi * 3e8)^2 - 2 * 1im * gi[1] * omega * 0.01 / (2 * pi * 3e8)) +
             A[2] * oi[2] .^ 2 ./ (oi[2] .^ 2 - omega .^ 2 * 0.01^2 / (2 * pi * 3e8)^2 - 2 * 1im * gi[2] * omega * 0.01 / (2 * pi * 3e8)) +
             A[3] * oi[3] .^ 2 ./ (oi[3] .^ 2 - omega .^ 2 * 0.01^2 / (2 * pi * 3e8)^2 - 2 * 1im * gi[3] * omega * 0.01 / (2 * pi * 3e8)) +
             A[4] * oi[4] .^ 2 ./ (oi[4] .^ 2 - omega .^ 2 * 0.01^2 / (2 * pi * 3e8)^2 - 2 * 1im * gi[4] * omega * 0.01 / (2 * pi * 3e8)) +
             A[5] * oi[5] .^ 2 ./ (oi[5] .^ 2 - omega .^ 2 * 0.01^2 / (2 * pi * 3e8)^2 - 2 * 1im * gi[5] * omega * 0.01 / (2 * pi * 3e8)) +
             A[6] * oi[6] .^ 2 ./ (oi[6] .^ 2 - omega .^ 2 * 0.01^2 / (2 * pi * 3e8)^2 - 2 * 1im * gi[6] * omega * 0.01 / (2 * pi * 3e8)) -
             op2 ./ (omega .^ 2 + 1im * omega / tsc)
    if typeof(omega) != Float64
      er_[isnan.(er_)] .= 1
      er_[isinf.(er_)] .= 1
    end
    return er_

end


