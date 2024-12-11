import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'dart:io';

import '../../Scontrollers/VendorOnboardController/vendor_onboarding_controller.dart';

class VendorOnboardingDetails extends StatelessWidget {
  const VendorOnboardingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final VendorOnboardingController controller = Get.put(VendorOnboardingController());
    final primary = Get.theme.colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Onboarding Details'),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Your Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              buildTextField('Business Name', controller.businessNameController, false),
              const Gap(8),
              buildTextField('Description', controller.descriptionController, true), // Changed here
              const Gap(8),
              buildDropdown('State', controller.selectedState, controller.states),
              const Gap(8),
              buildDropdown('City', controller.selectedCity, controller.cities),
              const Gap(8),
              buildTextField('Address', controller.addressController, false),
              const Gap(8),
              buildTextField('Postal Code', controller.postalCodeController, false),
              const SizedBox(height: 10),

              const Text(
                'Upload Relevant Valid Certificate',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildImagePicker(controller),
              const SizedBox(height: 10),
              // buildTextField('Upload File', controller.certificateController, false, readOnly: true),
              const Gap(8),
              // buildTextField('Certificate', controller.certificateController, false),
              buildTermsAndPolicyCheckbox(controller),
              const SizedBox(height: 10),
              buildSubmitButton('Submit', () async {
                if (controller.termsAccepted.value) {
                  if(await controller.uploadData()){
                  Get.snackbar('Certificate Submitted', 'Data uploaded successfully!',backgroundColor: Get.theme.colorScheme.primary);
                    Get.offNamed("/vendor_approval_screen");
                  }
                  else{
                  Get.snackbar('Failed', 'Data not uploaded!');

                  }
                } else {
                  Get.snackbar('Error', 'Please accept the Terms & Policies to continue.');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }


  // Reusable TextField Widget
  Widget buildTextField(String labelText, TextEditingController controller, bool bool, {bool readOnly = false}) {
    Color primary = Get.theme.colorScheme.primary;
    return TextField(
      controller: controller,
      readOnly: readOnly,
      maxLines: null,
      decoration: InputDecoration(
        labelText: labelText,
        filled: false,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)), // Rounded corners
          borderSide: BorderSide(
            color: Colors.blue, // Border color
            width: 2.0, // Border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: primary, // Color when enabled
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: primary, // Color when focused
            width: 3.0,
          ),
        ),
      ),
    );
  }

  // Reusable Dropdown Widget
  Widget buildDropdown(String labelText, RxString selectedValue, List<String> items) {
    Color primary = Get.theme.colorScheme.primary;
    return Obx(() => DropdownButtonFormField<String>(
      value: selectedValue.value.isEmpty ? null : selectedValue.value,
      onChanged: (value) => selectedValue.value = value!,
      decoration: InputDecoration(
        labelText: labelText,
        filled: false,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)), // Rounded corners
          borderSide: BorderSide(
            color: Colors.blue, // Border color
            width: 2.0, // Border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: primary, // Color when enabled
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: primary, // Color when focused
            width: 3.0,
          ),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    ));
  }

  // Image Picker Section
  Widget buildImagePicker(VendorOnboardingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Images (up to 4)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
             ElevatedButton(
              // icon: const Icon(Icons.add_a_photo, color: Colors.black),
              onPressed: () async {
                if (controller.selectedImages.length < 4) {
                  final pickedFiles = await controller.pickImages();
                  controller.addImages(pickedFiles);
                }
                else{
                  print("Upload limit reached.");
                }
              },
               child: const Text("Add Image",style: TextStyle(fontSize: 14),),
            ),
          ],
        ),
        const Gap(12),
        Obx(() => SizedBox(
          height: 80, // Fixed height for grid view
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of images per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 8.0, // Adjust main axis spacing
            ),

            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.selectedImages.length,
            itemBuilder: (context, index) {
              final image = controller.selectedImages[index];
              return Stack(
                children: [
                  Image.file(
                    File(image.path),
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      padding: EdgeInsets.zero, // Remove default padding
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        controller.removeImage(image);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(4), // Add padding around icon
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )),
      ],
    );
  }



  // Terms and Policies Checkbox
  Widget buildTermsAndPolicyCheckbox(VendorOnboardingController controller) {
    return Obx(() => CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: controller.termsAccepted.value,
      visualDensity: const VisualDensity(horizontal: 0.1, vertical: 0.1),
      onChanged: (value) => controller.termsAccepted.value = value!,
      title: const Text('Terms & Policies',),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Get.theme.colorScheme.primary,
    ));
  }

  // Submit Button
  Widget buildSubmitButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Get.theme.colorScheme.primary,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Validate form inputs

}
