import 'package:flutter/material.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/presentation/widgets/home_page.dart';
import 'package:my_blogz/presentation/widgets/my_blogs_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late List<BlogModel> blogs;

  @override
  void initState() {
    blogs = [
      for (int i = 0; i < 10; i++)
        BlogModel(
          title: 'Blog Title $i',
          description: 'Blog Body $i',
          author: 'Blog Author $i',
        )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(selectedIndex == 0 ? 'Home' : 'My Blogs'),
      ),
      body: selectedIndex == 0
          ? RefreshIndicator(
              onRefresh: () async {},
              child: HomePage(
                blogs: blogs,
              ),
            )
          : MyBlogsPage(blogs: blogs),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
  }
}
