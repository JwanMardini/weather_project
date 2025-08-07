import 'package:flutter/material.dart';
import 'package:weather_project/models/forecast_data.dart';
import 'package:weather_project/services/weather_service.dart';
import 'package:weather_project/widgets/forecast_app_bar.dart';
import 'package:weather_project/widgets/forecast_background_widget.dart';
import 'package:weather_project/widgets/forecast_list_widget.dart';
import 'package:weather_project/widgets/loading_widget.dart';
import 'package:weather_project/widgets/error_widget.dart' as custom;

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key, required this.title});

  final String title;

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final WeatherService _weatherService = WeatherService();
  
  ForecastData? _forecastData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadForecastData();
  }

  Future<void> _loadForecastData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final forecastData = await _weatherService.getForecastData();
      setState(() {
        _forecastData = forecastData;
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
      appBar: ForecastAppBar(
        title: widget.title,
        isLoading: _isLoading,
        onRefresh: _loadForecastData,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ForecastBackgroundWidget(
            weatherStatus: _forecastData?.forecasts.isNotEmpty == true
                ? _forecastData!.forecasts.first.weatherMain
                : null,
          ),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: LoadingWidget());
    } else if (_errorMessage != null) {
      return custom.ErrorWidget(
        errorMessage: _errorMessage!,
        onRetry: _loadForecastData,
      );
    } else if (_forecastData != null && _forecastData!.forecasts.isNotEmpty) {
      return ForecastListWidget(forecastData: _forecastData!);
    } else {
      return const Center(
        child: Text(
          'No forecast data available',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }
  }
}