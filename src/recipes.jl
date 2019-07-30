@recipe function f(l::FullBinner{T}) where T<:Number
    framestyle --> :grid
    size --> (750, 500)
    plottype = get(plotattributes, :seriestype, :plot)

    if plottype == :histogram
        @series begin
            color --> :lightblue
            alpha --> 0.6
            label --> ""
            legend --> true
            l.x
        end
    elseif plottype == :binning
        bss, errors, error_means = BinningAnalysis.all_binning_errors(l)
        @series begin
            label --> "standard error"
            seriestype := :line
            markershape --> :circle
            markercolor --> :lightgreen
            markersize --> 2
            color --> :lightgreen
            legend --> true
            bss, errors
        end

        @series begin
            seriestype := :line
            xlabel --> "bin sizes"
            label --> "cumulative mean"
            markershape --> :circle
            markercolor --> :green
            markersize --> 2
            color --> :green
            legend --> true
            bss, error_means
        end
    elseif plottype == :corrplot
        @series begin
            bss, errors, error_means = BinningAnalysis.all_binning_errors(l)
            taus = tau.(Ref(l), errors)
            seriestype := :line
            xlabel --> "bin sizes"
            ylabel --> "autocorrelation time"
            markershape --> :circle
            markercolor --> :blue
            markersize --> 2
            color --> :blue
            legend --> false
            bss, taus
        end
    else
        @series begin
            xlabel --> "time t"
            label --> "time series"
            markershape --> :circle
            markercolor --> :grey
            markersize --> 2
            color --> :grey
            legend --> true
            l.x
        end
    end

    μ = mean(l)
    if plottype == :histogram
        @series begin
            seriestype := :vline
            color --> :black
            label --> "mean"
            fill(μ, length(l))
        end
    elseif plottype in (:binning, :corrplot)
        nothing
    else
        @series begin
            seriestype := :hline
            color --> :purple
            label --> "mean"
            fill(μ, length(l))
        end
    end

    Δ = std_error(l)
    if !(plottype in (:binning, :corrplot))
        for i in (1, -1)
            @series begin
                seriestype := (plottype == :histogram ? :vline : :hline)
                color --> :violet
                label --> (i == 1 ? "std error" : "")
                fill(μ + i*Δ, length(l))
            end
        end
    end
end

@shorthands binning
@shorthands corrplot
