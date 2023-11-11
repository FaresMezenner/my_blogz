import 'package:flutter/material.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/presentation/screens/read_blog_screen.dart';

class BlogCardView extends StatelessWidget {
  final BlogModel blog;

  const BlogCardView({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ReadBlogScreen(
            blog: blog,
          ),
        ),
      ),
      child: Card(
        elevation: 20,
        child: ListTile(
          title: Text(
            blog.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            blog.description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
