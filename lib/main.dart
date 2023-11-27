import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blogz/logic/cubits/blogs_cubit.dart';
import 'package:my_blogz/presentation/screens/main_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => BlogsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ),
        ),
        title: 'My Blogz',
        home: const MainScreen(),
      ),
    ),
  );
}
