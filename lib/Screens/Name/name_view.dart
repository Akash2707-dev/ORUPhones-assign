import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:oruphones_assign/Screens/Name/name_viewmodel.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NameViewModel>.reactive(
      viewModelBuilder: () => NameViewModel(),
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

                  // 🔹 Subtitle
                  Text(
                    "Sign Up to Continue",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 70),

                  // 🔹 "Enter Your Name" Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Please Tell Us Your Name ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  // 🔹 Name Input Field
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade400), // Faint Grey Outline
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: viewModel.nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                  SizedBox(height: 80),

                  // 🔹 Confirm Name Button
                  SizedBox(
                    width: double.infinity, // ✅ Makes the button full width
                    child: ElevatedButton(
                      onPressed: viewModel.confirmName,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3F3E8F), // #3F3E8F
                        padding: EdgeInsets.symmetric(
                            vertical: 16), // ✅ Taller button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Confirm Name",
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
                          ),
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
