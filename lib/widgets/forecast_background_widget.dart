import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_project/utils/weather_animation_helper.dart';

class ForecastBackgroundWidget extends StatelessWidget {
  final String? weatherStatus;

  const ForecastBackgroundWidget({
    super.key,
    this.weatherStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: WrapperScene.weather(
        scene: weatherStatus != null
            ? WeatherAnimationHelper.getWeatherScene(weatherStatus!)
            : WeatherScene.sunset,
      ),
    );
  }
}
