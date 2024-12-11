import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';

class ProfilePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var name = ''.obs;
  var email = ''.obs;
  var address = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var postalCode = ''.obs;
  var phone = ''.obs;
RxString profileurl=''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserData();
  }
  void fetchUserData() async {
    String uid=EmailPassLoginAl().getEmail();
    try {
      DocumentSnapshot userDoc = await _firestore.collection('vendorusers').doc(uid).get();
      if (userDoc.exists) {

        name.value = userDoc['businessName'] ?? '';
        email.value = userDoc['email'] ?? '';
        address.value = userDoc['address'] ?? '';
        city.value = userDoc['city'] ?? '';
        state.value = userDoc['state'] ?? '';
        phone.value = userDoc['phoneNo'] ?? '';
        postalCode.value = userDoc['postalCode'] ?? '';
        profileurl.value = userDoc['profileUrl'] ?? '';
        print(name.value);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
