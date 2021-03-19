import 'package:get/get.dart';
import 'package:sokia_app/data/responses/home_response.dart';

class OrderController extends GetxController {
  Map<int, OrderModel> orderMap = {};

  addToOrderMap({OrderModel orderModel}) {
    orderMap.addAll({
      orderModel.mosque.id: orderModel,
    });
    print('add'+orderMap.toString());
    update();
  }

  updateOrderMap({OrderModel orderModel}) {
    orderMap[orderModel.mosque.id] = orderModel;
    print('update'+orderMap.toString());
    update();
  }
}

class OrderModel {
  Mosque mosque;
  Category category;
  String workerName;
  String workerNumber;
  int count;

  OrderModel({
    this.mosque,
    this.category,
    this.workerName,
    this.workerNumber,
    this.count,
  });

  @override
  String toString() {
    return '${mosque.mosqueName} - ${category.categoryName} - $count - $workerName - $workerNumber';
  }
}
