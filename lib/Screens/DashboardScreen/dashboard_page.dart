import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:petkart_vendor/Scontrollers/DashboardScreenController/dashboard_page_controller.dart';

import '../../Models/income_model.dart';
import '../../MyWidgets/custom_fillers.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardPageController dashboardPageController = Get.put(DashboardPageController());
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "This Month",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
print(dashboardPageController.incomeData);
                        Get.toNamed("/dashboard_all_report_screen",arguments: dashboardPageController.incomeData);
                      },
                      child: const Text("All Reports"))
                ],
              ),
              const Gap(5),
              SizedBox(
                  height: Get.height - 550,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('vendorusers')
                        .doc(EmailPassLoginAl().getEmail())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(),

                        );

                      }

                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }

                      // Accessing the nested 'incomeData' field from the document
                      var incomeData = snapshot.data!.get('incomeData');
                      if (incomeData is List) {
                        // Safely cast incomeData to List<Map<String, dynamic>>
                        final List<Map<String, dynamic>> parsedIncomeData =
                        incomeData.map((e) => Map<String, dynamic>.from(e)).toList();

                        final data = parsedIncomeData[2]; // Assuming you want the third item
                        print(parsedIncomeData);

                        dashboardPageController.incomeData =
                            IncomeModel.fromData(incomeData: parsedIncomeData);
                        return GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            StatCard(title: 'Earnings', amount: data['currentEarnings'].toString(),
                                growth: getGrowth(data['currentEarnings'],data['previousEarnings']).toString(), icon: Icons.money),

                            StatCard(title: 'Gross Sales', amount: data['currentGrossSales'].toString(),
                                growth: getGrowth(data['currentGrossSales'],data['previousGrossSales']).toString(), icon: Icons.do_not_disturb_on_total_silence),

                            StatCard(title: 'Product Sales', amount: data['currentProductSales'].toString(),
                                growth: getGrowth(data['currentProductSales'],data['previousProductSales']).toString(), icon: Icons.shopping_cart),

                            StatCard(title: 'Total Sales', amount: data['currentTotalSales'].toString(),
                                growth: getGrowth(data['currentTotalSales'],data['previousTotalSales']).toString(), icon: Icons.point_of_sale_sharp),
                          ],
                        );
                      } else {
                        return const Text("Invalid data format for incomeData");
                      }
                    },
                  )

              ),
              Row(
                children: [
                  const Text(
                    "New Orders",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        dashboardPageController.navToOrders();
                      }, child: const Text("See All Orders"))
                ],
              ),
              // const Gap(10),
      StreamBuilder<List<Map<String, dynamic>>>(
        stream: dashboardPageController.fetchPetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Pet Orders Found'));
          }

          final petOrder = snapshot.data!;

          return SizedBox(
            height: Get.height,
            child: Column(
              children: [
            orderTile(orderId: petOrder[0]['petId'],customerName: petOrder[0]['customerId'],imgUrl: petOrder[0]['imgUrl'],
                      price: petOrder[0]['totalPrice'] ,status: petOrder[0]['orderStatus']
                  ),
                Gap(10),
                orderTile(orderId: petOrder[1]['petId'],customerName: petOrder[1]['customerId'],imgUrl: petOrder[1]['imgUrl'],
                    price: petOrder[1]['totalPrice'] ,status: petOrder[1]['orderStatus']
                ),
              ],
            )
            // ListView.separated(
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: petOrders.length,
            //   itemBuilder: (context, index) {
            //     final petOrder = petOrders[index];
            //
            //     return orderTile(orderId: petOrder['petId'],customerName: petOrder['customerId'],imgUrl: petOrder['imgUrl'],
            //         price: petOrder['totalPrice'] ,status: petOrder['orderStatus']
            //     );
            //
            //   }, separatorBuilder: (BuildContext context, int index) =>const Gap(10),
            // ),
          );
        },
      )
            ],
          )),
    );
  }
  String getGrowth(curr,prev) {
    if(prev==0)return '0%';
double d=(((curr+prev)/prev)*100);

    return d<=0?'O%':'${d.toStringAsFixed(1)}%';
  }

  Widget orderTile({required String imgUrl, required String price,required String orderId,
    required String customerName, required String status}) {
    print(imgUrl);
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text:  TextSpan(
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  children: [
                    const TextSpan(
                      text: 'Order Id\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: orderId,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 4),
              RichText(
                text:  TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    const TextSpan(
                      text: 'Customer Name\n',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:customerName +'\n',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const TextSpan(
                      text: 'Status\n',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: status,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              // Image.asset(
              //   'assets/img/cat.png',
              //   height: 90,
              //   width: 90,
              //   fit: BoxFit.cover,
              // ),
              handeledNetworkImage(imgUrl),
              const SizedBox(height: 5),
              Text(
                price,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final String growth;
  final IconData icon;

  const StatCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.growth,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Get.theme.colorScheme.primary),
                const Spacer(),
                Text(
                  growth,
                  style: const TextStyle(
                    color: Colors
                        .green, // Change this color based on growth value if needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
