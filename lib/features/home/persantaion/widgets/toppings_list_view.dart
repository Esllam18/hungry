import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_assets.dart';
import 'package:hungry/core/utils/responsive_helper.dart';
import 'package:hungry/features/home/persantaion/widgets/food_topping_card.dart';

class ToppingsListView extends StatefulWidget {
  const ToppingsListView({super.key});

  @override
  State<ToppingsListView> createState() => _ToppingsListViewState();
}

class _ToppingsListViewState extends State<ToppingsListView> {
  final List<String> toppings = [
    'Lettuce',
    'Tomato',
    'Cheese',
    'Onions',
    'Pickles',
    'Bacon',
    'Mushroom',
    'Avocado',
  ];

  final Set<int> selectedToppings = {};

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.setHeight(120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: responsive.setWidth(20)),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(12)),
            child: FoodToppingCard(
              width: responsive.setWidth(100),
              height: responsive.setHeight(120),
              heightForWhiteCon: 0.6,
              imageWidth: responsive.setWidth(55),
              imageHeight: responsive.setHeight(46),
              image: AppImages.imageDetailsTest,
              name: toppings[index],
              isSelected: selectedToppings.contains(index),
              onTap: () {
                setState(() {
                  if (selectedToppings.contains(index)) {
                    selectedToppings.remove(index);
                  } else {
                    selectedToppings.add(index);
                  }
                });
              },
            ),
          );
        },
        itemCount: toppings.length,
      ),
    );
  }
}

class SideOptionsListView extends StatefulWidget {
  const SideOptionsListView({super.key});

  @override
  State<SideOptionsListView> createState() => _SideOptionsListViewState();
}

class _SideOptionsListViewState extends State<SideOptionsListView> {
  final List<String> sideOptions = [
    'Fries',
    'Rings',
    'Sticks',
    'Salad',
    'Bread',
    'Coleslaw',
    'Mac',
    'Beans',
  ];

  final Set<int> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SizedBox(
      width: double.infinity,
      height: responsive.setHeight(120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: responsive.setWidth(20)),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(12)),
            child: FoodToppingCard(
              width: responsive.setWidth(100),
              height: responsive.setHeight(120),
              heightForWhiteCon: 0.7,
              imageWidth: responsive.setWidth(65),
              imageHeight: responsive.setHeight(65),
              image: AppImages.imageDetailsTest,
              name: sideOptions[index],
              isSelected: selectedOptions.contains(index),
              onTap: () {
                setState(() {
                  if (selectedOptions.contains(index)) {
                    selectedOptions.remove(index);
                  } else {
                    selectedOptions.add(index);
                  }
                });
              },
            ),
          );
        },
        itemCount: sideOptions.length,
      ),
    );
  }
}
