import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      color: Colors.white, // Background color for pinned search bar
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Search bar background
          hintText: "Search phones with make, model....",
          hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFF7C04A),
            size: 16,
          ), // ✅ Updated color
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 2, // ✅ Divider width
                height: 17,
                color: const Color(0xFF707070), // ✅ Divider color
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                child: Image.asset(
                  "lib/assets/images/Mic.png",
                  height: 16,
                  width: 16,
                ),
              ),
              // ✅ Mic icon
              // ✅ Right padding
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0), // ✅ Border color
              width: 1, // ✅ Border width
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0), // ✅ Border color
              width: 1, // ✅ Border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0), // ✅ Border color
              width: 1, // ✅ Border width
            ),
          ),
        ),
      ),
    );
  }
}
