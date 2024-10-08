import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../MyWidgets/snackbarAL.dart';


class LoginController extends GetxController {
  final GlobalKey<FormState> formKeylogin = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
final FocusNode emailFocus=FocusNode();
final FocusNode passFocus=FocusNode();
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    super.onClose();
    // print("LoginController disposed");
  }
  loginUser() async {
    if (formKeylogin.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      if (await EmailPassLoginAl().loginInAL(email, password)) {
        Get.toNamed("/entrySet");
      } else {
        showErrorSnackbar("login Failed");
      }
    }
  }
  void clearText() {
    emailController.clear();
    passwordController.clear();
    passFocus.unfocus();
    emailFocus.unfocus();
  }

}
