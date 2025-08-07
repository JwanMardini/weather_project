import 'package:flutter/material.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLoading;
  final VoidCallback onRefresh;

  const WeatherAppBar({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 10.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: isLoading ? null : onRefresh,
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
            size: 28,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          tooltip: 'Refresh weather data',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
