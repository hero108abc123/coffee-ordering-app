import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/core/common/entities/user_profile.dart';
import 'package:flutter_application/features/home/domain/entities/cart.dart';
import 'package:flutter_application/features/home/domain/entities/invoice.dart';
import 'package:flutter_application/features/home/presentation/screens/edit_profile_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/purchase_history_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/invoice_detail_screen.dart';
import 'package:flutter_application/features/home/presentation/widgets/common_button.dart';

// Giả lập dữ liệu địa chỉ và hóa đơn
const String userAddress = '123 Đường ABC, Quận 1, TP.HCM';
final List<Invoice> recentInvoices = [
  Invoice(
    items: [
      CartItem(id: 1, quantity: 2, size: 'M'),
      CartItem(id: 2, quantity: 1, size: 'L'),
    ],
    phone: '0123456789',
    address: userAddress,
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
    address: userAddress,
    paymentMethod: 'Momo',
    discount: 2000,
    vat: 2000,
    id: 2,
    date: '2025-05-10',
    totalPrice: 600000,
  ),
];

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Profile user = Profile(
    id: 1,
    username: 'Nguyen Van A',
    mobileNumber: '0123456789',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallate.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallate.backgroundColor,
        title: Text(user.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thông tin người dùng
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 18),
                        const SizedBox(width: 8),
                        Text(user.mobileNumber),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 18),
                        SizedBox(width: 8),
                        Expanded(child: Text(userAddress)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Top 3 hóa đơn gần nhất
            const Text(
              'Recent Invoices',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: recentInvoices
                      .take(3) // Lấy đúng top 3 hóa đơn gần nhất
                      .map((invoice) {
                    return ListTile(
                      leading: const Icon(Icons.receipt_long),
                      title: Text('Invoice #${invoice.id}'),
                      subtitle: Text(
                        'Số món: ${invoice.items.fold(0, (sum, item) => sum + item.quantity)}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Các nút chức năng
            CommonButton(
              title: 'Edit Profile',
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              title: 'Purchase History',
              onTab: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PurchaseHistoryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CommonButton(
              title: 'Logout',
              onTab: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
