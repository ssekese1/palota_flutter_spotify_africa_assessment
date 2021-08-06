import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:http/http.dart' as http;

Future<Category> fetchCategory() async {
  final response = await http.get(
    Uri.parse(
        "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro"),
    // Send authorization headers to the backend.
    headers: {"x-functions-key": dotenv.env['APIKEY'].toString()},
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Category.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class IconData {
  final String url;

  const IconData(
    this.url,
  );

  IconData.fromJson(Map jsonMap) : url = jsonMap['url'];
}

class Category {
  final List<IconData> categoryIcons;
  final String categoryName;
  final String categoryId;

  const Category({
    required this.categoryIcons,
    required this.categoryName,
    required this.categoryId,
  });

  Category.fromJson(
    Map jsonMap,
  )   : categoryName = jsonMap['name'],
        categoryId = jsonMap['id'],
        categoryIcons = (jsonMap['icons'] as List)
            .map((i) => IconData.fromJson(i))
            .toList();
}

class SpotifyCategoryPage extends StatefulWidget {
  const SpotifyCategoryPage({Key? key, required String categoryId})
      : super(key: key);

  @override
  _SpotifyCategoryPageState createState() => _SpotifyCategoryPageState();
}

class _SpotifyCategoryPageState extends State<SpotifyCategoryPage> {
  late Future<Category> futureCategory;

  @override
  void initState() {
    super.initState();
    futureCategory = fetchCategory();
  }
// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: FutureBuilder<Category>(
          future: futureCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.categoryName);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return Text("Loading Category...");
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.blue,
                AppColors.cyan,
                AppColors.green,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: FutureBuilder<Category>(
              future: futureCategory,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.categoryIcons.length,
                      itemBuilder: (context, int index) {
                        return Card(
                            // clipBehavior: Clip.antiAlias,
                            child: Container(
                                height: 300,
                                width: 300,
                                color: Colors.grey[850],
                                padding: const EdgeInsets.all(0),
                                child: Column(children: [
                                  Expanded(
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                        Text((snapshot.data!.categoryName),
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .apply(
                                                  fontSizeFactor: 5.0,
                                                )),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            // title: Text(snapshot.data!.categoryName),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .categoryIcons[index]
                                                        .url),
                                                    fit: BoxFit.contain)),
                                          ),
                                        ),
                                      ])))
                                ])));
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
