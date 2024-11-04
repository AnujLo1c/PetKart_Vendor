import 'package:get/get.dart';

class EarningPageController extends GetxController{
  var currentEarnings = 6000.obs;
  var lastMonthEarnings = 10000.obs;
  var totalEarnings = 10000.obs;
  var percentageChangeCurrent = 5.obs;
  var percentageChangeLast = 15.obs;
}