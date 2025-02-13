import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/home_viewmodel.dart';
import 'package:oruphones_assign/widgets/drawer.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) =>
          viewModel.checkLoginStatus(), // ✅ Check login status on init
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leadingWidth: 114,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: SizedBox(
                  child: Image.asset(
                    'lib/assets/images/Drawer_logo.png',
                    fit: BoxFit.contain, // ✅ Ensures proper scaling
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                const Spacer(),
                const Text(
                  "India",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.74, bottom: 3.89, top: 3.89, right: 8.74),
                  child: Image.asset(
                    'lib/assets/images/location.png',
                    height: 20,
                    width: 14.52,
                  ),
                )
              ],
            ),
            actions: [
              viewModel.isUserLoggedIn
                  ? IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {
                        print("🔔 Notifications Clicked");
                      },
                    )
                  : GestureDetector(
                      onTap: () {
                        viewModel.logout();
                      },
                      child: Container(
                        height: 29,
                        width: 66,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6C018), // Custom Yellow
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
            ],
          ),
          drawer: Container(width: 311, child: AppDrawer()), // ✅ Drawer Widget
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
