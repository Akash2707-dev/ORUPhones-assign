import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oruphones_assign/services/auth_service.dart';
import 'package:oruphones_assign/app/app.locator.dart';

class HomeService {
  final String baseUrl = "http://40.90.224.241:5000";
  final http.Client _client = http.Client();
  final AuthService _authService = locator<AuthService>();

  Future<Map<String, dynamic>?> fetchFaqs() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/faq'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey("FAQs") && data["FAQs"] is List) {
          return data;
        }
      }
      return null;
    } catch (e) {
      print("❌ Error fetching FAQs: $e");
      return null;
    }
  }

  Future<List<dynamic>?> fetchBrands() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/makeWithImages'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey("dataObject")) {
          return decodedResponse["dataObject"] as List<dynamic>;
        } else {
          print("❌ Error: 'dataObject' key not found in API response.");
          return null;
        }
      }
      return null;
    } catch (e) {
      print("❌ Error fetching brands: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchFilters() async {
    try {
      final response =
          await _client.get(Uri.parse('$baseUrl/showSearchFilters'));
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    } catch (e) {
      print("❌ Error fetching filters: $e");
      return null;
    }
  }

  Future<List<dynamic>?> fetchProducts({
    Map<String, dynamic>? userFilters,
    int page = 1,
  }) async {
    try {
      Map<String, dynamic> defaultFilters = {"page": page};
      Map<String, dynamic> finalFilters = defaultFilters;
      if (userFilters != null) {
        finalFilters.addAll(userFilters);
      }

      final response = await _client.post(
        Uri.parse('$baseUrl/filter'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"filter": finalFilters}),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey("data") &&
            decodedResponse["data"] is Map<String, dynamic> &&
            decodedResponse["data"].containsKey("data") &&
            decodedResponse["data"]["data"] is List) {
          return decodedResponse["data"]["data"];
        } else {
          print("❌ Error: 'data.data' key not found or invalid format.");
          return null;
        }
      }
      return null;
    } catch (e) {
      print("❌ Error fetching products: $e");
      return null;
    }
  }

  Future<List<dynamic>?> fetchLikedProducts() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/favs'),
        headers: {
          "Content-Type": "application/json",
          "X-Csrf-Token": _authService.csrfToken!,
          "Cookie": _authService.sessionCookie!,
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey("data")) {
          return decodedResponse["data"] as List<dynamic>;
        } else {
          print("❌ Error: Invalid response format for liked products.");
          return [];
        }
      } else {
        print("❌ Error fetching liked products: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Error fetching liked products: $e");
      return [];
    }
  }

  Future<bool> toggleProductLike(String listingId, bool isFav) async {
    try {
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

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error liking/unliking product: $e");
      return false;
    }
  }
}
