import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/components/app_logo.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:ar_visionary_explora/screens/auth/signup.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const Signup()));
        Provider.of<AuthProvider>(context, listen: false)
            .initializedUser(context);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(
              width: 331,
              height: 331,
            ),
            const SizedBox(
              height: 72,
            ),
            FadeInUp(
              child: const CustomText(
                "Build your own Reality with Us..\nAR Visionary Explora",
                fontSize: 30,
                textAlign: TextAlign.center,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
