import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mac_address/mac_address.dart';

const API_URL = "http://192.168.100.4:3000/api/blogs/";

class BlogsAPI {
  Future<List<dynamic>> fetchRawBlogs() async {
    final response = await http.get(Uri.parse("${API_URL}getBlogs"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<List<dynamic>> fetchMyRawBlogs() async {
    final Map<String, String> headers = {
      'author': await GetMac.macAddress,
    };
    final response = await http.get(
      Uri.parse("${API_URL}myBlogs"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<void> createBlog(Map<String, dynamic> blog) async {
    print("blog that will be added in json: $blog");
    final request = http.Request(
      'POST',
      Uri.parse("${API_URL}create/"),
    )
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(blog);
    final response = await http.Client().send(request);
    print("response code: ${response.statusCode}");
    if (response.statusCode == 200) {
      print("Blog created");
    } else {
      throw Exception('Failed to add blog');
    }
  }

  Future<void> deleteBlog(String id) async {
    final response = await http.delete(
      Uri.parse("${API_URL}delete/"),
      headers: {
        'id': id,
      },
    );
    if (response.statusCode == 200) {
      print("Blog deleted");
    } else {
      throw Exception('Failed to delete blog');
    }
  }
}
