import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../Firebase/FirebaseAuth/google_sign_in.dart';
import '../../MyWidgets/snackbarAL.dart';
import '../../Scontrollers/LoginScreenControllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
   const LoginScreen({super.key});
   @override
   Widget build(BuildContext context) {
     LoginController loginController=Get.put(LoginController());
     return Scaffold(
         appBar:  AppBar(title: const Text("Petkart")),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: SingleChildScrollView(
           child: Column(
             children: [
           Center(
           child: Container(
           width: 200,
             height: 130,
             decoration: BoxDecoration(
               border: Border.all(
                 color: Get.theme.colorScheme.primary, // Border color
                 width: 2, // Border thickness
               ),
               borderRadius: const BorderRadius.all(
                 Radius.elliptical(250, 160), // Oval shape
               ),
             ),
           ),
                  ),
               const Gap(15),
               ShaderMask(
                 shaderCallback: (Rect bounds) {
                   return const LinearGradient(
                     colors: <Color>[Colors.blue, Colors.lightBlueAccent],
                     tileMode: TileMode.mirror,
                   ).createShader(bounds);
                 },
                 child: const Text("Welcome",
                   style: TextStyle(
                   fontSize: 22,
                   fontWeight: FontWeight.w600,
                   color: Colors.white,
                 ),),
               ),
           const Gap(20),
               SizedBox(
                 height: 200,
                 child: Stack(
           
                   alignment: Alignment.topCenter,
                   children:[
                     Container(
                     height: 170,
                     width: Get.size.width-50,
                     decoration: BoxDecoration(
                       shape: BoxShape.rectangle,
                       borderRadius: BorderRadius.circular(10),
                       color: Get.theme.colorScheme.primary.withOpacity(.2)
                     ),
                     child: Form(
                       key: loginController.formKeylogin,
                       child: Column(
                         children: <Widget>[
                           TextFormField(
                             focusNode: loginController.emailFocus,
                             controller: loginController.emailController,
                             decoration: const InputDecoration(labelText: 'Email'),
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Please enter your email';
                               }
                               return null;
                             },
                           ),
                           TextFormField(
                             focusNode: loginController.passFocus,
                             controller: loginController.passwordController,
                             decoration: const InputDecoration(labelText: 'Password'),
                             obscureText: true,
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Please enter your password';
                               }
                               return null;
                             },
                           ),
                           Align(
                             alignment: Alignment.topRight,
                             child: TextButton(onPressed: (){
                               loginController.clearText();
                               Get.toNamed("/forgetpass");
                             },
                                 child: const Text("Forgot Password?",style: TextStyle(fontSize: 14),)
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                     Positioned(
                       bottom: 7,
                       child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15),
           
                           ),
                           minimumSize: const Size(130, 45)
                         ),
                         onPressed: () async {
                           loginController.loginUser();
                         },
                         child: const Text('Login'),
                       ),
                     ),
                   ]
                 ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text("Don’t have a account?"),
                   TextButton(onPressed: (){
                     loginController.clearText();
                     Get.toNamed("/signup");
                   }, child: const Text("Sign Up"))
                 ],
               ),
               ElevatedButton(onPressed: () async {
                 loginController.clearText();
                 UserCredential? uc=await GoogleSignInAL().signInGoogle();
                 if(uc==null){
                   showErrorSnackbar("Some Error");
                 }
                 else if(uc.additionalUserInfo!.isNewUser){
                   //TODO::fix nav
                   Get.toNamed("/googlesignup");
                 }else{
                   Get.toNamed("/bottom_nav");
                 }
               }, child: const Text("Google")),
               // ElevatedButton(onPressed: (){
               //   ThemeController tc=Get.find<ThemeController>();
               //   tc.toggleTheme();
           
               // }, child: const Text("asdf"))
             ],
           ),
         ),
       ),
     );
   }
}