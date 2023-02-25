import 'package:flutter/material.dart';
import 'package:flutter_grupo4/services/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../providers/register_form_provider.dart';
import '../ui/input_decorations.dart';
import '../widgets/auth_background.dart';
import '../widgets/card_container.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Register',
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 20),
                  ChangeNotifierProvider(
                    create: (_) => RegisterFormProvider(),
                    child: const _RegisterForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text(
                'Do you have an account',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      )),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  // ignore: unused_element
  const _RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return SizedBox(
      child: Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecorations.authInputDecoration(
                    hinText: 'Pepito',
                    labelText: 'UserName',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => registerForm.username = value,
                validator: (value) {
                  return (value != null && value.length >= 3)
                      ? null
                      : 'User name must have more than 6 characters';
                }),
            TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorations.authInputDecoration(
                    hinText: '*******',
                    labelText: 'Password',
                    prefixIcon: Icons.lock_open),
                onChanged: (value) => registerForm.password = value,
                validator: (value) {
                  String pattern = r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Password must have atleast one Capital Letter, Small Letters, Numbers & a special character ';
                }),
            const SizedBox(height: 5),
            TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorations.authInputDecoration(
                    hinText: '*******',
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock),
                onChanged: (value) => registerForm.c_password = value,
                validator: (value) {
                  return (value != null && value == registerForm.password)
                      ? null
                      : 'The password and the c_pasword must be the same';
                }),
            const SizedBox(height: 5),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey[600],
              onPressed: registerForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final registerService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!registerForm.isValidForm()) return;
                      final String? errorMessage =
                          await registerService.register(
                        registerForm.username,
                        registerForm.password,
                      );
                      if (errorMessage != null) {
                        // ignore: use_build_context_synchronously
                        customToast(errorMessage, context);
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamed('login');
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  registerForm.isLoading ? 'Wait' : 'Submit',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void customToast(String message, BuildContext context) {
    showToast(
      message,
      textStyle: const TextStyle(
        fontSize: 14,
        wordSpacing: 0.1,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textPadding: const EdgeInsets.all(23),
      fullWidth: true,
      toastHorizontalMargin: 25,
      borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.blueGrey[500],
      alignment: Alignment.topCenter,
      position: StyledToastPosition.bottom,
      duration: const Duration(seconds: 3),
      animation: StyledToastAnimation.slideFromBottom,
      context: context,
    );
  }
}
