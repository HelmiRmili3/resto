import 'package:get/get.dart';
import 'package:resto/presentation/bindings/auth_bindings.dart';
import 'package:resto/presentation/bindings/chef_bindings.dart';
import 'package:resto/presentation/bindings/client_bindings.dart';
import 'package:resto/presentation/bindings/gerant_bindings.dart';
import 'package:resto/presentation/bindings/signup_bindings.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    SignupBinding().dependencies();
    AuthBinding().dependencies();
    ClientBinding().dependencies();
    GerantBindings().dependencies();
    ChefBindings().dependencies();
  }
}
