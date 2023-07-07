import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  //const CatalogScreen({super.key});
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () => Navigator.pushNamed(context, '/'));
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            width: 125,
            height: 125,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          color: Color.fromARGB(255, 158, 123, 170),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Text(
            'Floby',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Colors.white),
          ),
        )
      ],
    ));
  }
}
