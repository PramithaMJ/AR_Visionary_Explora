import 'package:ar_visionary_explora/screens/main/myhome/item_details_screen.dart';
import 'package:ar_visionary_explora/screens/main/myhome/items.dart';
import 'package:flutter/material.dart';

class ItemUIDesignWidget extends StatefulWidget {
  final Items? itemsInfo;
  final BuildContext? context;

  ItemUIDesignWidget({
    this.itemsInfo,
    this.context,
  });

  @override
  State<ItemUIDesignWidget> createState() => _ItemUIDesignWidgetState();
}

class _ItemUIDesignWidgetState extends State<ItemUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    // Safe parsing of item price
    double? itemPrice = widget.itemsInfo?.itemPrice != null
        ? double.tryParse(widget.itemsInfo!.itemPrice!)
        : null;

    // Calculate the new price if itemPrice is valid
    double? newPrice =
        itemPrice != null ? itemPrice / 2 : null; // Assuming a 50% discount

    return InkWell(
      onTap: () {
        // send user to the item detail screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemDetailsScreen(
                      clickedItemInfo: widget.itemsInfo,
                    )));
      },
      splashColor: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 190,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Image.network(
                widget.itemsInfo?.itemImage ?? '',
                width: 140,
                height: 140,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              const SizedBox(
                width: 4.0,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  //item name
                  Expanded(
                    child: Text(
                      widget.itemsInfo?.itemName ?? 'No Name',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  //seller name
                  Expanded(
                    child: Text(
                      widget.itemsInfo?.sellerName ?? 'No Seller',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Price section
                  if (itemPrice != null && newPrice != null) ...[
                    Row(
                      children: [
                        // 50% OFF badge
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.pink,
                          ),
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 44,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "50%",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "OFF",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Original and new price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Original price
                            Row(
                              children: [
                                const Text(
                                  "Original Price: LKR ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  itemPrice.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            // New price
                            Row(
                              children: [
                                const Text(
                                  "New Price: LKR ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  newPrice.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  const Divider(
                    height: 4,
                    color: Colors.white70,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
