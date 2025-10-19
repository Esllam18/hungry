import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/router/route_names.dart';

import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_state.dart';
import 'package:hungry/features/profil/views/widgets/confirmation_dialog.dart';
import 'package:hungry/features/profil/views/widgets/profil_btn.dart';

class TheTowBtnForProfile extends StatelessWidget {
  final VoidCallback onEditProfile;

  const TheTowBtnForProfile({super.key, required this.onEditProfile});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AuthInitial) {
          // Navigate to login only after successful logout
          CustomSnackBar.show(
            context,
            message: 'Logged out successfully',
            type: SnackBarType.success,
          );
          GoRouter.of(context).pushReplacement(RouteNames.login);
        }
      },
      builder: (context, state) {
        return Container(
          color: AppColors.white,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .1,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onEditProfile,
                  child: ProfileBtn(
                    color: AppColors.primary,
                    onTap: () {},
                    child: ElmentBtnRow(
                      text: 'Edit Profile',
                      color: AppColors.white,
                      icon: Icons.edit_document,
                      iconColor: AppColors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => const LogoutConfirmationDialog(),
                    );
                    if (confirm == true) {
                      context.read<AuthCubit>().logout();
                    }
                  },
                  child: ProfileBtn(
                    color: AppColors.transparent,
                    onTap: () {},
                    child: ElmentBtnRow(
                      text: 'Log out',
                      color: AppColors.primary,
                      icon: Icons.logout,
                      iconColor: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
