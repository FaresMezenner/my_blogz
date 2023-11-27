import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/logic/cubits/blogs_cubit.dart';
import 'package:my_blogz/logic/states/blogs_states.dart';
import 'package:my_blogz/presentation/widgets/blog_card_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BlogsCubit>(context).fetchBlogs();
    return BlocBuilder<BlogsCubit, BolgsState>(
      builder: (context, state) {
        print("HomePage: is building: ");
        if (state is BlogsLoaded) {
          print("HomePage: is building: ${state.blogs}");
          return ListView.separated(
            itemBuilder: (context, index) {
              return BlogCardView(
                blog: state.blogs[index],
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
