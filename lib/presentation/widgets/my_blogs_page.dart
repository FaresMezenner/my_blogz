import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/logic/cubits/blogs_cubit.dart';
import 'package:my_blogz/logic/states/blogs_states.dart';
import 'package:my_blogz/presentation/widgets/blog_card_view.dart';

class MyBlogsPage extends StatefulWidget {
  final List<BlogModel> myBlogs;
  final List<BlogModel> blogs;
  const MyBlogsPage({super.key, required this.myBlogs, required this.blogs});

  @override
  State<MyBlogsPage> createState() => _MyBlogsPageState();
}

class _MyBlogsPageState extends State<MyBlogsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BlogsCubit>(context).fetchMyBlogs();

    return BlocBuilder<BlogsCubit, BolgsState>(
      builder: (context, state) {
        print("MyBlogsPage: is building");
        if (state is BlogsLoaded) {
          print("MyBlogsPage: is building: ${state.blogs}");
          return ListView.separated(
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(state.blogs[index].hashCode.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  BlocProvider.of<BlogsCubit>(context)
                      .deleteBlog(state.blogs[index]);
                  // setState(() {
                  //   widget.blogs.remove(widget.myBlogs[index]);
                  //   widget.myBlogs.removeAt(index);
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(
                  //         'Blog Deleted',
                  //         style: Theme.of(context).textTheme.bodyMedium,
                  //       ),
                  //       backgroundColor: Theme.of(context).colorScheme.primary,
                  //       duration: const Duration(seconds: 1),
                  //     ),
                  //   );
                  // });
                },
                child: BlogCardView(
                  blog: state.blogs[index],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.blogs.length,
          );
        } else if (state is BlogsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BlogsEmpty && !state.error) {
          return const Center(
            child: Text('No Blogs'),
          );
        } else if (state is BlogsEmpty && state.error) {
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      buildWhen: (previous, current) =>
          current is! DeleteBlogFailed && current is! AddBlogFailed,
    );
  }
}
