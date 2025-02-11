// import 'package:stacked/stacked.dart';
import 'package:oruphones_assign/Screens/Login/login_view.dart';
import 'package:oruphones_assign/Screens/Name/name_view.dart';
import 'package:oruphones_assign/Screens/OTP/otp_view.dart';
import 'package:stacked_services/stacked_services.dart';
import '../Screens/Splash/splash_view.dart';
import '../Screens/Home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:oruphones_assign/services/auth_service.dart';

/// 🎯 Define all the routes that will be generated automatically
@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OtpView),
    MaterialRoute(page: NameView)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: AuthService)
  ],
)
class App {}
