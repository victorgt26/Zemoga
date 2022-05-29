import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  bool favorite;
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.favorite,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      favorite: json['favorite']==null ? false:json['favorite'] as bool,
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) => Post(
    id: map["id"]?.toInt() ?? 0,
    title: map["title"] ?? '',
    userId: map["userId"] ?? '',
    body: map["body"] ?? '',
    favorite: map["favorite"] ?? false,
  );

  static String encode(List<Post> posts) => json.encode(
    posts
        .map<Map<String, dynamic>>((post) => Post.toMap(post))
        .toList(),
  );

  static Map<String, dynamic> toMap(Post post) => {
    'id': post.id,
    'body': post.body,
    'userId': post.userId,
    'favorite': post.favorite,
    'title': post.title,
  };

  static List<Post> decode(String posts) =>
      (json.decode(posts) as List<dynamic>)
          .map<Post>((item) => Post.fromJson(item))
          .toList();
}