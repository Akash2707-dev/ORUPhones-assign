import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:oruphones_assign/app/app.locator.dart';
import 'package:oruphones_assign/app/app.router.dart';

class SplashViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void initialize() async {
    await Future.delayed(Duration(seconds: 2)); // Wait 2 seconds
    _navigationService.replaceWithLoginView(); // Navigate using generated route
  }
}
