import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(40),
        _buildAddButtons(),

        const Gap(40),
        navButton("All Products",(){Get.toNamed("/all_product_screen");}),
        const Gap(10),
        navButton("All Pets",(){Get.toNamed("/all_pet_screen");}),
      ],
    );
  }
Widget navButton(String title, VoidCallback f){
    Color primary =Get.theme.colorScheme.primary;
    return GestureDetector(
      onTap: f,
      child: Container(
        height: 55,
        width: Get.width-40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primary),
          color: primary
        ),
        child: Row(
          children: [
            const Gap(10),
            Text(title,style: const TextStyle(letterSpacing: 1,color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            const Spacer(),
            const Icon(Icons.chevron_right),
            const Gap(10)
          ],
        ),
      ),
    );
}
  Widget _buildAddButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AddBox("Add New\nProduct", Icons.add_box, () {
          Get.toNamed("/add_product_screen");
        }),
        AddBox("Add New\n   Pet", Icons.pets, () {
          Get.toNamed("/add_pet_screen");
        }),
      ],
    );
  }

}

Widget AddBox(String text, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.black),
          const Gap(10),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

