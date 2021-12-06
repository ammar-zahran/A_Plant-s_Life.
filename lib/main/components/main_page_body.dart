import 'package:a_plants_life/data/main_page_categories.dart';
import 'package:flutter/material.dart';

class CategoriesBuild extends StatelessWidget {
  final Categorie categorie;

  const CategoriesBuild({
    Key? key,
    required this.categorie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(right: 20),
      height: MediaQuery.of(context).size.height * 0.30 - 50,
      decoration: BoxDecoration(
        color: categorie.color,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Stack(children: <Widget>[
        Align(
          alignment: Alignment(0.8, -0.8),
          child: Image(
            image: AssetImage(categorie.image),
          ),
        ),
        Align(
          alignment: Alignment(-0.8, 0.8),
          child: Text(
            "${categorie.title}",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
