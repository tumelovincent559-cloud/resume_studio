
import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Studio',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}
