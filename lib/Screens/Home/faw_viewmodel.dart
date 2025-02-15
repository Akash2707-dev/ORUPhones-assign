import 'package:stacked/stacked.dart';
import 'package:oruphones_assign/services/home_service.dart';

class FaqViewModel extends BaseViewModel {
  final HomeService _homeService = HomeService();

  List<Map<String, dynamic>> _faqs = [];
  List<bool> _expandedStates = [];

  List<Map<String, dynamic>> get faqs => _faqs;
  List<bool> get expandedStates => _expandedStates;

  /// **🔹 Fetch FAQs from API**
  Future<void> fetchFaqs() async {
    setBusy(true);
    final response = await _homeService.fetchFaqs();

    if (response != null && response["FAQs"] is List) {
      _faqs = List<Map<String, dynamic>>.from(response["FAQs"]);
      _expandedStates = List<bool>.filled(_faqs.length, false);
    } else {
      _faqs = [];
      _expandedStates = [];
    }

    setBusy(false);
  }

  /// **🔹 Toggle FAQ Expansion**
  void toggleExpansion(int index) {
    if (index >= 0 && index < _expandedStates.length) {
      _expandedStates[index] = !_expandedStates[index];
      notifyListeners();
    }
  }
}
