import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/main/profile/model/items.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ussd_phone_call_sms/ussd_phone_call_sms.dart';

class CartTile extends StatelessWidget {
  final Items item;
  final Function(Items) onRemove;

  const CartTile({
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(item.itemImage ?? ''),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    item.itemName ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Product Price
                  Text(
                    'LKR ${item.itemPrice ?? "0"}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Product Description
                  Text(
                    item.sellerName ?? '',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 2),
                  // Product Description
                  Text(
                    item.status ?? '',
                    style: const TextStyle(fontSize: 10, color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Phone and Message Icons
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    color: Colors.blue,
                    onPressed: () => _showConfirmationDialog(
                      context,
                      'Make a Call',
                      'Do you want to make a call to ${item.sellerName}?',
                      () => FlutterPhoneDirectCaller.callNumber(
                          item.sellerPhone ?? '1234567890'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: Icon(Icons.message),
                    color: Colors.green,
                    onPressed: () => _showConfirmationDialog(
                      context,
                      'Send Message',
                      'Do you want to send a message to ${item.sellerName}?',
                      () => launch('sms:${item.sellerPhone ?? '1234567890'}'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            // Remove Button
            Container(
              margin: EdgeInsets.only(top: 15),
              child: IconButton(
                icon: Icon(Icons.remove_circle),
                color: Colors.red,
                onPressed: () => onRemove(item),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
