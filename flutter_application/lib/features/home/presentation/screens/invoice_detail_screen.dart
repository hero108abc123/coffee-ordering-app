import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/domain/entities/coffee.dart';
import 'package:flutter_application/features/home/domain/entities/invoice.dart';
import 'package:intl/intl.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;
  const InvoiceDetailScreen({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin hóa đơn'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Center(
              child: Text(
                'Đặt hàng ${invoice.id}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'Ngày: ${invoice.date}',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
            const Divider(height: 24),
            ...invoice.items.map((item) {
              final coffee = listOfCoffee.firstWhere((c) => c.id == item.id);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        coffee.image,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Size: ${item.size}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('x${item.quantity}'),
                    const SizedBox(width: 8),
                    Text(
                      currencyFormatter.format(coffee.price * item.quantity),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giá các món:'),
                Text(currencyFormatter.format(
                    invoice.totalPrice - invoice.vat + invoice.discount)),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giá phụ kiện:'),
                Text('0₫'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giảm giá:'),
                Text(
                    '(-) ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(invoice.discount)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('VAT/Thuế:'),
                Text(currencyFormatter.format(invoice.vat)),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  currencyFormatter.format(invoice.totalPrice),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.phone, size: 18),
                const SizedBox(width: 8),
                Text(invoice.phone),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(invoice.address)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.payment, size: 18),
                const SizedBox(width: 8),
                Text('Phương thức: ${invoice.paymentMethod}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
