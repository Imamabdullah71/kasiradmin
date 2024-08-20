import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasiradmin/views/users/detail_users_page.dart';
import 'package:kasiradmin/controlllers/users_controller/user_controller.dart';
import 'package:kasiradmin/models/user_model.dart';

class UsersPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userController.userList.isEmpty) {
          return const Center(child: Text("Tidak ada pengguna yang ditemukan"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: userController.userList.length,
          itemBuilder: (context, index) {
            UserModel user = userController.userList[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => DetailUsersPage(user: user));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${user.namaToko}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
