import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/images/images.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class AboutPage extends StatelessWidget {
  static const String _website = "https://palota.co.za";
  static const String _email = "jobs@palota.co.za";
  static const String _spotifyTerms =
      "https://www.spotify.com/us/legal/end-user-agreement/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.width * 0.75,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(
                  top: kToolbarHeight,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.blue,
                      AppColors.cyan,
                      AppColors.green,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  AboutImages.logoWhite,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 32,
              right: 32,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Text(
                    'This is a simple Flutter project prepared by Palota to be used for assessment purposes.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        child: Text("Open Website"),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.blue,
                        ),
                        onPressed: () => _openUrl(_website),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        child: Text("E-Mail Us"),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.green,
                        ),
                        onPressed: () => _launchEmail(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Music playlist and category data in this assessment belongs to Spotify and is used under Spotify's terms and conditions",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextButton(
                        onPressed: () => _openUrl(_spotifyTerms),
                        child: Text("Spotify Terms and Conditions"),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                _buildVersionText(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionText(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext ctx, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          final PackageInfo packageInfo = snapshot.data as PackageInfo;
          return Text(
            "v${packageInfo.version} (${packageInfo.buildNumber})",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Future<bool> _openUrl(String url) async {
    if (await urlLauncher.canLaunch(url)) {
      return urlLauncher.launch(url);
    } else {
      return false;
    }
  }

  Future<bool> _launchEmail() async {
    final emailLink = "mailto:$_email";
    if (await urlLauncher.canLaunch(emailLink)) {
      return urlLauncher.launch(emailLink);
    } else {
      return false;
    }
  }
}
