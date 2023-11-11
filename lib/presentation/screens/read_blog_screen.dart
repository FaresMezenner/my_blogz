import 'package:flutter/material.dart';
import 'package:my_blogz/data/models/blog_mode.dart';

class ReadBlogScreen extends StatelessWidget {
  final BlogModel blog;
  const ReadBlogScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      title: blog.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            blog.title,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    blog.description,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(blog.content)
            ],
          ),
        ),
      ),
    );
  }
}
