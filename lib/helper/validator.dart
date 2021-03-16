import 'package:get/get.dart';

class Validator {
  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Mobile phone number is required";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile phone number must contain only digits";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be more than 5 characters';
    else
      return null;
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value))
      return true;
    else {
      Get.snackbar('Validator', 'Enter valid email',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  String validateConfirmPassword(String password, String confirmPassword) {
    print("$password $confirmPassword");
    if (password != confirmPassword) {
      return 'Password doesn\'t match';
    } else if (confirmPassword.length == 0) {
      return 'Confirm password is required';
    } else {
      return null;
    }
  }
}
