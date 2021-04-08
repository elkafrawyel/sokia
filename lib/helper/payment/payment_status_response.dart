import 'package:sokia_app/helper/payment/payment_response.dart';

class PaymentStatusResponse {
  String _id;
  String _paymentType;
  String _paymentBrand;
  String _amount;
  String _currency;
  String _descriptor;
  String _merchantTransactionId;
  Result _result;
  Card _card;
  Customer _customer;
  CustomParameters _customParameters;
  Risk _risk;
  String _buildNumber;
  String _timestamp;
  String _ndc;

  String get id => _id;

  String get paymentType => _paymentType;

  String get paymentBrand => _paymentBrand;

  String get amount => _amount;

  String get currency => _currency;

  String get descriptor => _descriptor;

  String get merchantTransactionId => _merchantTransactionId;

  Result get result => _result;

  Card get card => _card;

  Customer get customer => _customer;

  CustomParameters get customParameters => _customParameters;

  Risk get risk => _risk;

  String get buildNumber => _buildNumber;

  String get timestamp => _timestamp;

  String get ndc => _ndc;

  PaymentStatusResponse(
      {String id,
      String paymentType,
      String paymentBrand,
      String amount,
      String currency,
      String descriptor,
      String merchantTransactionId,
      Result result,
      Card card,
      Customer customer,
      CustomParameters customParameters,
      Risk risk,
      String buildNumber,
      String timestamp,
      String ndc}) {
    _id = id;
    _paymentType = paymentType;
    _paymentBrand = paymentBrand;
    _amount = amount;
    _currency = currency;
    _descriptor = descriptor;
    _merchantTransactionId = merchantTransactionId;
    _result = result;
    _card = card;
    _customer = customer;
    _customParameters = customParameters;
    _risk = risk;
    _buildNumber = buildNumber;
    _timestamp = timestamp;
    _ndc = ndc;
  }

  PaymentStatusResponse.fromJson(dynamic json) {
    _id = json["id"];
    _paymentType = json["paymentType"];
    _paymentBrand = json["paymentBrand"];
    _amount = json["amount"];
    _currency = json["currency"];
    _descriptor = json["descriptor"];
    _merchantTransactionId = json["merchantTransactionId"];
    _result = json["result"] != null ? Result.fromJson(json["result"]) : null;
    _card = json["card"] != null ? Card.fromJson(json["card"]) : null;
    _customer =
        json["customer"] != null ? Customer.fromJson(json["customer"]) : null;
    _customParameters = json["customParameters"] != null
        ? CustomParameters.fromJson(json["customParameters"])
        : null;
    _risk = json["risk"] != null ? Risk.fromJson(json["risk"]) : null;
    _buildNumber = json["buildNumber"];
    _timestamp = json["timestamp"];
    _ndc = json["ndc"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["paymentType"] = _paymentType;
    map["paymentBrand"] = _paymentBrand;
    map["amount"] = _amount;
    map["currency"] = _currency;
    map["descriptor"] = _descriptor;
    map["merchantTransactionId"] = _merchantTransactionId;
    if (_result != null) {
      map["result"] = _result.toJson();
    }
    if (_card != null) {
      map["card"] = _card.toJson();
    }
    if (_customer != null) {
      map["customer"] = _customer.toJson();
    }
    if (_customParameters != null) {
      map["customParameters"] = _customParameters.toJson();
    }
    if (_risk != null) {
      map["risk"] = _risk.toJson();
    }
    map["buildNumber"] = _buildNumber;
    map["timestamp"] = _timestamp;
    map["ndc"] = _ndc;
    return map;
  }
}

class Risk {
  String _score;

  String get score => _score;

  Risk({String score}) {
    _score = score;
  }

  Risk.fromJson(dynamic json) {
    _score = json["score"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["score"] = _score;
    return map;
  }
}

class CustomParameters {
  String _sHOPPERMSDKIntegrationType;
  String _sHOPPERDevice;
  String _ctpedescriptortemplate;
  String _shopperos;
  String _sHOPPERMSDKVersion;

  String get sHOPPERMSDKIntegrationType => _sHOPPERMSDKIntegrationType;

  String get sHOPPERDevice => _sHOPPERDevice;

