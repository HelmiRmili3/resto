import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/presentation/controllers/gerant_controller.dart';

class GerantDashbordWidget extends StatelessWidget {
  GerantDashbordWidget({super.key});
  final GerantController controller = Get.find<GerantController>();
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GerantController>(
      builder: (controller) {
        return Obx(
          () {
            if (controller.orders.isEmpty) {
              return const Center(
                child: Text(
                  'No orders available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  OrderModel order = controller.orders[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "N° ${order.id.substring(0, 8)}",
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: order.order
                                  .map((plate) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 6),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Text(
                                              capitalizeFirstLetter(plate.name),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      subtitle:
                          Text("Client: ${order.orderedBy.substring(0, 10)}"),
                      trailing: ElevatedButton(
                        onPressed: () => controller.orderPayed(order.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: Text(
                          "Payed ${order.prix} DT",
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
    );
  }
}
