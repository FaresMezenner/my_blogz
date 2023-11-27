import 'package:bloc/bloc.dart';
import 'package:my_blogz/data/models/blog_mode.dart';
import 'package:my_blogz/data/repositories/blogs_repository.dart';
import 'package:my_blogz/logic/states/blogs_states.dart';

class BlogsCubit extends Cubit<BolgsState> {
  final BlogsRepository _blogsRepository = BlogsRepository();

  BlogsCubit() : super(BlogsLoading());

  void fetchBlogs() async {
    emit(BlogsLoading());
    try {
      final blogs = await _blogsRepository.fetchBlogs();

      if (blogs.isNotEmpty) {
        emit(BlogsLoaded(blogs: blogs));
      } else {
        emit(BlogsEmpty());
      }
    } catch (e) {
      print(e);
      emit(BlogsEmpty.withError());
    }
  }

  void fetchMyBlogs() async {
    emit(BlogsLoading());
    try {
      final blogs = await _blogsRepository.fetchMyBlogs();
      if (blogs.isNotEmpty) {
        emit(BlogsLoaded(blogs: blogs));
      } else {
        emit(BlogsEmpty());
      }
    } catch (e) {
      print(e);
      emit(BlogsEmpty.withError());
    }
  }

  void addBlog(BlogModel blog, int page) async {
    print("blog that will be added: $blog");
    try {
      await _blogsRepository.addBlog(blog);
      emit(AddBlogSuccess());
      if (page == 0) {
        fetchBlogs();
      } else {
        fetchMyBlogs();
      }
    } catch (e) {
      print(e);
      emit(AddBlogFailed());
    }
  }

  void deleteBlog(BlogModel blog) async {
    try {
      await _blogsRepository.deleteBlog(blog);
      fetchMyBlogs();
    } catch (e) {
      emit(DeleteBlogFailed());
    }
  }
}
