import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/payments/custom_visa_field.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_snackbar.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_state.dart';
import 'package:hungry/features/checkout/widgets/payment_method_card.dart';
import 'package:hungry/features/profil/views/widgets/profile_loading.dart';
import 'package:hungry/features/profil/views/widgets/proflie_form.dart'
    hide AppColors;

import 'package:hungry/features/profil/views/widgets/the_tow_btn.dart';
import 'package:hungry/features/profil/views/widgets/user_profile_image.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _visaController = TextEditingController();
  bool selectedPayment = true;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Trigger fetch current user
    context.read<AuthCubit>().getCurrentUser();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().updateUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _adressController.text.trim(),
        visa: _visaController.text.trim(),
        phone: '',
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _adressController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, responsive.setHeight(100)),
            child: ProfileAppBar(),
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              }
            },

            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(child: ProfileLoading(responsive: responsive));
              }

              final user = (state is AuthSuccess) ? state.user : null;
              if (state is AuthSuccess) {
                // Update controllers only if not already set
                if (_nameController.text.isEmpty && user != null) {
                  _nameController.text = user.name;
                  _emailController.text = user.email;
                  _adressController.text = user.address ?? '';
                  _visaController.text = user.visa ?? '';
                }
              }
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Gap(20.h),

                          // Replace the UserProfileImage widget call in profil_view.dart with this:
                          UserProfileImage(
                            imageUrl: (state is AuthSuccess)
                                ? state.user.image
                                : null,
                          ),
                          Gap(15.h),
                          Text(
                            (state is AuthSuccess)
                                ? state.user.name
                                : 'Guest User',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Gap(5.h),
                          VerifiledAccount(),
                          Gap(20.h),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ProfileForm(
                                formKey: _formKey,
                                addressController: _adressController,
                                nameController: _nameController,
                                emailController: _emailController,
                              ),
                            ),
                          ),
                          Gap(20.h),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(22),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: 0.9 + (0.1 * value),
                                    child: Opacity(
                                      opacity: value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: (user != null && user.visa != null)
                                    ? PaymentMethodCardProfile(
                                        code: user.visa!,
                                        responsive: responsive,
                                        selectedPayment: selectedPayment,
                                      )
                                    : ProfessionalVisaField(
                                        controller: _visaController,
                                      ),
                              ),
                            ),
                          ),
                          Gap(100.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: TheTowBtnForProfile(
            onEditProfile: () {
              if (_formKey.currentState!.validate()) {
                _updateProfile();
              }
            },
          ),
        ),
      ),
    );
  }
}

class PaymentMethodCardProfile extends StatelessWidget {
  const PaymentMethodCardProfile({
    super.key,
    required this.responsive,
    required this.selectedPayment,
    required this.code,
  });

  final Responsive responsive;
  final bool selectedPayment;
  final String code;

  @override
  Widget build(BuildContext context) {
    return PaymentMethodCard(
      isProfile: true,
      responsive: responsive,
      title: 'Debit card',
      subtitle: code,

      isSelected: selectedPayment,
      textColor: AppColors.black,
      backgroundColor: Colors.white,
      icon: Container(
        width: responsive.setWidth(60),
        height: responsive.setHeight(35),
        padding: EdgeInsets.all(responsive.setWidth(8)),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(responsive.setWidth(8)),
        ),
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                'VISA',
                style: TextStyle(
                  color: const Color(0xFF1A1F71),
                  fontSize: responsive.setFont(18),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VerifiledAccount extends StatelessWidget {
  const VerifiledAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // ignore: deprecated_member_use
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified, color: AppColors.primary, size: 16.sp),
            Gap(5.w),
            Text(
              'Verified Account',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 10,
      automaticallyImplyLeading: false,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 8, bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(Icons.settings, color: AppColors.primary, size: 20.sp),
        ),
      ],
    );
  }
}
