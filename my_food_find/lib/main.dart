import 'package:flutter/material.dart';
import 'package:my_food_find/routes.dart';
import 'package:my_food_find/shared/load_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    // TODO
  ], child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _AppState extends State<App> {
  final Future<FirebaseApp> _initializeApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // Wait until initailisation and connection to firebase as completed before starting the app
    return FutureBuilder(
      future: _initializeApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error occured during initialisation!",
              textDirection: TextDirection.ltr);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: ThemeData.dark(),
            routes: appRoutes,
          );
        }
        return const LoadScreen();
      },
    );
  }
}
