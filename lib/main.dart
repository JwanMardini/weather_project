import 'package:flutter/material.dart';
import 'package:weather_project/router/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
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
