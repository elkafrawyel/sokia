import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/controllers/home_controller.dart';
import 'package:sokia_app/data/data_models/create_order_request.dart';
import 'package:sokia_app/data/data_models/order_model.dart';
import 'package:sokia_app/data/data_models/search_model.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/data/responses/static_data_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/screens/order_completed_screen.dart';

class CreateOrderController extends GetxController {
  bool loading = false;
  bool error = false;

  Map<int, OrderModel> orderMap = {};
  bool cash = true;
  double fee = 0.0;
  double shipping = 0.0;
  double totalPriceForAllOrders = 0.0;
  double totalPrice = 0.0;
  String checkoutId;
  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    getStaticData();
  }

  getStaticData() {
    ApiService().getStaticData(state: (dataState) {
      if (dataState is SuccessState) {
        StaticDataModel dataModel = dataState.data as StaticDataModel;
        shipping = double.parse(dataModel.shipping.toString());
        fee = double.parse(dataModel.fee.toString());
        update();
      } else if (dataState is ErrorState) {
        error = true;
        update();
      } else if (dataState is NoConnectionState) {
        update();
        CommonMethods().goOffline();
      }
    });
  }

  void addOrders(List<SearchModel> mosques, Category category) {
    mosques.forEach((mosque) {
      OrderModel orderModel = OrderModel(searchModel: mosque, orderCategories: [
        OrderCategories(
          category == null ? homeController.categories[0] : category,
          10,
        )
      ]);

      if (orderMap[orderModel.searchModel.id] == null) {
        print('add' + orderMap.toString());

        orderMap.addAll({
          orderModel.searchModel.id: orderModel,
        });
      }
    });

    calculatePrices();
    update();
  }

  updateOrderMap({OrderModel orderModel}) {
    orderMap[orderModel.searchModel.id] = orderModel;
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
          donateTo: e.searchModel.name,
          orderDetailsCategoryModel: e.orderCategories
              .map((element) => OrderDetailsCategoryModel(
                  count: element.count,
                  price: element.categoryPrice(),
                  categoryName: element.category.categoryName))
              .toList(),
          latitude: e.searchModel.latitude,
          longitude: e.searchModel.longitude,
          address: e.searchModel.adress,
          workerName: e.workerName,
          workerNumber: e.workerNumber));
    });
    if (!cash && checkoutId == null) {
      CommonMethods().showToast(message: 'Payment Error');
      return;
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

  void clearValues() {
    orderMap.clear();
    cash = true;
    // fee = 0.0;
    // shipping = 0.0;
    totalPriceForAllOrders = 0.0;
    totalPrice = 0.0;
    checkoutId = null;
  }
}
