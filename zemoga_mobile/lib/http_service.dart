import 'dart:convert';
import 'package:http/http.dart';
import 'model/post.dart';
import 'model/user.dart';
import 'model/comment.dart';
import 'constants.dart';

class HttpService {
  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(ApiConstants.baseUrl+ApiConstants.postsEndpoint));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<User>> getUsers() async {
    Response res = await get(Uri.parse(ApiConstants.baseUrl+ApiConstants.usersEndpoint));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> users = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();

      return users;
    } else {
      throw "Unable to retrieve users.";
    }
  }

  Future<List<Comment>> getComments(int postId) async {
    Response res = await get(Uri.parse(ApiConstants.baseUrl+ApiConstants.commentsEndpoint+postId.toString()));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Comment> users = body
          .map(
            (dynamic item) => Comment.fromJson(item),
      )
          .toList();

      return users;
    } else {
      throw "Unable to retrieve users.";
    }
  }
}
