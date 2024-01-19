import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/custom_textfield.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/main/profile/screen/profile_update_form.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
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
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Center(
        child: FadeInLeft(
          child: Consumer<AuthProvider>(
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
                        height: 50,
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
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        value.userModel?.userName ?? "No Name",
                        fontSize: 13,
                        color: AppColors.ash,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        value.userModel?.email ?? "No Email",
                        fontSize: 13,
                        color: AppColors.ash,
                      ),
                    ],
                  ),
                  ProfileUpdateForm(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: CustomButton(
                      text: "LogOut",
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logOut();
                      },
                    ),
                  ),
                  //const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
