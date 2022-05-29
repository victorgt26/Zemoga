import 'package:flutter/material.dart';
import 'model/post.dart';
import 'model/user.dart';
import 'model/comment.dart';
import 'http_service.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, required this.post, required this.user});

  final Post post;
  final User user;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Icon favoriteIcon = const Icon(Icons.star_outline);

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 40.0),
        Row(
          children: const <Widget>[
            Icon(
              Icons.person,
              color: Colors.white,
              size: 40.0,
            ),
            Text(
              "User",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Text(
          widget.user.name,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          widget.user.email,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          widget.user.phone,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          widget.user.website,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ],
    );

    final topContent = Container(
        child: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.33,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.80,
          top: MediaQuery.of(context).size.height * 0.25,
          child: IconButton(
            color: Colors.amberAccent,
            iconSize: 40,
            icon: favoriteIcon,
            tooltip: 'Add to Favorite',
            onPressed: () {
              setState(() {
                widget.post.favorite = !widget.post.favorite;
                if (widget.post.favorite) {
                  print("favorito");
                  favoriteIcon = const Icon(Icons.star_outline);
                } else {
                  print("no favorito");
                  favoriteIcon = const Icon(Icons.star);
                }
              });
            },
          ),
        ),
      ],
    ));

    final bodyPost = Text(
      widget.post.body,
      style: const TextStyle(fontSize: 18.0),
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[bodyPost],
      ),
    );

    final separator = Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: const Divider(
              color: Colors.black,
              thickness: 5,
              height: 10,
            )),
      ),
      const Text("COMMENTS"),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              color: Colors.black,
              height: 10,
              thickness: 5,
            )),
      ),
    ]);

    final listComments = FutureBuilder(
      future: HttpService().getComments(widget.post.id),
      builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
        if (snapshot.hasData) {
          List<Comment>? comments = snapshot.data;
          return Container(
            height: 250,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: comments?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      title: Text(comments![index].body),
                    ));
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
    ;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topContent,
            bottomContent,
            separator,
            listComments
          ],
        ),
      ),
    );
  }
}
