import 'package:flutter/material.dart';
import 'package:my_blogz/presentation/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      title: 'My Blogz',
      home: HomePage(),
    ),
  );
}
