import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../Firebase/FirebaseFirestore/firestore_firebase.dart';
import '../../Firebase/FirebaseStorage/cloud_storage.dart';
import '../../Scontrollers/LoginScreenControllers/sign_up_controller_google.dart';
import '../../Models/customer.dart';
class SingupScreengoogle extends StatelessWidget {
  const SingupScreengoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpControllerGoogle controller = Get.put(SignUpControllerGoogle());

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // FirestoreFirebaseAL().deleteGoogleUser();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey1,
            child: ListView(
              children: [
                _buildProfileImage(context, controller),
                const Gap(16),
                _buildUsernameField(controller),
                const Gap(32),
                _buildSignUpButton(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, SignUpControllerGoogle controller) {
    return GestureDetector(
      onTap: () => _showImageSourceActionSheet(context, controller),
      child: Obx(() => CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[300],
        backgroundImage: controller.image.value != null ? FileImage(controller.image.value!) : null,
        child: controller.image.value == null ? const Icon(Icons.add_a_photo, size: 50) : null,
      )),
    );
  }

  Widget _buildUsernameField(SignUpControllerGoogle controller) {
    return TextFormField(
      controller: controller.nicknameController,
      decoration: const InputDecoration(labelText: 'Username'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your nickname';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton(SignUpControllerGoogle controller) {
    return ElevatedButton(
      onPressed: () async {
        await _handleSignUp(controller);
      },
      child: const Text('Sign Up'),
    );
  }

  Future<void> _handleSignUp(SignUpControllerGoogle controller) async {
    String? email = controller.email;
    if (email == null) {
      print("Email null");
      Get.close(2);
      return;
    }

    String profileUrl = await CloudStorage().uploadImageAL(controller.image.value, email);
    if (profileUrl.isEmpty) {
      print("Profile URL empty");
      Get.close(1);
      return;
    }

    Customer cu = Customer(
      customerName: controller.nicknameController.text,
      email: controller.email,
      profileUrl: profileUrl,
    );

    bool isSuccess = await FirestoreFirebaseAL().uploadUserDataAL(cu);
    if (isSuccess) {
      print("Success data upload");
      Get.offNamed("/login");
    } else {
      print("Failed data upload");
      Get.close(2);
    }
  }


  void _showImageSourceActionSheet(BuildContext context, SignUpControllerGoogle controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}