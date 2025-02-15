import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oruphones_assign/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/services/home_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final HomeService _homeService = locator<HomeService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;

  String userName = "Guest"; // ✅ Store user name
  String joiningDate = "N/A"; // ✅ Store joining date
  /// **Floating Action Button Visibility**
  final ScrollController scrollController = ScrollController();
  bool _isFabVisible = true;

  bool get isFabVisible => _isFabVisible;
  List<dynamic> brands = [];
  Future<void> fetchBrands() async {
    final fetchedBrands = await _homeService.fetchBrands();
    if (fetchedBrands != null) {
      brands = fetchedBrands; // ✅ Stores the extracted brand list
      notifyListeners();
    }
  }

  /// **Initialize Scroll Listener**
  void initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setFabVisibility(false); // Hide FAB on scroll down
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setFabVisibility(true); // Show FAB on scroll up
      }
    });
  }

  /// **Update FAB Visibility**
  void setFabVisibility(bool isVisible) {
    if (_isFabVisible != isVisible) {
      _isFabVisible = isVisible;
      notifyListeners();
    }
  }

  /// **🔹 Check Login Status & Fetch User Details**
  Future<void> checkLoginStatus() async {
    print("🟡 Checking login status...");
    _isUserLoggedIn = await _authService.checkLoginStatus();
    print("🟢 User logged in: $_isUserLoggedIn");

    if (_isUserLoggedIn) {
      await getUserDetails(); // ✅ Fetch user details after login check
    }

    notifyListeners(); // 🔥 Updates UI when login status or user details change
  }

  /// **🔹 Fetch User Details**
  Future<void> getUserDetails() async {
    print("🔹 Fetching user details...");
    final userDetails = await _authService.getUserDetails();
    print("🟢 User Details API Response: $userDetails");

    if (userDetails != null) {
      userName = userDetails["userName"] ?? "Unknown User";

      // ✅ Convert "02/09/2025" → "February 9, 2025"
      String rawDate = userDetails["createdDate"] ?? "";
      joiningDate = _formatDate(rawDate);

      print("✅ Updated User Name: $userName");
      print("✅ Updated Joining Date: $joiningDate");

      notifyListeners(); // 🔥 Update UI with new details
    } else {
      print("❌ Failed to fetch user details, using defaults.");
    }
  }

  /// **🔹 Logout Function**
  Future<void> logout() async {
    bool success = await _authService.logout();
    if (success) {
      print("✅ Logged out successfully!");
      _isUserLoggedIn = false;
      userName = "Guest"; // ✅ Reset user data
      joiningDate = "N/A";
      notifyListeners(); // 🔥 Update UI after logout
      _navigationService.replaceWithLoginView();
    } else {
      print("❌ Logout failed");
    }
  }

  String _formatDate(String rawDate) {
    try {
      if (rawDate.isEmpty) return "N/A";
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(rawDate);
      return DateFormat("MMMM d, yyyy")
          .format(parsedDate); // ✅ February 9, 2025
    } catch (e) {
      print("❌ Error parsing date: $e");
      return "N/A"; // Default if parsing fails
    }
  }
}
