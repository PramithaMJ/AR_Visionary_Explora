import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:flutter/material.dart';

class CartAmmountRaw extends StatelessWidget {
  const CartAmmountRaw({
    super.key,
    required this.name,
    required this.ammount,
    this.isTotal = false,
  });

  final String name;
  final String ammount;
  final bool isTotal;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          name,
          fontSize: isTotal ? 16 : 14,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
        ),
        CustomText(
          ammount,
          fontSize: isTotal ? 16 : 14,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
        ),
      ],
    );
  }
}
