import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';
import 'package:oruphones_assign/app/app.router.dart';

class OtpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

  final String phoneNumber;
  bool isLoading = false;
  int timerSeconds = 30;
  bool canResendOtp = false;
  String? _csrfToken; // 🔥 Store CSRF Token

  OtpViewModel({required this.phoneNumber}) {
    startResendTimer();
  }

  /// **1️⃣ Start Resend OTP Timer**
  void startResendTimer() {
    canResendOtp = false;
    timerSeconds = 30;
    notifyListeners();

    Future.delayed(Duration(seconds: 1), _decrementTimer);
  }

  void _decrementTimer() {
    if (timerSeconds > 0) {
      timerSeconds--;
      notifyListeners();
      Future.delayed(Duration(seconds: 1), _decrementTimer);
    } else {
      canResendOtp = true;
      notifyListeners();
    }
  }

  /// **2️⃣ Resend OTP**
  Future<void> resendOtp() async {
    bool otpSent = await _authService.requestOtp("91", phoneNumber);
    if (otpSent) {
      print("✅ OTP Resent Successfully!");
      startResendTimer();
    } else {
      print("❌ Failed to resend OTP");
    }
  }

  /// **3️⃣ Validate OTP**
  Future<void> validateOtp() async {
    String otp = otpControllers.map((c) => c.text).join(); // Combine OTP digits
    print("🔹 Entered OTP: $otp");

    if (otp.length != 4) {
      print("❌ Invalid OTP: Must be 4 digits");
      return;
    }

    isLoading = true;
    notifyListeners();

    var response = await _authService.validateOtp("91", phoneNumber, otp);

    isLoading = false;
    notifyListeners();

    if (response != null) {
      print("✅ OTP Verified Successfully! User Data: $response");

      // **Store CSRF Token from response**
      _csrfToken = response["csrfToken"];
      print("🔹 CSRF Token stored: $_csrfToken");

      // **Check if user has a name set**
      String? userName = response["user"]?["userName"];
      if (userName == null || userName.isEmpty) {
        print("🔹 No name found, navigating to NameView...");
        _navigationService.replaceWithNameView();
      } else {
        print("✅ Name found, navigating to HomeView...");
        _navigationService.replaceWithHomeView();
      }
    } else {
      print("❌ OTP Validation Failed");
    }
  }

  /// **4️⃣ Navigate to Home**
  void navigateToHome() {
    _navigationService.replaceWithHomeView();
  }

  /// **5️⃣ Dispose Controllers**
  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
