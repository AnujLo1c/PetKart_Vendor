
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Firebase/FirebaseFirestore/firestore_firebase.dart';
import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Scontrollers/LoginScreenControllers/verify_email_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifyEmailController verifyEmailController=Get.put(VerifyEmailController());
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {EmailPassLoginAl().signOut();
EmailPassLoginAl().deleteUser();
FirestoreFirebaseAL().deleteUserDataAl(EmailPassLoginAl().getEmail());
        },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                const Center(
                  child: Text(
                    'Verify Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'We have sent you a Email on ${verifyEmailController.fa.currentUser?.email}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      '\nVerifying email....',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          elevation: 5,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text('Cancel',style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        verifyEmailController.cancelOp();
                      },
                    ),
                    const Gap(10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 5,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        verifyEmailController.resendEmail();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
