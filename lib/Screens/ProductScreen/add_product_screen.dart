import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Scontrollers/ProductScreenController/add_product_controller.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = Get.theme.colorScheme.primary;
    final AddProductController controller = Get.put(AddProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField(
                  'Product Name', controller.productNameController, false),
              buildCategoryDropdown(controller),
              buildSubcategoryDropdown(controller),
              buildTextField(
                  'Weight/Quantity', controller.weightController, false),
              buildTextField(
                  'Description', controller.descriptionController, true),
              buildTextField('Stock Availability',
                  controller.stockAvailabilityController, false),
              buildTextField(
                  'Price',
                  controller.priceController,
                  keyboardType: TextInputType.number,
                  false),
              buildTextField(
                  'Discount',
                  controller.discountController,
                  keyboardType: TextInputType.number,
                  false),
              buildTextField(
                  'Shipping Charges',
                  controller.shippingChargesController,
                  keyboardType: TextInputType.number,
                  false),
              buildImageSection(controller),
              buildPrimaryImageSection(controller),
              buildSwitch('Warranty', controller.warranty),
              buildSwitch('Return/Refundable', controller.returnRefundable),
              buildSwitch('Publish', controller.publish),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool b=await controller.uploadProduct();
                  if(b){
                  Get.back();
                  print("Product Saved");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: Size(Get.width - 20, 50),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, bool flex,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: flex ? 3 : 1,
        maxLines: flex ? null : 1,
        decoration: InputDecoration(
          hintText: label,
          hintStyle:
              TextStyle(fontWeight: FontWeight.w400, color: Colors.black54),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: Get.theme.colorScheme.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: Get.theme.colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryDropdown(AddProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(() {
        return DropdownButtonFormField<String>(
          value: controller.selectedCategory.value,
          decoration: InputDecoration(
            labelText: 'Category',
            filled: false,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Get.theme.colorScheme.primary, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Get.theme.colorScheme.primary, width: 2),
            ),
          ),
          items: controller.categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category, style: TextStyle(color: Colors.black54)),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              controller.setSelectedCategory(newValue);
            }
          },
        );
      }),
    );
  }

  Widget buildSubcategoryDropdown(AddProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(() {
        return DropdownButtonFormField<String>(
          value: controller.selectedSubcategory.value.isEmpty
              ? null
              : controller.selectedSubcategory.value,
          decoration: InputDecoration(
            labelText: 'Subcategory',
            filled: false,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Get.theme.colorScheme.primary, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Get.theme.colorScheme.primary, width: 2),
            ),
          ),
          items: controller.subcategories.map((String subcategory) {
            return DropdownMenuItem<String>(
              value: subcategory,
              child: Text(subcategory, style: TextStyle(color: Colors.black54)),
            );
          }).toList(),
          onChanged: (newValue) {
            controller.selectedSubcategory.value = newValue ?? '';
          },
        );
      }),
    );
  }

  Widget buildImageSection(AddProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: controller.pickImage,
            child: Text('Select Images'),
          ),
          SizedBox(height: 8),
          Obx(() {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Prevent scrolling
              shrinkWrap: true, // Use only the space required
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: controller.selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(controller.selectedImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }


  Widget buildSwitch(String label, RxBool value) {
    return Obx(() {
      return SwitchListTile(
        title: Text(label),
        value: value.value,
        onChanged: (newValue) => value.value = newValue,
      );
    });
  }
  Widget buildPrimaryImageSection(AddProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Primary Image'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: controller.pickPrimaryImage, // Call the method to pick primary image
            child: Text('Select Primary Image'),
          ),
          SizedBox(height: 8),
          Obx(() {
            return Container(
              width: double.infinity, // Set width to be full
              height: 200, // Fixed height for the primary image display
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                image: controller.primaryImage.value != null
                    ? DecorationImage(
                  image: FileImage(controller.primaryImage.value!),
                  fit: BoxFit.cover,
                )
                    : null, // No image
              ),
              child: controller.primaryImage.value == null
                  ? Center(child: Text('No Image Selected', style: TextStyle(color: Colors.black54)))
                  : null,
            );
          }),
        ],
      ),
    );
  }
}
