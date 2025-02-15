import 'package:flutter/material.dart';

class InviteFriendWidget extends StatelessWidget {
  const InviteFriendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// **🔹 Main Background Container (Split into Two Colors)**
        Container(
          height: 450, // ✅ Fixed height
          width: double.infinity, // ✅ Full width
          child: Column(
            children: [
              /// **🔹 Top Half (Dark Background)**
              Expanded(
                child: Container(
                  color: const Color(0xFF363636), // ✅ #363636
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "Invite a Friend", // ✅ White Text in Black Section
                      style: TextStyle(
                        fontSize: 20, // ✅ Font size 20px
                        fontWeight: FontWeight.w600, // ✅ Font weight 600
                        fontFamily: 'Poppins',
                        color: Colors.white, // ✅ Text color white
                      ),
                    ),
                  ),
                ),
              ),

              /// **🔹 Bottom Half (White Background)**
              Expanded(
                child: Container(color: Colors.white), // ✅ White
              ),
            ],
          ),
        ),

        /// **🔹 Foreground Floating Container**
        Positioned(
          left: 50,
          right: 50,
          top: 90, // ✅ Adjust position
          child: Container(
            height: 255,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white, // ✅ Foreground is White
              borderRadius: BorderRadius.circular(40), // ✅ Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withAlpha((0.2 * 255).toInt()), // ✅ Subtle shadow
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                /// **📢 Invite a Friend Text**
                const Text(
                  "Invite a friend to ORUphones application.\nTap to copy the respective download link\nto the clipboard",
                  style: TextStyle(
                    fontSize: 12, // ✅ Font size
                    fontWeight: FontWeight.w400, // ✅ Font weight
                    fontFamily: 'Poppins',
                    color: Colors.black, // ✅ Text color
                  ),
                  textAlign: TextAlign.center, // ✅ Center text alignment
                ),

                const SizedBox(height: 20), // ✅ Space between text & images

                /// **📸 Invite Image**
                Image.asset(
                  "lib/assets/images/shareplay.png",
                  height: 119.13,
                  width: 166.23, // ✅ Adjust size
                ),
              ],
            ),
          ),
        ),

        /// **🔹 Social Media Icons**
        Positioned(
          left: 0,
          right: 0,
          bottom: 10, // ✅ Position at bottom of the white section
          child: Column(
            children: [
              /// **"or Share" Text**
              const Text(
                "or Share",
                style: TextStyle(
                  fontSize: 12, // ✅ Font size
                  fontWeight: FontWeight.w600, // ✅ Font weight 600
                  fontFamily: 'Poppins',
                  color: Colors.black, // ✅ Text color
                ),
              ),

              const SizedBox(height: 15), // ✅ Spacing

              /// **Row of Social Media Icons**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// **Instagram**
                  Image.asset(
                    "lib/assets/images/instagram.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 20),

                  /// **Telegram**
                  Image.asset(
                    "lib/assets/images/telegram.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 20),

                  /// **Twitter**
                  Image.asset(
                    "lib/assets/images/twitter.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 20),

                  /// **WhatsApp**
                  Image.asset(
                    "lib/assets/images/whatsapp.png",
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
