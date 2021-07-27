import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palota Spotify Africa Assessment',
      theme: ThemeData.dark(),
      initialRoute: AppRoutes.startUp,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
