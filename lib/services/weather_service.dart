import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_project/env.dart' as env;
import 'package:weather_project/models/weather_data.dart';
import 'package:weather_project/models/forecast_data.dart';

class WeatherService {
  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Check and request location permissions
  Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  // Get current position
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  // Fetch weather data from API
  Future<WeatherData> fetchWeatherData(Position position) async {
    try {
      var client = http.Client();
      var uri =
          '${env.OPENWEATHER_API_URL}lat=${position.latitude}&lon=${position.longitude}&appid=${env.OPENWEATHER_API_KEY}&units=metric';
      var url = Uri.parse(uri);
      var response = await client.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        var data = response.body;
        var weatherData = jsonDecode(data);
        return WeatherData.fromJson(weatherData);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenWeather API configuration.');
      } else if (response.statusCode == 404) {
        throw Exception('Weather data not found for your location.');
      } else {
        throw Exception('Failed to fetch weather data. Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Get complete weather data with location checks
  Future<WeatherData> getWeatherData() async {
    // Check if location services are enabled
    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable location services and try again.');
    }

    // Check location permission
    LocationPermission permission = await checkLocationPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied. Please grant location permission to get weather data.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied. Please enable location permission in settings.');
    }

    // Get current position and fetch weather data
    Position position = await getCurrentPosition();
    return await fetchWeatherData(position);
  }

  // Get forecast data
  Future<ForecastData> getForecastData() async {
    // Check if location services are enabled
    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable location services and try again.');
    }

    // Check location permission
    LocationPermission permission = await checkLocationPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied. Please grant location permission to get weather data.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied. Please enable location permission in settings.');
    }

    // Get current position and fetch forecast data
    Position position = await getCurrentPosition();
    return await fetchForecastData(position);
  }

  // Fetch forecast data from API
  Future<ForecastData> fetchForecastData(Position position) async {
    try {
      var client = http.Client();
      var uri =
          '${env.OPENWEATHER_FORECAST_API_URL}lat=${position.latitude}&lon=${position.longitude}&appid=${env.OPENWEATHER_API_KEY}&units=metric';
      var url = Uri.parse(uri);
      var response = await client.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        var data = response.body;
        var forecastData = jsonDecode(data);
        return ForecastData.fromJson(forecastData);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenWeather API configuration.');
      } else if (response.statusCode == 404) {
        throw Exception('Weather data not found for your location.');
      } else {
        throw Exception('Failed to fetch weather data. Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }

}