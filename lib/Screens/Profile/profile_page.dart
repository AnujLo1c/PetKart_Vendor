
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/MyWidgets/snackbarAL.dart';

import '../../Firebase/FirebaseAuth/google_sign_in.dart';
import '../../Scontrollers/ProfileController/profile_page_controller.dart';
class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Replace 'your_user_id_here' with the actual user ID you want to fetch.
  final ProfilePageController controller = Get.put(ProfilePageController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(10),
        userBox(controller),
        const Gap(15),
        detailsBox(controller),
        // const Gap(20),
        const Gap(20),
        Column(
          children: [
            profileTile("Change Password",
                    () {
                  Get.toNamed("/profile_change_password_screen");
                },
                Icons.bookmark_add_outlined),
            profileTile("Update Personal Details",
                    () {
                  Get.toNamed("/update_profile_screen");
                },
                Icons.history),

            profileTile("Settings",
                    () {
                  Get.offNamed("/profile_setting_screen");
                },
                Icons.settings),
            const Gap(5),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 55)
                ),
                child: const Text("Log Out",style: TextStyle(fontSize: 20),),
                onPressed: () async {
                  if(await GoogleSignInAL().signOutGoogle()){
                    Get.until((route) => route.settings.name == "/login_signup_screen");
                  }
                  else{
                    showErrorSnackbar("Logout Failed");
                  }
                }),
          ],
        ),
      ],
    );
  }

  Widget userBox(ProfilePageController controller) {
    return Obx(() => SizedBox(
      width: Get.width - 20,
      height: 170,
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.only(top: 10),
              height: 140,
              width: Get.width - 24,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Get.theme.colorScheme.primary),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Get.theme.colorScheme.primary,
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: const Offset(3, 0)
                    )
                  ]
              ),
              child: Row(children: [
                const Gap(110),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${controller.name.value}\n",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18
                        ),
                      ),
                      TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        text: controller.email.value+'\n',
                      ),
                      TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        text: controller.phone.value,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
              left: 10,
              child: Obx(()=>
ClipRRect(
  borderRadius: BorderRadius.circular(15) ,
  child: CachedNetworkImage(
    height: 100,
                    fit: BoxFit.cover,
  
                    width: 90,
                    progressIndicatorBuilder: (context, url, progress) => SizedBox(height:2,width: 2,child: const CircularProgressIndicator()),
                    imageUrl: controller.profileurl.value,
    errorWidget: (context, url, error) => Container(
      height: 100,
      width: 90,
      color: Get.theme.colorScheme.primary,
        child: const Icon(Icons.person,size: 40,)),
                  ),
),
              )
          ),
          const SizedBox(height: 10),
          Positioned(
            bottom: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: Get.width - 30,
                child: const Text(
                  "Are you ready for the First Treasure Hunt of the Series? Let’s gear up to an amazing month end. Showcase your knowledge and compete with others in this exciting Unstop Treasure Hunt: October Series. Let the battle commence!",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
  Widget profileTile(String text, dynamic onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height / 16,
        width: Get.width,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Get.theme.colorScheme.primary
            ),
            boxShadow: [
              BoxShadow(
                  color: Get.theme.colorScheme.shadow,
                  blurRadius: 2,
                  spreadRadius: 2),
            ]),
        child: Row(
          children: [
            const Gap(10),
            Icon(icon,color: Colors.black,),
            const Gap(10),
            Text(text),
            const Spacer(),
            const Icon(Icons.chevron_right,color: Colors.black,),
            const Gap(10)
          ],
        ),
      ),
    );
  }

  Widget detailsBox(ProfilePageController controller) {
    return Obx(() => Container(
      height: 160,
      width: Get.width - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Get.theme.colorScheme.primary),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Get.theme.colorScheme.primary,
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(1, 1)
            )
          ]
      ),
      child: Column(
        children: [
          Text(
            "Communication Address",
            style: TextStyle(color: Get.theme.colorScheme.primary, fontSize: 18, letterSpacing: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(30),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(10),
                  Text("Address:"),
                  Gap(10),
                  Text("City:"),
                  Gap(10),
                  Text("State:"),
                  Gap(10),
                  Text("Pin Code:"),
                ],
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Text(controller.address.value),
                  const Gap(10),
                  Text(controller.city.value),
                  const Gap(10),
                  Text(controller.state.value),
                  const Gap(10),
                  Text(controller.postalCode.value),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
