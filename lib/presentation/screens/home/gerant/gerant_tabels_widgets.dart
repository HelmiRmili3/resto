import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/presentation/controllers/gerant_controller.dart';

class GerantTabelsWidget extends StatelessWidget {
  GerantTabelsWidget({super.key});

  final GerantController controller = Get.find<GerantController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GerantController>(
      builder: (controller) {
        return Obx(
          () {
            if (controller.tabels.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No tables available',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 100),
                    FloatingActionButton(
                      onPressed: () {
                        _showAddTableDialog(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.tabels.length,
                      itemBuilder: (context, index) {
                        TableModel tabel = controller.tabels[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text("Table N°${tabel.number.toString()}"),
                            subtitle: Text(
                                "Places Available : ${tabel.places.toString()}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteConfirmationDialog(
                                    context, controller, tabel);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 280),
                    child: FloatingActionButton(
                      onPressed: () {
                        _showAddTableDialog(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  void _showAddTableDialog(BuildContext context) {
    TextEditingController numberController = TextEditingController();
    TextEditingController placesController = TextEditingController();
    final GerantController controller = Get.find<GerantController>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Table'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Number'),
              ),
              TextField(
                controller: placesController,
                decoration: const InputDecoration(labelText: 'Places'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String number = numberController.text;
                String places = placesController.text;
                controller.addTable(
                  int.parse(number),
                  int.parse(places),
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

void _showDeleteConfirmationDialog(
    BuildContext context, GerantController controller, TableModel table) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Table'),
        content: Text('Are you sure you want to delete ${table.id}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteTable(table.id);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
