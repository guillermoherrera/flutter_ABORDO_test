import 'package:flutter/material.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import 'package:flutter_application_2/ui/input_decorations.dart';
import 'package:flutter_application_2/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 150,),
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
              child: const Text.rich(
                TextSpan(
                  text: 'Aún no tengo contraseña. ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'Activar cuenta',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                  ],
                ),
              ),
              onPressed: ()=>Navigator.pushNamed(context, 'activar')),
            const SizedBox(height: 50),
          ],),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        width: double.infinity,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Image(image: const AssetImage('assets/BANNER_INICIAL.jpg'), width: size.width * 1),
            MaterialButton(
              minWidth: size.width * 1,
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
          ],
        ),
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
  bool obscureText = true;
  
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

    chanceObscureText() => setState(()=>obscureText = !obscureText);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text('Hola !', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 10),
          const Text('Iniciar Sesión', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
          const SizedBox(height: 50),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Color.fromRGBO(4, 68, 155, 1), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Nº Empleado', prefixIcon: null, iconField: Icons.numbers ),
            //onChanged: (value) => loginCubit.usuarioChanged(value),
            keyboardType: TextInputType.number,
            validator: (value){
              String? val;
              val = FormValidators.existValidator(value);
              //val ??= FormValidators.emailValidator(value);
              return val;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: Color.fromRGBO(4, 68, 155, 1), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            autocorrect: false,
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: null, suffixIconOnPressed: chanceObscureText, visibility: obscureText ),
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