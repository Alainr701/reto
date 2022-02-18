import 'package:flutter/material.dart';
import 'package:reto_flutter_app/services/auth_service.dart';

class LoginProvider extends ChangeNotifier {

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void singIn(context) async {
    isLoading = true;
    if (!isValidForm()) {
      isLoading = false;
      return;
    }
        
    String user = await AuthService().login(context,email: email, password: password);
    if (user == 'success') {
      isLoading = false;
      print('entro');
    } else {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Usuario o contraseña incorrectos'),
      ));
    }
  }

  bool isValidForm() {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }
}
