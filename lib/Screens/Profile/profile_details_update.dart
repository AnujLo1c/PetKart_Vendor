import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Scontrollers/ProfileController/profile_details_update_controller.dart';

class ProfileDetailsUpdateScreen extends StatelessWidget {
  const ProfileDetailsUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller outside of build to avoid multiple initializations
    final ProfileDetailsUpdateController controller = Get.put(ProfileDetailsUpdateController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Basic Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              buildTextField('Name', controller.name),
              buildTextField('Email', controller.email),
              buildTextField('Mobile Number', controller.mobileNumber),
              buildTextField('Store Description', controller.storeDescription),
              SizedBox(height: 20),
              buildUpdateButton('Update Profile', () {
                // Handle profile update logic
                controller.updateProfile();
              }),
              SizedBox(height: 30),
              Text('Communication Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              buildTextField('Your Address', controller.address),
              buildDropdown('Please Select State', controller.state, ['State 1', 'State 2', 'State 3']),
              buildDropdown('Please Select City', controller.city, ['City 1', 'City 2', 'City 3']),
              buildTextField('Postal Code', controller.postalCode),
              SizedBox(height: 20),
              buildUpdateButton('Update Address', () {
                // Handle address update logic
                controller.updateAddress();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, RxString reactiveValue) {
    return Obx(() {
      return TextField(
        controller: TextEditingController(text: reactiveValue.value)
          ..selection = TextSelection.collapsed(offset: reactiveValue.value.length),
        onChanged: (text) => reactiveValue.value = text,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      );
    });
  }

  Widget buildDropdown(String hint, RxString selectedValue, List<String> items) {
    return Obx(() => DropdownButtonFormField<String>(
      value: selectedValue.value.isEmpty ? null : selectedValue.value,
      onChanged: (value) => selectedValue.value = value!,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      hint: Text(hint),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
    ));
  }

  Widget buildUpdateButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.pinkAccent,
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
