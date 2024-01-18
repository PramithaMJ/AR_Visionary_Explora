import 'package:ar_visionary_explora/components/common_back_button.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/screens/main/cart/cart.dart';
import 'package:ar_visionary_explora/screens/main/cart/provider/CartProvider.dart';
import 'package:ar_visionary_explora/screens/main/myhome/items.dart';
import 'package:ar_visionary_explora/screens/main/myhome/virtual_ar_view_screen.dart';
import 'package:ar_visionary_explora/screens/main/product_details/widgets/related_item_type.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:ar_visionary_explora/utils/helpers/helpers.dart';
import 'package:ar_visionary_explora/utils/helpers/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  final String index;
  const ProductDetails({super.key, required this.index});

  @override
  State<ProductDetails> createState() => _ProductDetailsState(index: index);
}

class _ProductDetailsState extends State<ProductDetails> {
  final String index;

  _ProductDetailsState({required this.index});

  @override
  void initState() {
    super.initState();
  }

  void showNotification(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
      webPosition: "center",
      webShowClose: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Items itemsInfo = Items.fromJson(snapshot.data!.docs
                .firstWhere((doc) => doc['itemID'] == index)
                .data());

            print(itemsInfo);

            return SafeArea(
              child: SizedBox(
                width: SizeConfig.w(context),
                height: SizeConfig.h(context),
                child: Stack(
                  children: [
                    UpperSection(itemsInfo: itemsInfo),
                    Positioned(
                      top: 440,
                      child: ProductDetailsSection(itemsInfo: itemsInfo),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              text: "Add to Cart",
                              onTap: () {
                                // Show a confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Add to Cart"),
                                      content: const Text(
                                          "Do you want to keep shopping or go to the cart?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                            // Access the CartProvider and add the item to the cart
                                            final cartProvider =
                                                Provider.of<CartProvider>(
                                                    context,
                                                    listen: false);
                                            cartProvider.addToCart(itemsInfo);
                                            showNotification(
                                                'Item added to cart', context);
                                          },
                                          child: const Text("Keep Shopping"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                            // Navigate to the cart screen
                                            final cartProvider =
                                                Provider.of<CartProvider>(
                                                    context,
                                                    listen: false);
                                            cartProvider.addToCart(itemsInfo);
                                            Helpers.navigateToPage(
                                                context, const Cart());
                                          },
                                          child: const Text("Go to Cart"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              text: "Try AR View",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => VirtualARViewScreen(
                                      clickedItemImageLink:
                                          itemsInfo.itemImage.toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ProductDetailsSection extends StatelessWidget {
  final Items? itemsInfo;
  final BuildContext? context;

  ProductDetailsSection({
    this.itemsInfo,
    this.context,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.w(context),
      height: SizeConfig.h(context),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(29, 34, 29, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                itemsInfo?.itemName ?? "default name",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "LKR: ${itemsInfo?.itemPrice ?? "0"}",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Rating Section
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    "4.5", // Replace with the actual rating value
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "  (50 reviews)", // Replace with the actual rating value
                    fontSize: 12,
                    color: Color.fromARGB(255, 218, 210, 210),
                  ),
                ],
              ),
              // const COunterSection(),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText(
            itemsInfo?.itemDescription ??
                "loerieujdshfughdfuygdsufgudsg u sedugfdusgf usdgfuydsgfuy dufguds usdfgfruydsg dfghdsu  sdufg dsuf udsf sufgsdfugds ufdsuf udsf udsfgds dusfgds uufsdg udfgusd fgusdfisd",
            textAlign: TextAlign.justify,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}

class COunterSection extends StatelessWidget {
  const COunterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.ash,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          InkWell(
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 15,
          ),
          CustomText(
            "1",
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class UpperSection extends StatelessWidget {
  final Items? itemsInfo;
  final BuildContext? context;

  UpperSection({
    this.itemsInfo,
    this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: SizeConfig.w(context),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        // color: AppColors.primaryColor,
        image: DecorationImage(
          image: NetworkImage(
              itemsInfo?.itemImage ?? 'https://example.com/default_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: CommonBackButton(),
        ),
      ),
    );
  }
}
