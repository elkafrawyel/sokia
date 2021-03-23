class MyOrdersResponse {
  bool _status;
  List<Order> _orders;

  bool get status => _status;

  List<Order> get orders => _orders;

  MyOrdersResponse({bool status, List<Order> orders}) {
    _status = status;
    _orders = orders;
  }

  MyOrdersResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["orders"] != null) {
      _orders = [];
      json["orders"].forEach((v) {
        _orders.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_orders != null) {
      map["orders"] = _orders.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Order {
  int _id;
  int _userId;
  String _orderCode;
  var _orderPrice;
  String _paymentMethod;
  String _orderType;
  String _orderStatus;
  String _note;
  var _fee;
  String _createdAt;
  String _updatedAt;
  var _shippingPrice;
  List<OrderDetails> _orderDetails;

  int get id => _id;

  int get userId => _userId;

  String get orderCode => _orderCode;

  double get orderPrice => double.parse(_orderPrice.toString());

  String get paymentMethod => _paymentMethod;

  String get orderType => _orderType;

  String get orderStatus => _orderStatus;

  String get note => _note;

  double get fee => double.parse(_fee.toString());

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  double get shippingPrice => double.parse(_shippingPrice.toString());

  List<OrderDetails> get orderDetails => _orderDetails;

  Order(
      {int id,
      int userId,
      String orderCode,
      double orderPrice,
      String paymentMethod,
      String orderType,
      String orderStatus,
      String note,
      double fee,
      String createdAt,
      String updatedAt,
      double shippingPrice,
      List<OrderDetails> orderDetails}) {
    _id = id;
    _userId = userId;
    _orderCode = orderCode;
    _orderPrice = orderPrice;
    _paymentMethod = paymentMethod;
    _orderType = orderType;
    _orderStatus = orderStatus;
    _note = note;
    _fee = fee;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _shippingPrice = shippingPrice;
    _orderDetails = orderDetails;
  }

  Order.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _orderCode = json["orderCode"];
    _orderPrice = json["orderPrice"];
    _paymentMethod = json["paymentMethod"];
    _orderType = json["orderType"];
    _orderStatus = json["orderStatus"];
    _note = json["note"];
    _fee = json["fee"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _shippingPrice = json["shippingPrice"];
    if (json["order_details"] != null) {
      _orderDetails = [];
      json["order_details"].forEach((v) {
        _orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["orderCode"] = _orderCode;
    map["orderPrice"] = _orderPrice;
    map["paymentMethod"] = _paymentMethod;
    map["orderType"] = _orderType;
    map["orderStatus"] = _orderStatus;
    map["note"] = _note;
    map["fee"] = _fee;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["shippingPrice"] = _shippingPrice;
    if (_orderDetails != null) {
      map["order_details"] = _orderDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderDetails {
  int _id;
  String _donateTo;
  var _price;
  int _count;
  String _longitude;
  String _workerName;
  String _workerNumber;
  String _latitude;
  String _adress;
  String _categoryName;
  int _orderId;
  String _createdAt;
  String _updatedAt;

  int get id => _id;

  String get donateTo => _donateTo;

  double get price => double.parse(_price.toString());

  int get count => _count;

  String get longitude => _longitude;

  String get latitude => _latitude;

  String get adress => _adress;

  String get categoryName => _categoryName;

  String get workerName => _workerName;

  String get workerNumber => _workerNumber;

  int get orderId => _orderId;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  OrderDetails(
      {int id,
      String donateTo,
      int price,
      int count,
      String longitude,
      String latitude,
      String workerName,
      String workerNumber,
      String adress,
      String categoryName,
      int orderId,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _donateTo = donateTo;
    _price = price;
    _count = count;
    _longitude = longitude;
    _latitude = latitude;
    _workerName = workerName;
    _workerNumber = workerNumber;
    _adress = adress;
    _categoryName = categoryName;
    _orderId = orderId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  OrderDetails.fromJson(dynamic json) {
    _id = json["id"];
    _donateTo = json["donateTo"];
    _price = json["price"];
    _workerName = json["workerName"];
    _workerNumber = json["workerNumber"];
    _count = json["count"];
    _longitude = json["longitude"];
    _latitude = json["latitude"];
    _adress = json["adress"];
    _categoryName = json["categoryName"];
    _orderId = json["order_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["donateTo"] = _donateTo;
    map["price"] = _price;
    map["count"] = _count;
    map["workerName"] = _workerName;
    map["workerNumber"] = _workerNumber;
    map["longitude"] = _longitude;
    map["latitude"] = _latitude;
    map["adress"] = _adress;
    map["categoryName"] = _categoryName;
    map["order_id"] = _orderId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
