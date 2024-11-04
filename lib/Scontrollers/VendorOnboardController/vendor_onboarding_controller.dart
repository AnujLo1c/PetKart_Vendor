import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';

class VendorOnboardingController extends GetxController {
  var businessNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  var addressController = TextEditingController();
  var postalCodeController = TextEditingController();
  // var certificateController = TextEditingController();

  var selectedState = ''.obs;
  var selectedCity = ''.obs;
  var termsAccepted = false.obs;

  var selectedImages = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Example states and cities
  var states = <String>[
    'State 1',
    'State 2',
    'State 3',
    // Add your states here
  ];

  var cities = <String>[
    'City 1',
    'City 2',
    'City 3',
    // Add your cities here
  ];

  Future<List<XFile>?> pickImages() async {
    return await _picker.pickMultiImage();
  }

  void addImages(List<XFile>? images) {
    if (images != null && selectedImages.length + images.length <= 4) {
      selectedImages.addAll(images);
    }
    else{
      Get.snackbar('Limit reached', "More than 4 images are selected.");
    }
  }

  void removeImage(XFile image) {
    selectedImages.remove(image);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Validate form inputs
  bool validateForm() {
    if (businessNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Business Name');
      return false;
    }
    if (descriptionController.text.isEmpty) {
      // Validate Description
      Get.snackbar('Error', 'Please enter Description');
      return false;
    }
    if (selectedState.value.isEmpty) {
      Get.snackbar('Error', 'Please select a State');
      return false;
    }
    if (selectedCity.value.isEmpty) {
      Get.snackbar('Error', 'Please select a City');
      return false;
    }
    if (!termsAccepted.value) {
      Get.snackbar('Error', 'Please accept the Terms & Policies');
      return false;
    }
    return true;
  }

  // Function to upload data to Firebase
  Future<List<String>> uploadImages(List<XFile> images) async {
    List<String> downloadUrls = [];
    final storageRef = FirebaseStorage.instance.ref();

    for (var image in images) {
      try {
        final imageRef = storageRef.child('vendorCertificates/${image.name}');
        await imageRef.putFile(File(image.path));
        final downloadUrl = await imageRef.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image: $e');
      }
    }
    return downloadUrls;
  }

  // Function to upload data to Firebase, including images
  Future<bool> uploadData() async {
    if (!validateForm()) return false; // Check form validation

    try {
      final String email = EmailPassLoginAl().getEmail();

      // Prepare data without images
      final vendorData = {
        'businessName': businessNameController.text,
        'description': descriptionController.text,
        'state': selectedState.value,
        'city': selectedCity.value,
        'address': addressController.text,
        'postalCode': postalCodeController.text,
        'verified': false, // Set verified to false by default
      };

      // Upload images and get their URLs
      List<String> imageUrls = await uploadImages(selectedImages);

      // Add image URLs to the vendorData
      vendorData['certificates'] = imageUrls; // Save URLs as a list

      // Upload data to Firestore with images
      await _firestore
          .collection('vendorusers')
          .doc(email)
          .set(vendorData, SetOptions(merge: true));

      Get.snackbar('Success', 'Vendor details and images uploaded successfully!');
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload data: $e');
      return false;
    }
  }
}
