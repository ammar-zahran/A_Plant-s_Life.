import 'package:flutter/material.dart';

class Categorie {
  final String image, title;
  final int id;
  final Color color;
  Categorie({
    required this.id,
    required this.image,
    required this.title,
    required this.color,
  });
}

List<Categorie> categories = [
  Categorie(
    id: 1,
    title: "Nurseries",
    image: "assets/images/nurseries_icon.png",
    color: Color(0xFF094a4c),
  ),
  Categorie(
    id: 2,
    title: "Plant Tracker",
    image: "assets/images/plantracker 221.png",
    color: Color(0xFF83c75f),
  ),
  Categorie(
    id: 3,
    title: "Design Your Garden",
    image: "assets/images/designyourgarden.png",
    color: Color(0xFF094539),
  ),
  Categorie(
    id: 4,
    title: "My Nursery",
    image: "assets/images/nurseries_icon.png",
    color: Color(0xFF2c3b40),
  ),
  Categorie(
    id: 5,
    title: "Expert",
    image: "assets/images/expert.png",
    color: Color(0xFF104e50),
  ),
];
