import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/presentation/controllers/signup_controller.dart';
import 'package:resto/presentation/screens/auth/signin_screen.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    keyboardType: TextInputType.text,
                    controller: controller.nameController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.signUp();
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignInScreen());
                    },
                    child: const Text(
                      "You already have an account? Login",
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
