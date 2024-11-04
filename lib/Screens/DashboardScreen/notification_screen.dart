import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            //TODO::implement delete logic
          }, icon: Icon(Icons.clear_all_sharp))
        ],
      ),
      body: ListView(
        children: [
          notificationTile(0,"category","item",DateTime.now()),
          notificationTile(0,"category","item",DateTime.now()),
          notificationTile(0,"category","item",DateTime.now()),
        ],
      ),
    );
  }
}

notificationTile(int i, String category, String item, DateTime dt ) {
  String title=i==0?"New Order Recieved":"Item Delivered Successfully";
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10)
        ,color: Get.theme.colorScheme.primary
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
          children: [
        TextSpan(text: title,style: const TextStyle(fontWeight: FontWeight.bold),),
        TextSpan(text: "\n$category > $item\n"),
        TextSpan(text: dt.toString())
          ]
        ),

        ),
        const Spacer(),
        IconButton(onPressed: (){
          //TODO::implement delete logic
        }, icon: const Icon(Icons.delete,size: 20,),color: Colors.white,)
      ],
    ),
  );
}
