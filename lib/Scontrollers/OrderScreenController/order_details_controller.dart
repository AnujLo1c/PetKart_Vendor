import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  var orderId = "2021102042004".obs;
  var orderStatus = "Placed".obs;
  var customerName = "Nandini Dhote".obs;
  var customerEmail = "nandindhote04@gmail.com".obs;
  var shippingAddress = "98/1 Kushwah Shri Nagar".obs;
  var orderDate = "10-10-2024 4:10 PM".obs;
  var totalEarning = "Rs 5000".obs;
  var paymentMethod = "Phonepay".obs;
  var courierName = "Rabbit(ruby)".obs;

  var vendorOptions = ['Placed', 'Dispatched', 'Delivered', 'Cancelled'].obs;
  void trackOrder() {
Get.toNamed("/track_order_screen");
    // Get.snackbar("Track Order", "Tracking feature coming soon!");
  }
}
