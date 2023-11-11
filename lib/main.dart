import 'package:flutter/material.dart';
import 'package:my_blogz/presentation/main_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      title: 'My Blogz',
      home: const HomePage(),
    ),
  );
}
