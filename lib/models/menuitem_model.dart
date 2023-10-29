import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final double price;
  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
  });
  @override
  List<Object?> get props => [id, restaurantId, name, price];

  static List<MenuItem> menu = [
    MenuItem(id: 1, restaurantId: 1, name: 'Pizza', price: 500),
    MenuItem(id: 2, restaurantId: 1, name: 'Coca Cola', price: 400),
    MenuItem(id: 3, restaurantId: 2, name: 'ice cream', price: 199),
    MenuItem(id: 4, restaurantId: 2, name: 'chicken', price: 600),
    MenuItem(id: 5, restaurantId: 3, name: 'paneer', price: 400),
    MenuItem(id: 6, restaurantId: 3, name: 'burger', price: 450),
  ];
}
