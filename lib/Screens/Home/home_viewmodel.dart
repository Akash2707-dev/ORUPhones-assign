// import 'package:oruphones_assign/Screens/Login/login_view.dart';
import 'package:oruphones_assign/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  /// **Logout Function**
  Future<void> logout() async {
    bool success = await _authService.logout();
    if (success) {
      print("✅ Logged out successfully!");
      _navigationService.replaceWithLoginView(); // 🔥 Navigate to Login
    } else {
      print("❌ Logout failed");
    }
  }
}
