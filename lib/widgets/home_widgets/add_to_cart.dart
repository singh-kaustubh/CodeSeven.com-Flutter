// ignore_for_file: deprecated_member_use, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/catalogue.dart';

class AddToCart extends StatelessWidget {
  final Item catalogue;
  AddToCart({
    Key? key,
    required this.catalogue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart; 
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    bool isInCart = _cart.items.contains(catalogue);
    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          AddMutation(catalogue);
          // setState(() {});
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
        shape: MaterialStateProperty.all(
          StadiumBorder(),
        ),
      ),
      child: isInCart ? Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}
