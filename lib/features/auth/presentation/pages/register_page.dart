/*

REGISTER PAGE UI

-------------------------------------------------------

on this page user can enter email and password to create
a new account and once authenticated they are directed to 
home page 

-------------------------------------------------------

if user have account send to register page 

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makepost/features/auth/presentation/components/button.dart';
import 'package:makepost/features/auth/presentation/components/custom_text_field.dart';
import 'package:makepost/features/auth/presentation/cubits/auth_cubits.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? tooglePages;
  const RegisterPage({super.key, required this.tooglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();

  void registerButtonPressed() {
    // data
    final name = nameController.text;
    final email = emailController.text;
    final pass = passController.text;
    final confirmPass = confirmPassController.text;

    // auth cubits
    final authCubits = context.read<AuthCubits>();

    // checks
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        pass.isNotEmpty &&
        confirmPass.isNotEmpty) {
      print(pass.length);
      if (pass.length >= 6 && confirmPass.length >= 6) {
        if (pass == confirmPass) {
          authCubits.register(name, email, pass);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Confirm Password and password didn't match"),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password must be at least 6 character long"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
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

              // name , email and password text field
              CustomTextField(
                controller: nameController,
                hintText: "name",
                isObscure: false,
              ),
              const SizedBox(height: 10),
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
              CustomTextField(
                controller: confirmPassController,
                hintText: "Confirm Password",
                isObscure: true,
              ),
              const SizedBox(height: 25),

              // login button
              Button(onTap: registerButtonPressed, text: "Register"),

              // oauth sign in (google)
              // don't have a account register
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.tooglePages,
                    child: Text(
                      "              Login now",
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
