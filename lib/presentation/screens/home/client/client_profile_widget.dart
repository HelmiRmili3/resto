import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/presentation/controllers/auth_controller.dart';

class ClientProfileWidget extends StatelessWidget {
  ClientProfileWidget({super.key});
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/pngegg.png"),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Center(
                            child: Icon(
                          Icons.camera_alt_outlined,
                          size: 24,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                controller.userData.value?.name ?? 'Name not available',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                controller.userData.value?.email ?? 'Email not available',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  controller.signOut();
                },
                child: const Text("LogOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
