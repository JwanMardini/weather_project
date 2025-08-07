import 'package:weather_animation/weather_animation.dart';

class WeatherAnimationHelper {
  // Map weather description to WeatherScene
  static WeatherScene getWeatherScene(String weatherDescription) {
    String description = weatherDescription.toLowerCase();
    
    if (description.contains('clear') || description.contains('sunny')) {
      return WeatherScene.sunset;
    } else if (description.contains('cloud')) {
      return WeatherScene.rainyOvercast;
    } else if (description.contains('rain') || description.contains('drizzle')) {
      return WeatherScene.rainyOvercast;
    } else if (description.contains('snow')) {
      return WeatherScene.snowfall;
    } else if (description.contains('thunder') || description.contains('storm')) {
      return WeatherScene.stormy;
    } else if (description.contains('mist') || description.contains('fog') || description.contains('haze')) {
      return WeatherScene.rainyOvercast; // Use overcast for misty/foggy conditions
    } else if (description.contains('hot') || description.contains('scorching')) {
      return WeatherScene.scorchingSun;
    } else {
      return WeatherScene.sunset; // Default fallback
    }
  }
}
