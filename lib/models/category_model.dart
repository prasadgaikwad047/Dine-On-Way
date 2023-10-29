import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final Image image;
  const Category({
    required this.id,
    required this.name,
    required this.image,
  });
  @override
  List<Object?> get props => [id, name, image];

  static List<Category> categories = [
    Category(
      id: 1,
      name: 'Pizza',
      image: Image.asset("assets/image/img 1.jpg"),
    ),
    Category(
      id: 2,
      name: 'Rice',
      image: Image.asset("assets/image/img 2.jpg"),
    ),
    Category(
      id: 3,
      name: 'Vegetable',
      image: Image.asset("assets/image/img 3.jpg"),
    ),
    Category(
      id: 4,
      name: 'Starters',
      image: Image.asset("assets/image/img 1.jpg"),
    ),
    Category(
      id: 5,
      name: 'Dessert',
      image: Image.asset("assets/image/img 2.jpg"),
    ),
  ];
}
