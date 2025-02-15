import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://40.90.224.241:5000";
  final http.Client _client = http.Client();

  String? _csrfToken; // 🔹 Stores CSRF token
  String? _sessionCookie; // 🔹 Stores session cookie
  String? get csrfToken => _csrfToken;
  String? get sessionCookie => _sessionCookie;
  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      if (_sessionCookie == null || _csrfToken == null) {
        print("❌ No authentication data available, cannot fetch user details.");
        return null;
      }

      final response = await _client.get(
        Uri.parse('$baseUrl/isLoggedIn'), // ✅ Use isLoggedIn API
        headers: {
          "Content-Type": "application/json",
          "Cookie": _sessionCookie!,
        },
      );

      print("🔹 User Details API Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey("user")) {
          return responseData["user"]; // ✅ Returns user details
        } else {
          print("❌ No user data found in response!");
          return null;
        }
      } else {
        print("❌ Failed to fetch user details");
        return null;
      }
    } catch (e) {
      print("❌ Error fetching user details: $e");
      return null;
    }
  }

  List<String> getUserFavListings(Map<String, dynamic> userDetails) {
    return List<String>.from(userDetails['favListings'] ?? []);
  }

  /// **1️⃣ Request OTP (Login)**
  Future<bool> requestOtp(String countryCode, String phoneNumber) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/login/otpCreate'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "countryCode": int.parse(countryCode),
          "mobileNumber": int.parse(phoneNumber),
        }),
      );

      print("🔹 OTP API Response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error in requestOtp: $e");
      return false;
    }
  }

  /// **2️⃣ Validate OTP (Extracts CSRF Token & Session Cookie)**
  Future<Map<String, dynamic>?> validateOtp(
      String countryCode, String phoneNumber, String otp) async {
    try {
      int otpNumber = int.tryParse(otp) ?? 0;
      String formattedOtp =
          otpNumber.toString().padLeft(4, '0'); // Ensure 4 digits

      print("🔹 Sending OTP for Validation: $formattedOtp");

      final response = await _client.post(
        Uri.parse('$baseUrl/login/otpValidate'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "countryCode": int.parse(countryCode),
          "mobileNumber": int.parse(phoneNumber),
          "otp": int.parse(formattedOtp),
        }),
      );

      print("🔹 OTP Validation Response: ${response.body}");

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);

        // ✅ Extract CSRF Token & Session Cookie
        await _extractAndStoreAuthData(response);

        // ✅ Check if user is actually logged in
        bool isLoggedIn = await checkLoginStatus();
        if (!isLoggedIn) {
          print("❌ User is not logged in even after OTP verification!");
          return null;
        }

        return userData;
      } else {
        throw Exception("❌ OTP validation failed: ${response.body}");
      }
    } catch (e) {
      print("❌ Error in validateOtp: $e");
      return null;
    }
  }

  /// **3️⃣ Check Login Status (Auto Login)**
  Future<bool> checkLoginStatus() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/isLoggedIn'),
        headers: {
          "Content-Type": "application/json",
          if (_sessionCookie != null) "Cookie": _sessionCookie!,
        },
      );

      print("🔹 isLoggedIn API Response: ${response.body}");
      print("🔹 isLoggedIn Headers: ${response.headers}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // ✅ Extract CSRF Token
        if (responseData.containsKey("csrfToken")) {
          _csrfToken = responseData["csrfToken"];
          print("✅ CSRF Token Stored: $_csrfToken");
        } else {
          print("❌ CSRF Token Missing in Response!");
          return false;
        }

        // ✅ Store session cookie if available
        if (response.headers.containsKey('set-cookie')) {
          _extractAndStoreAuthData(response);
        }

        bool isLoggedIn = responseData["isLoggedIn"];
        print("🔹 Final Login Status: $isLoggedIn");
        return isLoggedIn;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ Error in checkLoginStatus: $e");
      return false;
    }
  }

  /// **4️⃣ Update User Name (Attach CSRF & Cookie)**
  Future<bool> updateUserName(String countryCode, String userName) async {
    try {
      if (_sessionCookie == null || _csrfToken == null) {
        print("❌ No authentication data available, cannot update name.");
        return false;
      }

      final response = await _client.post(
        Uri.parse('$baseUrl/update'),
        headers: {
          "Content-Type": "application/json",
          "X-Csrf-Token": _csrfToken!,
          "Cookie": _sessionCookie!,
        },
        body: jsonEncode({
          "countryCode": int.parse(countryCode),
          "userName": userName,
        }),
      );

      print("🔹 Update User API Response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error in updateUserName: $e");
      return false;
    }
  }

  /// **5️⃣ Logout (Attach CSRF & Cookie)**
  Future<bool> logout() async {
    try {
      if (_sessionCookie == null || _csrfToken == null) {
        print("❌ No authentication data available, cannot logout.");
        return false;
      }

      final response = await _client.get(
        Uri.parse('$baseUrl/logout'),
        headers: {
          "X-Csrf-Token": _csrfToken!,
          "Cookie": _sessionCookie!,
        },
      );

      print("🔹 Logout API Response: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Logout successful!");
        _sessionCookie = null;
        _csrfToken = null; // Clear authentication data
        return true;
      } else {
        print("❌ Logout failed");
        return false;
      }
    } catch (e) {
      print("❌ Error in logout: $e");
      return false;
    }
  }

  /// **6️⃣ Extract & Store CSRF Token & Session Cookie**
  Future<void> _extractAndStoreAuthData(http.Response response) async {
    // Extract CSRF token from response body
    var responseData = jsonDecode(response.body);
    if (responseData.containsKey("csrfToken")) {
      _csrfToken = responseData["csrfToken"];
      print("✅ Extracted CSRF Token: $_csrfToken");
    } else {
      print("❌ No CSRF Token Found in Response");
    }

    // Extract session cookie from headers
    if (response.headers.containsKey('set-cookie')) {
      String rawCookie = response.headers['set-cookie']!;
      _sessionCookie = rawCookie.split(';')[0]; // Extract actual session cookie
      print("✅ Extracted Session Cookie: $_sessionCookie");
    } else {
      print("❌ No Session Cookie Found in Headers");
    }
  }
}
