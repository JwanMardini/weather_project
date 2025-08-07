class WeatherData {
  final String city;
  final DateTime date;
  final String weatherStatus;
  final double temperature;
  final double feelsLike;
  final double humidity;
  final String imageUrl;

  WeatherData({
    required this.city,
    required this.date,
    required this.weatherStatus,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.imageUrl,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      weatherStatus: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      imageUrl: 'http://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
    );
  }

  // Helper method to get temperature as string
  String get temperatureString => '${temperature.round()}°C';

  String get feelsLikeString => '${feelsLike.round()}°C';

  String get humidityString => '${humidity.round()}%';

  // Helper method to format date
  String get formattedDate => '${date.day}/${date.month}/${date.year}';
}
