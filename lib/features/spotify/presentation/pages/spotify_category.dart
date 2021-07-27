import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary
class SpotifyCategory extends StatelessWidget {
  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("{CategoryName}"),
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
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            '''Populate with playlist info for category '$categoryId', click on playlist to view playlist detail''',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
