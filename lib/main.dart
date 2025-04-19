import 'package:flutter/material.dart';
import 'screens/initial_page.dart';
import 'screens/items_page.dart'; // Import halaman ItemsPage
import 'screens/dashboard_page.dart'; // Import halaman ItemsPage


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logistikin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const InitialPage(),
      routes: {
        '/items': (context) => const ItemsPage(), // Tambahkan route untuk ItemsPage
        '/dashboard': (context) => const DashboardPage(), // Tambahkan route untuk ItemsPage

      },
    );
  }
}