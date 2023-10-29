import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'menuitem_model.dart';

class HotelModel extends Equatable {
  final int id;
  final String thumbnailPath;
  final String title;
  final String location;
  final List<String> tags;
  final List<MenuItem> menuList;
  final String address;
  final String description;
  final List<String> imagePaths;
  final int totalReview;
  final double ratingScore;
  final LatLng coordinate;
  @override
  List<Object?> get props => [
        id,
        thumbnailPath,
        title,
        location,
        tags,
        address,
        imagePaths,
        totalReview,
        ratingScore,
        coordinate
      ];

  const HotelModel(
      {required this.id,
      required this.title,
      required this.location,
      required this.description,
      required this.address,
      required this.thumbnailPath,
      required this.imagePaths,
      this.totalReview = 0,
      this.ratingScore = 0,
      required this.tags,
      required this.menuList,
      required this.coordinate});

  static List<HotelModel> sampleHotels = [
    HotelModel(
      id: 1,
      //routeid:,
      thumbnailPath: 'assets/image/img 1.jpg',
      title: 'D`Omah Hotel Yogya',
      location: 'Bantul Regency, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari)',
      ratingScore: 4.25,
      coordinate: LatLng(-7.8712168283326625, 110.353484068852),
      tags: ['pizza', 'rice', 'vegetables'],
      menuList: MenuItem.menu.where((dish) => dish.restaurantId == 1).toList(),
      imagePaths: [
        'assets/image/img 2.jpg',
        'assets/image/img 3.jpg',
      ],
      totalReview: 134,
    ), // HotelModel

    HotelModel(
      id: 2,
      thumbnailPath: 'assets/image/img 2.jpg',
      title: 'The abbott',
      location: 'Main street road, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari)',
      ratingScore: 4.25,
      coordinate: LatLng(-7.8543168283326625, 110.343484068852),
      tags: ['starters', 'dessert', 'pizza'],
      menuList: MenuItem.menu.where((dish) => dish.restaurantId == 2).toList(),
      imagePaths: [
        'assets/image/img 1.jpg',
        'assets/image/img 3.jpg',
      ],
      totalReview: 76,
    ), // Hot

    HotelModel(
      id: 3,
      thumbnailPath: 'assets/image/img 3.jpg',
      title: 'Candi Tirta Raharjo',
      location: 'Bantul Regency, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari)',
      ratingScore: 2.6,
      coordinate: LatLng(-7.842320836894338, 110.33722565674677),
      tags: ['dessert', 'rice', 'vegetables'],
      menuList: MenuItem.menu.where((dish) => dish.restaurantId == 3).toList(),
      imagePaths: [
        'assets/image/img 1.jpg',
        'assets/image/img 2.jpg',
      ],
      totalReview: 99,
    ), // HotelModel
  ];
}
