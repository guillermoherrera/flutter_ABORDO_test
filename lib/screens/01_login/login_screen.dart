import 'package:flutter/material.dart';
import 'package:flutter_application_2/helpers/helpers.dart';
import '../../ui/ui_files.dart';
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
            const SizedBox(height: 120,),
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Aún no tengo contraseña. ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
                CustomTextButton(onPressed: ()=>Navigator.pushNamed(context, 'activar'), text: 'Activar cuenta'),
              ],
            ),
            const SizedBox(height: 50),
          ],),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Image(image: const AssetImage('assets/BANNER_INICIAL.jpg'), width: size.width * 1),
            MaterialButton(
              minWidth: size.width * 1,
              disabledColor: ColorPalette.colorTerciarioMedio,
              elevation: 0,
              color: ColorPalette.colorSecundario,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: const Text('Términos y Aviso Legal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),), 
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
          const Text('Hola !', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
          const SizedBox(height: 10),
          const Text('Iniciar Sesión', textAlign: TextAlign.center,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: ColorPalette.colorBlanco),),
          const SizedBox(height: 50),
          TextFormField(
            enabled: !loading,
            style: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold),
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
            style: const TextStyle(color: ColorPalette.colorPrincipalMedio, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            autocorrect: false,
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: null, suffixIconOnPressed: chanceObscureText, visibility: obscureText ),
            //onChanged: (value) => loginCubit.contrasenaChanged(value),
            validator: (value) => FormValidators.lengthValidator(value, 6),
            onFieldSubmitted: (value) => submitLogin() ,
          ),
          CustomTextButton(onPressed: ()=>Navigator.pushNamed(context, 'contrasena'), text: 'Olvidé mi contraseña'),
          const SizedBox(height: 20,),
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