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
                            height: 12), // ✅ Spacing below profile info
                      ],
                    ],
                  ),
                ),

                /// 🔹 **Show Login Button if Not Logged In**
                if (!viewModel.isUserLoggedIn) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildCustomButton(
                      text: "Login/SignUp",
                      backgroundColor: const Color(0xFF3E468F), // ✅ Deep blue
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                        print("🟡 Navigate to Login");
                      },
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                /// 🔹 **Sell Your Phone Button**
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCustomButton(
                    text: "Sell Your Phone",
                    backgroundColor: const Color(0xFFF6C018), // ✅ Golden Yellow
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                      print("🟡 Navigate to Sell Page");
                    },
                  ),
                ),

                /// 🔹 **Drawer Menu Items**
                Expanded(
                  child: ListView(
                    children: [
                      /// 🔹 **Logout Button (Only if Logged In)**
                      if (viewModel.isUserLoggedIn) // ✅ Hides if not logged in
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text(
                            "Logout",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          ),
                          onTap: () {
                            viewModel.logout();
                          },
                        ),
                    ],
                  ),
                ),

                /// 🔹 **Bottom Buttons (How to Buy, FAQs, etc.)**
                _buildBottomButtons(),
              ],
            ),
          ),
        );
      },
    );
  }

  /// **🔹 Reusable Custom Button**
  Widget _buildCustomButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  /// **🔹 Bottom Buttons (How to Buy, FAQs, etc.)**
  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              _buildDrawerButton("lib/assets/images/oruguide.png", "ORU Guide"),
            ],
          ),
          const SizedBox(height: 10), // ✅ Spacing between rows

          /// **Second Row of Buttons**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDrawerButton("lib/assets/images/aboutus.png", "About Us"),
              _buildDrawerButton(
                  "lib/assets/images/privacypolicy.png", "Privacy Policy"),
              _buildDrawerButton("lib/assets/images/faqs.png", "FAQs"),
            ],
          ),
        ],
      ),
    );
  }

  /// **🔹 Custom Function for Small Buttons**
  Widget _buildDrawerButton(String imagePath, String title) {
    return Container(
      width: 78,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
