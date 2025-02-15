import 'package:flutter/material.dart';

/// **🔹 Custom Button Widget**
class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        ),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

/// **🔹 Custom Button Widget with SVG Icon**
class CustomButtonWithSVG extends StatelessWidget {
  final String title;
  final String svgPath;
  final VoidCallback onPressed;

  const CustomButtonWithSVG({
    Key? key,
    required this.title,
    required this.svgPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.fromLTRB(4.25, 0, 4.25, 0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4.25, 4.41, 4.25, 4.41),
              child: Image.asset(
                svgPath,
                height: 13.82,
                width: 23.49,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

/// **🔹 Sort & Filter Button Widget**
class CustomActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomActionButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.black), // ✅ Leading Icon
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ), // ✅ Button Label
          const SizedBox(width: 5),
          const Icon(Icons.keyboard_arrow_down,
              size: 20, color: Colors.black), // ✅ Dropdown Icon
        ],
      ),
    );
  }
}
