import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/tile_models.dart';
import '../../Scontrollers/ProductScreenController/all_products_controller.dart';


class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllProductController controller = Get.put(AllProductController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('All Product List'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(controller),
            Expanded(
              child: Obx(() {
                final products = controller.filteredProducts;

                if (products.isEmpty) {
                  return Center(child: Text('No products found.'));
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return _buildProductTile(context, controller, index, products[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(AllProductController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildProductTile(BuildContext context, AllProductController controller, int index, ProductModel product) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://placekitten.com/80/80',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 60);
                },
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Expand the product details to fill the remaining space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: Pedigry', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Category: Food'),
                  Text('Price: 3000'),
                  Text('Publish Date: 10/10/2024'),
                  Row(
                    children: [
                      Text('Status:'),
                      SizedBox(height: 5,
                        child: Switch(value: true, onChanged: (value) {}
                        ,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Buttons for editing and deleting
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        )
        ,
      ),
    );
  }
}
