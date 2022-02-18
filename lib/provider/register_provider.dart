import 'package:flutter/material.dart';
import 'package:reto_flutter_app/services/auth_service.dart';

class RegisterProvider extends ChangeNotifier {


  String name = '';
  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void singUp(context) async {
    isLoading = true;
    if (!isValidForm()) {
      isLoading = false;
      return;
    }
    String register = await AuthService()
        .register(context,name: name, email: email, password: password);
    if (register == 'success') {
      isLoading = false;
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) =>  HomeScreen()));
    } else {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error al registrarse'),
      ));
    }
  }

  bool isValidForm() {
    if (name.isEmpty|| email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }
}
