import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:oruphones_assign/Screens/OTP/otp_viewmodel.dart';

class OtpView extends StatelessWidget {
  final String phoneNumber; // 🔥 Accept phoneNumber parameter

  const OtpView({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
      viewModelBuilder: () => OtpViewModel(phoneNumber: phoneNumber),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.black), // X Button
                onPressed: () => viewModel.navigateToHome(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  Center(
                    child: Text(
                      "Verify Mobile No.",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F3E8F), // #3F3E8F
                      ),
                    ),
                  ),

                  // 🔹 Sign In Subtitle
                  Center(
                    child: Text(
                      "Please enter the 4 digital verification code sent to\n      your mobile number $phoneNumber via SMS",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  SizedBox(height: 80),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // ✅ Centers OTP fields
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5), // ✅ Reduces space between boxes
                        child: SizedBox(
                          height: 42,
                          width: 44,
                          child: TextFormField(
                            controller: viewModel.otpControllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "", // Hide counter
                            ),
                            onChanged: (value) {
                              if (value.length == 1) {
                                if (index < 3) {
                                  FocusScope.of(context)
                                      .nextFocus(); // Move to next field
                                } else {
                                  FocusScope.of(context)
                                      .unfocus(); // Hide keyboard on last digit
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 45),
                  TextButton(
                    onPressed: viewModel.canResendOtp
                        ? () => viewModel.resendOtp()
                        : null, // Disable button during countdown
                    child: Text(
                      viewModel.canResendOtp
                          ? "Resend OTP"
                          : "Didn’t receive OTP?\nResend OTP in 0:${viewModel.timerSeconds.toString().padLeft(2, '0')} Sec",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: viewModel.canResendOtp
                            ? Colors.blue // ✅ Enable color
                            : Colors.black87, // ✅ Disable color
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),

                  SizedBox(
                    width: double.infinity, // ✅ Makes the button full width
                    child: ElevatedButton(
                      onPressed:
                          viewModel.validateOtp, // ✅ Calls validateOtp function
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF3F3E8F), // ✅ Matches Login Button color
                        padding: EdgeInsets.symmetric(
                            vertical: 16), // ✅ Taller button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // ✅ White text
                        ),
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
