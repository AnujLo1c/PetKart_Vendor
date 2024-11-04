import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:petkart_vendor/Scontrollers/ProductScreenController/product_page_controller.dart';
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AddBox("Add New\n Product",Icons.add_box,(){ Get.toNamed("/add_product_screen");}),
            AddBox("Add New\n    Pet",Icons.lan_rounded,(){}),
          ],
        ),
        const Gap(30),
        Row(
          children: [
            const Gap(20),
            const Text("Product List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const Spacer(),
            TextButton(onPressed: (){
              Get.toNamed("/all_product_screen");
            }, child: const Text("See all products"))
            ,const Gap(40),
          ],
        ),

Expanded(child: ProductList())
      ],
    );
  }
}

AddBox(String text, IconData icon, VoidCallback todo) {
return GestureDetector(
  onTap: todo,
  child: Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration(
      border: Border.all(color: Get.theme.colorScheme.primary),
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,size: 50,color: Colors.black,),
        const Gap(10),
        Text(text)
      ],
    ),
  ),
);
}



class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductPageController productController = Get.put(ProductPageController());

    return Obx(() {
      if (productController.isLoading.value && productController.products.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else if (productController.products.isEmpty) {
        return Center(child: Text('No products found.'));
      }

      return _buildProductList(productController);
    });
  }

  Widget _buildProductList(ProductPageController productController) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!productController.isLoading.value &&
            productController.hasMore.value &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          productController.loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: productController.products.length + (productController.hasMore.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < productController.products.length) {
            return ProductListItem(product: productController.products[index],productPageController: productController);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


class ProductListItem extends StatelessWidget {
  final Map<String, dynamic> product;
final ProductPageController productPageController;
  const ProductListItem({super.key, required this.product,required this.productPageController});

  @override
  Widget build(BuildContext context) {
    return productCard(
      productName: product['name'] ?? 'Product Name',
      productType: product['category'] ?? 'Unknown ',
      subType: product['subcategory'] ?? 'Unknown ',
      productPrice: product['price']?.toString() ?? '0',
      productStock: product['stockAvailability'],
      offerPrice: product['discount']?.toString() ?? '0',
      listingDate: getFormattedDate(product['date']) ,
      imageUrl: product['primaryImageUrl'] ?? 'assets/img/cat.png',
     controller: productPageController
   ,docId: product['docId']
        );


  }


  String getFormattedDate(dynamic date) {
    DateTime dateTime;

    // Check if the input is a Timestamp
    if (date is Timestamp) {
      dateTime = date.toDate(); // Convert Timestamp to DateTime
    } else if (date is DateTime) {
      dateTime = date; // If already a DateTime, use it directly
    } else {
      return 'Invalid date'; // Handle the case where the date is not recognized
    }

    // Format the DateTime
    return DateFormat('dd/MM/yy - kk:mm').format(dateTime); // Adjust format as needed
  }

}
Widget productCard({
  required String productName,
  required String productType,
  required String subType,
  required String productPrice,

  required String offerPrice,
  required String listingDate,
  required String imageUrl, required int productStock, required ProductPageController controller, required docId,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/img/cat.png', // Fallback image
                height: 120,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // Row(
                //   children: [
                //
                //     Spacer(),
                //     SizedBox(
                //       height: 25,
                //       child: IconButton(
                //         icon: Icon(Icons.edit, color: Colors.grey,size: 20,),
                //         onPressed: (){
                //           //TODO: edit
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                    Text('category: $productType/$subType'),
  //               Row(
  //                 children: [
  //                   Spacer(),
  //                   SizedBox(
  //                     height: 2,
  //                     child: IconButton(
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       icon: Icon(Icons.delete, color: Colors.grey),
  //                       onPressed: (){
  // showDeleteConfirmationDialog(
  // onConfirmDelete: () {
  // // Your delete logic here
  // controller.deleteProduct(docId);
  // print("Item deleted");
  //                       },);}
  //                     ),
  //                   ),
  //                 ],
  //               ),
                // Text('category: $productType/$subType'),
                Text('Price: $productPrice'),

                    Text('Discount: $offerPrice%'),
                  Text('Stock : ${productStock.toString()}  '),
                Text('Listed On: $listingDate'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
void showDeleteConfirmationDialog({
  required VoidCallback onConfirmDelete,
}) {
  Get.defaultDialog(
    title: "Confirm Delete",
    middleText: "Are you sure you want to delete ?",
    textConfirm: "Delete",
    textCancel: "Cancel",
    confirmTextColor: Colors.white,
    cancelTextColor: Colors.black,
    buttonColor: Colors.red,
    onConfirm: () {
      onConfirmDelete();
      Get.back(); // Close the dialog
    },
    onCancel: () {
      Get.back(); // Close the dialog without doing anything
    },
  );
}

