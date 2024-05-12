import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/data/models/transcation_model.dart';
import 'package:resto/presentation/controllers/client_controller.dart';

class ClientTranscationsScreen extends StatelessWidget {
  ClientTranscationsScreen({super.key});

  final ClientController controller = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
        centerTitle: true,
      ),
      body: GetBuilder<ClientController>(
        builder: (controller) {
          return Obx(
            () {
              if (controller.transactions.isEmpty) {
                return const Center(
                  child: Text(
                    'No Transcations yet',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    TransactionModel transcation =
                        controller.transactions[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(transcation.id),
                        subtitle: Text(transcation.orderedBy),
                        trailing: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text(
                            "${transcation.amount} DT",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
