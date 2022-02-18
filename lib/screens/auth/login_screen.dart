import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_flutter_app/const.dart';
import 'package:reto_flutter_app/provider/login_provider.dart';
import 'package:reto_flutter_app/screens/auth/register_screen.dart';
import 'package:reto_flutter_app/ui/input_decoration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('inicio de sesión', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
            _LoginForm(),
          ],
        ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'example@gmail.com',
              labelText: 'Correo Electronico',
              icon: Icons.mark_email_read),
          onChanged: (value) => loginForm.email = value,
          validator: (value) {
                 RegExp regExp = RegExp(pattern);
            return regExp.hasMatch(value ?? '') ? null : 'Ingrese un correo';
          },
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecorations.authInputDecoration(
              hintText: '************',
              labelText: 'Contraseña',
              icon: Icons.lock),
          onChanged: (value) => loginForm.password = value,
          validator: (value) =>(value != null && value.length >= 6)
                ? null
                : 'La contraseña debe terner 6 caracteres'
        ),
        const SizedBox(height: 20.0),
        MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.red,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    loginForm.singIn(context);
                  }),
          TextButton(onPressed: ()=>Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context)=>const RegisterScreen())),
          child: const Text('Registrarse',style: TextStyle(color: Colors.red)),
          ), 
      ]),
    );
  }
}
