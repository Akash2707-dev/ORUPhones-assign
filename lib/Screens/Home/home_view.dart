import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
        viewModelBuilder: () => HomeViewmodel(),
        builder: (context, viewModel, child) {
          return const Scaffold();
        });
  }
}
