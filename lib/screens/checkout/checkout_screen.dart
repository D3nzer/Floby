import 'package:ecommerce_v1/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_v1/blocs/checkout/checkout_bloc.dart';
import 'package:ecommerce_v1/blocs/wishlist/wishlist_bloc.dart';
import 'package:ecommerce_v1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 158, 123, 170),
        child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckoutLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CheckoutLoaded) {
                      return ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () {
                            context
                                .read<CheckoutBloc>()
                                .add(ConfirmCheckout(checkout: state.checkout));
                          },
                          child: Text(
                            'ORDER NOW',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: Color.fromARGB(255, 158, 123, 170)),
                          ));
                    } else {
                      return Text('Something went wrong');
                    }
                  },
                )
              ],
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CUSTOMER INFORMATION',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                  _buildTextFormField((value) {
                    context.read<CheckoutBloc>().add(
                          UpdateCheckout(email: value),
                        );
                  }, context, 'Email'),
                  _buildTextFormField((value) {
                    context.read<CheckoutBloc>().add(
                          UpdateCheckout(fullName: value),
                        );
                  }, context, 'Full Name'),
                  Text(
                    'DELIVERY INFORMATION',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                  _buildTextFormField((value) {
                    context.read<CheckoutBloc>().add(
                          UpdateCheckout(address: value),
                        );
                  }, context, 'Address'),
                  _buildTextFormField((value) {
                    context.read<CheckoutBloc>().add(
                          UpdateCheckout(city: value),
                        );
                  }, context, 'City'),
                  _buildTextFormField((value) {
                    context.read<CheckoutBloc>().add(
                          UpdateCheckout(country: value),
                        );
                  }, context, 'Country'),
                  _buildTextFormField((value) {
                    context.read<CheckoutBloc>().add(
                          UpdateCheckout(zipCode: value),
                        );
                  }, context, 'Zip Code'),
                  Text(
                    'ORDER SUMMARY',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                  OrderSummary(),
                ],
              );
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          Expanded(
              child: TextFormField(
            style: TextStyle(color: Colors.white),
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(left: 10),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white), // Kolor linii w stanie domyślnym
              ),
            ),
          ))
        ],
      ),
    );
  }
}
