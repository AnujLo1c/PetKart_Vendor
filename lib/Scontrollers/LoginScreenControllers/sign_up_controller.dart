import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Firebase/FirebaseFirestore/firestore_firebase.dart';
import '../../Firebase/FirebaseStorage/cloud_storage.dart';
import '../../Models/customer.dart';

class SignUpController extends GetxController {
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>(debugLabel: "signup");

  var image = Rx<File?>(null);
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

@override
  void onClose() {

    super.onClose();
    nicknameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
  }
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void signUpUser() async {
    if (formKey.currentState?.validate() ?? false) {

      if (await EmailPassLoginAl()
          .signUpAL( emailController.text, passwordController.text)) {

        String profileUrl = await CloudStorage()
            .uploadImageAL(image.value, emailController.text);
        if (profileUrl == "" || profileUrl.isEmpty) {
          await EmailPassLoginAl().deleteUser();
          print("user failed to upload userproffile");
        } else {
          Customer signupUser=Customer(customerName: nicknameController.text, email: emailController.text, profileUrl: profileUrl);
          bool userDataUploadStatus =
              await FirestoreFirebaseAL().uploadUserDataAL(signupUser);
          if (userDataUploadStatus) {
            Get.toNamed("/emailverify");
          } else {
            EmailPassLoginAl().deleteUser();
            CloudStorage().deleteProfile(emailController.text);
            FirestoreFirebaseAL().deleteUserDataAl(emailController.text);
            print("user failed to upload firebasefirestore");
          }
        }
      } else {
        print("here5");
        print("user failed to upload signup firebase auth");
      }
    }
  }
}
