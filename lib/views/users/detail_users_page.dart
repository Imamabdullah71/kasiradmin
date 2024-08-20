import 'package:flutter/material.dart';
import 'package:kasiradmin/models/user_model.dart';

class DetailUsersPage extends StatelessWidget {
  final UserModel user;

  const DetailUsersPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengguna'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text("Email: ${user.email}"),
                const SizedBox(height: 8.0),
                Text("Nama Toko: ${user.namaToko ?? "Nama Toko tidak ada"}"),
                const SizedBox(height: 8.0),
                Text("Alamat: ${user.alamat ?? "Alamat tidak ada"}"),
                const SizedBox(height: 8.0),
                Text("No Telepon: ${user.noTelepon ?? "No Telepon tidak ada"}"),
                const SizedBox(height: 8.0),
                Text("Dibuat pada: ${user.createdAt.toString()}"),
                const SizedBox(height: 8.0),
                Text("Diupdate pada: ${user.updatedAt.toString()}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
