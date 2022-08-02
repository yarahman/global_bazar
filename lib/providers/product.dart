import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    required this.id,
    required this.storeId,
    required this.title,
    required this.shortDescription,
    required this.numberOfReviews,
    required this.price,
    required this.deliveryTime,
    required this.categories,
    required this.isReadyToShip,
    this.imageOrVideoUrls,
    this.couponCode,
    this.isFavourite,
  });
  String? id;
  String? storeId;
  List<String>? imageOrVideoUrls;
  String? title;
  String? shortDescription;
  int? numberOfReviews;
  double? price;
  Categories? categories;
  bool? isReadyToShip;
  String? couponCode;
  String? deliveryTime;
  bool? isFavourite;
}

enum Categories {
  homeOrKitchen,
  beautyOrPersonalCare,
  toysOrGames,
  cloth,
  shoes,
  jewelry,
  healthOrBabyCare,
  sports,
  books,
  electronics,
}
