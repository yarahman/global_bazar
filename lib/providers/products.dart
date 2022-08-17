import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 'k20',
        storeId: 'yeasin1660',
        deliveryTime: '1 days',
        numberOfReviews: 0,
        countryName: CountryName.usa,
        price: 5.0,
        title: 'nike 6001',
        imageOrVideoUrls: [
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          'https://c.files.bbci.co.uk/44CF/production/_117751671_satan-shoes1.jpg',
          'https://s1.bukalapak.com/img/19707232321/large/JEJE_NIKE_AIRZOO.jpg'
        ],
        categories: [Categories.shoes],
        shortDescription: 'best shoes for ever you see',
        isReadyToShip: true),
    Product(
      id: 'k10',
      countryName: CountryName.china,
      storeId: 'arafat1660',
      deliveryTime: '3 days',
      numberOfReviews: 0,
      price: 20.0,
      title: 'used i phones',
      imageOrVideoUrls: [
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        'https://www.gazelle.com/thehorn/wp-content/uploads/2015/05/Used_Phones2.jpg',
        'https://res.cloudinary.com/jerrick/image/upload/f_jpg,fl_progressive,q_auto,w_1024/60278ce6e5abae001c525d99.png'
      ],
      categories: [Categories.electronics],
      shortDescription: 'used mobile phones for cheapest price',
      isReadyToShip: false,
    ),
  ];

  List<Product> get item {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((itm) {
      return itm.id == id;
    });
  }
}
