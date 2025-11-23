/*

AUTH PAGES - Determines whether to show login or register page

*/

import 'package:flutter/widgets.dart';
import 'package:makepost/features/auth/presentation/pages/login_page.dart';
import 'package:makepost/features/auth/presentation/pages/register_page.dart';

class AuthPages extends StatefulWidget {
  const AuthPages({super.key});

  @override
  State<AuthPages> createState() => _AuthPagesState();
}

class _AuthPagesState extends State<AuthPages> {
  // show login page at first
  bool showLoginPage = true;

  // toogle between pages
  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(tooglePages: tooglePages);
    } else {
      return RegisterPage(tooglePages: tooglePages);
    }
  }
}
