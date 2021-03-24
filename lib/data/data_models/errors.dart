import 'package:get/get.dart';

class VErrors {
  List<String> name;
  List<String> email;
  List<String> phone;
  List<String> password;
  List<String> orderPrice;
  List<String> note;
  List<String> fee;
  List<String> shippingPrice;

  VErrors({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.orderPrice,
    this.note,
    this.fee,
    this.shippingPrice,
  });

  VErrors.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) name = json['name'].cast<String>();
    if (json['email'] != null) email = json['email'].cast<String>();
    if (json['phone'] != null) phone = json['phone'].cast<String>();
    if (json['password'] != null) password = json['password'].cast<String>();
    if (json['orderPrice'] != null)
      orderPrice = json['orderPrice'].cast<String>();
    if (json['note'] != null) note = json['note'].cast<String>();
    if (json['fee'] != null) fee = json['fee'].cast<String>();
    if (json['shippingPrice'] != null)
      shippingPrice = json['shippingPrice'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['orderPrice'] = this.orderPrice;
    data['note'] = this.note;
    data['fee'] = this.fee;
    data['shippingPrice'] = this.shippingPrice;
    return data;
  }

  String getErrors() {
    try {
      String message;
      if (name != null) {
        message = 'name'.tr + ' ' + name[0] + '\n';
      } else if (email != null) {
        message = 'email'.tr + ' ' + email[0] + '\n';
      } else if (phone != null) {
        message = 'phone'.tr + ' ' + phone[0] + '\n';
      } else if (password != null) {
        message = 'password'.tr + ' ' + password[0] + '\n';
      } else if (orderPrice != null) {
        message = 'price'.tr + ' ' + orderPrice[0] + '\n';
      } else if (shippingPrice != null) {
        message = 'shipping'.tr + ' ' + shippingPrice[0] + '\n';
      } else if (fee != null) {
        message = 'fee'.tr + ' ' + fee[0] + '\n';
      } else if (note != null) {
        message = 'note'.tr + ' ' + note[0] + '\n';
      }

      return message.trim();
    } on Error {
      return null;
    }
  }
}
