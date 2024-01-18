import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';


class BottomNavTile extends StatelessWidget {
  const BottomNavTile({
    Key? key,
    required this.isActive,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final bool isActive;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onTap();
      },
      icon: Icon(
        icon,
        size: 38,
        color: isActive ? AppColors.primaryColor : AppColors.ash,
      ),
    );
  }
}
