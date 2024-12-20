import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:pet_kart/Firebase/FirebaseFirestore/firestore_firebase.dart';
// import 'package:pet_kart/Models/customer.dart';
// import 'package:pet_kart/SControllers/LoginScreenControllers/sign_up_controller_google.dart';
import '../../Firebase/FirebaseFirestore/firestore_firebase.dart';
import '../../Firebase/FirebaseStorage/cloud_storage.dart';
import '../../Models/customer.dart';
import '../../Scontrollers/LoginScreenControllers/sign_up_controller_google.dart';
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
                // _buildProfileImage(context, controller),
                // const Gap(16),
                _buildUsernameField(controller),
                const Gap(8),
                _buildPhoneField(controller),
                const Gap(20),
                _buildSignUpButton(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField(SignUpControllerGoogle controller) {
  Color primary=Get.theme.colorScheme.primary;
    return TextFormField(
      controller: controller.nicknameController,


      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your nickname';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Username',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(SignUpControllerGoogle controller) {
    return ElevatedButton(
      onPressed: () async {
        controller.GoogleSignUp(controller);
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
      phoneNo: "854964515468"
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


  // void _showImageSourceActionSheet(BuildContext context, SignUpControllerGoogle controller) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Gallery'),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 controller.pickImage(ImageSource.gallery);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 controller.pickImage(ImageSource.camera);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  _buildPhoneField(SignUpControllerGoogle controller) {
Color primary=Get.theme.colorScheme.primary;
      return TextFormField(
        controller: controller.phoneController,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Phone number',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  }
}