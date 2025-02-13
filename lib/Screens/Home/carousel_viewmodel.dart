import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CarouselViewModel extends BaseViewModel {
  final PageController pageController = PageController();
  final List<String> imagePaths = [
    'lib/assets/banners/banner1.png',
    'lib/assets/banners/banner2.png',
    'lib/assets/banners/banner3.png',
    'lib/assets/banners/banner4.png',
    'lib/assets/banners/banner 5.png'
  ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  CarouselViewModel() {
    _startAutoSlide();
  }

  /// ✅ **Auto-slide function**
  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (pageController.hasClients) {
        int nextIndex = (_currentIndex + 1) % imagePaths.length;
        pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        _currentIndex = nextIndex;
        notifyListeners(); // 🔥 Update UI when index changes
      }
    });
  }

  /// ✅ **Manually change page**
  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
