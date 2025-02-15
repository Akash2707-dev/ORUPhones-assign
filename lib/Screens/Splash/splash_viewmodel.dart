import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/app/app.locator.dart';
import 'package:oruphones_assign/app/app.router.dart';
import 'package:oruphones_assign/services/auth_service.dart'; // Import AuthService

class SplashViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>(); // Add AuthService

  void initialize() async {
    await Future.delayed(Duration(seconds: 5)); // Wait 2 seconds

    // Check if user is logged in
    bool isLoggedIn = await _authService.checkLoginStatus();

    if (isLoggedIn) {
      _navigationService.replaceWithHomeView(); // Navigate to home if logged in
    } else {
      _navigationService
          .replaceWithLoginView(); // Navigate to login if not logged in
    }
  }
}
