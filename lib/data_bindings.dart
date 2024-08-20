// data_bindings.dart
import 'package:get/get.dart';
import 'package:kasiradmin/controlllers/bottom_bar_controller/bottom_bar_controller.dart';
import 'package:kasiradmin/controlllers/user_admin_controller/user_admin_controller.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAdminController>(() => UserAdminController());
    Get.lazyPut<BottomBarController>(() => BottomBarController());
  }
}
