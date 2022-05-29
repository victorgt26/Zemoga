import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zemoga_mobile/posts.dart';
import 'dart:convert';
import 'ApiService.dart';
import 'model/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: PostsPage(),
    );
  }
}
