import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width = 202,
    this.height = 138,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      // child: SvgPicture.asset(
      //  AppAssets.logo,
      //  width: 202,
      //  height: 138,
      //  fit: BoxFit.fill,
      // ),

      child: Image.asset(
        AppAssets.logo,
        width: 200,
        height: 190,
        fit: BoxFit.fill,
      ),
    );
  }
}
