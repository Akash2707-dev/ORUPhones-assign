import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String deviceStorage;
  final String deviceCondition;
  final String originalPrice;
  final String discountedPrice;
  final int discountPercentage;
  final String location;
  final String date;
  final bool isLiked;
  final bool openForNegotiation;
  final bool verified; // ✅ Added verified flag
  final VoidCallback onLikePressed;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.deviceStorage,
    required this.deviceCondition,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.location,
    required this.date,
    required this.isLiked,
    required this.openForNegotiation,
    required this.verified, // ✅ Receive verified status from API
    required this.onLikePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 294,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **🔹 Product Image with Overlays**
          Stack(
            children: [
              /// **Product Image**
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  imageUrl,
                  height: 181,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// **🔹 Show OruVerified Badge Only If Verified**
              if (verified) // ✅ Only show if verified
                Positioned(
                  top: 8,
                  child: Image.asset(
                    "lib/assets/images/oruverified.png",
                    height: 21,
                    fit: BoxFit.contain,
                  ),
                ),

              /// **🔹 Heart Checkbox (Favorite)**
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onLikePressed,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 24,
                  ),
                ),
              ),

              /// **🔹 Black Transparent Overlay (Only if Negotiable)**
              if (openForNegotiation)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 21,
                    color: Colors.black.withAlpha((0.69 * 255).toInt()),
                    alignment: Alignment.center,
                    child: const Text(
                      "PRICE NEGOTIABLE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// **🔹 Product Details**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Product Name**
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                /// **Device Storage & Condition**
                Text(
                  "$deviceStorage  •  $deviceCondition",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 15),

                /// **Price with Discount**
                Row(
                  children: [
                    /// **Discounted Price**
                    Expanded(
                      child: Text(
                        "₹$discountedPrice",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Arial',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),

                    const SizedBox(width: 4),

                    /// **Original Price (Strikethrough)**
                    Flexible(
                      child: Text(
                        "₹$originalPrice",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),

                    const SizedBox(width: 4),

                    /// **Discount Percentage**
                    Flexible(
                      child: Text(
                        "($discountPercentage% off)",
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          /// **🔹 Location & Date Row**
          Container(
            color: const Color.fromARGB(255, 240, 239, 239),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// **Location**
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),

                /// **Date**
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
