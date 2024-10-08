import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputType;
  const CustomTextFormField({super.key,required this.controller,required this.labelText, this.textInputType});

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
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(labelText: labelText),
        keyboardType: textInputType??TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
          if (labelText.compareTo("Email")==0 && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          if (labelText.compareTo("")==0 && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }
}
