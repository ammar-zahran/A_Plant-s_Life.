import 'package:a_plants_life/data/nurseries_data.dart';
import 'package:flutter/material.dart';

class Product {
  String image, imageDetails, title, description;
  int size, id, qunatity;
  double price;
  Color color;

  Product({
    required this.qunatity,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
    required this.imageDetails,
  });
}

List<Product> products = [
  Product(
      qunatity: 1,
      id: 1,
      title: "Azalea",
      price: 1,
      size: 12,
      description:
          'Azaleas are flowering shrubs in the genus Rhododendron, particularly the former sections Tsutsuji and Pentanthera. Azaleas bloom in the spring, their flowers often lasting several weeks. Shade tolerant, they prefer living near or under trees. They are part of the family Ericaceae.',
      image: "assets/images/f9.png",
      imageDetails: "assets/images/123.png",
      color: Color(0xFFCEE4B8)),
  Product(
      qunatity: 1,
      id: 2,
      title: "Chrisanthimum",
      price: 2,
      size: 8,
      description:
          'Chrysanthemums, sometimes called mumingtons or chrysanths, are flowering plants of the genus Chrysanthemum in the family Asteraceae. They are native to East Asia and northeastern Europe. Most species originate from East Asia and the center of diversity is in China',
      image: "assets/images/f11.png",
      imageDetails: "assets/images/f10.png",
      color: Color(0xFF63CBFF)),
  Product(
      qunatity: 1,
      id: 3,
      title: "Kalanchoe",
      price: 1,
      size: 15,
      description:
          'Kalanchoe KAL-ən-KOH-ee, also written Kalanchöe or Kalanchoë, is a genus of about 125 species of tropical, succulent flowering plants in the family Crassulaceae, mainly native to Madagascar and tropical Africa.',
      image: "assets/images/f13.png",
      imageDetails: "assets/images/f12.png",
      color: Color(0xFFEB5056)),
  Product(
      qunatity: 1,
      id: 4,
      title: "Apple",
      price: 1,
      size: 12,
      description:
          'Azaleas are flowering shrubs in the genus Rhododendron, particularly the former sections Tsutsuji and Pentanthera. Azaleas bloom in the spring, their flowers often lasting several weeks. Shade tolerant, they prefer living near or under trees. They are part of the family Ericaceae.',
      image: "assets/images/f6.png",
      imageDetails: "assets/images/123.png",
      color: Color(0xFF08AE66)),
  Product(
      qunatity: 1,
      id: 5,
      title: "Apple",
      price: 1,
      size: 12,
      description:
          'Azaleas are flowering shrubs in the genus Rhododendron, particularly the former sections Tsutsuji and Pentanthera. Azaleas bloom in the spring, their flowers often lasting several weeks. Shade tolerant, they prefer living near or under trees. They are part of the family Ericaceae.',
      image: "assets/images/f6.png",
      imageDetails: "assets/images/123.png",
      color: Color(0xFF08AE66)),
  Product(
      qunatity: 1,
      id: 6,
      title: "Apple",
      price: 1,
      size: 12,
      description:
          'Azaleas are flowering shrubs in the genus Rhododendron, particularly the former sections Tsutsuji and Pentanthera. Azaleas bloom in the spring, their flowers often lasting several weeks. Shade tolerant, they prefer living near or under trees. They are part of the family Ericaceae.',
      image: "assets/images/f6.png",
      imageDetails: "assets/images/123.png",
      color: Color(0xFF08AE66)),
];

List colors = [
  Colors.redAccent,
  Colors.greenAccent,
  Colors.cyanAccent,
  Colors.orangeAccent,
  Colors.purpleAccent,
  Colors.blueAccent
];
