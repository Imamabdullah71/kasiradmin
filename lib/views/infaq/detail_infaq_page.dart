import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasiradmin/controlllers/infaq_controller/data_infaq_controller.dart';
import 'package:kasiradmin/controlllers/users_controller/user_controller.dart';
import 'package:kasiradmin/models/user_model.dart';
import 'package:kasiradmin/models/infaq_model.dart';

class DetailInfaqPage extends StatelessWidget {
  final int userId;

  const DetailInfaqPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final DataInfaqController infaqController = Get.find<DataInfaqController>();

    UserModel? user = userController.getUserById(userId);
    List<Infaq> infaqList = infaqController.riwayatInfaqList
        .where((infaq) => infaq.userId == userId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Infaq'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card untuk detail user
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "Nama tidak ditemukan",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text("Email: ${user?.email ?? "Email tidak ditemukan"}"),
                    const SizedBox(height: 8.0),
                    Text("Nama Toko: ${user?.namaToko ?? "Nama Toko tidak ada"}"),
                    const SizedBox(height: 8.0),
                    Text("Alamat: ${user?.alamat ?? "Alamat tidak ada"}"),
                    const SizedBox(height: 8.0),
                    Text("No Telepon: ${user?.noTelepon ?? "No Telepon tidak ada"}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Card untuk daftar infaq
            Expanded(
              child: ListView.builder(
                itemCount: infaqList.length,
                itemBuilder: (context, index) {
                  final infaq = infaqList[index];
                  return Card(
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
                        DateFormat('dd MMMM yyyy').format(infaq.tanggalInfaq),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('HH.mm').format(infaq.tanggalInfaq),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(
                        'Rp ${infaq.jumlahInfaq.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
