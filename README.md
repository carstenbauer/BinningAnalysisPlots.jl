# BinningAnalysisPlots.jl

Plotting recipes for BinningAnalysis.jl

Supported series types

* `FullBinner`: `plot, histogram, binning, corrplot`
* `LogBinner`: `binning, corrplot`

## Examples

```julia
using Plots, BinningAnalysis, BinningAnalysisPlots

x = FullBinner(randn(1000)) # uncorrelated test data

plot(x)
histogram(x)
binning(x)
corrplot(x)
```


<img src="test/plot.png" width=500>
<img src="test/histogram.png" width=500>
<img src="test/binning.png" width=500>
<img src="test/corrplot.png" width=500>
