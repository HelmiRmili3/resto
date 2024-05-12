import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/presentation/controllers/client_controller.dart';
import 'package:resto/presentation/screens/home/client/client_history_screen.dart';
import 'package:resto/presentation/screens/home/client/client_orders_screen.dart';
import 'package:resto/presentation/screens/home/client/client_profile_widget.dart';

class ClientScanMenuScreen extends StatelessWidget {
  ClientScanMenuScreen({
    super.key,
  });
  final ClientController controller = Get.find<ClientController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 206, 206),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: controller.qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                  // child: Container(
                  //   color: Colors.black,
                  // ),
                ),
              ],
            ),
            Positioned(
              bottom: 20.0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => controller.addOrder(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white.withOpacity(0.4),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: GetBuilder<ClientController>(
                  builder: (controller) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => ClientProfileWidget()),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Obx(() => Text(
                              "Welcome , ${controller.data.value == null ? "Unknown" : controller.data.value!.name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(
                          width: 100,
                        ),
                        PopupMenuButton<String>(
                          iconColor: Colors.white,
                          onSelected: (String choice) {
                            switch (choice) {
                              case 'Option 1':
                                Get.to(() => ClientOrdersScreen());

                                break;
                              case 'Option 2':
                                Get.to(() => ClientTranscationsScreen());

                                break;
                              case 'Option 3':
                                Get.to(() => ClientProfileWidget());
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return const <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Option 1',
                                child: Text('Orders'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Option 2',
                                child: Text('History'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Option 3',
                                child: Text('Profile'),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100.0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    Get.find<ClientController>().swipeRight();
                  } else if (details.primaryVelocity! < 0) {
                    Get.find<ClientController>().swipeLeft();
                  }
                },
                child: SafeArea(
                  minimum: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 540,
                    child: PageView(
                      controller: PageController(
                          initialPage:
                              Get.find<ClientController>().currentIndex.value),
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: GetBuilder<ClientController>(
                            builder: (controller) => ListView.builder(
                              itemCount: controller.plats.length,
                              itemBuilder: (context, index) {
                                PlatModel plat = controller.plats[index];
                                return Card(
                                  elevation: 4,
                                  color: Colors.white.withOpacity(0.4),
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: controller.isPlateSelected(plat),
                                      onChanged: (newValue) {
                                        newValue!
                                            ? controller.addPlate(plat)
                                            : controller.removePlate(plat);
                                        controller.update();
                                      },
                                    ),
                                    title: Text(
                                      plat.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      "${plat.prix.toString()} DT",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {},
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: GetBuilder<ClientController>(
                            builder: (controller) => GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: controller.tabels.length,
                              itemBuilder: (context, index) {
                                final table = controller.tabels[index];
                                return Card(
                                  color: table.isReserved
                                      ? Colors.redAccent.withOpacity(0.5)
                                      : Colors.white.withOpacity(0.4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Table ${table.number}',
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          'Seats: ${table.places}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        !table.isReserved
                                            ? Radio(
                                                activeColor: Colors.white,
                                                value: table.number,
                                                groupValue: controller
                                                    .selectedTable
                                                    .value as int?,
                                                toggleable: true,
                                                onChanged: (value) {
                                                  controller
                                                      .setSelectedTable(value!);
                                                  controller.update();
                                                },
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrcontroller) {
    controller.qrcontroller = qrcontroller;
    qrcontroller.scannedDataStream.listen((scanData) {
      controller.update();
    });
  }
}
