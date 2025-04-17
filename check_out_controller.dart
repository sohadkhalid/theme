import 'package:flutter/material.dart';
import '../view/screens/cart_screens/add_card_screen.dart';
import '../view/screens/cart_screens/check_out_successfully_screen.dart';

class CheckOutController with ChangeNotifier {
  String _selectedPaymentMethod = "card";
  String get selectedPaymentMethod => _selectedPaymentMethod;

  void setSelectedPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  String _selectedCardType = "Visa";
  String get selectedCardType => _selectedCardType;

  void setSelectedCardType(String type) {
    _selectedCardType = type;
    notifyListeners();
  }

  String _promoCode = "";
  String get promoCode => _promoCode;

  void setPromoCode(String code) {
    _promoCode = code;
    notifyListeners();
  }

  void navigateToNextScreen(BuildContext context) {
    if (_selectedPaymentMethod == "cash") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CheckOutSuccessfullyScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddCardScreen(),
        ),
      );
    }
  }
}
