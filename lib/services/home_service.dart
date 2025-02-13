import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';

class HomeService {
  final String baseUrl = "http://40.90.224.241:5000";
  final http.Client _client = http.Client();
  final AuthService _authService =
      locator<AuthService>(); // ✅ Inject AuthService

  /// **1️⃣ Fetch FAQs**
  Future<List<dynamic>?> fetchFaqs() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/faq'));

      print("🔹 FAQ API Response: ${response.body}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    } catch (e) {
      print("❌ Error fetching FAQs: $e");
      return null;
    }
  }

  /// **2️⃣ Fetch Brands**
  Future<List<dynamic>?> fetchBrands() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/makeWithImages'));

      print("🔹 Brands API Response: ${response.body}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    } catch (e) {
      print("❌ Error fetching brands: $e");
      return null;
    }
  }

  /// **3️⃣ Fetch Filters**
  Future<Map<String, dynamic>?> fetchFilters() async {
    try {
      final response =
          await _client.get(Uri.parse('$baseUrl/showSearchFilters'));

      print("🔹 Filters API Response: ${response.body}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    } catch (e) {
      print("❌ Error fetching filters: $e");
      return null;
    }
  }

  /// **4️⃣ Fetch Products (Uses Default Filters)**
  Future<List<dynamic>?> fetchProducts(
      {Map<String, dynamic>? userFilters}) async {
    try {
      if (_authService.sessionCookie == null ||
          _authService.csrfToken == null) {
        print("❌ No authentication data available, cannot fetch products.");
        return null;
      }

      // ✅ Default Filters (if user does not provide any)
      Map<String, dynamic> defaultFilters = {
        "condition": ["Like New", "Fair"],
        "make": ["Samsung"],
        "storage": ["16 GB", "32 GB"],
        "ram": ["4 GB"],
        "warranty": ["Brand Warranty", "Seller Warranty"],
        "priceRange": [40000, 175000],
        "verified": true,
        "sort": {"date": -1}, // Default: Latest
        "page": 1,
      };

      // ✅ Merge Default & User Filters
      Map<String, dynamic> finalFilters = defaultFilters;
      if (userFilters != null) {
        finalFilters.addAll(userFilters);
      }

      final response = await _client.post(
        Uri.parse('$baseUrl/filter'),
        headers: {
          "Content-Type": "application/json",
          "X-Csrf-Token": _authService.csrfToken!,
          "Cookie": _authService.sessionCookie!,
        },
        body: jsonEncode({"filter": finalFilters}),
      );

      print("🔹 Products API Response: ${response.body}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    } catch (e) {
      print("❌ Error fetching products: $e");
      return null;
    }
  }

  /// **5️⃣ Like/Unlike a Product**
  Future<bool> toggleProductLike(String listingId, bool isFav) async {
    try {
      if (_authService.sessionCookie == null ||
          _authService.csrfToken == null) {
        print(
            "❌ No authentication data available, cannot like/unlike product.");
        return false;
      }

      final response = await _client.post(
        Uri.parse('$baseUrl/favs'),
        headers: {
          "Content-Type": "application/json",
          "X-Csrf-Token": _authService.csrfToken!,
          "Cookie": _authService.sessionCookie!,
        },
        body: jsonEncode({
          "listingId": listingId,
          "isFav": isFav,
        }),
      );

      print("🔹 Like Product API Response: ${response.body}");
      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error liking/unliking product: $e");
      return false;
    }
  }
}
