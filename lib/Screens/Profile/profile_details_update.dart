import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Scontrollers/ProfileController/profile_page_controller.dart';
import '../../Scontrollers/ProfileController/profile_details_update_controller.dart';

class ProfileDetailsUpdateScreen extends StatelessWidget {
  const ProfileDetailsUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
final Color primary=Get.theme.colorScheme.primary;
    // Initialize the controller outside of build to avoid multiple initializations
    final ProfileDetailsUpdateController controller = Get.put(ProfileDetailsUpdateController());
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        ProfilePageController temp=Get.find<ProfilePageController>();
        temp.fetchUserData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Basic Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildTextField('Name', controller.name),
                const Gap(5),
                // buildTextField('Email', controller.email),
                // const Gap(5),
                buildTextField('Mobile Number', controller.mobileNumber),
                const Gap(5),
                buildTextField('Store Description', controller.storeDescription),

                const Gap( 20),
                buildUpdateButton('Update Profile', () {
                  // Handle profile update logic
                  controller.updateProfile();
                }),
                const SizedBox(height: 30),
                const Text('Communication Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildTextField('Your Address', controller.address),
                const Gap(5),

                buildDropdown(
                  'Select State',
                  controller.selectedState,
                  controller.states,
                ),

                const Gap(5),
                // Dropdown for City
                buildDropdown(
                  'Select City',
                  controller.selectedCity,
                  controller.cities,
                ),
                const Gap(5),
                buildTextField('Postal Code', controller.postalCode),
                const SizedBox(height: 20),
                buildUpdateButton('Update Address', () {
                  // Handle address update logic
                  controller.updateAddress();
                }),
                ElevatedButton(onPressed: () => controller.selectCropAndUploadImage(),
                    child:Text("Upload Image"))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildTextField(String labelText, RxString reactiveValue) {
    final Color primary=Get.theme.colorScheme.primary;
    return Obx(() {
      return TextField(
        controller: TextEditingController(text: reactiveValue.value)
          ..selection = TextSelection.collapsed(offset: reactiveValue.value.length),
        onChanged: (text) => reactiveValue.value = text,
        decoration: InputDecoration(
          labelText: labelText,
          filled: false,
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primary)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primary)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primary)
          ),
        ),
      );
    });
  }


  Widget buildDropdown(String hint, RxString selectedValue, List<String> items) {
    final Color primary = Get.theme.colorScheme.primary;

    return Obx(
          () => DropdownButtonFormField<String>(
        value: selectedValue.value.isEmpty ? null : selectedValue.value,
        onChanged: (value) {
          if (value != null) {
            selectedValue.value = value;
          }
        },
        decoration: InputDecoration(
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primary),
          ),
        ),
        hint: Text(hint),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget buildUpdateButton(String text, VoidCallback onPressed) {

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Get.theme.colorScheme.primary,
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
