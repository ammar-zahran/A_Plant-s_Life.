import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../../data/Product.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        item.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
