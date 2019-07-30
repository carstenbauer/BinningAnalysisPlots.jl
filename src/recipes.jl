@recipe function f(l::FullBinner{T}) where T<:Number
    framestyle --> :grid
    legend --> true
    plottype = get(plotattributes, :seriestype, :plot)

    if plottype == :histogram
        @series begin
            color --> :lightblue
            alpha --> 0.6
            label --> ""
            l.x
        end
    elseif plottype == :binning
        # bss, R, means = BinningAnalysis.R_function(l.x)
        bss, errors, error_means = BinningAnalysis.all_binning_errors(l)
        @series begin
            label --> "standard error"
            seriestype := :line
            markershape --> :circle
            markercolor --> :lightgreen
            markersize --> 2
            color --> :lightgreen
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
            bss, error_means
        end
    else
        @series begin
            xlabel --> "time t"
            label --> "time series"
            markershape --> :circle
            markercolor --> :grey
            markersize --> 2
            color --> :grey
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
    elseif plottype == :binning
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
    if plottype != :binning
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
