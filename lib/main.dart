
import 'package:flutter/material.dart';
import 'package:weather_project/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


void main() {
  runApp(const MainApp());
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      builder: (context, child) {
        if (!_isConnected) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
        return child!;
      },
    );
  }
}



// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int myindex = 0;
//   List<Widget> pages = [
//     const HomePage(),
//     const AboutPage(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: myindex,
//         children: pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (value) => {
//           setState(() {
//             myindex = value;
//           })
//         },
//         currentIndex: myindex,
//         items: [
//         BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: const Icon(Icons.info), label: 'About'),
//       ]),
//     );
//   }
// }
