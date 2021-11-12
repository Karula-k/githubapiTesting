import 'package:flutter/material.dart';
import 'package:githubapi/data/api/api.dart';
import 'package:githubapi/data/model/github.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Github> _github;
  @override
  void initState() {
    super.initState();
    _github = ApiService().userSearch();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
            future: _github,
            builder: (context, AsyncSnapshot<Github> snapshot) {
              var state = snapshot.connectionState;
              if (state != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.totalCount,
                      itemBuilder: (context, index) {
                        var github = snapshot.data!.items[index];
                        return BuildImage(item: github);
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Text("");
                }
              }
            }),
      ),
    );
  }
}

class BuildImage extends StatelessWidget {
  final Item item;
  BuildImage({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Image.network(
          item.avatarUrl,
          width: 100,
          height: 120,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) =>
              const Text("ERROR happens \n check your internet"),
        ),
        title: Text(item.login),
        subtitle: Column(children: [
          Row(
            children: [
              const Icon(Icons.place),
              Text(item.id.toString()),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star),
              Text(item.login.toString()),
            ],
          ),
        ]));
  }
}
