import 'package:flutter/material.dart';

class DownloadAppWidget extends StatelessWidget {
  const DownloadAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 345, // ✅ Fixed height
      width: double.infinity, // ✅ Full width
      color: const Color(0xFF363636), // ✅ Background color #363636
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 40), // ✅ Padding for spacing
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // ✅ Center items vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // ✅ Center items horizontally
        children: [
          /// **📲 "Download App" Text**
          const Text(
            "Download App",
            style: TextStyle(
              fontSize: 20, // ✅ Font size 20px
              fontWeight: FontWeight.w600, // ✅ Font weight 600
              fontFamily: 'Poppins',
              color: Colors.white, // ✅ White text color
            ),
          ),

          const SizedBox(height: 20), // ✅ Space between text & QR codes

          /// **📱 QR Code Row**
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // ✅ Center-align images
            children: [
              /// **📌 Play Store QR**
              Image.asset(
                'lib/assets/images/playstore_qr.png', // ✅ Update with correct path
                height: 215,
                width: 159, // ✅ Adjust height
              ),

              const SizedBox(width: 20), // ✅ Space between images

              /// **📌 Apple Store QR**
              Image.asset(
                'lib/assets/images/applestore_qr.png', // ✅ Update with correct path
                height: 215,
                width: 159, // ✅ Adjust height
              ),
            ],
          ),
        ],
      ),
    );
  }
}
