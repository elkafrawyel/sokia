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
  int _unixTime;
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

  int get unixTime => _unixTime;

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
      int unixTime,
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
    _unixTime = unixTime;
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
    _unixTime = json["unx_time"];
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
    map["unx_time"] = _unixTime;
    map["updated_at"] = _updatedAt;
    map["shippingPrice"] = _shippingPrice;
    if (_orderDetails != null) {
      map["order_details"] = _orderDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

  double getTotalPrice() {
    double price = 0.0;
    orderDetails.forEach((element) {
      price += element.getTotalPrice();
    });

    return price;
  }
}

class OrderDetails {
  int _id;
  String _donateTo;
  var _orderPrice;
  String _longitude;
  String _workerName;
  String _workerNumber;
  String _latitude;
  String _adress;
  int _orderId;
  String _createdAt;
  String _updatedAt;
  List<OrderDonatesWith> _orderDonatesWith;

  int get id => _id;

  String get donateTo => _donateTo;

  double get orderPrice => double.parse(_orderPrice.toString());

  String get longitude => _longitude;

  String get latitude => _latitude;

  String get adress => _adress;

  String get workerName => _workerName;

  String get workerNumber => _workerNumber;

  int get orderId => _orderId;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  List<OrderDonatesWith> get orderDonatesWith => _orderDonatesWith;

  OrderDetails(
      {int id,
      String donateTo,
      String longitude,
      String latitude,
      String adress,
      double orderPrice,
      int orderId,
      String createdAt,
      String updatedAt,
      String workerName,
      String workerNumber,
      List<OrderDonatesWith> orderDonatesWith}) {
    _id = id;
    _donateTo = donateTo;
    _orderPrice = orderPrice;
    _longitude = longitude;
    _latitude = latitude;
    _adress = adress;
    _orderId = orderId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _workerName = workerName;
    _workerNumber = workerNumber;
    _orderDonatesWith = orderDonatesWith;
  }

  OrderDetails.fromJson(dynamic json) {
    _id = json["id"];
    _donateTo = json["donateTo"];
    _longitude = json["longitude"];
    _latitude = json["latitude"];
    _orderPrice = json["orderPrice"];
    _adress = json["adress"];
    _orderId = json["order_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _workerName = json["workerName"];
    _workerNumber = json["workerNumber"];
    if (json["order_donates_with"] != null) {
      _orderDonatesWith = [];
      json["order_donates_with"].forEach((v) {
        _orderDonatesWith.add(OrderDonatesWith.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["donateTo"] = _donateTo;
    map["longitude"] = _longitude;
    map["latitude"] = _latitude;
    map["adress"] = _adress;
    map["order_id"] = _orderId;
    map["orderPrice"] = _orderPrice;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["workerName"] = _workerName;
    map["workerNumber"] = _workerNumber;
    if (_orderDonatesWith != null) {
      map["order_donates_with"] =
          _orderDonatesWith.map((v) => v.toJson()).toList();
    }
    return map;
  }

  double getTotalPrice() {
    double price = 0.0;
    orderDonatesWith.forEach((element) {
      print(element.price);
      price += element.price;
    });

    return double.parse(price.toString());
  }
}

class OrderDonatesWith {
  int _id;
  int _count;
  int _price;
  String _categoryName;
  int _orderDetailsId;
  String _createdAt;
  String _updatedAt;

  int get id => _id;

  int get count => _count;

  int get price => _price;

  String get categoryName => _categoryName;

  int get orderDetailsId => _orderDetailsId;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  OrderDonatesWith(
      {int id,
      int count,
      int price,
      String categoryName,
      int orderDetailsId,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _count = count;
    _price = price;
    _categoryName = categoryName;
    _orderDetailsId = orderDetailsId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  OrderDonatesWith.fromJson(dynamic json) {
    _id = json["id"];
    _count = json["count"];
    _price = json["price"];
    _categoryName = json["categoryName"];
    _orderDetailsId = json["order_details_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["count"] = _count;
    map["price"] = _price;
    map["categoryName"] = _categoryName;
    map["order_details_id"] = _orderDetailsId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
