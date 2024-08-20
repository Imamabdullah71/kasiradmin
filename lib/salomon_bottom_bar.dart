import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasiradmin/controlllers/bottom_bar_controller/bottom_bar_controller.dart';
import 'package:kasiradmin/manage_pengaturan.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

import 'manage_home_page.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomBarController controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: const [
          ManageHomePage(),
          ManagePengaturan(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SalomonBottomBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.onTabTapped,
              items: [
                _buildBottomBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text("Home"),
                ),
                _buildBottomBarItem(
                  icon: const Icon(BootstrapIcons.gear),
                  title: const Text("Pengaturan"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SalomonBottomBarItem _buildBottomBarItem({
    required Icon icon,
    required Text title,
  }) {
    return SalomonBottomBarItem(
      icon: icon,
      title: title,
      selectedColor: const Color.fromARGB(255, 114, 94, 225),
      unselectedColor: Colors.grey,
      activeIcon: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 94, 225),
              Color.fromARGB(255, 229, 135, 246),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: icon,
      ),
    );
  }
}
