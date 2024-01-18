import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({
    super.key,
    this.color = Colors.black
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}
