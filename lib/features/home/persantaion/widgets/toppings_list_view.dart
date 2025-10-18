// toppings_list_view.dart (fixed path typo, changed to use dynamic toppings/sideOptions from param, updated to take List<ToppingModel>/List<SideOptionModel>, adjusted name/image)
import 'package:flutter/material.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';
import 'package:hungry/features/home/persantaion/widgets/food_topping_card.dart';

class ToppingsListView extends StatelessWidget {
  final List<ToppingModel> toppings;
  final Set<int> selectedToppings;
  final Function(int) onToppingToggle;

  const ToppingsListView({
    super.key,
    required this.toppings,
    required this.selectedToppings,
    required this.onToppingToggle,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.setHeight(120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: responsive.setWidth(20)),
        itemCount: toppings.length,
        itemBuilder: (context, index) {
          final topping = toppings[index];
          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(12)),
            child: FoodToppingCard(
              width: responsive.setWidth(100),
              height: responsive.setHeight(120),
              heightForWhiteCon: 0.6,
              imageWidth: responsive.setWidth(55),
              imageHeight: responsive.setHeight(46),
              image: topping.image ?? '',
              name: topping.name,
              isSelected: selectedToppings.contains(topping.id),
              onTap: () => onToppingToggle(topping.id),
            ),
          );
        },
      ),
    );
  }
}

class SideOptionsListView extends StatelessWidget {
  final List<SideOptionModel> sideOptions;
  final Set<int> selectedSideOptions;
  final Function(int) onSideOptionToggle;

  const SideOptionsListView({
    super.key,
    required this.sideOptions,
    required this.selectedSideOptions,
    required this.onSideOptionToggle,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.setHeight(120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: responsive.setWidth(20)),
        itemCount: sideOptions.length,
        itemBuilder: (context, index) {
          final option = sideOptions[index];
          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(12)),
            child: FoodToppingCard(
              width: responsive.setWidth(100),
              height: responsive.setHeight(120),
              heightForWhiteCon: 0.7,
              imageWidth: responsive.setWidth(65),
              imageHeight: responsive.setHeight(65),
              image: option.image ?? '',
              name: option.name,
              isSelected: selectedSideOptions.contains(option.id),
              onTap: () => onSideOptionToggle(option.id),
            ),
          );
        },
      ),
    );
  }
}
