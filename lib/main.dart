import 'package:ar_visionary_explora/main/cart/provider/CartProvider.dart';
import 'package:ar_visionary_explora/main/myhome/firebase_options.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/providers/theme_provider.dart';
import 'package:ar_visionary_explora/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

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
        ChangeNotifierProvider(create: (context) => ThemeModeProvider()),
      ],
      child: const StartWidget(),
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

class StartWidget extends StatelessWidget {
  const StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: Duration(seconds: 3),
      builder: Builder(builder: (context) => MyApp()),
    );
  }
}
