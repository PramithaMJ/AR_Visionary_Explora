import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/main/home/screeen/home.dart';
import 'package:ar_visionary_explora/main/profile/model/items.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
