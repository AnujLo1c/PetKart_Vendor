import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Scontrollers/LoginScreenControllers/login_signup_controller.dart';



class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginSignupController loginSignupController =
    Get.put(LoginSignupController());
    Color primary = Get.theme.colorScheme.primary;
    return Scaffold(
      backgroundColor: primary,
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Petkart',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      loginSignupController.toggleMove();
                      _showBottomSheet(true, loginSignupController);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primary),
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      loginSignupController.toggleMove();
                      _showBottomSheet(false, loginSignupController);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primary),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
              const Gap(15)
            ],
          ),
        ),

        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 80,
          topF: 650,
          left: 20,
          icon: Icons.pets,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 140,
          topF: 580,
          left: 60,
          icon: Icons.emoji_emotions,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 130,
          topF: 450,
          left: 130,
          icon: Icons.person,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 170,
          topF: 470,
          left: 70,
          icon: Icons.mood,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 250,
          topF: 40,
          left: 10,
          icon: Icons.pets,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 280,
          topF: 380,
          left: 90,
          icon: Icons.emoji_emotions,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 240,
          topF: 220,
          left: 150,
          icon: Icons.person,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 200,
          topF: 300,
          left: 40,
          icon: Icons.mood,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 250,
          topF: 90,
          left: 110,
          icon: Icons.star,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 300,
          topF: 550,
          left: 25,
          icon: Icons.ac_unit,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 90,
          topF: 200,
          left: 80,
          icon: Icons.wb_sunny,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 30,
          topF: 280,
          left: 100,
          icon: Icons.beach_access,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 180,
          topF: 520,
          left: 220,
          icon: Icons.sports_soccer,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 160,
          topF: 120,
          left: 30,
          icon: Icons.flight,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 110,
          topF: 200,
          left: 20,
          icon: Icons.local_cafe,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 300,
          topF: 680,
          left: 290,
          icon: Icons.shopping_cart,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 200,
          topF: 590,
          left: 140,
          icon: Icons.home,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 80,
          topF: 150,
          left: 130,
          icon: Icons.nature_people,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 50,
          topF: 430,
          left: 50,
          icon: Icons.directions_bike,
        ),

        //rest
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 250,
          topF: 650,
          left: Get.width-10-20,
          icon: Icons.pets,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 240,
          topF: 580,
          left: Get.width-10-60,
          icon: Icons.emoji_emotions,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 130,
          topF: 450,
          left: Get.width-10-130,
          icon: Icons.person,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 170,
          topF: 470,
          left: Get.width-10-70,
          icon: Icons.mood,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 150,
          topF: 40,
          left: Get.width-10-10,
          icon: Icons.pets,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 120,
          topF: 380,
          left: Get.width-10-90,
          icon: Icons.emoji_emotions,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 280,
          topF: 220,
          left: Get.width-10-150,
          icon: Icons.person,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 200,
          topF: 300,
          left: Get.width-10-40,
          icon: Icons.mood,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 250,
          topF: 100,
          left: Get.width-10-110,
          icon: Icons.star,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 230,
          topF: 570,
          left: Get.width-10-155,
          icon: Icons.ac_unit,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 210,
          topF: 200,
          left: Get.width-10-100,
          icon: Icons.wb_sunny,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 50,
          topF: 280,
          left: Get.width-10-100,
          icon: Icons.beach_access,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 80,
          topF: 320,
          left: Get.width-10-150,
          icon: Icons.sports_soccer,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 90,
          topF: 120,
          left: Get.width-10-30,
          icon: Icons.flight,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 30,
          topF: 200,
          left: Get.width-10-20,
          icon: Icons.local_cafe,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 120,
          topF: 650,
          left: Get.width-10-190,
          icon: Icons.shopping_cart,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 120,
          topF: 60,
          left: Get.width-10-160,
          icon: Icons.home,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 34,
          topF: 150,
          left: Get.width-10-130,
          icon: Icons.nature_people,
        ),
        buildAnimatedIcon(
          move: loginSignupController.move,
          topT: 50,
          topF: 430,
          left: Get.width-10-50,
          icon: Icons.directions_bike,
        ),
      ]),
    );
  }

  Widget buildAnimatedIcon({
    required RxBool move,
    required double topT,
    required double topF,
    required double left,
    required IconData icon,
  }) {
    return Obx(
          () => AnimatedPositioned(
        top: move.value ? topT : topF,
        left: left,
        duration: const Duration(seconds: 1),
        child: Icon(icon),
      ),
    );
  }

  void _showBottomSheet(
      bool isSignIn, LoginSignupController loginSignupController) async {
    loginSignupController.isSignIn.value = isSignIn;
    Color primary = Get.theme.colorScheme.primary;

    await Get.bottomSheet(
      Obx(
            () => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            height: loginSignupController.isSignIn.value ? 490 : 550,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  loginSignupController.isSignIn.value
                      ? 'Welcome Back'
                      : 'Get Started',
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: primary),
                ),
                const Gap(30),
                loginSignupController.isSignIn.value
                    ? const SignInWidget()
                    : const SignUpWidget(),
                ElevatedButton(
                  onPressed: () {
                    SignInController().googleLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: primary,
                    backgroundColor: Colors.white,
                    minimumSize: Size(Get.width - 20, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/img/google.png', height: 30),
                      const SizedBox(width: 10),
                      const Text('Sign In with Google'),
                    ],
                  ),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () {
                    loginSignupController.toggleView();
                  },
                  child: Center(
                    child: Text(
                      loginSignupController.isSignIn.value
                          ? 'Don\'t have an account? Sign Up'
                          : 'Already have an account? Sign In',
                      style: TextStyle(color: primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isDismissible: true,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
    );

    print("BottomSheet dismissed");
    loginSignupController.toggleMove();
  }
}

//SignIn
class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.put(SignInController());
    Color primary = Get.theme.colorScheme.primary;
    return Form(
      key: signInController.formKeylogin,
      child: Column(
        children: [
          TextFormField(
            controller: signInController.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              else if (!EmailValidator.validate(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },

          ),
          const Gap(10),
          Obx(
                () => TextFormField(
              obscureText: signInController.isObscure.value,
              controller: signInController.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
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
                suffixIcon: IconButton(
                  icon: Icon(
                    signInController.isObscure.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: signInController.togglePasswordVisibility,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          const Gap(5),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                signInController.clearText();
                Get.toNamed("/forgetpass");
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text("Forget Password?"),
            ),
          ),
          // const Gap(20),
          ElevatedButton(
            onPressed: () {
              signInController.loginUser();
            },
            style:
            ElevatedButton.styleFrom(minimumSize: Size(Get.width - 20, 50)),
            child: const Text('Sign In'),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "OR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 10),

        ],
      ),
    );
  }
}

//SignUP
class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController=Get.put(SignUpController());
    Color primary = Get.theme.colorScheme.primary;
    return Column(
      children: [
        TextField(
          controller: signUpController.nameController,
          decoration: InputDecoration(
            labelText: 'Name',
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
        ),
        const Gap(5),
        TextField(
          controller: signUpController.emailController,
          decoration: InputDecoration(
            labelText: 'Email',
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
        ),
        const Gap(5),
        TextField(
          controller: signUpController.phoneController,
          decoration: InputDecoration(
            labelText: 'Phone No',
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
        ),
        const Gap(5),
        Obx(
              ()=> TextField(
            controller: signUpController.passwordController,

            decoration: InputDecoration(
                labelText: 'Password',
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
                suffixIcon: GestureDetector( onTap: signUpController.toggleObscurePassword,child: Icon(Icons.remove_red_eye))
            ),
            obscureText: signUpController.obscurePassword.value,


          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            signUpController.signUpUser();
          },
          style:
          ElevatedButton.styleFrom(minimumSize: Size(Get.width - 20, 50)),
          child: const Text('Sign Up'),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR"),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 10),

      ],
    );
  }
}
