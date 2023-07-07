import 'package:ecommerce_v1/models/category_models.dart';

abstract class BaseCategoryRepository {
  Stream<List<Category>> getAllCategories();
}
