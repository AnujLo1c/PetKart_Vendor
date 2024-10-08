import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../MyWidgets/custom_obx_textformfield.dart';
import '../../MyWidgets/custom_textformfield.dart';
import '../../SControllers/LoginScreenControllers/sign_up_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _showImageSourceActionSheet(context, controller),
                  child: Obx(() => CircleAvatar(
                        radius: 70,
                        backgroundColor: Get.theme.colorScheme.primary,
                        backgroundImage: controller.image.value != null
                            ? FileImage(controller.image.value!)
                            : null,
                        child: controller.image.value == null
                            ? const Icon(Icons.person, size: 70)
                            : null,
                      )),
                ),
                const Gap(10),
                const Text(
                  "Select Profile",
                  style: TextStyle(fontSize: 14),
                ),
                const Gap(20),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      //TODO:Fix the validator message issue . Set up snackbar or this.
                      CustomTextFormField(
                        controller: controller.nicknameController,
                        labelText: "Name",
                      ),
                      const Gap(10),
                      CustomTextFormField(
                        controller: controller.emailController,
                        labelText: "Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                      const Gap(10),
                      CustomTextFormField(
                          controller: controller.phoneController,
                          labelText: "Phone no."),

                      const Gap(10),
                      CustomObxTextFormField(
                        controller: controller,
                        textEditingController: controller.passwordController,
                        obscureText: controller.obscurePassword,
                        toggleObscureCall: controller.toggleObscurePassword,
                        labelText: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      CustomObxTextFormField(
                        textEditingController:
                            controller.confirmPasswordController,
                        controller: controller,
                        obscureText: controller.obscureConfirmPassword,
                        toggleObscureCall:
                            controller.toggleObscureConfirmPassword,
                        labelText: "Confirm Password",
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
                const Gap(25),
                ElevatedButton(
                  onPressed: () {
                    controller.signUpUser();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width - 60, 60)),
                  child: const Text('Sign Up'),
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     label: Text("help")
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(
      BuildContext context, SignUpController controller) {
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
