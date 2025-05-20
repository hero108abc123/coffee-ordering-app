import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/presentation/screens/invoice_detail_screen.dart';

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
        itemCount: 10, // Example: 10 invoices
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Invoice #${index + 1}'),
            subtitle: const Text('Date: 2025-05-09'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InvoiceDetailScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
