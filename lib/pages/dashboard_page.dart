import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_project/models/weather_data.dart';
import 'package:weather_project/services/weather_service.dart';
import 'package:weather_project/utils/weather_animation_helper.dart';
import 'package:weather_project/widgets/loading_widget.dart';
import 'package:weather_project/widgets/error_widget.dart' as custom;
import 'package:weather_project/widgets/weather_info_widget.dart';
import 'package:weather_project/widgets/weather_app_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.title});

  final String title;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final WeatherService _weatherService = WeatherService();
  
  WeatherData? _weatherData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final weatherData = await _weatherService.getWeatherData();
      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeatherAppBar(
        title: widget.title,
          isLoading: _isLoading,
          onRefresh: _loadWeatherData,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Background Weather Animation
            if (_weatherData != null)
              Positioned.fill(
                child: WrapperScene.weather(
                  scene: WeatherAnimationHelper.getWeatherScene(
                    _weatherData!.weatherStatus,
                  ),
                ),
              ),
            // Content overlay
            Center(
              child: _buildContent(),
            ),
          ],
        ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const LoadingWidget();
    } else if (_errorMessage != null) {
      return custom.ErrorWidget(
        errorMessage: _errorMessage!,
        onRetry: _loadWeatherData,
      );
    } else if (_weatherData != null) {
      return WeatherInfoWidget(weatherData: _weatherData!);
    } else {
      return const SizedBox.shrink();
    }
  }
}