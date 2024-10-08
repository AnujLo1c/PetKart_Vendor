import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Scontrollers/LoginScreenControllers/forget_pass_controller.dart';

class ForgetpasswordScreen extends StatelessWidget {
   const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPassController forgetPassController=Get.put(ForgetPassController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.arrow_back_ios_sharp)),
        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: forgetPassController.formKey,
          child: Column(
            children: <Widget>[
              const Gap(30),
              TextFormField(
                controller: forgetPassController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                    return null;
                },
              ),
              const Gap(20),
              ElevatedButton(

                onPressed: () {
                  forgetPassController.resetPass();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width-90, 60)
                ),
                child: const Text('Send Reset Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}