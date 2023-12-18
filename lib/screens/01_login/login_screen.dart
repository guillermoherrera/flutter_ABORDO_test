import 'package:flutter/material.dart';
import 'package:flutter_application_2/helpers/form_validators.dart';
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
            const CardContainer(
              child: Column(
                children: [
                  // const SizedBox(height: 10),
                  // Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                  // const SizedBox(height: 30),
                  _LoginForm()
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
              child: const Text('Activar cuenta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.underline, decorationColor: Colors.white),),
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

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  @override
  Widget build(BuildContext context) {

    //final loginCubit = context.watch<LoginCubit>();
    // final usuario = loginCubit.state.usuario;
    // final contrasena = loginCubit.state.contrasena;

    submitLogin() async {
      FocusScope.of(context).unfocus();
      if(!formKey.currentState!.validate()) return;
      
      //loginCubit.loadingChanged();
      setState(() {
        loading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      //loginCubit.loadingChanged();
      setState(() {
        loading = false;
      });
      if(context.mounted) Navigator.pushReplacementNamed(context, 'home');
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Usuario', prefixIcon: null ),
            //onChanged: (value) => loginCubit.usuarioChanged(value),
            validator: (value){
              String? val;
              val = FormValidators.existValidator(value);
              val ??= FormValidators.emailValidator(value);
              return val;
            },
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20,),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: null ),
            //onChanged: (value) => loginCubit.contrasenaChanged(value),
            validator: (value) => FormValidators.lengthValidator(value, 6),
            onFieldSubmitted: (value) => submitLogin() ,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft),
            child: const Text('Olvidé mi contraseña', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.underline, decorationColor: Colors.white)),
            onPressed: ()=>Navigator.pushNamed(context, 'contrasena'),  
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