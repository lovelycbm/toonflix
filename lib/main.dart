import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  // ApiService().getTodaysToon();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
