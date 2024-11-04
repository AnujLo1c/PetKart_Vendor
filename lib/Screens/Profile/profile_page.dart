
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Firebase/FirebaseAuth/google_sign_in.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(20),
        userBox(),
     const Gap(30),
        detailsBox(),
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
                onPressed: () {
              GoogleSignInAL().signOutGoogle();
            }),
          ],
        ),
      ],
    );
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
  userBox(){
    return Container(
      width: Get.width-20,
      height: 170,

      child: Stack(
        children: [
          Positioned(
              bottom: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.only(top: 10),
height: 140,width: Get.width-24,
                // color: Colors.black,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Get.theme.colorScheme.primary),

                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                      color: Get.theme.colorScheme.primary,
                      blurRadius: 4,
                      spreadRadius: 2,
                    offset: const Offset(3,0)
                  )]
                ),
                child: Row(children: [
                  const Gap(110),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Nandini Dhote\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Bold style for the name
                            color: Colors.black,
                            fontSize: 18
                          ),
                        ),
                        TextSpan(
                          text: "anujlowanshi3@gmail.com",
                          style: TextStyle(
                            color: Colors.black, // Normal style for the email
                          ),
                        ),
                      ],
                    ),
                  )],),
          )),
          const Positioned(
              left: 10,
              //TODO:cached network image
              child: Image(height: 100,width: 90,fit:BoxFit.fill,image: AssetImage("assets/img/cat.png"))),
          const SizedBox(height: 10,),
          Positioned(
            bottom: 15,
            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: Get.width - 30,
                child: const Text(
                  "Are you ready for the First Treasure Hunt of the Series? Let’s gear up to amazing month end. Showcase your knowledge and compete with others in this exciting Unstop Treasure Hunt: October Series. Let the battle commence!",
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
    );
  }
  //Vendor detail box
  detailsBox(){
return Container(
  height: 160,
  width: Get.width-20,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Get.theme.colorScheme.primary),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: Get.theme.colorScheme.primary,
          blurRadius: 2,
          spreadRadius: 1,
          offset: const Offset(1,1)
      )
    ]
  ),
  child: Column(
    children: [
      Text("Communication  Address ",style: TextStyle(color: Get.theme.colorScheme.primary,fontSize: 18, letterSpacing: 2),)
    ,const Row(
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Gap(30),
        Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            Text("Address :"),
            Gap(10),
            Text("City :"),
            Gap(10),
            Text("State :"),
            Gap(10),
            Text("Pin Code :"),
          ],
        ),
        Gap(20),
        Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            Text("98/1 Kushwah Shri Nagar"),
            Gap(10),
            Text("Indore"),
            Gap(10),
            Text("Madhya Pradesh"),
            Gap(10),
            Text("452010"),
          ],
        )
      ],
    )
    ],
  ),
);
  }
}
