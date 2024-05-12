import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/presentation/controllers/client_controller.dart';

class MenuListWidget extends StatefulWidget {
  const MenuListWidget({super.key});

  @override
  State<MenuListWidget> createState() => _MenuListWidgetState();
}

class _MenuListWidgetState extends State<MenuListWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ClientController controller = Get.find<ClientController>();

    return Positioned(
      bottom: 100.0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            setState(() {
              _currentIndex = (_currentIndex - 1).clamp(0, 1);
            });
          } else if (details.primaryVelocity! < 0) {
            setState(() {
              _currentIndex = (_currentIndex + 1).clamp(0, 1);
            });
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: SizedBox(
            height: 540,
            child: PageView(
              controller: PageController(initialPage: _currentIndex),
              children: [
                Container(
                  color: Colors.transparent,
                  child: GridView.builder(
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
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Table ${table.number}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Seats: ${table.places}'),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: controller.plats.length,
                    itemBuilder: (context, index) {
                      PlatModel plat = controller.plats[index];
                      return Card(
                        elevation: 4,
                        color: Colors.white.withOpacity(0.3),
                        child: ListTile(
                          leading: Checkbox(
                            value: true,
                            onChanged: (newValue) {},
                          ),
                          title: Text(plat.name),
                          subtitle: Text(plat.prix.toString()),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
