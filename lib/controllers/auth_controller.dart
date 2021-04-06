import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/data/data_models/user_model.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/firebase_helper.dart';
import 'package:sokia_app/helper/keys.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/auth/verify_phone/verify_phone_screen.dart';
import 'package:sokia_app/screens/home/home_screen.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  bool loading = false;
  bool error = false;
  bool noConnection = false;

  register({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) {
    loading = true;
    update();

    ApiService().register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      state: (dataState) {
        if (dataState is SuccessState) {
          UserModel userModel = dataState.data as UserModel;

          saveUserState(userModel);

          loading = false;
          update();

          userModel.approved
              ? Get.offAll(() => VerifyPhoneScreen(
                    phone: userModel.phone,
                  ))
              : Get.offAll(() => HomeScreen());
        } else if (dataState is ErrorState) {
          loading = false;
          error = true;
          update();
        } else if (dataState is NoConnectionState) {
          loading = false;
          CommonMethods().goOffline();
          update();
        }
      },
    );
  }

  login({
    @required String phone,
    @required String password,
  }) {
    loading = true;
    update();

    ApiService()
        .login(phone: phone, password: password, state: handleUserState);
  }

  signInGoogle() async {
    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        CommonMethods().goOffline();
        break;
      case DataConnectionStatus.connected:
        final GoogleSignInAccount googleSignInAccount =
            await GoogleSignIn(scopes: ['profile']).signIn();

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential credential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        if (credential.user != null) {
          ApiService().registerWithSocialAccount(
              name: credential.user.displayName,
              email: credential.user.email,
              socialType: 'google',
              state: handleUserState);
          break;
        }
    }
  }

  signInFacebook() async {
    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        CommonMethods().goOffline();
        break;
      case DataConnectionStatus.connected:
        try {
          FacebookLoginResult result = await FacebookLogin().logIn(['email']);

          AuthCredential authCredential =
              FacebookAuthProvider.credential(result.accessToken.token);

          UserCredential credential =
              await FirebaseAuth.instance.signInWithCredential(authCredential);

          if (credential.user != null) {
            ApiService().registerWithSocialAccount(
                name: credential.user.displayName,
                email: credential.user.email,
                socialType: 'face',
                state: handleUserState);
            break;
          }
        } on FirebaseAuthException catch (e) {
          FirebaseLoginHelper().handleFirebaseError(e);
        }
    }
  }

  signInTwitter() async {
    /*

    first add these 3 urls in twitter developer

    https://sokia-b46f4.firebaseapp.com/__/auth/handler

    twitterkit-consumerKey://

    twittersdk://

    */

    var twitterLogin = new TwitterLogin(
      //api key
      consumerKey: twitterConsumerKey,
      //secret key
      consumerSecret: twitterConsumerSecret,
    );

    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        CommonMethods().goOffline();
        break;
      case DataConnectionStatus.connected:
        final TwitterLoginResult result = await twitterLogin.authorize();

        switch (result.status) {
          case TwitterLoginStatus.loggedIn:
            var twitterSession = result.session;

            // Once signed in, return the UserCredential
            // Create a credential from the access token
            final AuthCredential twitterAuthCredential =
                TwitterAuthProvider.credential(
                    accessToken: twitterSession.token,
                    secret: twitterSession.secret);

            // Once signed in, return the UserCredential
            UserCredential credential = await FirebaseAuth.instance
                .signInWithCredential(twitterAuthCredential);

            print('<-- Twitter Login ');
            print('Name ${credential.user.displayName}');
            print('Email ${credential.user.email}');
            print('End Twitter -->');

            if (credential.user.email == null) {
              return;
            }

            ApiService().registerWithSocialAccount(
                name: credential.user.displayName,
                email: credential.user.email,
                socialType: 'twitter',
                state: handleUserState);
            break;
          case TwitterLoginStatus.cancelledByUser:
            break;
          case TwitterLoginStatus.error:
            break;
        }
        break;
    }
  }

  signInApple() async {
    switch (await DataConnectionChecker().connectionStatus) {
      case DataConnectionStatus.disconnected:
        CommonMethods().goOffline();
        break;
      case DataConnectionStatus.connected:
        // final credential = await SignInWithApple.getAppleIDCredential(
        //   scopes: [
        //     AppleIDAuthorizationScopes.email,
        //     AppleIDAuthorizationScopes.fullName,
        //   ],
        // );
        //
        // print(credential);
        // ApiService().registerWithSocialAccount(
        //   name: credential.givenName,
        //   email: credential.email,
        //   socialType: 'apple',
        //   state: (dataState) async {
        //     if (dataState is SuccessState) {
        //       UserModel userModel = dataState.data as UserModel;
        //
        //       saveUserState(userModel);
        //
        //       loading = false;
        //       update();
        //
        //       await Get.offAll(() => HomeScreen());
        //     } else if (dataState is ErrorState) {
        //       loading = false;
        //       error = true;
        //       update();
        //     } else if (dataState is NoConnectionState) {
        //       loading = false;
        //       CommonMethods().goOffline();
        //       update();
        //     }
        //   },
        // );
        break;
    }
  }

  saveUserState(UserModel userModel) {
    LocalStorage().setBool(LocalStorage.loginKey, true);
    LocalStorage().setString(LocalStorage.token, userModel.apiToken);
    LocalStorage().setString(LocalStorage.userId, userModel.id.toString());
    Get.find<UserController>().setUser(userModel);
  }

  handleUserState(DataState dataState) async {
    if (dataState is SuccessState) {
      UserModel userModel = dataState.data as UserModel;

      saveUserState(userModel);

      loading = false;
      update();

      await Get.offAll(() => HomeScreen());
    } else if (dataState is ErrorState) {
      loading = false;
      error = true;
      update();
    } else if (dataState is NoConnectionState) {
      loading = false;
      CommonMethods().goOffline();
      update();
    }
  }
}
