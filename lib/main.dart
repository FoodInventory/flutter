import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_inventory/pages/app_menu.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Inventory',
      theme: ThemeData(
        colorScheme: ColorScheme?.fromSwatch(
          primarySwatch: Colors.green,
          primaryColorDark: Colors.green[700],
          accentColor: Colors.greenAccent[100],
          backgroundColor: Colors.green[50],
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const AppMenu(title: 'Food Inventory'),
    );
  }
}
