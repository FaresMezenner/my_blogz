import 'package:flutter/material.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(selectedIndex == 0 ? 'Home' : 'My Blogs'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: selectedIndex == 0
            ? HomePage(
                blogs: blogs,
              )
            : MyBlogsPage(blogs: myBlogs),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddBlogScreen(),
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
  }
}
