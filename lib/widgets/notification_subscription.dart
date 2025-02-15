import 'package:flutter/material.dart';

class NotificationSubscription extends StatelessWidget {
  const NotificationSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222, // ✅ Fixed height
      width: double.infinity, // ✅ Full width
      color: const Color(0xFFF6C018), // ✅ Background color #F6C018
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // ✅ Padding
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // ✅ Center items vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // ✅ Center items horizontally
        children: [
          /// **📢 Get Notified Text**
          const Text(
            "Get Notified About Our \nLatest Offers and Price Drops",
            textAlign: TextAlign.center, // ✅ Center-align text
            style: TextStyle(
              fontSize: 20, // ✅ Font size 20px
              fontWeight: FontWeight.w600, // ✅ Font weight 600
              fontFamily: 'Poppins',
              color: Colors.black87, // ✅ Text color
            ),
          ),

          const SizedBox(height: 20), // ✅ Space between text & text field

          /// **📩 Email Text Field with Send Button**
          Container(
            height: 43, // ✅ Fixed height
            width: 259, // ✅ Fixed width
            decoration: BoxDecoration(
              color: Colors.white, // ✅ White background
              borderRadius: BorderRadius.circular(73), // ✅ Rounded corners
            ),
            child: Row(
              children: [
                /// **📧 Email Input Field**
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10), // ✅ Added left padding for hint
                    child: Center(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "   Enter your email here",
                          hintStyle: TextStyle(
                            fontSize: 14, // ✅ Adjust hint font size
                            color: Colors.grey, // ✅ Grey hint color
                          ),
                          border: InputBorder.none, // ✅ No border
                        ),
                        style: const TextStyle(
                            fontSize: 12), // ✅ Adjust input font size
                      ),
                    ),
                  ),
                ),

                /// **📤 Send Button**
                Padding(
                  padding: const EdgeInsets.only(
                      right: 5), // ✅ Added right padding for button
                  child: Container(
                    height: 29,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.black, // ✅ Button color black
                      borderRadius:
                          BorderRadius.circular(42), // ✅ Rounded corners
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          print(
                              "Send button clicked"); // ✅ Placeholder for action
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // ✅ Removes default padding
                          minimumSize: const Size(
                              75, 29), // ✅ Ensures full button height is used
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // ✅ Removes extra spacing
                        ),
                        child: const Text(
                          "Send",
                          textAlign: TextAlign.center, // ✅ Center text
                          style: TextStyle(
                            fontSize: 12, // ✅ Button text size
                            fontWeight: FontWeight.w400,
                            color: Colors.white, // ✅ Button text color white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
