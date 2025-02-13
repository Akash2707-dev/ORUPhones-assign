import 'package:flutter/material.dart';
import 'package:oruphones_assign/Screens/Home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.checkLoginStatus(),
      builder: (context, viewModel, child) {
        return SizedBox(
          width: 280, // ✅ Custom drawer width
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: [
                /// 🔹 **Drawer Header (AppBar-Sized)**
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  color: const Color(0xFFF4F4F4),
                  // ✅ Background color
                  child: Column(
                    children: [
                      /// 🔹 **Logo & Close Button**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'lib/assets/images/ORULOGO.png',
                            width: 42,
                            height: 40,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close,
                                size: 24, color: Colors.black),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),

                      /// 🔹 **Show User Info if Logged In**
                      if (viewModel.isUserLoggedIn) ...[
                        const SizedBox(height: 12), // ✅ Adds spacing

                        Row(
                          children: [
                            const SizedBox(width: 8),

                            /// 🔹 **Profile Picture**
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(
                                  "lib/assets/images/Profile_image.jpg"),
                            ),

                            const SizedBox(width: 12),

                            /// 🔹 **User Name & Join Date**
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  viewModel.userName, // ✅ Dynamically from API
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Joined: ${viewModel.joiningDate}", // ✅ Dynamically from API
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 12), // ✅ Add spacing below profile info
                      ],
                    ],
                  ),
                ),

                /// 🔹 **Show Login Button if Not Logged In**
                if (!viewModel.isUserLoggedIn) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF3E468F), // ✅ Deep blue background
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                                0x3310227B), // ✅ Shadow #10227B33 (20% opacity)
                            blurRadius: 8,
                            offset: const Offset(0, 4), // ✅ Slight drop shadow
                          ),
                          BoxShadow(
                            color: const Color(
                                0x3304139C), // ✅ Shadow #04139C33 (20% opacity)
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          print("🟡 Navigate to Login");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // ✅ Transparent to show Container color
                          shadowColor: Colors
                              .transparent, // ✅ Remove default button shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          minimumSize: const Size(
                              double.infinity, 40), // ✅ Full-width button
                        ),
                        child: const Text(
                          "Login/SignUp",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // ✅ Change text to white for contrast
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFFF6C018), // ✅ Golden Yellow Background
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                              0x33737B10), // ✅ Shadow #737B1033 (20% opacity)
                          blurRadius: 8,
                          offset: const Offset(0, 4), // ✅ Soft drop shadow
                        ),
                        BoxShadow(
                          color: const Color(
                              0x33A8AB18), // ✅ Shadow #A8AB1833 (20% opacity)
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        print("🟡 Navigate to Login");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .transparent, // ✅ Transparent to show Container color
                        shadowColor: Colors
                            .transparent, // ✅ Remove default button shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        minimumSize: const Size(
                            double.infinity, 40), // ✅ Full-width button
                      ),
                      child: const Text(
                        "Sell Your Phone",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black, // ✅ Ensuring contrast with yellow background
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔹 **Drawer Menu Items**
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text(
                          "Logout",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                        ),
                        onTap: () {
                          viewModel.logout();
                        },
                      ),
                    ],
                  ),
                ),

                /// 🔹 **Buttons at the Bottom**
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      /// **First Row of Buttons**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDrawerButton(
                              "lib/assets/images/howtobuy.png", "How to Buy"),
                          _buildDrawerButton(
                              "lib/assets/images/howtosell.png", "How to Sell"),
                          _buildDrawerButton(
                              "lib/assets/images/oruguide.png", "ORU Guide"),
                        ],
                      ),
                      const SizedBox(height: 10), // ✅ Spacing between rows

                      /// **Second Row of Buttons**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDrawerButton(
                              "lib/assets/images/aboutus.png", "About Us"),
                          _buildDrawerButton(
                              "lib/assets/images/privacypolicy.png",
                              "Privacy Policy"),
                          _buildDrawerButton(
                              "lib/assets/images/faqs.png", "FAQs"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// **🔹 Custom Function for Buttons**
  Widget _buildDrawerButton(String imagePath, String title) {
    return Container(
      width: 78,
      height: 54,
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.grey[400]!, width: 1), // ✅ Outline color
        borderRadius: BorderRadius.circular(8), // ✅ Rounded corners
        color: Colors.white, // ✅ Background color
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // ✅ Center align image & text
        children: [
          Image.asset(
            imagePath,
            width: 30,
            height: 30,
            fit: BoxFit.contain, // ✅ Ensures proper scaling
          ),
          const SizedBox(height: 4), // ✅ Spacing between image and text
          Text(
            title,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center, // ✅ Ensures text stays centered
          ),
        ],
      ),
    );
  }
}
