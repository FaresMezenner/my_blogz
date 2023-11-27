import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/data/repositories/blogs_repository.dart';
import 'package:my_blogz/logic/cubits/blogs_cubit.dart';
import 'package:my_blogz/logic/states/blogs_states.dart';
import 'package:my_blogz/presentation/screens/add_blog_screen.dart';
import 'package:my_blogz/presentation/widgets/home_page.dart';
import 'package:my_blogz/presentation/widgets/my_blogs_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final List<BlogModel> blogs = [];
  final List<BlogModel> myBlogs = [];

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      final blog = BlogModel(
        title: 'Blog Title $i',
        description: 'Blog Body $i',
        content: "Blog Content $i",
        author: 'Blog Author $i',
      );
      blogs.add(blog);
      if (i % 3 == 0) {
        myBlogs.add(blog);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(selectedIndex == 0 ? 'Home' : 'My Blogs'),
        ),
        body: Builder(builder: (context) {
          return BlocListener<BlogsCubit, BolgsState>(
            listener: (context, state) {
              if (state is AddBlogFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to add blog',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    duration: const Duration(seconds: 1),
                  ),
                );
              } else if (state is DeleteBlogFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to delete blog',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
            child: RefreshIndicator(
              onRefresh: () async {
                if (selectedIndex == 0) {
                  BlocProvider.of<BlogsCubit>(context).fetchBlogs();
                } else {
                  BlocProvider.of<BlogsCubit>(context).fetchMyBlogs();
                }
              },
              child: selectedIndex == 0
                  ? const HomePage()
                  : MyBlogsPage(
                      myBlogs: myBlogs,
                      blogs: blogs,
                    ),
            ),
            listenWhen: (previous, current) =>
                current is AddBlogFailed || current is DeleteBlogFailed,
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBlogScreen(selectedIndex),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          currentIndex: selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'My Blogs',
            ),
          ],
        ),
      );
    });
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('MainScreen: didUpdateWidget');
  }
}
