import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_v1/blocs/category/category_bloc.dart';
import 'package:ecommerce_v1/blocs/product/product_bloc.dart';
import 'package:ecommerce_v1/config/theme.dart';
import 'package:ecommerce_v1/models/category_models.dart';
import 'package:ecommerce_v1/models/models.dart';
import 'package:ecommerce_v1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Floby'),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          Container(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlay: true,
                    ),
                    items: state.categories
                        .map((category) => HeroCaruselCard(category: category))
                        .toList(),
                  );
                } else {
                  return Text('Something went wrong');
                }
              },
            ),
          ),
          SectionTitle(title: 'RECCOMMENDED'),
          // Product carusel
          //ProductCard(
          // product: Product.products[0],
          //)
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProductLoaded) {
                return ProductCarusel(
                    products: state.products
                        .where((product) => product.isRecommended)
                        .toList());
              } else {
                return Text('Something went wrong');
              }
            },
          ),
          SectionTitle(title: 'MOST POPULAR'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProductLoaded) {
                return ProductCarusel(
                    products: state.products
                        .where((product) => product.isPopular)
                        .toList());
              } else {
                return Text('Something went wrong');
              }
            },
          ),
        ],
      ),
    );
  }
}
