import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';
import 'package:oruphones_assign/app/app.router.dart';

class NameViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  final TextEditingController nameController = TextEditingController();

  /// **Confirm Name and Navigate**
  void navigateToHome() {
    _navigationService.replaceWithHomeView();
  }

  Future<void> confirmName() async {
    String name = nameController.text.trim();

    if (name.isEmpty) {
      print("❌ Name cannot be empty");
      return;
    }

    bool success = await _authService.updateUserName("91", name);

    if (success) {
      print("✅ Name Updated Successfully!");
      _navigationService.replaceWithHomeView(); // Navigate to Home
    } else {
      print("❌ Failed to update name");
    }
  }

  /// **Dispose Controller to Prevent Memory Leaks**
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
