import 'package:flutter/material.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/presentation/widgets/blog_card_view.dart';

class MyBlogsPage extends StatefulWidget {
  final List<BlogModel> blogs;
  const MyBlogsPage({super.key, required this.blogs});

  @override
  State<MyBlogsPage> createState() => _MyBlogsPageState();
}

class _MyBlogsPageState extends State<MyBlogsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(widget.blogs[index].hashCode.toString()),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              // setState(() {
              widget.blogs.removeAt(index);
              // });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Blog Deleted',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          child: BlogCardView(
            blog: widget.blogs[index],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: widget.blogs.length,
    );
  }
}
