import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Scontrollers/LoginScreenControllers/sign_up_controller_google.dart';
import 'package:petkart_vendor/Scontrollers/ProductScreenController/all_products_controller.dart';
import 'package:petkart_vendor/Scontrollers/ProfileController/settings_screen_controller.dart';
import 'package:petkart_vendor/Scontrollers/theme_controller.dart';
import 'package:petkart_vendor/Screens/DashboardScreen/dashboard_all_report_screen.dart';
import 'package:petkart_vendor/Screens/DashboardScreen/dashboard_page.dart';
import 'package:petkart_vendor/Screens/DashboardScreen/notification_screen.dart';
import 'package:petkart_vendor/Screens/EarningScreen/payment_history_screen.dart';
import 'package:petkart_vendor/Screens/LoginScreen/email_verification_screen.dart';
import 'package:petkart_vendor/Screens/LoginScreen/login_signup_screen.dart';
import 'package:petkart_vendor/Screens/OrderScreen/order_detail_screen.dart';
import 'package:petkart_vendor/Screens/OrderScreen/track_order_screen.dart';
import 'package:petkart_vendor/Screens/Profile/profile_details_update.dart';
import 'package:petkart_vendor/Screens/Profile/settings_screen.dart';
import 'package:petkart_vendor/Screens/VendorOnboardScreens/vendor_onboarding_screen.dart';
import 'package:petkart_vendor/Screens/bottom_nav.dart';

import 'Firebase/firebase_options.dart';
// import 'Screens/LoginScreen/login_screen.dart';
// import 'Screens/LoginScreen/signUp_screen.dart';
import 'Screens/LoginScreen/singUp_screenGoogle.dart';
import 'Screens/ProductScreen/add_product_screen.dart';
import 'Screens/ProductScreen/all_products_screen.dart';
import 'Screens/Profile/profile_change_password_screen.dart';
import 'Screens/VendorOnboardScreens/vendor_approval_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    ThemeController themeController=Get.put(ThemeController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetKart Vendor',
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      themeMode: themeController.themeMode.value,
      getPages: [

        //Login
        // GetPage(name: "/login", page: () => const LoginScreen()),
        // GetPage(name: "/signup", page: () => const SignupScreen()),
        // GetPage(name: "/login_home", page: () => const SignupScreen()),
        GetPage(name: "/login_signup_screen", page: () => const LoginSignupScreen()),
        GetPage(name: "/signup_google_screen", page: () => const SingupScreengoogle()),
        GetPage(name: "/emailverify", page: () => const EmailVerificationScreen()),

//bottom-nav /home
        GetPage(name: "/bottom_nav", page: () => const BottomNav()),

        //vendor onboarding
        GetPage(name: "/vendor_approval_screen", page: () => const VendorApprovalScreen()),
        GetPage(name: "/vendor_onboarding_details_screen", page: () => const VendorOnboardingDetails()),

        //dashboard
        GetPage(name: "/noti_screen", page: () => const NotificationScreen()),
        GetPage(name: "/dashboard_all_report_screen", page: () => const DashboardAllReportScreen()),

        //product
        GetPage(name: "/all_product_screen", page: () => const AllProductScreen()),
        GetPage(name: "/add_product_screen", page: () => const AddProductScreen()),

        //order-section
        GetPage(name: "/order_details_screen", page: () => const OrderDetailScreen()),
        GetPage(name: "/track_order_screen", page: () => const TrackOrderScreen()),

        //Earnings
        GetPage(name: "/payment_history_screen", page: () => const PaymentHistoryScreen()),


        //profile
        GetPage(name: "/update_profile_screen", page: () => const ProfileDetailsUpdateScreen()),
        GetPage(name: "/profile_setting_screen", page: () => const SettingsScreen()),
        GetPage(name: "/profile_change_password_screen", page: () => const ProfileChangePasswordScreen()),

      ],
      // initialRoute: "/login_signup_screen",
      initialRoute: "/vendor_onboarding_details_screen",

      unknownRoute: GetPage(name: "/login", page: () => const LoginSignupScreen()),
    );
  }
}

