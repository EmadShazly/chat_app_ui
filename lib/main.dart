import 'package:flutter/material.dart';
import 'package:shazly_chat/theme.dart';

import 'screens/screens_exports.dart';
 
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.dark(),
      
      debugShowCheckedModeBanner: false,
      title: 'Chatter App',
      theme: AppTheme.dark(),
      home:   HomeScreen(),
    );
  }
}

 