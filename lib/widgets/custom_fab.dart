import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onPressed;

  const CustomFloatingActionButton({
    Key? key,
    required this.isVisible,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isVisible ? 1.0 : 0.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 51, // ✅ Set height
            width: 105.16, // ✅ Set width
            child: FloatingActionButton.extended(
              onPressed: onPressed,
              backgroundColor: const Color(0xFF363636),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Color(0xFFF6C018), width: 4),
              ),
              label: const Text(
                "Sell +",
                style: TextStyle(
                  color: Color(0xFFF6C018),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
