import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  BlocProvider(
                    create: (context) => LoginCubit(),
                    child: const _LoginForm(),
                  )
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
              child: const Text('Activar cuenta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
              onPressed: ()=>Navigator.pushNamed(context, 'activar')
            ),
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
  const _LoginForm();
  
  @override
  Widget build(BuildContext context) {
    
    final loginCubit = context.watch<LoginCubit>();
    final usuario = loginCubit.state.usuario;
    final contrasena = loginCubit.state.contrasena;
    final loading = loginCubit.state.loading;

    submitLogin() async {
      FocusScope.of(context).unfocus();
      if(!loginCubit.onSubmit()) return;
      
      loginCubit.loadingChanged();
      await Future.delayed(const Duration(seconds: 3));
      loginCubit.loadingChanged();
      if(context.mounted) Navigator.pushReplacementNamed(context, 'home');
    }

    return Form(
      //key: formKeyLogin,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Usuario', prefixIcon: null, errorMessage: usuario.errorMessage ),
            onChanged: (value) => loginCubit.usuarioChanged(value),
            // validator: (value){
              // String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              // RegExp regExp  = new RegExp(pattern);
    
              // return regExp.hasMatch(value ?? '') ? null : 'El valor ingresado no tiene formato de correo' ;
            //   return (value != null && value.isNotEmpty) ? null : ' Ingresa el usuario ' ;
            // },
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20,),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: null, errorMessage: contrasena.errorMessage ),
            onChanged: (value) => loginCubit.contrasenaChanged(value),
            // validator: (value){
            //   return (value != null && value.length >= 6) ? null : ' La contraseña debe ser de 6 caracteres minimo ' ;
            // },
            onFieldSubmitted: (value) => submitLogin() ,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft),
            child: const Text('Olvidé mi contraseña', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
            onPressed: (){},  
          ),
          const SizedBox(height: 40,),
          CustomMaterialButton(
            text: !loading ? 'Entrar' : 'Ingresando ...', 
            loading: loading,
            onPressed: loading ? null : () => submitLogin(),
          )
        ]
      )
    );
  }
}