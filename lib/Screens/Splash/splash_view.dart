import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SplashViewmodel(),
        onViewModelReady: (viewModel) {
          viewModel.initialize();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Lottie.asset(
                'lib/assets/Splash.json', // Path to your animation
                width: 300, // Adjust size if needed
                height: 500,
                fit: BoxFit.contain,
              ),
            ),
          );
        });
  }
}
