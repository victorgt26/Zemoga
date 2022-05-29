import 'package:flutter/material.dart';
import 'package:zemoga_mobile/posts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: const Color.fromRGBO(58, 66, 86, 1.0)),
      home: const PostsPage(),
    );
  }
}
