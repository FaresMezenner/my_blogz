import 'package:my_blogz/data/data_providers/blogs_api.dart';
import 'package:my_blogz/data/models/blog_mode.dart';

class BlogsRepository {
  final BlogsAPI _blogsAPI = BlogsAPI();

  BlogsRepository();

  Future<List<BlogModel>> fetchBlogs() async {
    final blogsJson = await _blogsAPI.fetchRawBlogs();

    List<BlogModel> blogs = [];

    for (var blogJson in blogsJson) {
      print(blogJson);
      blogs.add(BlogModel.fromJson(blogJson));
    }

    return blogs;
  }

  Future<List<BlogModel>> fetchMyBlogs() async {
    final blogsJson = await _blogsAPI.fetchMyRawBlogs();

    List<BlogModel> blogs = [];

    for (var blogJson in blogsJson) {
      print(blogJson);
      blogs.add(BlogModel.fromJson(blogJson));
    }

    return blogs;
  }

  Future<void> addBlog(BlogModel blog) async {
    print("blog that will be added in json: ${blog.toJson()}");
    await _blogsAPI.createBlog(blog.toJson());
  }

  Future<void> deleteBlog(BlogModel blog) async {
    await _blogsAPI.deleteBlog(blog.id!);
  }
}
