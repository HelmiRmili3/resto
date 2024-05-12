import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/data/models/user_model.dart';

import 'package:resto/domain/usecases/forget_password_usecase.dart';
import 'package:resto/domain/usecases/get_user_usecase.dart';
import 'package:resto/domain/usecases/signin_usecase.dart';
import 'package:resto/domain/usecases/signout_usecase.dart';
import 'package:resto/domain/usecases/signup_usecase.dart';

import 'package:resto/presentation/screens/auth/signin_screen.dart';
import 'package:resto/presentation/screens/home/chef/chef_home_screen.dart';
import 'package:resto/presentation/screens/home/gerant/gerant_home_screen.dart';

import 'package:resto/utils/enums.dart';

import '../screens/home/client/client_scan_menu_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final GetUserUseCase getUserUseCase;

  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> userData = Rx<UserModel?>(null);

  AuthController({
    required this.getUserUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.forgetPasswordUseCase,
    required this.signInUseCase,
  }) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> signOut() async {
    await signOutUseCase().then((_) => Get.to(() => const SignInScreen()));
    clear();
  }

  Future<void> signIn() async {
    final results = await signInUseCase(
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
        auth.authStateChanges().listen((User? firebaseUser) {
          user.value = firebaseUser;
          if (user.value != null) {
            getUserUseCase.repository
                .getUser(user.value!.uid)
                .then((userModel) {
              userData.value = userModel;
              return Get.to(() => determineInitialRoute(userModel.role));
            });
          }
          clear();
        });
      },
    );
  }

  Future<void> forgetPassword() async {
    final results = await forgetPasswordUseCase(emailController.text.trim());
    results.fold(
      (l) => Get.snackbar(
        "Error",
        l.message,
        backgroundColor: Colors.redAccent,
      ),
      (r) => Get.snackbar("Success", "Email sended successfully"),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  Widget determineInitialRoute(Role role) {
    switch (role) {
      case Role.client:
        return ClientScanMenuScreen();
      case Role.chef:
        return const ChefHomeScreen();
      case Role.gerant:
        return const GerantHomeScreen();
      default:
        return const SignInScreen();
    }
  }
}
