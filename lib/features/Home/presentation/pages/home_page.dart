import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makepost/features/auth/presentation/cubits/auth_cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        actions: [
          // logout button
          IconButton(
            onPressed: () {
              final authCubits = context.read<AuthCubits>();
              authCubits.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
