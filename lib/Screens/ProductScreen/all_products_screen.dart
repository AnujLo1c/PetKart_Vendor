import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/tile_models.dart';
import '../../Scontrollers/ProductScreenController/all_products_controller.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllProductController controller = Get.put(AllProductController());
    Color primary = Get.theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('All Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context, controller);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(controller), // Search bar with a search button
            Expanded(
              child: Obx(() {
                final products = controller.filteredProducts;

                if (products.isEmpty) {
                  return const Center(child: Text('No products found.'));
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

  // Build the search bar with a button to trigger search
  Widget _buildSearchBar(AllProductController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              controller.applyFilters(); // Trigger search when button is pressed
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  // Function to show the filter dialog
  void _showFilterDialog(BuildContext context, AllProductController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Apply Filters'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchField(controller),
                _buildCategoryDropdown(controller),
                _buildPriceSlider(controller),
                _buildDatePicker(controller),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.applyFilters();
                Navigator.of(context).pop();
              },
              child: const Text('Apply Filters'),
            ),
            TextButton(
              onPressed: () {
                controller.searchQuery.value = '';
                controller.categoryFilter.value = '';
                controller.priceFilter.value = 0.0;
                controller.startDateFilter.value = '';
                controller.endDateFilter.value = '';
                controller.applyFilters();
                Navigator.of(context).pop();
              },
              child: const Text('Clear Filters'),
            ),
          ],
        );
      },
    );
  }

  // Search field for filtering by name
  Widget _buildSearchField(AllProductController controller) {
    return TextField(
      onChanged: (value) {
        controller.searchQuery.value = value;
      },
      decoration: const InputDecoration(
        labelText: 'Search by name',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  // Category dropdown for filtering by category
  Widget _buildCategoryDropdown(AllProductController controller) {
    return DropdownButton<String>(
      hint: const Text("Select Category"),
      value: controller.categoryFilter.value.isEmpty ? null : controller.categoryFilter.value,
      onChanged: (newValue) {
        controller.categoryFilter.value = newValue ?? '';
      },
      items: <String>['', 'Food', 'Toys', 'Accessories', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Price slider for filtering by price
  Widget _buildPriceSlider(AllProductController controller) {
    return Row(
      children: [
        const Text('Max Price: ₹'),
        Expanded(
          child: Slider(
            min: 0,
            max: 5000,
            value: controller.priceFilter.value,
            onChanged: (value) {
              controller.priceFilter.value = value;
            },
          ),
        ),
        Text('₹${controller.priceFilter.value.toStringAsFixed(2)}'),
      ],
    );
  }

  // Date picker for filtering by date range
  Widget _buildDatePicker(AllProductController controller) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              controller.startDateFilter.value = pickedDate.toIso8601String().split('T')[0];
            }
          },
        ),
        const Text('Start Date:'),
        Expanded(
          child: Text(controller.startDateFilter.value.isEmpty ? 'Select Date' : controller.startDateFilter.value),
        ),
      ],
    );
  }

  // Display the product tile in the list
  Widget _buildProductTile(BuildContext context, AllProductController controller, int index, Product product) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.img,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 60);
                },
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${product.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Category: ${product.category}'),
                  Text('Price: ₹${product.price.toStringAsFixed(2)}'),
                  Text('Publish Date: ${product.publishDate}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
