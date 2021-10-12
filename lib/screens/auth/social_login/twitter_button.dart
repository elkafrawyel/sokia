import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_login/twitter_login.dart';

import 'social_user_model.dart';

class TwitterButton extends StatefulWidget {
  const TwitterButton({Key key, this.onLoginComplete}) : super(key: key);
  final Function(SocialUserModel socialUserModel) onLoginComplete;

  @override
  _TwitterButtonState createState() => _TwitterButtonState();
}

class _TwitterButtonState extends State<TwitterButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _handleSignIn,
      icon: Icon(
        FontAwesomeIcons.twitter,
        color: Colors.lightBlueAccent,
      ),
      label: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Text(
          'Twitter',
          style: TextStyle(color: Colors.lightBlueAccent),
        ),
      ),
    );
  }

  final twitterConsumerKey = 'ziSFdNJZge9owWzweU5QeoVkY';
  final twitterConsumerSecret =
      'pxhRlKkgOsHj3YGByvQ0q2A0JEiG7QOr40JNAjpY0DTzhdHXlY';

  void _handleSignIn() async {
    final twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: twitterConsumerKey,
      // Consumer API Secret keys
      apiSecretKey: twitterConsumerSecret,
      // Registered Callback URLs in TwitterApp
      // Android is a deeplink
      // iOS is a URLScheme
      redirectURI: 'example://',
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        var twitterUser = authResult.user;
        widget.onLoginComplete(
          SocialUserModel(
            name: twitterUser.name,
            email: twitterUser.email,
            id: twitterUser.id.toString(),
            photoUrl: twitterUser.thumbnailImage,
          ),
        );
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        break;
      case TwitterLoginStatus.error:
        // error
        break;
    }
  }
}
