import 'package:flutter/material.dart';

class HorizontalListWidget extends StatelessWidget {
  // ✅ Full List of Images & Texts with Custom Sizes, Image Padding & Text Padding
  final List<Map<String, dynamic>> items = [
    {
      "image": "lib/assets/whats_on_mind/buyusedphones.png",
      "text": "Buy Used\nPhones",
      "width": 103,
      "height": 103,
      "imagePadding": EdgeInsets.fromLTRB(0, 18, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 5, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/sellusedphones.png",
      "text": "Sell Used\nPhones",
      "width": 103,
      "height": 103,
      "imagePadding": EdgeInsets.fromLTRB(0, 20, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 8, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/compareprices.png",
      "text": "Compare\nPrices",
      "width": 103,
      "height": 103,
      "imagePadding": EdgeInsets.fromLTRB(0, 20, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 3, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/myprofile.png",
      "text": "My Profile",
      "width": 103,
      "height": 103,
      "imagePadding": EdgeInsets.fromLTRB(0, 10, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 3, 0, 10),
    },
    {
      "image": "lib/assets/whats_on_mind/mylistings.png",
      "text": "My Listings",
      "width": 75,
      "height": 75,
      "imagePadding": EdgeInsets.fromLTRB(0, 10, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 6, 0, 10),
    },
    {
      "image": "lib/assets/whats_on_mind/openstore.png",
      "text": "Open Store",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 5, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 7, 0, 10),
    },
    {
      "image": "lib/assets/whats_on_mind/services.png",
      "text": "Services",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 4, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 8, 0, 10),
    },
    {
      "image": "lib/assets/whats_on_mind/devicehealthcheck.png",
      "text": "Device Health\nCheck",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(15, 25, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 10, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/batteryhealthcheck.png",
      "text": "Battery Health\nCheck",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 25, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 10, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/IMEIverification.png",
      "text": "IMEI\nVerification",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 25, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 10, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/devicedetails.png",
      "text": "Device Details",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 15, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 7, 0, 10),
    },
    {
      "image": "lib/assets/whats_on_mind/datawipe.png",
      "text": "Data Wipe",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 4, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 7, 0, 10),
    },
    {
      "image": "lib/assets/whats_on_mind/underwarrantypones.png",
      "text": "Under Warranty\nPhones",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 40, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 15, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/premiumphones.png",
      "text": "Premium\nPhones",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 30, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 15, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/likenewphones.png",
      "text": "Like New\nPhones",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 40, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 18, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/refurbishedphones.png",
      "text": "Refurbished\nPhones",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 40, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 20, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/verifiedphones.png",
      "text": "Verified\nPhones",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 40, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 20, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/mynegotiations.png",
      "text": "My Negotiations",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 45, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 20, 0, 0),
    },
    {
      "image": "lib/assets/whats_on_mind/myfavourites.png",
      "text": "My Favorites",
      "width": 72,
      "height": 72,
      "imagePadding": EdgeInsets.fromLTRB(0, 6, 0, 0),
      "textPadding": EdgeInsets.fromLTRB(0, 7, 0, 0),
    },
  ];

  HorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168, // 🔹 Reduced height to remove extra whitespace
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) => _buildListItem(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100, // 🔹 Reduced height to bring images up
          alignment: Alignment.center,
          child: Padding(
            padding: item["imagePadding"],
            child: Image.asset(
              item["image"]!,
              width: (item["width"] as num).toDouble(),
              height: (item["height"] as num).toDouble(),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: item["textPadding"],
          child: SizedBox(
            width: 100,
            child: Text(
              item["text"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
          ),
        ),
      ],
    );
  }
}
