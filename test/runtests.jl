using Test
using Revise
using Plots, BinningAnalysis, BinningAnalysisPlots
# pyplot()
gr()

x = FullBinner(randn(1000))

plot(x)
savefig(joinpath(@__DIR__, "plot.pdf"))

histogram(x)
savefig(joinpath(@__DIR__, "histogram.pdf"))

binning(x)
savefig(joinpath(@__DIR__, "binning.pdf"))
