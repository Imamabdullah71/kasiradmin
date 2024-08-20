import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasiradmin/controlllers/infaq_controller/data_infaq_controller.dart';
import 'package:kasiradmin/views/infaq/detail_infaq_page.dart';
import 'package:kasiradmin/controlllers/users_controller/user_controller.dart';
import 'package:kasiradmin/models/user_model.dart';

class RiwayatInfaqPage extends StatelessWidget {
  final DataInfaqController infaqController = Get.put(DataInfaqController());
  final UserController userController = Get.put(UserController());

  final TextEditingController searchController = TextEditingController();
  final Rxn<DateTimeRange> selectedDateRange = Rxn<DateTimeRange>();
  final RxString sortOrder = ''.obs;

  RiwayatInfaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 114, 94, 225),
        ),
        title: const Text(
          "Data Infaq",
          style: TextStyle(
            color: Color.fromARGB(255, 114, 94, 225),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10.0,
        shadowColor: Colors.black.withOpacity(0.5),
        actions: [
          IconButton(
            onPressed: () {
              _showSortOptions(context);
            },
            icon: const Icon(BootstrapIcons.three_dots_vertical),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 229, 135, 246),
                                Color.fromARGB(255, 114, 94, 225),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        hintText: "Cari infaq...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        _filterInfaq();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 229, 135, 246),
                        Color.fromARGB(255, 114, 94, 225),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(BootstrapIcons.calendar4_week),
                    color: Colors.white,
                    onPressed: () async {
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        initialDateRange: selectedDateRange.value,
                      );
                      if (picked != null && picked != selectedDateRange.value) {
                        selectedDateRange.value = picked;
                        _filterInfaq();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (infaqController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (infaqController.groupedInfaqList.isEmpty) {
                return const Center(child: Text("Tidak ada riwayat infaq"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: infaqController.groupedInfaqList.length,
                itemBuilder: (context, index) {
                  final groupedInfaq = infaqController.groupedInfaqList[index];
                  final UserModel? user = groupedInfaq["user"];
                  final double totalInfaq = groupedInfaq["totalInfaq"];

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailInfaqPage(userId: user?.id ?? 0));
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
                          user?.name ?? "User Tidak Ditemukan",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          user?.namaToko ?? "Nama Toko Tidak Ada",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          'Rp ${totalInfaq.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _filterInfaq() {
    final query = searchController.text.toLowerCase();
    final dateRange = selectedDateRange.value;
    final sort = sortOrder.value;

    infaqController.filterInfaq(
      query: query,
      dateRange: dateRange,
      sortOrder: sort,
    );
  }

  void _showSortOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Urutkan menurut...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Nama A - Z'),
                onTap: () {
                  sortOrder.value = 'name_asc';
                  _filterInfaq();
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Nama Z - A'),
                onTap: () {
                  sortOrder.value = 'name_desc';
                  _filterInfaq();
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Terbaru'),
                onTap: () {
                  sortOrder.value = 'newest';
                  _filterInfaq();
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Terlama'),
                onTap: () {
                  sortOrder.value = 'oldest';
                  _filterInfaq();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
