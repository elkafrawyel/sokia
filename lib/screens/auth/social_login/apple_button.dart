import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'social_user_model.dart';

class AppleButton extends StatefulWidget {
  final Function(SocialUserModel socialUserModel) onLoginComplete;

  const AppleButton({Key key, this.onLoginComplete}) : super(key: key);

  @override
  _AppleButtonState createState() => _AppleButtonState();
}

class _AppleButtonState extends State<AppleButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _handleSignIn,
      icon: Icon(
        FontAwesomeIcons.apple,
        color: Colors.black,
      ),
      label: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Text(
          'Apple',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential);
  }
}
