import 'dart:ui';

import 'package:flutter/material.dart';

String uri = 'http://192.168.100.106:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 45, 195, 137);

  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://www.landmarkgroup.com/qa/sites/default/files/Brand-logo/New%20Max%20Logo-%20Eng%20With%20Outline_1.png',
    'https://www.bmainternationalgroup.com/img/brands/redtag/redtag-logo.png',
    'https://iconape.com/wp-content/png_logo_vector/centerpoint-logo.png',
    'https://logos-world.net/wp-content/uploads/2020/12/Bershka-Logo.png',
    'https://th.bing.com/th/id/R.ee53006419454924f1bd5b4fc04efb83?rik=Uo3tOQmA%2b2duoA&riu=http%3a%2f%2fwww.franchisemart.in%2ffranchise%2fwp-content%2fuploads%2f2012%2f09%2fsplash-logo.jpg&ehk=zZtH2qf0N%2fMoMS%2f5IEvF6CG%2bLVQ58FfNIcROTFSgZ14%3d&risl=&pid=ImgRaw&r=0',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'MAX',
      'image': 'images/appliances.jpeg',
    },
    {
      'title': 'Center Point',
      'image': 'images/p.jpg',
    },
    {
      'title': 'Splash',
      'image': 'images/s.jpg',
    },
    {
      'title': 'Bershka',
      'image': 'images/j.jpg',
    },
    {
      'title': 'Red Tag',
      'image': 'images/redtag.png',
    },
  ];
}
