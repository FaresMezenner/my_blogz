import 'package:my_blogz/data/models/blog_mode.dart';

class BolgsState {}

class BlogsLoading extends BolgsState {}

class BlogsEmpty extends BolgsState {
  final bool error;

  BlogsEmpty({this.error = false});

  factory BlogsEmpty.withError() {
    return BlogsEmpty(error: true);
  }

  factory BlogsEmpty.initial() {
    return BlogsEmpty();
  }
}

class BlogsLoaded extends BolgsState {
  final List<BlogModel> blogs;

  BlogsLoaded({required this.blogs});
}

class AddBlogFailed extends BolgsState {}

class AddBlogSuccess extends BolgsState {}

class DeleteBlogFailed extends BolgsState {}
