import 'package:ar_visionary_explora/main/cart/provider/CartProvider.dart';
import 'package:ar_visionary_explora/main/cart/widgets/cart_amount.dart';
import 'package:ar_visionary_explora/utils/helpers/alert_helpers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';

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
      height: 270,
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
          const SizedBox(
            height: 12,
          ),
          CustomButton(
            text: "Place Order",
            onTap: () {
              // Show invoice dialog
              _showInvoiceDialog(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _showInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildInvoiceDialogContent(context),
        );
      },
    );
  }

  Widget _buildInvoiceDialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color here
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invoice header with app name, credentials, dummy QR, etc.
            const Text(
              'AR Visionary Explora',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Build your own reality with us ...',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),

            // Table of ordered items with their details
            _buildOrderedItemsTable(),

            // Calculated total price, discount, tax, and related information
            const SizedBox(height: 16),
            Text(
              'Total Price: LKR. ${cartProvider.calculateTotalPrice()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Discount: LKR. ${cartProvider.getDiscount().toString()}'),
            Text('Tax: LKR. ${cartProvider.getTax().toString()}'),
            const SizedBox(height: 16),

            // Close button or any other actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    AlertHelpers.showAlert(context, "Order Placed Successfully",
                        type: DialogType.success);
                    // Navigator.pop(context);
                    // Close the dialog
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Close the dialog
                  },
                  child: const Text(
                    'Discard',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderedItemsTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          children: [
            _buildTableCell('ID', textColor: Colors.white),
            _buildTableCell('Product', textColor: Colors.white),
            _buildTableCell('Price', textColor: Colors.white),
          ],
        ),
        for (var item in cartProvider.cartItems)
          TableRow(
            children: [
              _buildTableCell(item.itemID.toString()),
              _buildTableCell(item.itemName.toString()),
              _buildTableCell('LKR. ${item.itemPrice.toString()}'),
            ],
          ),
      ],
    );
  }

  Widget _buildTableCell(String text, {Color textColor = Colors.black}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
