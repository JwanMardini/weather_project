import 'package:flutter/material.dart';
import 'package:weather_project/models/forecast_data.dart';
import 'package:weather_project/utils/forecast_helper.dart';

class ForecastListWidget extends StatelessWidget {
  final ForecastData forecastData;

  const ForecastListWidget({
    super.key,
    required this.forecastData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5-Day Weather Forecast',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (forecastData.forecasts.isNotEmpty)
            Text(
              forecastData.city,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: forecastData.forecasts.length,
              itemBuilder: (context, index) {
                final forecast = forecastData.forecasts[index];
                return _buildForecastItem(forecast, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastItem(ForecastItem forecast, int index) {
    final isFirstItemOfDay = ForecastHelper.isFirstItemOfDay(forecastData.forecasts, index);
    
    return Column(
      children: [
        if (isFirstItemOfDay) _buildDayHeader(forecast.dateTime),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Row(
            children: [
              // Time
              Expanded(
                flex: 2,
                child: Text(
                  forecast.formattedTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              // Weather icon and description
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Icon(
                      ForecastHelper.getWeatherIcon(forecast.weatherDescription),
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        forecast.weatherDescription,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Temperature
              Expanded(
                flex: 2,
                child: Text(
                  forecast.temperatureString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Feels like
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      'Feels like',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      forecast.feelsLikeString,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // Humidity
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.white.withOpacity(0.7),
                      size: 16,
                    ),
                    Text(
                      forecast.humidityString,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayHeader(DateTime date) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        ForecastHelper.formatDayHeader(date),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
