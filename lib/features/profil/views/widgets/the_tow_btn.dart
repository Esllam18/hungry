import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/features/profil/views/widgets/profil_btn.dart';

class TheTowBtnForProfile extends StatelessWidget {
  const TheTowBtnForProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileBtn(
              color: AppColors.primary,
              child: ElmentBtnRow(
                text: 'Edit Profile',
                color: AppColors.white,
                icon: Icons.edit_document,
                iconColor: AppColors.white,
              ),
            ),
            ProfileBtn(
              color: AppColors.transparent,
              child: ElmentBtnRow(
                text: 'Log out',
                color: AppColors.primary,
                icon: Icons.logout,
                iconColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
