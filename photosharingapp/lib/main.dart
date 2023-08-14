import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosharingapp/screens/sign_in.dart';

void main() {
  runApp(const ProviderScope(child:MyApp() ) );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(useMaterial3: true
      ),
      home:const SignIn(),
    );
  }
}

