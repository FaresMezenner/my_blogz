class BlogModel {
  final String title;
  final String description;
  final String content;
  final String author;
  String? id;

  BlogModel({
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    this.id,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      author: json['author'] ?? 'Anonymous',
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'author': author,
    };
  }

  @override
  String toString() {
    return 'BlogModel(title: $title, description: $description, content: $content, author: $author)';
  }
}
