import 'package:go_router/go_router.dart';
import 'package:weather_project/pages/about_page.dart';
import 'package:weather_project/pages/home_page.dart';
import 'package:weather_project/pages/dashboard_page.dart';
import 'package:weather_project/pages/forecast_page.dart';

GoRouter appRouter = GoRouter(routes: [
  StatefulShellRoute.indexedStack(
    builder: (context, state, shell) => HomePage(shell: shell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => DashboardPage(title: 'Dashboard'),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/forecast',
            builder: (context, state) => ForecastPage(title: 'Forecast'),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/about',
            builder: (context, state) => AboutPage(title: 'About'),
          ),
        ],
      ),
    ],
  ),
]);