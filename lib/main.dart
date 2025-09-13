import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zip_link/functions/app_function.dart';
import 'package:zip_link/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    customStatusBar(Colors.black, Colors.black, Brightness.light, Brightness.light);
    return MaterialApp(
      title: 'ZipLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff2694A8),
          primary: Color(0xff47B0EE), //Color(0xff1E44C8),
          secondary: Color(0xff3EE379),
          tertiary: Color(0xffFEFEFE),
          surface: Color(0xff292B2D),
          brightness: Brightness.dark,
        ),        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
