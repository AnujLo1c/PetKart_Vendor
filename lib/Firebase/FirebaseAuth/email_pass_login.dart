import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

import '../../MyWidgets/snackbarAL.dart';

class EmailPassLoginAl {
  final _auth = FirebaseAuth.instance;
  getEmail(){
    return _auth.currentUser?.email;
  }

  loginInAL(String email, String password) async {
    try {
      if (!validateEmailAL(email)) {
        showErrorSnackbar("Email badly formatted.");
        return false;
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!_auth.currentUser!.emailVerified) {
        Get.toNamed("/emailverify");
      }
      // print("!_auth.currentUser!.emailVerified ${!_auth.currentUser!.emailVerified}");
      showSuccessSnackbar("Login successful.");

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        showErrorSnackbar("No User Found for that Email and Password.");
      } else {
        showErrorSnackbar(e.message.toString());
      }
      return false;

    } catch (e) {
      showErrorSnackbar(e.toString());
      return false;
    }
  }

  signUpAL( String email, String password) async {
    try {
      if (!validateEmailAL(email)) {
        showErrorSnackbar("Email badly formatted.");
        return false;
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      showSuccessSnackbar("Account created successful.");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showErrorSnackbar("Account with this email Already exists.");
        Get.toNamed("/emailverify", arguments: email);
      } else if (e.code == 'weak-password') {
        showErrorSnackbar("Password Provided is too Weak");
      } else {
        showErrorSnackbar(e.message.toString());
        // showSnackbarAL(e.message.toString(), context);
      }
      return false;
    } catch (e) {
        showErrorSnackbar(e.toString());
      // showSnackbarAL(e.toString(), context);
      return false;
    }
  }

  resetPasswordAL(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // showSnackbarAL("Password Reset Email has been sent !", context);
      //Getx controller
      print("Password Reset Email has been sent !");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        // showSnackbarAL("No user found for that email.", context);
      print("No user found for that email.");
      }
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        print('User deleted successfully');
        return true;
      } else {
        print('No user is currently signed in');
        return false;
      }
    } catch (e) {
      print('Failed to delete user: $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print("signout failded");
      return false;
    }
  }

  /////////////////////////////////////////////validation////////////////////////////////////////////////////
//   bool isEmailVerified = false;
//   Timer? timer;
//   @override
//   void initState() {
//     isEmailVerified = false;
//     super.initState();
//     FirebaseAuth.instance.currentUser?.sendEmailVerification();
//     timer =
//         Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
//   }
//   checkEmailVerifiedAL(BuildContext context) async {
//     // Check if currentUser is not null before reloading
//     if (FirebaseAuth.instance.currentUser != null) {
//       await FirebaseAuth.instance.currentUser!.reload();
//        bool isEmailVerifiedAL = FirebaseAuth.instance.currentUser!.emailVerified;
//
//       if (isEmailVerifiedAL) {
//         showSnackbarAL("Email Successfully Verified", context);
//
//        return true;
//       }
//     }
//     return false;
//   }
  ///////////////////////////////////////////// Validation ////////////////////////////////////////////////////

  showSnackbarAL(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(fontSize: 18.0),
    )));
  }

  validateEmailAL(String email) {
    if (EmailValidator.validate(email)) {
      if (email.endsWith("@gmail.com")) {
        return true;
      }
    }
    return false;
  }
}
