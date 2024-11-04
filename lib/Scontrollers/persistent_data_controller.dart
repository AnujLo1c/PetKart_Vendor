import 'package:get/get.dart';

class PersistentDataController extends GetxController{
  RxString userName=''.obs;
  updateName(String s){
    userName.value=s;
  }
}