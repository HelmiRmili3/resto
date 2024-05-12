import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/domain/usecases/signup_usecase.dart';
import 'package:resto/presentation/screens/auth/signin_screen.dart';

import '../../utils/enums.dart';

class SignUpController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  Rx<User?> user = Rx<User?>(null);
  Rx<Role> role = Role.client.obs;
  final SignUpUseCase signUpUseCase;

  SignUpController({required this.signUpUseCase}) {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> signUp() async {
    final results = await signUpUseCase(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    results.fold(
      (l) => Get.snackbar(
        "Error",
        l.message,
        backgroundColor: Colors.redAccent,
      ),
      (r) {
        clear();
        Get.snackbar("Success", "User Signup successfully");
        if (user.value != null) {
          Get.off(() => const SignInScreen());
        }
      },
    );
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
