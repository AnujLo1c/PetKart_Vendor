import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';

class AddPetController extends GetxController {
  // TextEditingControllers for each input field
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController deliveryPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController discountController = TextEditingController(text: "0");

  // Observables for dropdowns and toggles
  var category = ''.obs;
  var breed = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var color = ''.obs;
  var size = ''.obs;
  var vaccinated = false.obs;
  var petsCompatible = false.obs;
  var kidsCompatible = false.obs;
  var publish = false.obs;
  var neutered = false.obs;
  var healthCondition = 'Good'.obs;
  var delivery = false.obs;

  @override
  void onClose() {
    // Dispose controllers when the screen is closed
    petNameController.dispose();
    priceController.dispose();
    deliveryPriceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }


  var selectedImages = <String>[].obs;
  var primaryImage = Rx<File?>(null);
  Future<void> pickPrimaryImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      primaryImage.value = File(pickedFile.path); // Store the File object
    }
  }
  Future<void> pickImage() async {
    if (selectedImages.length >= 5) {
      Get.snackbar("Limit Reached", "You can only select up to 5 images.");
      return;
    }

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages.add(pickedFile.path); // Add the selected image path to the list
    }
  }
  Future<void> uploadPetData() async {
    try {
      // Create a reference to Firestore collection
      final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('pets').doc(category.value).collection(category.value);
      final CollectionReference vendorCollection =
      FirebaseFirestore.instance.collection('vendorusers');

      // Add a new document to the Firestore collection and get the document ID
      final docRef = await petsCollection.add({
        'petName': petNameController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': category.value,
        'breed': breed.value,
        'age': age.value,
        'gender': gender.value,
        'color': color.value,
        'size': size.value,
        'nature': size.value,
        'vaccinated': vaccinated.value,
        'neutered': neutered.value,
        'kidsCompatible':kidsCompatible.value,
        'petsCompatible':petsCompatible.value,
        'healthCondition': healthCondition.value,
        'price': priceController.text.trim(),
        'discount': discountController.text.trim(),
        'delivery': delivery.value,
        'deliveryPrice': delivery.value ? deliveryPriceController.text.trim() : null,
        'publish': publish.value,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final String docId = docRef.id;

      // Upload primary image
      if (primaryImage.value != null) {
        final String primaryImagePath = 'pets/$docId/primary_image.jpg';
        await _uploadImage(primaryImage.value!, primaryImagePath);

        // Update Firestore with primary image URL
        final String primaryImageUrl = await _getImageUrl(primaryImagePath);
        await docRef.update({'primaryImageUrl': primaryImageUrl});
      }

      // Upload other selected images
      if (selectedImages.isNotEmpty) {
        for (int i = 0; i < selectedImages.length; i++) {
          final String imagePath = 'pets/$docId/images/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
          await _uploadImage(File(selectedImages[i]), imagePath);
        }
      }
      final String vendorId = EmailPassLoginAl().getEmail(); // Replace with the vendor's actual ID
      var vendordata=await vendorCollection.doc(vendorId).get();
      var data=vendordata.data() as Map<String, dynamic>;

      Map<String,dynamic> additionalData={
        "owner": vendorId,
        "ordered":false,
        "stringList":selectedImages,
        "docid":docId,
        "city":data['city']
       , 'petsList': FieldValue.arrayUnion([docId]),
      };
      await vendorCollection.doc(vendorId).update(
      additionalData
      );

      Get.snackbar('Success', 'Pet details uploaded successfully.',backgroundColor: Get.theme.colorScheme.primary);
Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload pet details: $e',backgroundColor: Get.theme.colorScheme.primary);
    }
  }

  // Method to upload image to Firebase Storage
  Future<void> _uploadImage(File image, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(image);
  }

  // Method to get the URL of an uploaded image
  Future<String> _getImageUrl(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    return await ref.getDownloadURL();
  }
}