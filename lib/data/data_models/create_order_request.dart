class CreateOrderRequest {
  double _orderPrice;
  String _orderType;
  String _paymentMethod;
  String _note;
  String _checkoutId;
  double _fee;
  double _shipping;
  List<OrderDetails> _orderDetails;

  double get orderPrice => _orderPrice;

  String get orderType => _orderType;

  String get checkoutId => _checkoutId;

  String get paymentMethod => _paymentMethod;

  double get fee => _fee;

  double get shipping => _shipping;

  String get note => _note;

  List<OrderDetails> get orderDetails => _orderDetails;

  CreateOrderRequest(
      {double orderPrice,
      String orderType,
      String checkoutId,
      double fee,
      double shipping,
      String paymentMethod,
      String note,
      List<OrderDetails> orderDetails}) {
    _orderPrice = orderPrice;
    _orderType = orderType;
    _paymentMethod = paymentMethod;
    _note = note;
    _checkoutId = checkoutId;
    _fee = fee;
    _shipping = shipping;
    _orderDetails = orderDetails;
  }

  CreateOrderRequest.fromJson(dynamic json) {
    _orderPrice = json["orderPrice"];
    _orderType = json["orderType"];
    _paymentMethod = json["paymentMethod"];
    _fee = json["fee"];
    _shipping = json["shipping"];
    _checkoutId = json["checkoutId"];
    _note = json["note"];
    if (json["orderDetails"] != null) {
      _orderDetails = [];
      json["orderDetails"].forEach((v) {
        _orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["orderPrice"] = _orderPrice;
    map["orderType"] = _orderType;
    map["paymentMethod"] = _paymentMethod;
    map["shipping"] = _shipping;
    map["fee"] = _fee;
    map["checkoutId"] = _checkoutId;
    map["note"] = _note;
    if (_orderDetails != null) {
      map["orderDetails"] = _orderDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderDetails {
  String _donateTo;
  int _count;
  double _price;
  String _longitude;
  String _latitude;
  String _address;

  String _categoryName;
  String _workerName;
  String _workerNumber;

  String get donateTo => _donateTo;

  int get count => _count;

  double get price => _price;

  String get longitude => _longitude;

  String get latitude => _latitude;

  String get address => _address;

  String get categoryName => _categoryName;

  String get workerName => _workerName;

  String get workerNumber => _workerNumber;

  OrderDetails({
    String donateTo,
    int count,
    double price,
    String longitude,
    String latitude,
    String address,
    String categoryName,
    String workerName,
    String workerNumber,
  }) {
    _donateTo = donateTo;
    _count = count;
    _price = price;
    _longitude = longitude;
    _latitude = latitude;
    _address = address;

    _categoryName = categoryName;
    _workerName = workerName;
    _workerNumber = workerNumber;
  }

  OrderDetails.fromJson(dynamic json) {
    _donateTo = json["donateTo"];
    _count = json["count"];
    _price = json["price"];
    _longitude = json["longitude"];
    _latitude = json["latitude"];
    _address = json["adress"];

    _categoryName = json["categoryName"];
    _workerName = json["workerName"];
    _workerNumber = json["workerNumber"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["donateTo"] = _donateTo;
    map["count"] = _count;
    map["price"] = _price;
    map["longitude"] = _longitude;
    map["latitude"] = _latitude;
    map["adress"] = _address;
    map["categoryName"] = _categoryName;
    map["workerName"] = _workerName;
    map["workerNumber"] = _workerNumber;
    return map;
  }
}
