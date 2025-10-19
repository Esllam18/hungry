import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_state.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    context.read<AuthCubit>().getCurrentUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
        if (state is AuthSuccess) {
          CustomSnackBar.show(
            context,
            message: 'User loaded successfully',
            type: SnackBarType.success,
          );
        }

        if (state is AuthLoading) {
          Center(child: CircularProgressIndicator());
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppImages.logo,
                  // ignore: deprecated_member_use
                  color: AppColors.primary,
                  width: responsive.setWidth(170),
                  height: responsive.setHeight(37),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(responsive.setWidth(30)),
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: responsive.setWidth(30),
                    backgroundImage:
                        (state is AuthSuccess && state.user.image != null)
                        ? NetworkImage(state.user.image!)
                        : NetworkImage(
                            'https://www.gravatar.com/avatar/000000000000000000000000000000?d=mp&f=y',
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.setHeight(8)),
            CustomText(
              txt:
                  'Hello, ${(state is AuthSuccess) ? state.user.name : 'Guest'}',
              fontSize: responsive.setFont(18),
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ],
        );
      },
    );
  }
}
