import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_food_find/controller/auth.dart';
import 'package:my_food_find/shared/load_screen.dart';
import 'package:my_food_find/view/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Initial screen for the user, determines if the user is logged in. Steam is used to navigate them to either screen.
// If they are logged in, navigate them to the messages screen, otherwise navigate them to the login screen
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadScreen();
        } else if (snapshot.hasError) {
          return const Center(
              child: Text("Error Occured", textDirection: TextDirection.ltr));
        } else if (snapshot.hasData) {
          // TODO navigate to main screen
          return const Login();
        } else {
          return const Login();
        }
      },
    );
  }
}
