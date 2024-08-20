import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasiradmin/controlllers/user_admin_controller/auth_middleware.dart';
import 'package:kasiradmin/data_bindings.dart';
import 'package:kasiradmin/views/auth_admin/login.dart';
import 'package:kasiradmin/views/auth_admin/register.dart';
import 'package:kasiradmin/views/infaq/data_infaq_page.dart';
import 'package:kasiradmin/salomon_bottom_bar.dart';
import 'package:kasiradmin/controlllers/user_admin_controller/user_admin_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kasiradmin/views/users/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserAdminController userController = Get.put(UserAdminController());
  await userController.loadUserFromPreferences();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAdminController userController = Get.put(UserAdminController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: userController.currentUser.value != null
          ? '/halaman_utama'
          : '/login',
      getPages: [
        GetPage(
          name: "/login",
          page: () => LoginPage(),
          binding: DataBindings(),
        ),
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(
            name: "/halaman_utama",
            page: () => BottomBar(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: "/data_infaq_page",
            page: () => RiwayatInfaqPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: "/data_user",
            page: () => UsersPage(),
            middlewares: [AuthMiddleware()]),
      ],
    );
  }
}
