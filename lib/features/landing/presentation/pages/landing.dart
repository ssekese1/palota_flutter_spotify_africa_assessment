import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/landing/presentation/animations/flare_assets.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';

class LandingPage extends StatelessWidget {
  static const String _spotifyCategoryId = "afro";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlareActor(
          FlareAssets.palotaIntro,
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: FlareAssets.palotaIntroAnimationName,
          callback: (String _) {
            // wait 1 second before navigating (artificial delay for effect)
            Future.delayed(Duration(seconds: 1)).then(
              (value) => _navigateToSpotifyCategoryPage(context),
            );
          },
        ),
      ),
    );
  }

  void _navigateToSpotifyCategoryPage(BuildContext context) {
    // replace because we don't want to navigate back to the landing screen
    Navigator.of(context).pushReplacementNamed(AppRoutes.spotifyCategory,
        arguments: _spotifyCategoryId);
  }
}
