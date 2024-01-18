import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FadeInLeft(child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const CustomText(
                      "Profile",
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      height: 122,
                    ),
                    InkWell(
                      onTap: () => value.selectImage(context),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: value.isLoading
                              ? const SpinKitWaveSpinner(
                                  color: AppColors.primaryColor,
                                  size: 100,
                                )
                              : Image.network(
                                  value.userModel?.img ?? AppAssets.profileUrl,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                          // : Image.file(
                          //     value.image,
                          //     width: 200,
                          //     height: 200,
                          //   ),
                          ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      value.userModel?.userName ?? "No Name",
                      fontSize: 13,
                      color: AppColors.ash,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      value.userModel?.email ?? "No Email",
                      fontSize: 13,
                      color: AppColors.ash,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                    text: "LogOut",
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logOut();
                    },
                  ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
