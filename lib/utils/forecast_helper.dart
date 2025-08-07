import 'package:flutter/material.dart';

class ForecastHelper {
  /// Formats date into a readable day header
  /// Example: "Monday, Aug 7"
  static String formatDayHeader(DateTime date) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 
      'Friday', 'Saturday', 'Sunday'
    ];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }

  /// Returns appropriate weather icon for given weather status
  static IconData getWeatherIcon(String weatherStatus) {
    String status = weatherStatus.toLowerCase();
    
    if (status.contains('clear')) {
      return Icons.wb_sunny;
    } else if (status.contains('cloud')) {
      return Icons.cloud;
    } else if (status.contains('rain')) {
      return Icons.water_drop;
    } else if (status.contains('drizzle')) {
      return Icons.grain;
    } else if (status.contains('thunderstorm')) {
      return Icons.flash_on;
    } else if (status.contains('snow')) {
      return Icons.ac_unit;
    } else if (status.contains('mist') || status.contains('fog')) {
      return Icons.blur_on;
    } else {
      return Icons.wb_cloudy;
    }
  }

  /// Checks if this forecast item is the first entry of a new day
  static bool isFirstItemOfDay(List<dynamic> forecasts, int index) {
    if (index == 0) return true;
    
    final currentDate = forecasts[index].dateTime;
    final previousDate = forecasts[index - 1].dateTime;
    
    return currentDate.day != previousDate.day;
  }
}
