import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Scontrollers/ProductScreenController/add_pet_controller.dart';

class AddPetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddPetController controller = Get.put(AddPetController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Pet"),
        backgroundColor: Get.theme.colorScheme.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet Name
              _buildTextField(
                label: "Pet Name",
                controller: controller.petNameController,
              ),
              const SizedBox(height: 15),

              _buildTextField(
                label: "Description",
                controller: controller.descriptionController,
                maxLines: 3,
              ),
              Gap(15),
              // Category Dropdown
              _buildDropdown(
                label: "Category",
                items: ['Dog', 'Cat', 'Bird', 'Mammals','Fish'],
                onChanged: (value) => controller.category.value = value!,
              ),
              const SizedBox(height: 15),

              // Breed Dropdown
              _buildDropdown(
                label: "Breed",
                items: ['Breed 1', 'Breed 2', 'Breed 3'],
                onChanged: (value) => controller.breed.value = value!,
              ),
              const SizedBox(height: 15),

              // Age Dropdown
              _buildDropdown(
                label: "Age",
                items: ['1 Year', '2 Years', '3 Years'],
                onChanged: (value) => controller.age.value = value!,
              ),
              const SizedBox(height: 15),

              // Gender Dropdown
              _buildDropdown(
                label: "Gender",
                items: ['Male', 'Female'],
                onChanged: (value) => controller.gender.value = value!,
              ),
              const SizedBox(height: 15),

              // Color Dropdown
              _buildDropdown(
                label: "Colour",
                items: ['Black', 'White', 'Brown', 'Other'],
                onChanged: (value) => controller.color.value = value!,
              ),
              const SizedBox(height: 15),

              // Size Dropdown
              _buildDropdown(
                label: "Size/Height",
                items: ['Small', 'Medium', 'Large'],
                onChanged: (value) => controller.size.value = value!,
              ),
              Gap(10),
              _buildDropdown(
                label: "Nature",
                items: ['Friendly', 'Shy', 'Large'],
                onChanged: (value) => controller.size.value = value!,
              ),
              const SizedBox(height: 10),
              buildImageSection(controller),
              buildPrimaryImageSection(controller),
              // Vaccinated Toggle
              _buildSwitchTile(
                label: "Vaccinated",
                value: controller.vaccinated,
                onChanged: (value) => controller.vaccinated.value = value,
              ),
              _buildSwitchTile(
                label: "petsCompatible",
                value: controller.vaccinated,
                onChanged: (value) => controller.vaccinated.value = value,
              ),
              _buildSwitchTile(
                label: "kidsCompatible",
                value: controller.vaccinated,
                onChanged: (value) => controller.vaccinated.value = value,
              ),
              _buildSwitchTile(
                label: "Neutered",
                value: controller.neutered,
                onChanged: (value) => controller.neutered.value = value,
              ),
              const SizedBox(height: 5),

              // Health Condition Radio
              const Text("Health Condition", style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(
                    () => Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: RadioListTile(

                        title: const Text("Good"),
                        value: 'Good',
                        groupValue: controller.healthCondition.value,
                        onChanged: (value) => controller.healthCondition.value = value!,
                        contentPadding: EdgeInsets.zero,

                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Moderate"),
                        value: 'Avg',
                        groupValue: controller.healthCondition.value,
                        onChanged: (value) => controller.healthCondition.value = value!,
                      ),
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Bad"),
                      value: 'Bad',
                      groupValue: controller.healthCondition.value,
                      onChanged: (value) => controller.healthCondition.value = value!,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Price
              _buildTextField(
                label: "Price",
                controller: controller.priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: "Discount",
                controller: controller.discountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              // Delivery Toggle and Price
              _buildSwitchTile(
                label: "Enable Delivery",
                value: controller.delivery,
                onChanged: (value) => controller.delivery.value = value,
              ),
              Obx(
                    () => controller.delivery.value
                    ? _buildTextField(
                  label: "Delivery Price",
                  controller: controller.deliveryPriceController,
                  keyboardType: TextInputType.number,
                )
                    : Container(),
              ),
              // const SizedBox(height: 5),

              // Description
              _buildSwitchTile(
                label: "Publish",
                value: controller.publish,
                onChanged: (value) => controller.publish.value = value,
              ),
              const SizedBox(height: 30),

              // Upload Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Upload Logic Here
                    print("Pet Name: ${controller.petNameController.text}");
                    print("Category: ${controller.category.value}");
                    print("Description: ${controller.descriptionController.text}");
                    controller.uploadPetData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.colorScheme.primary,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("Upload", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Common TextField Widget
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
    );
  }

  // Common Dropdown Widget
  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
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
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  // Common Switch Tile Widget
  Widget _buildSwitchTile({
    required String label,
    required RxBool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Obx(
              () => Switch(
            value: value.value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  Widget buildPrimaryImageSection(AddPetController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Primary Image'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: controller.pickPrimaryImage, // Call the method to pick primary image
            child: Text('Select Image'),
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
  Widget buildImageSection(AddPetController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pet Images"),
          Gap(5),
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
}
