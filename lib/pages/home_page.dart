// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'dart:convert';
import 'package:flutter_application_1/models/catalogue.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalogue_header.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalogue_list.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Anubhav";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    // final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
    // final response = await http.get(Uri.parse(url));
    // final catalogueJson = response.body;
    final catalogueJson =
        await rootBundle.loadString("assets/files/catalogue.json");
    final decodedData = jsonDecode(catalogueJson);
    var productsData = decodedData["products"];
    CatalogueModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
        // backgroundColor: Theme.of(context).cardColor,
        floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (context, store, status) => FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
            backgroundColor: context.theme.buttonColor,
            child: Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(
              color: Vx.red500,
              size: 22,
              count: _cart.items.length,
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Vx.black)),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogueHeader(),
                if (CatalogueModel.items != null &&
                    CatalogueModel.items!.isNotEmpty)
                  CatalogueList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}
