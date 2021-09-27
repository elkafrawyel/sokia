import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/user_controller.dart';
import 'package:sokia_app/data/data_models/user_model.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/home/home_screen.dart';

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

          Get.offAll(() => HomeScreen());

          // userModel.approved
          //     ? Get.offAll(() => VerifyPhoneScreen(
          //           phone: userModel.phone,
          //         ))
          //     : Get.offAll(() => HomeScreen());
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

        await FirebaseAuth.instance.signInWithCredential(authCredential);

        User user = FirebaseAuth.instance.currentUser;
        UserInfo userInfo = user.providerData[0];
        print('<-- Google Login ');
        print('Name ${userInfo.displayName}');
        print('Email ${userInfo.email}');
        print('Phone ${userInfo.phoneNumber}');
        print('Photo ${userInfo.photoURL}');
        print('uid ${userInfo.uid}');
        print('End Google -->');

        if (userInfo.email == null) {
          Fluttertoast.showToast(
            msg: 'Login Failed',
            toastLength: Toast.LENGTH_LONG,
          );
          return;
        }

        ApiService().registerWithSocialAccount(
            name: userInfo.displayName,
            email: userInfo.email,
            socialType: 'Google',
            state: handleUserState);
        break;
    }
  }

  signInFacebook() async {
    // switch (await DataConnectionChecker().connectionStatus) {
    //   case DataConnectionStatus.disconnected:
    //     CommonMethods().goOffline();
    //     break;
    //   case DataConnectionStatus.connected:
    //     try {
    //       FacebookLoginResult result = await FacebookLogin().logIn(['email']);

    //       AuthCredential authCredential =
    //           FacebookAuthProvider.credential(result.accessToken.token);

    //       await FirebaseAuth.instance.signInWithCredential(authCredential);

    //       User user = FirebaseAuth.instance.currentUser;
    //       UserInfo userInfo = user.providerData[0];
    //       print('<-- Facebook Login ');
    //       print('Name ${userInfo.displayName}');
    //       print('Email ${userInfo.email}');
    //       print('Phone ${userInfo.phoneNumber}');
    //       print('Photo ${userInfo.photoURL}');
    //       print('uid ${userInfo.uid}');
    //       print('End Facebook -->');

    //       if (userInfo.email == null) {
    //         Fluttertoast.showToast(
    //           msg: 'Login Failed',
    //           toastLength: Toast.LENGTH_LONG,
    //         );
    //         return;
    //       }

    //       ApiService().registerWithSocialAccount(
    //           name: userInfo.displayName,
    //           email: userInfo.email,
    //           socialType: 'Facebook',
    //           state: handleUserState);
    //       break;
    //     } on FirebaseAuthException catch (e) {
    //       FirebaseLoginHelper().handleFirebaseError(e);
    //     }
    // }
  }

  signInTwitter() async {
    // var twitterLogin = new TwitterLogin(
    //   //api key
    //   consumerKey: twitterConsumerKey,
    //   //secret key
    //   consumerSecret: twitterConsumerSecret,
    // );

    // switch (await DataConnectionChecker().connectionStatus) {
    //   case DataConnectionStatus.disconnected:
    //     CommonMethods().goOffline();
    //     break;
    //   case DataConnectionStatus.connected:
    //     final TwitterLoginResult result = await twitterLogin.authorize();

    //     switch (result.status) {
    //       case TwitterLoginStatus.loggedIn:
    //         var twitterSession = result.session;

    //         // Once signed in, return the UserCredential
    //         // Create a credential from the access token
    //         final AuthCredential twitterAuthCredential =
    //             TwitterAuthProvider.credential(
    //                 accessToken: twitterSession.token,
    //                 secret: twitterSession.secret);

    //         // Once signed in, return the UserCredential
    //         await FirebaseAuth.instance
    //             .signInWithCredential(twitterAuthCredential);

    //         User user = FirebaseAuth.instance.currentUser;
    //         UserInfo userInfo = user.providerData[0];
    //         print('<-- Twitter Login ');
    //         print('Name ${userInfo.displayName}');
    //         print('Email ${userInfo.email}');
    //         print('Phone ${userInfo.phoneNumber}');
    //         print('Photo ${userInfo.photoURL}');
    //         print('uid ${userInfo.uid}');
    //         print('End Twitter -->');

    //         if (userInfo.email == null) {
    //           Fluttertoast.showToast(
    //             msg: 'Login Failed',
    //             toastLength: Toast.LENGTH_LONG,
    //           );
    //           return;
    //         }

    //         ApiService().registerWithSocialAccount(
    //             name: userInfo.displayName,
    //             email: userInfo.email,
    //             socialType: 'twitter',
    //             state: handleUserState);
    //         break;
    //       case TwitterLoginStatus.cancelledByUser:
    //         break;
    //       case TwitterLoginStatus.error:
    //         break;
    //     }
    //     break;
    // }
  }

  signInApple() async {
    // switch (await DataConnectionChecker().connectionStatus) {
    //   case DataConnectionStatus.disconnected:
    //     CommonMethods().goOffline();
    //     break;
    //   case DataConnectionStatus.connected:
    //     if (!(await SignInWithApple.isAvailable())) {
    //       Fluttertoast.showToast(msg: 'Not available on your device');
    //       return;
    //     }
    //     try {
    //       final appleIdCredential = await SignInWithApple.getAppleIDCredential(
    //               scopes: [
    //                 AppleIDAuthorizationScopes.email,
    //                 AppleIDAuthorizationScopes.fullName,
    //               ],
    //             );

    //             print(appleIdCredential);

    //             OAuthProvider oAuthProvider = new OAuthProvider("apple.com");
    //             final AuthCredential credential = oAuthProvider.credential(
    //               idToken:appleIdCredential.identityToken,
    //               accessToken:appleIdCredential.authorizationCode,
    //             );

    //             await FirebaseAuth.instance.signInWithCredential(credential);

    //             User user = FirebaseAuth.instance.currentUser;
    //             UserInfo userInfo = user.providerData[0];
    //             print('<-- Apple Login ');
    //             print('Name ${userInfo.displayName}');
    //             print('Email ${userInfo.email}');
    //             print('Phone ${userInfo.phoneNumber}');
    //             print('Photo ${userInfo.photoURL}');
    //             print('uid ${userInfo.uid}');
    //             print('End Apple -->');

    //             if (userInfo.email == null) {
    //               Fluttertoast.showToast(
    //                 msg: 'Login Failed',
    //                 toastLength: Toast.LENGTH_LONG,
    //               );
    //               return;
    //             }

    //             ApiService().registerWithSocialAccount(
    //                 name: userInfo.displayName,
    //                 email: userInfo.email,
    //                 socialType: 'Apple',
    //                 state: handleUserState);
    //             break;
    //     } catch (error) {
    //       print("error with apple sign in $error");
    //     }
    //     break;
    // }
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
