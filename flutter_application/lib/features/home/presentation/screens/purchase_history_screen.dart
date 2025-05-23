import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/domain/entities/invoice.dart';
import 'package:flutter_application/features/home/presentation/screens/invoice_detail_screen.dart';
import 'package:flutter_application/features/home/domain/entities/cart.dart';

// Danh sách hóa đơn mẫu
final List<Invoice> demoInvoices = [
  Invoice(
    items: [
      CartItem(id: 1, quantity: 2, size: 'M'),
      CartItem(id: 2, quantity: 1, size: 'L'),
    ],
    phone: '0123456789',
    address: '123 Đường ABC, Quận 1, TP.HCM',
    paymentMethod: 'Momo',
    discount: 1000,
    vat: 1000,
    id: 1,
    date: '2025-05-09',
    totalPrice: 500000,
  ),
  Invoice(
    items: [
      CartItem(id: 3, quantity: 1, size: 'S'),
      CartItem(id: 4, quantity: 2, size: 'M'),
    ],
    phone: '0123456789',
    address: '123 Đường ABC, Quận 1, TP.HCM',
    paymentMethod: 'Momo',
    discount: 2000,
    vat: 2000,
    id: 2,
    date: '2025-05-10',
    totalPrice: 600000,
  ),
];

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: demoInvoices.length,
        itemBuilder: (context, index) {
          final invoice = demoInvoices[index];
          return ListTile(
            title: Text('Invoice #${invoice.id}'),
            subtitle: Text('Date: ${invoice.date}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InvoiceDetailScreen(
                    invoice: invoice, // Truyền đúng hóa đơn được chọn
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
