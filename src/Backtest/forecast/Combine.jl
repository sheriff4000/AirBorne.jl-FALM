module Combine

"""
This struct represents a forecaster that can be combined with others

Can apply forecast to data with the following signature:
forecastFunction(data::Vector{Real}, params::Real...; F::Int=1) -> Vector{Real}
"""
struct Forecaster
    forecastFunction::Function
    params::Vector{Real}
end

"""
This function applies a forecast to a dataset

Arguments:
- forecaster::Forecaster: The forecaster to use
- data::Vector{Real}: The data to forecast
- F::Int: The number of future values to forecast

Returns:
- forecast::Vector{Real}: The forecast
"""
function applyForecast(forecaster::Forecaster, data; F=1)
    return forecaster.forecastFunction(data, forecaster.params...; F=F)
end

"""
This function combines the forecasts of multiple forecasters

Arguments:
- forecasters::Vector{(Forecaster, Real)}: The forecasters to combine and their associated weights
- data::Vector{Real}: The data to forecast
- F::Int: The number of future values to forecast

Returns:
- combinedForecast::Vector{Real}: The combined forecast
"""
function combineForecasts(forecasters::Vector{Tuple{Forecaster,Real}})
    function forecasterFun(data::Vector{Real}, params::Real...; F::Int=1)
        combinedForecast = zeros(F)
        for (forecaster, weight) in forecasters
            forecast = applyForecast(forecaster, data; F=F)
            combinedForecast += forecast .* weight
        end
    end

    return Forecaster(forecasterFun, [])
end

end
