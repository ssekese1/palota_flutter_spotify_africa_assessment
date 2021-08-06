import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<Playlists>> fetchPlaylist() async {
  final response = await http.get(
    Uri.parse(
        "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists"),
    // Send authorization headers to the backend.
    headers: {"x-functions-key": dotenv.env['APIKEY'].toString()},
  );
  if (response.statusCode == 200) {
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    List<Playlists> list = items.map<Playlists>((json) {
      return Playlists.fromJson(json);
    });

    return list;
  } else {
    throw Exception('Failed to load data from Server.');
  }
}

class Playlists {
  final List<Items> items;
  const Playlists({
    required this.items,
  });
  Playlists.fromJson(Map jsonMap)
      : items =
            (jsonMap['items'] as List).map((i) => Items.fromJson(i)).toList();
}

class Items {
  final String name;
  final List<Images> images;

  const Items({
    required this.images,
    required this.name,
  });

  Items.fromJson(Map jsonMap)
      : name = jsonMap['name'].toString(),
        images =
            (jsonMap['images'] as List).map((i) => Images.fromJson(i)).toList();
}

class Images {
  final String url;

  const Images({
    required this.url,
  });

  Images.fromJson(Map jsonMap) : url = jsonMap["url"];
}

class SpotifyPlaylistPage extends StatefulWidget {
  const SpotifyPlaylistPage({Key? key}) : super(key: key);

  @override
  _SpotifyPlaylistPageState createState() => _SpotifyPlaylistPageState();
}

class _SpotifyPlaylistPageState extends State<SpotifyPlaylistPage> {
  // late Future<Playlists> futurePlaylist;/

  @override
  void initState() {
    super.initState();
    // futurePlaylist = fetchPlaylist() as Future<Playlists>;
  }

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: FutureBuilder<Playlists>(builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.items.length,
                  itemBuilder: (context, int index) {
                    return Card(
                        child: Container(
                            height: 300,
                            width: 300,
                            color: Colors.grey[850],
                            padding: const EdgeInsets.all(0),
                            child: Column(children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot.data!
                                              .items[index].images[index].url),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                    Text((snapshot.data!.items.toString()),
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .apply(
                                              fontSizeFactor: 5.0,
                                            )),
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
