import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Scontrollers/ProductScreenController/all_pet_controller.dart';


class AllPetScreen extends StatelessWidget {
  const AllPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllPetController controller = Get.put(AllPetController());
    Color primary = Get.theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('All Pet List'),
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
            _buildSearchBar(controller),
            Expanded(
              child: Obx(() {
                final pets = controller.filteredPets;

                if (pets.isEmpty) {
                  return const Center(child: Text('No pets found.'));
                }

                return ListView.builder(
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    return _buildPetTile(context, controller, index, pets[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(AllPetController controller) {
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
              controller.applyFilters();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, AllPetController controller) {
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
                _buildAgeSlider(controller),
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
                controller.clearFilters();
                Navigator.of(context).pop();
              },
              child: const Text('Clear Filters'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField(AllPetController controller) {
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

  Widget _buildCategoryDropdown(AllPetController controller) {
    return DropdownButton<String>(
      hint: const Text("Select Type"),
      value: controller.typeFilter.value.isEmpty ? null : controller.typeFilter.value,
      onChanged: (newValue) {
        controller.typeFilter.value = newValue ?? '';
      },
      items: <String>['', 'Dog', 'Cat', 'Bird', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildAgeSlider(AllPetController controller) {
    return Row(
      children: [
        const Text('Max Age: '),
        Expanded(
          child: Slider(
            min: 0,
            max: 20,
            value: controller.ageFilter.value,
            onChanged: (value) {
              controller.ageFilter.value = value;
            },
          ),
        ),
        Text('${controller.ageFilter.value.toStringAsFixed(0)} years'),
      ],
    );
  }

  Widget _buildDatePicker(AllPetController controller) {
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

  Widget _buildPetTile(BuildContext context, AllPetController controller, int index, Pet pet) {
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
                pet.img,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 60);
                },
                width: 80,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${pet.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Gender: ${pet.type}'),
                  Text('Age: ${pet.age}'),
                  Text('Publish: ${pet.publish}'),
                  Text('Posted On: ${pet.postDate}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
