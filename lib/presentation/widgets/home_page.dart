import 'package:flutter/material.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/presentation/widgets/blog_card_view.dart';

class HomePage extends StatelessWidget {
  final List<BlogModel> blogs;

  const HomePage({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return BlogCardView(
          blog: blogs[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: blogs.length,
    );
  }
}
