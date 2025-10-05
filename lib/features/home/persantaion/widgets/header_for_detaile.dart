import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/core/widgets/custom_text.dart';
import 'package:hungry/features/home/persantaion/widgets/custom_slider.dart';

class CustomIzeOfDetaile extends StatelessWidget {
  const CustomIzeOfDetaile({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: 'food_0',
            child: Image.asset(
              AppImages.imageDetailsTest,
              width: responsive.setWidth(150),
              height: responsive.setHeight(220),
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(width: responsive.setWidth(12)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: responsive.setHeight(50)),
              Padding(
                padding: EdgeInsets.only(left: responsive.setWidth(10)),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Customize ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: responsive.setFont(16),
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Your Burger \nto Your Tastes. Ultimate\nExperience',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: responsive.setFont(14),
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: responsive.setHeight(12)),
              CustomSlider(
                min: 0,
                max: 10,
                divisions: 10,
                initialValue: 5,
                activeColor: AppColors.primary,
                inactiveColor: Colors.grey.shade400,
                onChanged: (val) {
                  debugPrint("Slider value: $val");
                },
              ),
              SizedBox(height: responsive.setHeight(8)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.setWidth(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: '🥶',
                      fontSize: responsive.setFont(16),
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(txt: '🌶️', fontSize: responsive.setFont(18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
