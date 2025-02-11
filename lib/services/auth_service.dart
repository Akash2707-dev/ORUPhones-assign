import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://40.90.224.241:5000";

  /// **1️⃣ Request OTP (Login)**
  Future<bool> requestOtp(String countryCode, String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login/otpCreate'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "countryCode": int.parse(countryCode),
          "mobileNumber": int.parse(phoneNumber),
        }),
      );

      print("🔹 OTP API Response: ${response.body}"); // Debugging API response

      if (response.statusCode == 200) {
        return true; // OTP request successful
      } else {
        throw Exception("❌ Failed to send OTP: ${response.body}");
      }
    } catch (e) {
      print("❌ Error in requestOtp: $e");
      return false;
    }
  }

  /// **2️⃣ Validate OTP**
  Future<Map<String, dynamic>?> validateOtp(
      String countryCode, String phoneNumber, String otp) async {
    try {
      int otpNumber = int.tryParse(otp) ?? 0; // Convert OTP safely

      // 🔥 Force OTP to always be 4 digits
      String formattedOtp = otpNumber.toString().padLeft(4, '0');

      print("🔹 Sending OTP for Validation: $formattedOtp"); // Debugging

      final response = await http.post(
        Uri.parse('$baseUrl/login/otpValidate'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "countryCode": int.parse(countryCode),
          "mobileNumber": int.parse(phoneNumber),
          "otp": int.parse(formattedOtp), // ✅ Ensure correct format
        }),
      );

      print("🔹 OTP Validation Response: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // ✅ Returns user data
      } else {
        throw Exception("❌ OTP validation failed: ${response.body}");
      }
    } catch (e) {
      print("❌ Error in validateOtp: $e");
      return null;
    }
  }

  /// **3️⃣ Check Login Status (Auto Login)**
  Future<Map<String, dynamic>?> checkLoginStatus() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/isLoggedIn'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // ✅ Returns user data
      } else {
        return null; // User not logged in
      }
    } catch (e) {
      print("❌ Error in checkLoginStatus: $e");
      return null;
    }
  }

  /// **4️⃣ Update User Name (For New Users)**
  Future<bool> updateUserName(String countryCode, String userName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "countryCode": int.parse(countryCode),
          "userName": userName,
        }),
      );

      if (response.statusCode == 200) {
        return true; // ✅ Name update successful
      } else {
        throw Exception("❌ Failed to update user name: ${response.body}");
      }
    } catch (e) {
      print("❌ Error in updateUserName: $e");
      return false;
    }
  }

  /// **5️⃣ Logout**
  Future<bool> logout() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/logout'));

      if (response.statusCode == 200) {
        return true; // ✅ Logout successful
      } else {
        return false; // ❌ Logout failed
      }
    } catch (e) {
      print("❌ Error in logout: $e");
      return false;
    }
  }
}
