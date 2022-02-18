import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_flutter_app/provider/register_provider.dart';
import 'package:reto_flutter_app/screens/auth/login_screen.dart';
import 'package:reto_flutter_app/ui/input_decoration.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Registrar Usuario', style: TextStyle(fontSize: 22)),
            _RegisterForm(),
          ],
        ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterProvider>(context,listen: false);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
         TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'a701',
              labelText: 'Nombre de Usuario',
              icon: Icons.person),
          onChanged: (value) => registerForm.name = value,
          validator: (value) {
             return (value != null  && value.isNotEmpty)
                ? null
                : 'Ingrese un nombre';
          },
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: 'example@gmail.com',
              labelText: 'Correo Electronico',
              icon: Icons.alternate_email),
          onChanged: (value) => registerForm.email = value,
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = RegExp(pattern);
            return regExp.hasMatch(value ?? '') ? null : 'Ingrese un correo';
          },
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecorations.authInputDecoration(
              hintText: '************',
              labelText: 'Contrase;a',
              icon: Icons.lock_open_outlined),
          onChanged: (value) => registerForm.password = value,
          validator: (value) {
            return (value != null && value.length >= 6)
                ? null
                : 'La contraseña debe terner 6 caracteres';
          },
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
                'Registrase',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: registerForm.isLoading
                ? null
                : () async {
                   registerForm.singUp(context);
                  }),
          TextButton(onPressed: ()=>Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context)=>const LoginScreen())),
          child: const Text('Login',style: TextStyle(color: Colors.red)),
          ), 
      ]),
    );
  }
}