import 'package:flutter/material.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/features/home/persantaion/widgets/home_header.dart';

class HomeHeaderSection extends StatelessWidget {
  final Responsive responsive;

  const HomeHeaderSection({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(responsive.setWidth(20)),
        child: const HomeHeader(),
      ),
    );
  }
}
