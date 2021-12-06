import 'package:a_plants_life/data/cart.dart';
import 'package:a_plants_life/nurseries/Nurseries-page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

String server_url = "http://134.209.247.54/API/";
//String server_url = "http://192.168.1.11:8000/API/";

class Catgo {
  final String catname;
  final int catid;

  Catgo({
    required this.catname,
    required this.catid,
  });
}

class Order {
  final int id, quantity;
  Order({
    required this.id,
    required this.quantity,
  });
}

class Shop {
  final int id;
  final String avatar, name;
  final double rating;
  final List<Category> categoryList;
  Shop(
      {required this.id,
      required this.avatar,
      required this.name,
      required this.rating,
      required this.categoryList});
}

class Item {
  final int id, categoryId, shopId, quantity;
  final String title, categoryTitle, description, avatar, avatar_2;
  final double price;
  Item({
    required this.id,
    required this.categoryId,
    required this.shopId,
    required this.quantity,
    required this.title,
    required this.categoryTitle,
    required this.description,
    required this.avatar,
    required this.avatar_2,
    required this.price,
  });
}

class Category {
  final int id;
  final String title;
  Category({required this.id, required this.title});
}

class Nurserie {
  final String image, name;
  final int id;
  final double rating;
  final int size = 10;
  Nurserie({
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
  });

  String get name1 {
    return name;
  }
}

List<Nurserie> nurseries = [
  Nurserie(
    id: 1,
    name: "The Garden Shop",
    image: "assets/images/thegradenshop.jpg",
    rating: 4.5,
  ),
  Nurserie(
    id: 2,
    name: "Shop",
    image: "assets/images/nurseries-.png",
    rating: 0,
  ),
  Nurserie(
    id: 3,
    name: "Shop",
    image: "assets/images/nurseries-.png",
    rating: 0,
  )
];

class CartItem {
  final String image, name;
  int id, quantity, shopId;
  final double price;
  double totalPrice;
  CartItem({
    required this.image,
    required this.name,
    required this.id,
    required this.price,
    required this.totalPrice,
    required this.quantity,
    required this.shopId,
  });
  static Map<String, dynamic> toMap(CartItem item) => {
        'shopId': item.shopId,
        'image': item.image,
        'name': item.name,
        'id': item.id,
        'price': item.price,
        'name': item.name,
        'totalPrice': item.totalPrice,
        'quantity': item.quantity,
      };
  factory CartItem.fromJson(Map<String, dynamic> jsonData) {
    return CartItem(
      shopId: jsonData['shopId'],
      image: jsonData['image'],
      id: jsonData['id'],
      name: jsonData['name'],
      price: jsonData['price'],
      totalPrice: jsonData['totalPrice'],
      quantity: jsonData['quantity'],
    );
  }
  static String encode(List<CartItem> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => CartItem.toMap(music))
            .toList(),
      );
  static List<CartItem> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CartItem>((item) => CartItem.fromJson(item))
          .toList();
}

class SelfItem {
  final int id, shop_id, quantity, bill_id;
  final String title, avatar, avatar_2, shop;
  final double price, totalPrice;
  final String date;
  SelfItem({
    required this.id,
    required this.date,
    required this.shop_id,
    required this.quantity,
    required this.bill_id,
    required this.title,
    required this.shop,
    required this.avatar,
    required this.avatar_2,
    required this.price,
    required this.totalPrice,
  });
}

List<CartItem> cartItemList = [];

class CategoryItem {
  final int id;
  final String title;
  CategoryItem({required this.id, required this.title});
}

class SelfItemSeller {
  final int id, shop_id, quantity, bill_id;
  final String title, avatar, avatar_2, shop, categoryTitle, username;
  final double price, totalPrice;
  final String date;
  SelfItemSeller({
    required this.id,
    required this.date,
    required this.shop_id,
    required this.quantity,
    required this.bill_id,
    required this.title,
    required this.shop,
    required this.avatar,
    required this.avatar_2,
    required this.price,
    required this.totalPrice,
    required this.categoryTitle,
    required this.username,
  });
}
