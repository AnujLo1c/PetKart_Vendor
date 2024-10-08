import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackbar(String msg) {
  Get.snackbar(
    "Success",
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}

void showErrorSnackbar(String errorMessage) {
  Get.snackbar(
    "Error",
    errorMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
