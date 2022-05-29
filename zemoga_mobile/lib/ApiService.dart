import 'dart:convert';
import 'package:http/http.dart';
import 'model/post.dart';
import 'model/user.dart';
import 'model/comment.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {

  Future<void> upgradeFavoritePosts(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsString = prefs.getString('posts');
    List<Post> posts = Post.decode(postsString!);
    posts.firstWhere((element) => element.id == post.id).favorite = post.favorite;
    savePostsSP(posts);
  }

  Future<void> savePostsSP(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('posts', Post.encode(posts));
  }

  Future<List<Post>> getPostsSP() async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsString = prefs.getString('posts');
    List<Post> posts = Post.decode(postsString!);
    posts.sort((a,b)=> b.favorite ? 1:-1 );
    return posts;
  }

  Future<List<Post>> removeAllPostSP()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('posts', Post.encode([]));
    return getPosts();
  }

  Future<void> removePostSP(Post post)async{
    final prefs = await SharedPreferences.getInstance();
    final String? postsString = prefs.getString('posts');
    List<Post> posts = Post.decode(postsString!);
    posts.removeWhere((element) => element.id == post.id);
    prefs.setString('posts', Post.encode(posts));
  }

  Future<void> removeSP(String key)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<List<Post>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("posts")) {
      return getPostsSP();
    }

    Response res =
        await get(Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();
      savePostsSP(posts);
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<User>> getUsers() async {
    Response res =
        await get(Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint));
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
    Response res = await get(Uri.parse(ApiConstants.baseUrl +
        ApiConstants.commentsEndpoint +
        postId.toString()));
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
