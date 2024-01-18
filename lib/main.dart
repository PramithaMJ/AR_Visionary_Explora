import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/screens/main/cart/provider/CartProvider.dart';
import 'package:ar_visionary_explora/screens/main/myhome/firebase_options.dart';
import 'package:ar_visionary_explora/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (errorMsg) {
    print("Error: " + errorMsg.toString());
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Visionary Explora App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0FA965)),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}