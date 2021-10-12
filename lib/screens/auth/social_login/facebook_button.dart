import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'social_user_model.dart';

class FacebookButton extends StatefulWidget {
  final Function(SocialUserModel socialUserModel) onLoginComplete;

  const FacebookButton({Key key, this.onLoginComplete}) : super(key: key);

  @override
  _FacebookButtonState createState() => _FacebookButtonState();
}

class _FacebookButtonState extends State<FacebookButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _handleSignIn,
      icon: Icon(
        FontAwesomeIcons.facebook,
        color: Colors.blue,
      ),
      label: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Text(
          'Facebook',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    // Create an instance of FacebookLogin
    final fb = FacebookLogin();

    //logout
    await fb.logOut();

    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        widget.onLoginComplete(
          SocialUserModel(
            id: res.accessToken.userId,
            name: profile.name,
            email: email ?? '',
            photoUrl: imageUrl,
          ),
        );

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
}
