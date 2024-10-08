import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';

class SignUpControllerGoogle extends GetxController{
  final nicknameController = TextEditingController();

  final formKey1 = GlobalKey<FormState>();

  var image = Rx<File?>(null);
String email=EmailPassLoginAl().getEmail();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}