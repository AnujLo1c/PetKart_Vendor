import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../MyWidgets/snackbarAL.dart';



class ForgetPassController extends GetxController{
  // final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPass() async {
      final email = emailController.text.trim();
      if(await EmailPassLoginAl().resetPasswordAL(email)){
        showSuccessSnackbar("Reset email send.");
      }
      else{
        showErrorSnackbar("Some Error");
      }

  }

}