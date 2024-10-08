import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Scontrollers/theme_controller.dart';
import 'package:petkart_vendor/Screens/DashboardScreen/dashboard_page.dart';
import 'package:petkart_vendor/Screens/DashboardScreen/notification_screen.dart';
import 'package:petkart_vendor/Screens/bottom_nav.dart';

import 'Firebase/firebase_options.dart';
import 'Screens/LoginScreen/login_screen.dart';

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
        GetPage(name: "/login", page: () => const LoginScreen()),
//bottom-nav
        GetPage(name: "/bottom_nav", page: () => const BottomNav()),
        
        //dashboard
        GetPage(name: "/noti_screen", page: () => const NotificationScreen()),
        
      ],
      // initialRoute: "/splash",
      initialRoute: "/bottom_nav",
      unknownRoute: GetPage(name: "/login", page: () => const LoginScreen()),
    );
  }
}

