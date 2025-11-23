/*

STARTING POINT OF THE APP 
----------------------------------------------------

Initialized firebase for current platform

----------------------------------------------------

Wrap the entire app with MultiBlocProvider
  provide providers to the blocProvider
  run checkIsAuthenticated()

----------------------------------------------------
Wrap the app inside a BlocConsumer and handle different States

*/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makepost/features/Home/presentation/pages/home_page.dart';
import 'package:makepost/features/auth/data/firebase_auth_repo.dart';
import 'package:makepost/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:makepost/features/auth/presentation/cubits/auth_states.dart';
import 'package:makepost/features/auth/presentation/pages/auth_pages.dart';
import 'package:makepost/firebase_options.dart';
import 'package:makepost/theme/dark_mode.dart';
import 'package:makepost/theme/light_mode.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // run app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // provide cubits to the app
      providers: [
        BlocProvider<AuthCubits>(
          create: (context) =>
              AuthCubits(authRepo: firebaseAuthRepo)..checkIsAuthenticated(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,

        /*

          BLOC CONSUMER - AUTH

        */
        home: Scaffold(
          body: BlocConsumer<AuthCubits, AuthStates>(
            builder: (context, state) {
              if (state is UnAuthenticated) {
                return const AuthPages();
              } else if (state is Authenticated) {
                return const HomePage();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Error occurred!")));
              }
            },
          ),
        ),
      ),
    );
  }
}
