import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';
import 'package:oruphones_assign/app/app.router.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  /// **1️⃣ Navigate to Home (Cross Button)**
  void navigateToHome() {
    _navigationService.replaceWithHomeView();
  }

  /// **2️⃣ Send OTP**
  Future<void> sendOtp() async {
    String phoneNumber = phoneController.text.trim();

    if (phoneNumber.length < 10) {
      print("Invalid phone number");
      return;
    }

    isLoading = true;
    rebuildUi();

    bool otpSent = await _authService.requestOtp("91", phoneNumber);

    isLoading = false;
    rebuildUi();

    if (otpSent) {
      print("OTP sent successfully!");
      _navigationService.navigateToOtpView(phoneNumber: phoneNumber);
    } else {
      print("Failed to send OTP");
    }
  }

  /// **3️⃣ Dispose Controller (Prevents Memory Leaks)**
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
