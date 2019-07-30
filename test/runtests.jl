using Test
using Revise
using Plots, BinningAnalysis, BinningAnalysisPlots
# pyplot()
gr()

x = FullBinner(randn(1000))

plot(x)
savefig(joinpath(@__DIR__, "plot.png"))

histogram(x)
savefig(joinpath(@__DIR__, "histogram.png"))

binning(x)
savefig(joinpath(@__DIR__, "binning.png"))

corrplot(x)
savefig(joinpath(@__DIR__, "corrplot.png"))
