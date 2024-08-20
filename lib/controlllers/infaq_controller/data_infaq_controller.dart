import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kasiradmin/controlllers/users_controller/user_controller.dart';
import 'package:kasiradmin/models/infaq_model.dart';
import 'dart:convert';

import 'package:kasiradmin/models/user_model.dart';

class DataInfaqController extends GetxController {
  var isLoading = false.obs;
  var riwayatInfaqList = <Infaq>[].obs; // Daftar infaq asli dari API
  var groupedInfaqList = <Map<String, dynamic>>[].obs; // Daftar infaq yang dikelompokkan dan difilter
  final String apiUrl = 'http://10.10.10.129/flutterapi/api_infaq_admin.php';
    final UserController userController = Get.put(UserController());

  @override
  void onInit() {
    fetchRiwayatInfaq();
    super.onInit();
  }

  void fetchRiwayatInfaq() async {
    isLoading.value = true;
    try {
      final response = await http.post(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        print("Data yang diterima dari API: $data");

        riwayatInfaqList.value = data.map((infaq) => Infaq.fromJson(infaq)).toList();
        
        _groupInfaqByUser(); // Mengelompokkan infaq berdasarkan userId
      } else {
        _showErrorSnackbar('Gagal Mengambil Data Riwayat Infaq');
      }
    } catch (e) {
      _showErrorSnackbar('Gagal Mengambil Data Riwayat Infaq');
    } finally {
      isLoading.value = false;
    }
  }

  // Mengelompokkan infaq berdasarkan userId dan menghitung total infaq per user
  void _groupInfaqByUser() {
    Map<int, double> infaqPerUser = {};
    Map<int, UserModel?> userMap = {};

    for (var infaq in riwayatInfaqList) {
      if (infaqPerUser.containsKey(infaq.userId)) {
        infaqPerUser[infaq.userId] = infaqPerUser[infaq.userId]! + infaq.jumlahInfaq;
      } else {
        infaqPerUser[infaq.userId] = infaq.jumlahInfaq;
        userMap[infaq.userId] = userController.getUserById(infaq.userId);
      }
    }

    groupedInfaqList.value = infaqPerUser.entries.map((entry) {
      return {
        "userId": entry.key,
        "totalInfaq": entry.value,
        "user": userMap[entry.key],
      };
    }).toList();
  }

  // Fungsi untuk memfilter dan mengurutkan data infaq
  void filterInfaq({
    required String query,
    required DateTimeRange? dateRange,
    required String sortOrder,
  }) {
    // Memfilter dan mengelompokkan ulang data infaq
    var filtered = riwayatInfaqList.where((infaq) {
      final user = userController.getUserById(infaq.userId);
      final matchesQuery = user != null && user.name.toLowerCase().contains(query.toLowerCase());
      final matchesDateRange = dateRange == null ||
          (infaq.tanggalInfaq.isAfter(dateRange.start) &&
              infaq.tanggalInfaq.isBefore(dateRange.end.add(const Duration(days: 1))));
      return matchesQuery && matchesDateRange;
    }).toList();

    // Urutkan berdasarkan pilihan pengguna
    switch (sortOrder) {
      case 'name_asc':
        filtered.sort((a, b) => userController.getUserById(a.userId)!.name.compareTo(
            userController.getUserById(b.userId)!.name));
        break;
      case 'name_desc':
        filtered.sort((a, b) => userController.getUserById(b.userId)!.name.compareTo(
            userController.getUserById(a.userId)!.name));
        break;
      case 'newest':
        filtered.sort((a, b) => b.tanggalInfaq.compareTo(a.tanggalInfaq));
        break;
      case 'oldest':
        filtered.sort((a, b) => a.tanggalInfaq.compareTo(b.tanggalInfaq));
        break;
    }

    // Lakukan pengelompokan ulang setelah filter dan sort diterapkan
    _groupInfaqByUser();
  }


  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.error, color: Colors.white),
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
