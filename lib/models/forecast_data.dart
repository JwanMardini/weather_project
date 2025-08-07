class ForecastData {
  final String city;
  final List<ForecastItem> forecasts;

  ForecastData({
    required this.city,
    required this.forecasts,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List<ForecastItem> forecastList = [];
    
    if (json['list'] != null) {
      for (var item in json['list']) {
        forecastList.add(ForecastItem.fromJson(item));
      }
    }

    return ForecastData(
      city: json['city']['name'] ?? 'Unknown',
      forecasts: forecastList,
    );
  }
}

class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final String weatherMain;
  final String weatherDescription;
  final int humidity;
  final double windSpeed;
  final String icon;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.weatherMain,
    required this.weatherDescription,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      feelsLike: (json['main']['feels_like'] ?? 0).toDouble(),
      minTemperature: (json['main']['temp_min'] ?? 0).toDouble(),
      maxTemperature: (json['main']['temp_max'] ?? 0).toDouble(),
      weatherMain: json['weather'][0]['main'] ?? 'Unknown',
      weatherDescription: json['weather'][0]['description'] ?? 'No description',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      icon: json['weather'][0]['icon'] ?? '01d',
    );
  }

  // Helper methods for display formatting
  String get temperatureString => '${temperature.round()}°C';
  
  String get feelsLikeString => '${feelsLike.round()}°C';
  
  String get humidityString => '${humidity}%';
  
  String get formattedTime => '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  
  String get formattedDate => '${dateTime.day}/${dateTime.month}';
  
  String get dayName {
    List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[dateTime.weekday - 1];
  }

  String get dayHeader {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dayName}, ${months[dateTime.month - 1]} ${dateTime.day}';
  }
}