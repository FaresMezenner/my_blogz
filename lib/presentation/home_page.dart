import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('My Blogz'),
      ),
      body: const Center(
        child: Text(
          'Welcome to My Blogs app!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}