import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';

class ProfileDetailsUpdateController extends GetxController {
  var name = ''.obs;
  // var email = ''.obs;
  var mobileNumber = ''.obs;
  var storeDescription = ''.obs;
  var address = ''.obs; // Text input
  var selectedState = ''.obs; // Dropdown for state
  var selectedCity = ''.obs; // Dropdown for city
  var postalCode = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  final List<String> states = [
    'California',
    'Texas',
    'Florida',
    // Add more states as needed
  ];

  final List<String> cities = [
    'Los Angeles',
    'Houston',
    'Miami',
    // Add more cities as needed
  ];

  String uid=EmailPassLoginAl().getEmail();
  void updateProfile() async {
    Map<String, String> updateData = {};

    // Check if fields are not empty and add to the updateData map
    if (name.value.isNotEmpty) {
      updateData['businessName'] = name.value;
    }

    if (mobileNumber.value.isNotEmpty) {
      updateData['phoneNo'] = mobileNumber.value;
    }
    if (storeDescription.value.isNotEmpty) {
      updateData['description'] = storeDescription.value;
    }

    try {
      if (updateData.isNotEmpty) {
        await _firestore.collection('vendorusers').doc(uid).update(updateData);
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Info', 'No fields to update');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }


  // Update address information
  void updateAddress() async {
    Map<String, String> updateData = {};

    // Check if fields are not empty and add to the updateData map
    if (address.value.isNotEmpty) {
      updateData['address'] = address.value;
    }
    if (selectedState.value.isNotEmpty) {
      updateData['state'] = selectedState.value;
    }
    if (selectedCity.value.isNotEmpty) {
      updateData['city'] = selectedCity.value;
    }
    if (postalCode.value.isNotEmpty) {
      updateData['postalCode'] = postalCode.value;
    }

    try {
      if (updateData.isNotEmpty) {
        await _firestore.collection('vendorusers').doc(uid).update(updateData);
        Get.snackbar('Success', 'Address updated successfully');
      } else {
        Get.snackbar('Info', 'No fields to update');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update address: $e');
    }
  }
  Future<String?> selectCropAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseStorage storage = FirebaseStorage.instance;

    try {
      // Step 1: Select an image from the gallery
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        return null; // User canceled image selection
      }

      // Step 2: Crop the selected image
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
          aspectRatio: CropAspectRatio(ratioX: 100, ratioY: 100),

        uiSettings: [ AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Get.theme.colorScheme.primary,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),]

      );

      if (croppedImage == null) {
        return null; // User canceled cropping
      }

      // Step 3: Get the user's email for the file name
      final User? user = auth.currentUser;
      if (user == null || user.email == null) {
        throw Exception("User is not logged in or email is unavailable");
      }
      final String fileName = uid;

      // Step 4: Upload the cropped image to Firebase Storage
      final File imageFile = File(croppedImage.path);
      final Reference storageRef = storage.ref().child("profile/$fileName");

      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Step 5: Update the vendorUser document in Firestore with profileUrl
      await _firestore.collection('vendorusers').doc(uid).update({
        'profileUrl': downloadUrl,
      });

      print("Profile URL updated successfully in Firestore: $downloadUrl");
    } catch (e) {
      print('Error selecting, cropping, uploading image, or updating Firestore: $e');
    }
  }
}
