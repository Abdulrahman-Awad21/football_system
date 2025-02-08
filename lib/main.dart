import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:football_system/firebase_options.dart';
import 'package:football_system/view_models/player_view_model.dart'; // Import PlayerViewModel
import 'package:provider/provider.dart'; // Import Provider
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Add Key? key

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Use MultiProvider for multiple providers if needed
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerViewModel()), // Provide PlayerViewModel
      ],
      child: MaterialApp(
        title: 'Football Coach App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}