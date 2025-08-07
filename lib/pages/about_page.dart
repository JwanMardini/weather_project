import 'package:flutter/material.dart';
import 'package:weather_project/widgets/about_widget.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        extendBodyBehindAppBar: true,
        body: const AboutWidget(),
    );
  }
}