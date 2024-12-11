import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:intl/intl.dart';
class AllPetController extends GetxController {
  var pets = <Pet>[].obs;
  var filteredPets = <Pet>[].obs;

  var searchQuery = ''.obs;
  var typeFilter = ''.obs;
  var ageFilter = 0.0.obs;
  var startDateFilter = ''.obs;
  var endDateFilter = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPets();
  }

  void fetchPets() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('pets').get();
      final petList = querySnapshot.docs.map((doc) {
        return Pet.fromJson(doc.data());
      }).toList();

      pets.assignAll(petList);
      filteredPets.assignAll(petList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch pets: $e', backgroundColor: Colors.black);
    }
  }

  void applyFilters() {
    filteredPets.assignAll(pets.where((pet) {
      bool matchesSearchQuery = pet.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      bool matchesType = typeFilter.value.isEmpty || pet.type.toLowerCase().contains(typeFilter.value.toLowerCase());
      bool matchesAge = ageFilter.value == 0 || int.parse(pet.age) <= ageFilter.value;
      bool matchesDate = (startDateFilter.value.isEmpty || pet.postDate.compareTo(startDateFilter.value) >= 0) &&
          (endDateFilter.value.isEmpty || pet.postDate.compareTo(endDateFilter.value) <= 0);

      return matchesSearchQuery && matchesType && matchesAge && matchesDate;
    }).toList());
  }

  void clearFilters() {
    searchQuery.value = '';
    typeFilter.value = '';
    ageFilter.value = 0.0;
    startDateFilter.value = '';
    endDateFilter.value = '';
    applyFilters();
  }
}



class Pet {
  String name;
  String type;
  String img;
  String age;
  bool publish;
  String postDate;

  Pet({
    required this.name,
    required this.type,
    required this.img,
    required this.age,
    required this.publish,
    required this.postDate,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['createdAt'] ?? Timestamp(0, 0);
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return Pet(
      name: json['petName'] ?? 'Unknown',
      type: json['gender'] ?? 'Unknown',
      img: json['primaryImageUrl'] ?? 'Unknown',
      age: json['age'] ?? 0,
      publish: json['publish'] ?? false,
      postDate: formattedDate,
    );
  }
}
