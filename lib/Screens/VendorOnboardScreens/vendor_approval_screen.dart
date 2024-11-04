import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorApprovalScreen extends StatelessWidget {
  const VendorApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16.0,left: 16,bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Petkart",style: TextStyle(
                  height: 1,
                  color: Get.theme.colorScheme.primary,
                  fontSize:28,
                  fontWeight: FontWeight.bold
                ),),
                Text("        Vendor Side",style: TextStyle(fontSize: 12),),
                // Image.asset(
                //   'assets/thankyou_icon.png',
                //   height: 150,
                // ),
                const SizedBox(height: 20),
                // Title and Description Text
                Text(
                  'Thank You For\nBecome Petkart Vendor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We will shortly Notify in Your Mail\nAbout Approval Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Check Mail Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Get.theme.colorScheme.primary,
                ),
                onPressed: () {
                  // Get.snackbar(
                  //   'Check Mail',
                  //   'Please check your mail for further updates.',
                  //   snackPosition: SnackPosition.BOTTOM,
                  //   backgroundColor: Colors.pinkAccent.withOpacity(0.8),
                  //   colorText: Colors.white,
                  // );

                },
                child: const Text(
                  'Check Mail',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  static Future<void> openGmail() async {
    const gmailUrl = 'mailto:';
    const webGmailUrl = 'https://mail.google.com/';

    try {
      if (await canLaunchUrl(Uri.parse(gmailUrl))) {
        await launchUrl(Uri.parse(gmailUrl));
      } else {

        if (await canLaunchUrl(Uri.parse(webGmailUrl))) {
          await launchUrl(Uri.parse(webGmailUrl), mode: LaunchMode.externalApplication);
        } else {

          throw 'Could not launch Gmail app or browser';
        }
      }
    } catch (e) {
      print("Error opening Gmail: $e");
      // Optionally, you can show a snackbar or dialog with error details
    }
  }
}
