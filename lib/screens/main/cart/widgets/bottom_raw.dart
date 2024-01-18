import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/screens/main/cart/provider/CartProvider.dart';
import 'package:ar_visionary_explora/screens/main/cart/widgets/cart_amount.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BottomRaw extends StatelessWidget {
  final CartProvider cartProvider;

  const BottomRaw({
    super.key,
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the total price dynamically
    double totalPrice = cartProvider.calculateTotalPrice();
    // Hypothetical discount and tax amounts
    double discount = cartProvider.getDiscount();
    double tax = cartProvider.getTax();

    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 40),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 8,
          ),
          // Use the calculated total price
          CartAmmountRaw(
            name: "Product Price",
            ammount: "LKR. ${cartProvider.calculateProductPrice()}",
          ),
          const SizedBox(
            height: 8,
          ),
          // Use hypothetical discount
          CartAmmountRaw(
            name: "Discount",
            ammount: "LKR. ${discount.toString()}",
          ),
          const SizedBox(
            height: 8,
          ),
          // Use hypothetical tax
          CartAmmountRaw(
            name: "Tax",
            ammount: "LKR. ${tax.toString()}",
          ),
          const SizedBox(
            height: 8,
          ),
          // Use the calculated total price, discount, and tax for the total amount
          CartAmmountRaw(
            name: "Total Price",
            ammount: "LKR. ${cartProvider.calculateTotalPrice()}",
            isTotal: true,
          ),
          CustomButton(
            text: "Place Order",
            onTap: () {
              // Place order logic
            },
          ),
        ],
      ),
    );
  }
}
