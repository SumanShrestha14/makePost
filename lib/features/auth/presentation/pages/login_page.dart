/*

LOGIN PAGE UI

-------------------------------------------------------

on this page user can enter email and password to login
and once authenticated they are directed to home page 

-------------------------------------------------------

if user don't have account send to register page 

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makepost/features/auth/presentation/components/button.dart';
import 'package:makepost/features/auth/presentation/components/custom_text_field.dart';
import 'package:makepost/features/auth/presentation/cubits/auth_cubits.dart';

class LoginPage extends StatefulWidget {
  final void Function()? tooglePages;
  const LoginPage({super.key, required this.tooglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  void loginButtonPressed() {
    final String email = emailController.text;
    final String pass = passController.text;
    final authCubits = context.read<AuthCubits>();

    if (email.isNotEmpty && pass.isNotEmpty) {
      authCubits.login(email, pass);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      // appBar: AppBar(
      //   title: Center(
      //     child: Text(
      //       "Login",
      //       style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
      //     ),
      //   ),
      //   leading: Icon(Icons.menu),
      // ),

      // BODY
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.pages_outlined,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 25),
              // name of app
              Text(
                "M A K E   P O S T",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // email and password text field
              CustomTextField(
                controller: emailController,
                hintText: "Email",
                isObscure: false,
              ),
              const SizedBox(height: 10),

              CustomTextField(
                controller: passController,
                hintText: "Password",
                isObscure: true,
              ),
              const SizedBox(height: 10),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // login button
              Button(onTap: loginButtonPressed, text: "Login"),

              // oauth sign in (google)
              // don't have a account register
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.tooglePages,
                    child: Text(
                      "              Register now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
