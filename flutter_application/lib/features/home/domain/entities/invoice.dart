import 'package:flutter_application/features/home/domain/entities/cart.dart';

class Invoice {
  final List<CartItem> items;
  final String phone;
  final String address;
  final String paymentMethod;
  final double discount;
  final double vat;
  final int id;
  final String date;
  final double totalPrice;

  Invoice(
      {required this.items,
      required this.phone,
      required this.address,
      required this.paymentMethod,
      required this.discount,
      required this.vat,
      required this.id,
      required this.date,
      required this.totalPrice});
}
