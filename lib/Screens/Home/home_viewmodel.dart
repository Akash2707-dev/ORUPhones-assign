import 'package:flutter/material.dart';
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

  String userName = "Guest";
  String joiningDate = "N/A";

  final ScrollController scrollController = ScrollController();
  bool _isFabVisible = true;

  bool get isFabVisible => _isFabVisible;
  List<dynamic> brands = [];

  List<dynamic> _products = [];
  List<dynamic> likedListings = [];

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  List<dynamic> get products => _products;

  Map<String, dynamic>? selectedFilters;

  Future<void> fetchBrands() async {
    final fetchedBrands = await _homeService.fetchBrands();
    if (fetchedBrands != null) {
      brands = fetchedBrands;
      notifyListeners();
    }
  }

  void navigateToLogin() {
    _navigationService.replaceWith(Routes.loginView);
  }

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore) {
      if (_isLoadingMore) return;
      _isLoadingMore = true;
      notifyListeners();
    } else {
      setBusy(true);
    }

    print("🟡 Fetching products for page $_currentPage...");

    final response = await _homeService.fetchProducts(
      userFilters: selectedFilters,
      page: _currentPage,
    );

    if (response != null && response.isNotEmpty) {
      List<dynamic> newProducts = response;

      newProducts.removeWhere((newProduct) => _products.any((existingProduct) =>
          existingProduct["listingId"] == newProduct["listingId"]));

      if (newProducts.isNotEmpty) {
        _products.addAll(newProducts);
        _currentPage++;

        // After adding new products, update the liked status
        await updateProductLikedStatus(); // Update products with liked status
      } else {
        print("🚨 No unique products found for page $_currentPage.");
      }
    } else {
      print("🚨 No new products found for page $_currentPage.");
    }

    setBusy(false);
    _isLoadingMore = false;
    notifyListeners();
  }

  // This function is called to mark products as liked based on the `favListings`
  Future<void> updateProductLikedStatus() async {
    final userDetails = await _authService.getUserDetails();
    final favListings = _authService.getUserFavListings(userDetails!);

    for (var product in _products) {
      product["isLiked"] = favListings.contains(product["listingId"]);
    }

    notifyListeners(); // Refresh the UI to show the heart status
  }

  Future<void> toggleLike(String listingId, bool isLiked) async {
    bool newLikeStatus = !isLiked;

    bool success =
        await _homeService.toggleProductLike(listingId, newLikeStatus);

    if (success) {
      int index =
          _products.indexWhere((product) => product["listingId"] == listingId);
      if (index != -1) {
        _products[index]["isLiked"] = newLikeStatus;

        if (newLikeStatus) {
          if (!likedListings.contains(listingId)) {
            likedListings.add(listingId);
          }
        } else {
          likedListings.remove(listingId);
        }
      }
      notifyListeners();
    } else {
      print("❌ Failed to like/unlike product.");
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    selectedFilters = filters;
    _currentPage = 1;
    _products.clear();
    fetchProducts();
  }

  void initScrollListener() {
    scrollController.addListener(() {
      double faqTriggerPosition =
          scrollController.position.maxScrollExtent - 500;

      if (scrollController.position.pixels >= faqTriggerPosition &&
          !_isLoadingMore) {
        print("🔄 Triggering pagination at FAQ section...");
        fetchProducts(loadMore: true);
      }

      if (scrollController.position.pixels == 0) {
        setFabVisibility(true);
      } else {
        setFabVisibility(false);
      }
    });
  }

  void setFabVisibility(bool isVisible) {
    if (_isFabVisible != isVisible) {
      _isFabVisible = isVisible;
      notifyListeners();
    }
  }

  Future<void> checkLoginStatus() async {
    print("🟡 Checking login status...");
    _isUserLoggedIn = await _authService.checkLoginStatus();
    print("🟢 User logged in: $_isUserLoggedIn");

    if (_isUserLoggedIn) {
      await getUserDetails();
    }

    rebuildUi();
  }

  Future<void> getUserDetails() async {
    print("🔹 Fetching user details...");
    final userDetails = await _authService.getUserDetails();
    print("🟢 User Details API Response: $userDetails");

    if (userDetails != null) {
      userName = userDetails["userName"] ?? "Unknown User";
      String rawDate = userDetails["createdDate"] ?? "";
      joiningDate = _formatDate(rawDate);

      print("✅ Updated User Name: $userName");
      print("✅ Updated Joining Date: $joiningDate");

      // Get the liked products directly from favListings
      likedListings = userDetails["favListings"]
              ?.map<String>((e) => e.toString())
              .toList() ??
          [];

      notifyListeners();
    } else {
      print("❌ Failed to fetch user details, using defaults.");
    }
  }

  Future<void> logout() async {
    bool success = await _authService.logout();
    if (success) {
      print("✅ Logged out successfully!");
      _isUserLoggedIn = false;
      userName = "Guest";
      joiningDate = "N/A";
      notifyListeners();
      _navigationService.replaceWithLoginView();
    } else {
      print("❌ Logout failed");
    }
  }

  String _formatDate(String rawDate) {
    try {
      if (rawDate.isEmpty) return "N/A";
      DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(rawDate);
      return DateFormat("MMMM d, yyyy").format(parsedDate);
    } catch (e) {
      print("❌ Error parsing date: $e");
      return "N/A";
    }
  }
}
