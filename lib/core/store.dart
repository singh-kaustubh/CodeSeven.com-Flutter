import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/catalogue.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  CatalogueModel catalogue = CatalogueModel();
  CartModel cart = CartModel();
  MyStore() {
    cart.catalogue = catalogue;
  }
}
