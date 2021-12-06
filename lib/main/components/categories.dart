import 'package:a_plants_life/data/main_page_categories.dart';

import 'package:flutter/material.dart';

import 'main_page_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScroller extends StatefulWidget {
  @override
  _CategoriesScrollerState createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {
  List<Categorie> generatedCategories = [];
  var username;
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() async {
    List<Categorie> tempGeneratedCategories = [];
    final prefs = await SharedPreferences.getInstance();
    var status = await prefs.getString('status');
    for (var i = 0; i < categories.length; i++) {
      if (status == 'Expert' && categories[i].title == 'My Nursery') {
        continue;
      } else if (status == 'Seller' && categories[i].title == 'Expert') {
        continue;
      } else if (status == 'Customer' && categories[i].title == 'Expert' ||
          status == 'Customer' && categories[i].title == 'My Nursery') {
        continue;
      } else {
        tempGeneratedCategories.add(categories[i]);
      }
    }
    setState(() {
      generatedCategories = tempGeneratedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
            children: List.generate(
          generatedCategories.length,
          (index) => InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(generatedCategories[index].title);
              },
              child: CategoriesBuild(categorie: generatedCategories[index])),
        )),
      ),
    );
  }
}
