import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [name, imageUrl];

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category = Category(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
    return category;
  }

  static List<Category> categories = [
    Category(
        name: 'Soft Drinks',
        imageUrl:
            'https://www.foodnavigator-asia.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator-asia.com/article/2018/03/29/soft-drink-health-concerns-not-yet-trickled-down-into-social-media-users-mentions-of-brands/7819019-1-eng-GB/Soft-drink-health-concerns-not-yet-trickled-down-into-social-media-users-mentions-of-brands.jpg'),
    Category(
        name: 'Smoothies',
        imageUrl:
            'https://cdn.galleries.smcloud.net/t/photos/gf-R1HK-jGAR-kqVi_smoothie-ze-szpinakiem-i-owocami.jpg'),
    Category(
        name: 'Water',
        imageUrl: 'https://m.media-amazon.com/images/I/617W9-jOXjS.jpg'),
  ];
}
