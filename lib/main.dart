import 'package:flutter/material.dart';
import 'package:my_blogz/presentation/screens/main_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      title: 'My Blogz',
      home: const MainScreen(),
    ),
  );
}
