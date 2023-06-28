import 'package:flutter/material.dart';
import 'package:zigy_demo/ui/views/dashboard.dart';
import 'package:zigy_demo/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zigy Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mobileBackgroundColor),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}