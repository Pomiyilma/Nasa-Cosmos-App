import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentations/screens/home_screen.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const NasaCosmos());
}

class NasaCosmos extends StatelessWidget {
  const NasaCosmos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nasa Cosmos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   runApp(const NasaCosmos());
// }
//
// class NasaCosmos extends StatelessWidget {
//   const NasaCosmos({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nasa Cosmos',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0A0A0A),
//         primaryColor: Colors.deepPurpleAccent,
//       ),
//       home: const HomeScreen(),   // We'll create this next
//     );
//   }
// }
//
// // Temporary HomeScreen
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Nasa Cosmos")),
//       body: const Center(child: Text("Milestone 2 Complete 🎉\nReady for UI")),
//     );
//   }
// }