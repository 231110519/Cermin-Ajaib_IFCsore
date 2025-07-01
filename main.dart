// main.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/provider/detail_provider.dart';
import 'package:projek_cerminajaib/provider/diet_provider.dart';
import 'package:projek_cerminajaib/provider/keranjang_provider.dart';
import 'package:projek_cerminajaib/provider/olahraga_provider.dart';
import 'package:projek_cerminajaib/provider/theme_provider.dart';
import 'package:projek_cerminajaib/screens/Home/home.dart';





import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
        ChangeNotifierProvider(create: (_) => KeranjangProvider()),
        ChangeNotifierProvider(create: (_) => ContainerProvider ()),
        ChangeNotifierProvider(create: (_) => OlahragaProvider()),
        ChangeNotifierProvider(create: (_) => DietProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: Home()
    );
  }
}


