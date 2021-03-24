import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/data/data_models/create_order_request.dart';
import 'package:sokia_app/data/data_models/order_model.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/screens/order_completed_screen.dart';

class CreateOrderController extends GetxController {
  bool loading = false;
  bool error = false;

  Map<int, OrderModel> orderMap = {};
  bool cash = true;
  double fee = 10.00;
  double shipping = 15.0;
  double totalPriceForAllOrders = 0.0;
  double totalPrice = 0.0;
  String checkoutId;
  final homeController = Get.find<HomeController>();

  void addOrders(List<Mosque> mosques, Category category) {
    mosques.forEach((mosque) {
      OrderModel orderModel = OrderModel(
        mosque: mosque,
        category: category == null ? homeController.categories[0] : category,
        count: 10,
      );

      if (orderMap[orderModel.mosque.id] == null) {
        print('add' + orderMap.toString());

        orderMap.addAll({
          orderModel.mosque.id: orderModel,
        });
      }
    });

    calculatePrices();
    update();
  }

  updateOrderMap({OrderModel orderModel}) {
    orderMap[orderModel.mosque.id] = orderModel;
    print('update' + orderMap.toString());
    calculatePrices();

    update();
  }

  calculatePrices() {
    totalPrice = 0.0;
    totalPriceForAllOrders = 0.0;
    orderMap.values.forEach((element) {
      totalPrice += element.orderPrice;
    });

    totalPriceForAllOrders = totalPrice + fee + shipping;
  }

  String priceWithCurrency(double price) {
    return '${price.toStringAsFixed(2)} ' + 'currency'.tr;
  }

  changePaymentMethod(bool isCash) {
    cash = isCash;
    update();
  }

  createOrder(String note) {
    loading = true;
    update();

    List<OrderDetails> orderDetails = [];
    orderMap.values.forEach((e) {
      orderDetails.add(OrderDetails(
          donateTo: e.mosque.mosqueName,
          count: e.count,
          price: e.price,
          latitude: e.mosque.mosqueLatitude,
          longitude: e.mosque.mosqueLongitude,
          address: e.mosque.mosqueAdress,
          categoryName: e.category.categoryName,
          workerName: e.workerName,
          workerNumber: e.workerNumber));
    });
    if (!cash && checkoutId == null) {
      CommonMethods().showToast(message: 'Payment Error', context: Get.context);
    }
    CreateOrderRequest createOrderRequest = CreateOrderRequest(
        orderPrice: totalPriceForAllOrders,
        orderType: 'normal',
        fee: fee,
        note: note,
        checkoutId: checkoutId,
        shipping: shipping,
        paymentMethod: cash ? 'cash' : 'visa',
        orderDetails: orderDetails);

    ApiService().createOrder(
        createOrderRequest: createOrderRequest,
        state: (dataState) {
          if (dataState is SuccessState) {
            loading = false;
            update();
            Get.to(() => OrderCompletedScreen());
          } else if (dataState is ErrorState) {
            loading = false;
            error = true;
            update();
          } else if (dataState is NoConnectionState) {
            loading = false;
            update();
            CommonMethods().goOffline();
          }
        });
  }
}
