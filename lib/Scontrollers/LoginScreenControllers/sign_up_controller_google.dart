import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
// import 'package:pet_kart/Firebase/FirebaseFirestore/firestore_firebase.dart';
// import 'package:pet_kart/Models/customer.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Firebase/FirebaseFirestore/firestore_firebase.dart';
import '../../Models/customer.dart';
import '../persistent_data_controller.dart';

class SignUpControllerGoogle extends GetxController{
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();
  PersistentDataController persistentDataController=Get.put(PersistentDataController());
  final formKey1 = GlobalKey<FormState>();

  var image = Rx<File?>(null);
String email=EmailPassLoginAl().getEmail();

  void GoogleSignUp(SignUpControllerGoogle controller) {
    Customer user=Customer(customerName: nicknameController.text, email: email, phoneNo: phoneController.text);
    FirestoreFirebaseAL().uploadUserDataAL(user);
    storeUserName(email);
    Get.toNamed("/bottom_nav");
  }

  Future<void> storeUserName(String email) async {
    persistentDataController.userName.value = await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .get()
        .then((value) {
      final data = value.data();
      return data?["customerName"] ?? "Unknown User"; // Default value if null
    }).catchError((error) {
      print("Error fetching username: $error");
      return "Unknown User";  // Fallback in case of error
    });
  }

}