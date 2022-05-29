import 'dart:io';

import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'model/post.dart';
import 'model/user.dart';
import 'post_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<Post>> posts;
  late List<User>? users = [];

  @override
  void initState() {
    super.initState();
    posts = HttpService().getPosts();
    getUsers();
  }

  void getUsers() async {
    users = (await HttpService().getUsers());
  }

  void getPosts() async {
    posts = HttpService().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Post post) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(post.favorite ? Icons.star : Icons.star_outline,
                color: Colors.white),
          ),
          title: Text(
            post.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                          post: post,
                          user: users!
                              .firstWhere((user) => user.id == post.userId),
                        )));
            setState(() {
              getPosts();
            });
          },
        );

    Card makeCard(Post post) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(post),
          ),
        );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      title: const Text("Posts"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              HttpService()
                  .removeSP("posts")
                  .then((value) => posts = HttpService().getPosts());
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showMyDialog();
          },
        )
      ],
    );

    final makeBody = FutureBuilder(
      future: posts,
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          List<Post>? posts = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: posts?.length,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(posts![index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
    );
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure to delete all posts?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {

                setState(() {
                  posts = HttpService().removeAllPostSP();
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
