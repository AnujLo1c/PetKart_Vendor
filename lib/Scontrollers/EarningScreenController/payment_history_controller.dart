import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Models/tile_models.dart';

class PaymentHistoryController extends GetxController {

  var paymentHistoryList = <PaymentHistory>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadPaymentHistory();
  }

  void loadPaymentHistory() {

    paymentHistoryList.assignAll([
      PaymentHistory(
        accountNumber: '202456984890112',
        holderName: 'Nandini Dhote',
        bankName: 'Punjab National Bank',
        date: '10/10/2024',
        orderId: '2021102042004',
      ),
      PaymentHistory(
        accountNumber: '202456984890112',
        holderName: 'Anuj Iowanshi',
        bankName: 'Punjab National Bank',
        date: '10/10/2024',
        orderId: '2021102042004',
      ),

    ]);
  }
}