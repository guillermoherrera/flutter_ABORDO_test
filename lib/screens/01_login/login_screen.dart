import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 320,),
            CardContainer(
              child: Column(
                children: [
                  // const SizedBox(height: 10),
                  // Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                  // const SizedBox(height: 30),
                  _LoginForm()
                ],
              ),
            ),
            const Text('Activar cuenta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
            const SizedBox(height: 50),
          ],),
        ),
      ),
      bottomNavigationBar: MaterialButton(
        disabledColor: Colors.grey,
        elevation: 0,
        color: const Color.fromRGBO(209, 57, 41, 1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Text('Términos y Aviso Legal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),), 
        ),
        onPressed: (){
      
        }
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>(); 

    return Form(
      key: formKeyLogin,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Usuario', prefixIcon: null/*Icons.person*/),
            validator: (value){
              // String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              // RegExp regExp  = new RegExp(pattern);
    
              // return regExp.hasMatch(value ?? '') ? null : 'El valor ingresado no tiene formato de correo' ;
              return (value != null && value.isNotEmpty) ? null : ' Ingresa el usuario ' ;
            },
          ),
          const SizedBox(height: 20,),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: null/*Icons.lock_outline*/),
            validator: (value){
              return (value != null && value.length >= 6) ? null : ' La contraseña debe ser de 6 caracteres minimo ' ;
            },
          ),
          const Text('Olvidé mi contraseña', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 40,),
          MaterialButton(
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 10,
            color: const Color.fromRGBO(209, 57, 41, 1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.00),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(209, 57, 41, 1),
                    Color.fromRGBO(209, 57, 41, 1),
                    Color.fromRGBO(159, 57, 41, 1),
                    Color.fromRGBO(159, 57, 41, 1),
                  ],
                ),
              ), 
              child: const Text('Entrar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
            onPressed: (){
              if(!(formKeyLogin.currentState?.validate() ?? false)) return;
    
              Navigator.pushReplacementNamed(context, 'home');
            }
          )
        ]
      )
    );
  }
}