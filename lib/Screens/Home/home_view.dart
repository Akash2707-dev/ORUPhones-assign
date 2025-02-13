import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/home_viewmodel.dart';
import 'package:oruphones_assign/widgets/carousel_banner.dart';
import 'package:oruphones_assign/widgets/drawer.dart';
import 'package:oruphones_assign/widgets/search_bar.dart';
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
          body: Column(
            children: [
              /// **🔹 Pinned Search Bar**
              const SearchBarWidget(),

              /// **🔹 Pinned Row of Horizontally Scrollable Buttons**
              Container(
                height: 50, // ✅ Fixed height for button row
                color: Colors.white, // Background color
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: _buildCustomButton("Sell Used Phones"),
                      ),
                      _buildCustomButton("Buy Used Phones"),
                      _buildCustomButton("Compare Prices"),
                      _buildCustomButton("My Profile"),
                      _buildCustomButton("My Listings"),
                      _buildCustomButton("Services"),
                      _buildCustomButtonWithSVG(
                          "Register your Store", "lib/assets/images/new.png"),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: _buildCustomButton("Get the App"),
                      ),
                    ],
                  ),
                ),
              ),

              /// **🔹 Scrollable Main Content**
              Expanded(
                child: ListView(
                  children: const [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 18,
                          ),
                          CarouselWidget(),
                        ],
                      ),
                    ),
                    SizedBox(height: 1500), // Dummy space to test scrolling
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// **🔹 Custom Button Widget**
  Widget _buildCustomButton(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      child: OutlinedButton(
        onPressed: () {
          print("Selected: $title");
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white, // ✅ White background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // ✅ Rounded corners
            ),
            side: const BorderSide(
              color: Color(0xFFE0E0E0), // ✅ Border color #E0E0E0
              width: 1, // ✅ 1px border
            ),
            minimumSize: const Size(0, 36),
            padding: EdgeInsets.fromLTRB(12, 4, 12, 4) // ✅ Set button height
            ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black, // ✅ Black text
          ),
        ),
      ),
    );
  }

  /// **🔹 Custom Button Widget with SVG Icon**
  Widget _buildCustomButtonWithSVG(String title, String svgPath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: OutlinedButton(
        onPressed: () {
          print("Selected: $title");
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white, // ✅ White background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // ✅ Rounded corners
            ),
            side: const BorderSide(
              color: Color(0xFFE0E0E0), // ✅ Border color #E0E0E0
              width: 1, // ✅ 1px border
            ),
            minimumSize: const Size(0, 36),
            padding: EdgeInsets.fromLTRB(4.25, 0, 4.25, 0)
            // ✅ Set button height
            ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4.25, 4.41, 4.25, 4.41),
              child: Image.asset(
                svgPath,
                height: 13.82,
                width: 23.49,
              ),
            ), // ✅ SVG Image

            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black, // ✅ Black text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
