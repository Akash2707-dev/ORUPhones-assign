import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: viewModel.logout, // 🔥 Calls logout function
              ),
            ],
          ),
          body: const Center(
            child: Text(
              "Welcome to Home!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
