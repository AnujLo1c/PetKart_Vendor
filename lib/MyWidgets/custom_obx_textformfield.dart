import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../SControllers/LoginScreenControllers/sign_up_controller.dart';

class CustomObxTextFormField extends StatelessWidget {
  final SignUpController controller;
  final TextEditingController textEditingController;
  final RxBool obscureText;
  final VoidCallback toggleObscureCall;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomObxTextFormField({
    super.key,
    required this.controller,
    required this.textEditingController,
    required this.obscureText,
    required this.toggleObscureCall,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(2, 2)
            )
          ]
      ),
      child: Obx(() => TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: IconButton(
            icon: Icon(
              obscureText.value ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: toggleObscureCall,
          ),
        ),
        obscureText: obscureText.value,
        validator: (value) {

        if (value == null || value.isEmpty) {
      return 'Please enter your $labelText';
      }
        else if (value != controller.passwordController.text && labelText=="Confirm Password") {
          return 'Passwords do not match';
        }

          return null;
        },
      )),
    );
  }
}
