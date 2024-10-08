import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Text("This Month",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                const Spacer(),
                TextButton(onPressed: (){}, child: const Text("All Reports"))
              ],
            ),
      const Gap(20),
            SizedBox(
              height: Get.height-550,
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
childAspectRatio: 1.2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                 Container(

                   decoration: BoxDecoration(border: Border.all(color: Colors.black)),),
                 Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),),
                 Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),),
                 Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),),

                ],
              ),
            ),

            Row(
              children: [
                const Text("New Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                const Spacer(),
                TextButton(onPressed: (){}, child: const Text("See All Orders"))
              ],
            ),
            const Gap(10),
            SizedBox(
              height: Get.height,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (BuildContext context, int index) { 
                  return orderTile();
                }, itemCount: 5,
                
               
              ),
            )
          ],
        )
      ),
    );
  }
  Widget orderTile(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red), // Red border as per the image
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Order Id\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '20110204-asdsadf\n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Customer Name\n',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Anuj Lowanshi\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Status\n',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Purchased\n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Circular image
                child: Image.asset(
                  'assets/img/cat.png', // Replace with your image path
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Rs 3000',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
