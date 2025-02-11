import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:oruphones_assign/Screens/Login/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(), // Removes back button
            actions: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.black), // X Button
                onPressed: () => viewModel.navigateToHome(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 🔹 App Logo
                  Image.asset(
                    'lib/assets/images/ORULOGO.png', // Ensure correct path
                    width: 161,
                    height: 120,
                  ),

                  SizedBox(height: 16),

                  // 🔹 Welcome Text
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F3E8F), // #3F3E8F
                    ),
                  ),

                  // 🔹 Sign In Subtitle
                  Text(
                    "Sign in to continue",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 70),

                  // 🔹 "Enter your phone number" Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Your Phone Number",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  // 🔹 Phone Number Input with Country Code
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade400), // Faint Grey Outline
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Country Code
                        Text(
                          "+91",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: viewModel.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 80),

                  // 🔹 Accept Terms & Conditions (No toggle)
                  Row(
                    children: [
                      Checkbox(
                        value: false, // Always unchecked
                        onChanged: null, // No toggle functionality
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Accept ",
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Poppins"),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                color: Color.fromARGB(
                                    255, 116, 114, 231), // Blue color
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 🔹 Next Button with Arrow
                  SizedBox(
                    width: double.infinity, // ✅ Makes the button full width
                    child: ElevatedButton(
                      onPressed: viewModel.sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3F3E8F), // #3F3E8F
                        padding: EdgeInsets.symmetric(
                            vertical: 16), // ✅ Taller button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // ✅ Keeps content compact
                        mainAxisAlignment:
                            MainAxisAlignment.center, // ✅ Centers text & icon
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // ✅ White text
                            ),
                          ),
                          SizedBox(width: 10), // ✅ Space between text & arrow
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ), // ✅ Arrow AFTER text
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
