import 'package:get/get.dart';

class VErrors {
  List<String> name;
  List<String> email;
  List<String> phone;
  List<String> password;

  VErrors({
    this.name,
    this.email,
    this.phone,
    this.password,
  });

  VErrors.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) name = json['name'].cast<String>();
    if (json['email'] != null) email = json['email'].cast<String>();
    if (json['phone'] != null) phone = json['phone'].cast<String>();
    if (json['password'] != null) password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }

  String getErrors() {
    try {
      String message;
      if (name != null) {
        message = 'name'.tr + ' ' + name[0];
      } else if (email != null) {
        message = 'email'.tr + ' ' + email[0];
      } else if (phone != null) {
        message = 'phone'.tr + ' ' + phone[0];
      } else if (password != null) {
        message = 'password'.tr + ' ' + password[0];
      }

      return message;
    } on Error {
      return null;
    }
  }
}
