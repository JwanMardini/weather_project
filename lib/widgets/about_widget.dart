import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';


class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

    @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            // Background Weather Animation
            Positioned.fill(
              child: WrapperScene.weather(
                scene: WeatherScene.sunset,
              ),
            ),
            // Content overlay
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Weather App',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Developed for course 1DV535 at Linnaeus University using Flutter and OpenWeatherMap API.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Developed by Jwan Mardini',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
  }

}