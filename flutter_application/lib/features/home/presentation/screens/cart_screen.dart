import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/features/home/domain/entities/cart.dart';
import 'package:flutter_application/features/home/domain/entities/coffee.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Hàm tính tổng giá tiền
  double calculateTotalPrice() {
    return widget.cartItems.fold(
      0,
      (sum, item) {
        final coffee =
            listOfCoffee.firstWhere((coffee) => coffee.id == item.id);
        return sum + (coffee.price * item.quantity);
      },
    );
  }

  // Hàm tăng số lượng sản phẩm
  void increaseQuantity(int index) {
    setState(() {
      widget.cartItems[index].quantity++;
    });
  }

  // Hàm giảm số lượng sản phẩm
  void decreaseQuantity(int index) {
    setState(() {
      if (widget.cartItems[index].quantity > 1) {
        widget.cartItems[index].quantity--;
      } else {
        // Nếu số lượng là 1, xóa sản phẩm khỏi giỏ hàng
        widget.cartItems.removeAt(index);
      }
    });
  }

  // Hàm xóa sản phẩm khỏi giỏ hàng
  void removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    double totalPrice = calculateTotalPrice();

    return Scaffold(
      backgroundColor: AppPallate.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallate.backgroundColor,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.cartItems.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    itemBuilder: (context, index) {
                      final cartItem = widget.cartItems[index];
                      final coffee = listOfCoffee
                          .firstWhere((coffee) => coffee.id == cartItem.id);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hiển thị hình ảnh đồ uống
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  coffee.image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Hiển thị thông tin đồ uống
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coffee.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Size: ${cartItem.size}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppPallate.xsecondaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Price: ${currencyFormatter.format(coffee.price)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () =>
                                              decreaseQuantity(index),
                                        ),
                                        Text(
                                          '${cartItem.quantity}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () =>
                                              increaseQuantity(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Nút xóa
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Hiển thị tổng giá tiền và nút thanh toán
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      currencyFormatter.format(totalPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppPallate.xprimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        String selectedMethod = 'Cash';
                        return StatefulBuilder(
                          builder: (context, setModalState) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Select Payment Method',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                RadioListTile<String>(
                                  value: 'Thanh toán khi nhận',
                                  groupValue: selectedMethod,
                                  title: const Text('Thanh toán khi nhận'),
                                  onChanged: (value) {
                                    setModalState(
                                        () => selectedMethod = value!);
                                  },
                                ),
                                RadioListTile<String>(
                                  value: 'Thanh toán bằng thẻ',
                                  groupValue: selectedMethod,
                                  title: const Text('Thanh toán bằng thẻ'),
                                  onChanged: (value) {
                                    setModalState(
                                        () => selectedMethod = value!);
                                  },
                                ),
                                RadioListTile<String>(
                                  value: 'Momo',
                                  groupValue: selectedMethod,
                                  title: const Text('Momo'),
                                  onChanged: (value) {
                                    setModalState(
                                        () => selectedMethod = value!);
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (context) {
                                        String phone = '0123456789';
                                        String address =
                                            '123 Đường ABC, Quận 1, TP.HCM';
                                        widget.cartItems.fold(0,
                                            (sum, item) => sum + item.quantity);
                                        double totalPrice =
                                            calculateTotalPrice();
                                        double discount = 0; // ví dụ giảm giá
                                        double vat = 0; // ví dụ VAT/Thuế
                                        double finalTotal =
                                            totalPrice - discount + vat;

                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Container(
                                                  width: 40,
                                                  height: 4,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 16),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                ),
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Đặt hàng 100015',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              const Divider(height: 24),
                                              ...widget.cartItems.map((item) {
                                                final coffee =
                                                    listOfCoffee.firstWhere(
                                                        (c) => c.id == item.id);
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                              coffee.name)),
                                                      Text('${item.quantity}'),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        NumberFormat.currency(
                                                                locale: 'vi_VN',
                                                                symbol: '₫')
                                                            .format(coffee
                                                                    .price *
                                                                item.quantity),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              const SizedBox(height: 8),
                                              Container(
                                                height: 32,
                                                width: double.infinity,
                                                color: Colors.grey[100],
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: const Text(''),
                                              ),
                                              const Divider(height: 24),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Giá các món:'),
                                                  Text(NumberFormat.currency(
                                                          locale: 'vi_VN',
                                                          symbol: '₫')
                                                      .format(totalPrice)),
                                                ],
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Giá phụ kiện:'),
                                                  Text('0₫'),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Giảm giá:'),
                                                  Text(
                                                      '(-) ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(discount)}'),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('VAT/Thuế:'),
                                                  Text(NumberFormat.currency(
                                                          locale: 'vi_VN',
                                                          symbol: '₫')
                                                      .format(vat)),
                                                ],
                                              ),
                                              const Divider(height: 24),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Tổng cộng',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'vi_VN',
                                                            symbol: '₫')
                                                        .format(finalTotal),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  const Icon(Icons.phone,
                                                      size: 18),
                                                  const SizedBox(width: 8),
                                                  Text(phone),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(Icons.location_on,
                                                      size: 18),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                      child: Text(address)),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      widget.cartItems
                                                          .clear(); // Reset giỏ hàng về empty
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Order placed successfully!')),
                                                    );
                                                  },
                                                  child: const Text(
                                                      'Xác nhận đặt hàng'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallate.xprimaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
