// controllers\barang\bottom_bar_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  void onTabTapped(int index) {
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void resetToHome() {
    // Cek jika currentIndex bukan 0
    if (selectedIndex.value != 0) {
      // Reset index ke 0
      selectedIndex.value = 0;
      // Gunakan jumpToPage tanpa dispose PageController
      pageController.jumpToPage(0);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
