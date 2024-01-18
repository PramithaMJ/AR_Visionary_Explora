import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/screens/main/cart/cart.dart';
import 'package:ar_visionary_explora/screens/main/myhome/items.dart';
import 'package:ar_visionary_explora/screens/main/product_details/product_details.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:ar_visionary_explora/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          margin:
              const EdgeInsets.only(top: 20), // Adjust the top margin as needed
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppAssets.menuIcon),
                  InkWell(
                    onTap: () {
                      Helpers.navigateToPage(context, const Cart());
                    },
                    child: SvgPicture.asset(
                      AppAssets.cartIcon,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "Furniture",
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              // PRODUCT GRID
              ProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var products = snapshot.data!;
            return FadeInLeft(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 44,
                ),
                itemCount: products.docs.length,
                itemBuilder: (context, index) {
                  Items eachItemInfo = Items.fromJson(
                      products.docs[index].data() as Map<String, dynamic>);
                  return ProductTile(
                    itemsInfo: eachItemInfo,
                    context: context,
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            // Use a custom loading indicator
            return const Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor, // Choose your desired color
                size: 100.0, // Choose your desired size
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Items? itemsInfo;
  final BuildContext? context;

  ProductTile({
    this.itemsInfo,
    this.context,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Helpers.navigateToPage(context,
            ProductDetails(index: itemsInfo?.itemID ?? "1704364391579"));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 218, 236, 232),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  itemsInfo?.itemImage ??
                      'https://example.com/default_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              itemsInfo?.itemName ?? "default name",
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        'LKR: ${itemsInfo?.itemPrice ?? "0"}',
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        itemsInfo?.sellerName ?? "0",
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          CustomText(
                            itemsInfo?.status ?? "0",
                            fontSize: 10,
                            color: Color.fromARGB(255, 85, 168, 53),
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(width: 26),
                          DiscountTag(value: '15%'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscountTag extends StatelessWidget {
  final String value;

  DiscountTag({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red, // Customize the color of the discount tag
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        '$value OFF',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
