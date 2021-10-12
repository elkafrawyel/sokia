import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'social_user_model.dart';

class GoogleButton extends StatefulWidget {
  final Function(SocialUserModel socialUserModel) onLoginComplete;

  const GoogleButton({Key key, this.onLoginComplete}) : super(key: key);

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(scopes: ['profile']);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _handleSignIn,
      icon: Icon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      label: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Text(
          'Google',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      _googleSignIn.signOut();
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      print(googleSignInAccount.toString());
      widget.onLoginComplete(
        SocialUserModel(
          name: googleSignInAccount.displayName,
          email: googleSignInAccount.email,
          id: googleSignInAccount.id,
          photoUrl: googleSignInAccount.photoUrl,
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}
