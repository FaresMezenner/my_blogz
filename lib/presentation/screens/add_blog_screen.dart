import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mac_address/mac_address.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/logic/cubits/blogs_cubit.dart';
import 'package:my_blogz/logic/states/blogs_states.dart';

class AddBlogScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contentController = TextEditingController();
  final int page;
  late String macAddress;
  AddBlogScreen(
    this.page, {
    super.key,
  });

  void getMacAddress() async {
    macAddress = await GetMac.macAddress;
  }

  @override
  Widget build(BuildContext context) {
    getMacAddress();
    return BlocListener<BlogsCubit, BolgsState>(
      listener: (_, state) {
        Navigator.pop(context);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ),
        ),
        title: "Add blog",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Add blog"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "Title",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Description",
                        ),
                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: contentController,
                        decoration: const InputDecoration(
                          hintText: "Content",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final blog = BlogModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            content: contentController.text,
                            author: macAddress,
                          );

                          BlocProvider.of<BlogsCubit>(context)
                              .addBlog(blog, page);
                        },
                        child: const Text(
                          "Add",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "cancel",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      listenWhen: (previous, current) =>
          current is AddBlogSuccess || current is AddBlogFailed,
    );
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
