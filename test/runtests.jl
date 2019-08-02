using Test, LinearAlgebra
# using Revise
using Plots, BinningAnalysis, BinningAnalysisPlots, Distributions
# pyplot()
gr()

function generate_correlated_data(n)
    n_thermalize = floor(Int, 0.03*n)
    A = Base.clamp.(0.3 .+ rand(n_thermalize,n_thermalize), 0, 1);
    A = 0.5*(A+A');
    issymmetric(A)
    A = A + n_thermalize*I;
    @assert isposdef(A)
    C = cholesky(A);
    y_corr = C.L'*rand(n_thermalize)

    i = floor(Int, n_thermalize*0.9)
    μ = mean(y_corr[i:end])
    σ = std(y_corr[i:end])
    y = vcat(y_corr, rand(Normal(μ, σ), n-n_thermalize))
end

n = 10_000
data = generate_correlated_data(n)
x = FullBinner(data)

plot(x)
savefig(joinpath(@__DIR__, "plot.png"))

histogram(x)
savefig(joinpath(@__DIR__, "histogram.png"))

binning(x)
savefig(joinpath(@__DIR__, "binning.png"))

corrplot(x)
savefig(joinpath(@__DIR__, "corrplot.png"))

tauplot(x)
savefig(joinpath(@__DIR__, "tauplot.png"))


x = LogBinner(data)

binning(x)

tauplot(x)

corrplot(x)