  String get ctpedescriptortemplate => _ctpedescriptortemplate;

  String get shopperos => _shopperos;

  String get sHOPPERMSDKVersion => _sHOPPERMSDKVersion;

  CustomParameters(
      {String sHOPPERMSDKIntegrationType,
      String sHOPPERDevice,
      String ctpedescriptortemplate,
      String shopperos,
      String sHOPPERMSDKVersion}) {
    _sHOPPERMSDKIntegrationType = sHOPPERMSDKIntegrationType;
    _sHOPPERDevice = sHOPPERDevice;
    _ctpedescriptortemplate = ctpedescriptortemplate;
    _shopperos = shopperos;
    _sHOPPERMSDKVersion = sHOPPERMSDKVersion;
  }

  CustomParameters.fromJson(dynamic json) {
    _sHOPPERMSDKIntegrationType = json["SHOPPER_MSDKIntegrationType"];
    _sHOPPERDevice = json["SHOPPER_device"];
    _ctpedescriptortemplate = json["CTPE_DESCRIPTOR_TEMPLATE"];
    _shopperos = json["SHOPPER_OS"];
    _sHOPPERMSDKVersion = json["SHOPPER_MSDKVersion"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["SHOPPER_MSDKIntegrationType"] = _sHOPPERMSDKIntegrationType;
    map["SHOPPER_device"] = _sHOPPERDevice;
    map["CTPE_DESCRIPTOR_TEMPLATE"] = _ctpedescriptortemplate;
    map["SHOPPER_OS"] = _shopperos;
    map["SHOPPER_MSDKVersion"] = _sHOPPERMSDKVersion;
    return map;
  }
}

class Customer {
  String _ip;
  String _ipCountry;

  String get ip => _ip;

  String get ipCountry => _ipCountry;

  Customer({String ip, String ipCountry}) {
    _ip = ip;
    _ipCountry = ipCountry;
  }

  Customer.fromJson(dynamic json) {
    _ip = json["ip"];
    _ipCountry = json["ipCountry"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ip"] = _ip;
    map["ipCountry"] = _ipCountry;
    return map;
  }
}

class Card {
  String _bin;
  String _binCountry;
  String _last4Digits;
  String _holder;
  String _expiryMonth;
  String _expiryYear;

  String get bin => _bin;

  String get binCountry => _binCountry;

  String get last4Digits => _last4Digits;

  String get holder => _holder;

  String get expiryMonth => _expiryMonth;

  String get expiryYear => _expiryYear;

  Card(
      {String bin,
      String binCountry,
      String last4Digits,
      String holder,
      String expiryMonth,
      String expiryYear}) {
    _bin = bin;
    _binCountry = binCountry;
    _last4Digits = last4Digits;
    _holder = holder;
    _expiryMonth = expiryMonth;
    _expiryYear = expiryYear;
  }

  Card.fromJson(dynamic json) {
    _bin = json["bin"];
    _binCountry = json["binCountry"];
    _last4Digits = json["last4Digits"];
    _holder = json["holder"];
    _expiryMonth = json["expiryMonth"];
    _expiryYear = json["expiryYear"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bin"] = _bin;
    map["binCountry"] = _binCountry;
    map["last4Digits"] = _last4Digits;
    map["holder"] = _holder;
    map["expiryMonth"] = _expiryMonth;
    map["expiryYear"] = _expiryYear;
    return map;
  }
}


class Result {
  String _code;
  String _description;
  List<ParameterErrors> _parameterErrors;

  String get code => _code;

  String get description => _description;

  List<ParameterErrors> get parameterErrors => _parameterErrors;

  Result(
      {String code,
        String description,
        List<ParameterErrors> parameterErrors}) {
    _code = code;
    _description = description;
    _parameterErrors = parameterErrors;
  }

  Result.fromJson(dynamic json) {
    _code = json["code"];
    _description = json["description"];
    if (json["parameterErrors"] != null) {
      _parameterErrors = [];
      json["parameterErrors"].forEach((v) {
        _parameterErrors.add(ParameterErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["description"] = _description;
    if (_parameterErrors != null) {
      map["parameterErrors"] = _parameterErrors.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
