import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/data/models/plat_model.dart';

import '../../../controllers/chef_controller.dart';

class ChefPlatsWidget extends StatelessWidget {
  ChefPlatsWidget({super.key});

  final ChefController controller = Get.find<ChefController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChefController>(
      builder: (controller) {
        return Obx(() => Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AddPlatDialog();
                      },
                    );
                  },
                  child: const Text('Add Plate'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.plats.length,
                    itemBuilder: (context, index) {
                      PlatModel plat = controller.plats[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(plat.name),
                          subtitle: Text(plat.description),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.deletePlate(plat.id),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ));
      },
    );
  }
}

class AddPlatDialog extends StatelessWidget {
  const AddPlatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Add New Plate'),
      content: AddPlatForm(),
    );
  }
}

class AddPlatForm extends StatefulWidget {
  const AddPlatForm({super.key});

  @override
  _AddPlatFormState createState() => _AddPlatFormState();
}

class _AddPlatFormState extends State<AddPlatForm> {
  // Define controller for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final ChefController controller = Get.find<ChefController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageUrlController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
          TextFormField(
            controller: _prixController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.addPate(
                  _nameController.text,
                  double.parse(_prixController.text),
                  _imageUrlController.text,
                  _descriptionController.text);
              Navigator.pop(context);
            },
            child: const Text('Add Plate'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _prixController.dispose();
    super.dispose();
  }
}
