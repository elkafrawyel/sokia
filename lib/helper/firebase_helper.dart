import 'package:firebase_auth/firebase_auth.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/local_storage.dart';

class FirebaseLoginHelper {
  void handleFirebaseError(FirebaseAuthException e) {
    print(e.message);
    bool isArabic = LocalStorage().isArabicLanguage();
    var errorMessage;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        if (isArabic) {
          errorMessage = "ايميل غير صحيح";
        } else {
          errorMessage = "Your email address appears to be invalid.";
        }
        break;
      case "ERROR_WRONG_PASSWORD":
        if (isArabic) {
          errorMessage = "كلمة المرور غير صحيحة";
        } else {
          errorMessage = "Your password is wrong.";
        }
        break;
      case "ERROR_USER_NOT_FOUND":
        if (isArabic) {
          errorMessage = "ايميل غير موجود";
        } else {
          errorMessage = "User with this email doesn't exist.";
        }

        break;
      case "ERROR_USER_DISABLED":
        if (isArabic) {
          errorMessage = "هذا الحساب معطل";
        } else {
          errorMessage = "User with this email has been disabled.";
        }
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        if (isArabic) {
          errorMessage = "خطأ حاول مرة اخري لاحقا";
        } else {
          errorMessage = "Too many requests. Try again later.";
        }
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        if (isArabic) {
          errorMessage = "التسجيل غير متاح";
        } else {
          errorMessage = "Signing in with this method is not enabled.";
        }
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        if (isArabic) {
          errorMessage =
              "هذا البريد مستخدم من قبل حاول تسجيل الدخول او جرب طريقة اخري للتسجيل";
        } else {
          errorMessage =
              "The email has already been registered. Please login or reset your password.";
        }
        break;
      case "account-exists-with-different-credential":
        if (isArabic) {
          errorMessage = "هذا الايميل مستخدم من قبل بطريقة تسجيل اخري";
        } else {
          errorMessage =
              "An account already exists with the same email address but different sign-in credentials.";
        }
        break;
      default:
        if (isArabic) {
          errorMessage = "خطأ غير معروف";
        } else {
          errorMessage = "An undefined Error happened.";
        }
    }
    CommonMethods().showSnackBar(errorMessage);
  }
}
