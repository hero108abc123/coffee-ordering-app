import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/features/home/presentation/screens/detail_screen.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/cart.dart';
import '../../domain/entities/coffee.dart';

class FavoriteScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  const FavoriteScreen({super.key, required this.cartItems});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  @override
  Widget build(BuildContext context) {
    // Danh sách đồ uống yêu thích (ví dụ)
    final List<Coffee> favoriteCoffees = [
      Coffee(
        id: 1,
        image: 'images/coffee4.png',
        name: 'Caffee Mocha',
        type: 'Deep Foam',
        rate: 4.8,
        review: 230,
        description:
            'A delightful mix of espresso, steamed milk, and chocolate syrup, creating a harmonious blend of rich coffee and sweet chocolate flavors. It’s often topped with whipped cream or cocoa powder, making it a favorite for those who love a dessert-like coffee experience.',
        price: 40000,
        category: 'Coffee',
      ),
      Coffee(
        id: 2,
        image: 'images/coffee3.png',
        name: 'Flat White',
        type: 'Espresso',
        rate: 4.8,
        review: 20,
        description:
            'A smooth coffee crafted with a double shot of espresso and finely textured micro-foamed milk. Its velvety texture and balanced coffee-to-milk ratio make it creamier than a latte yet less foamy than a cappuccino, offering a rich and satisfying coffee experience.',
        price: 35000,
        category: 'Coffee',
      ),
    ];

    return Scaffold(
      backgroundColor: AppPallate.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallate.backgroundColor,
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: favoriteCoffees.isEmpty
          ? const Center(
              child: Text(
                'Your favorite items will appear here!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 270,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              itemCount: favoriteCoffees.length,
              itemBuilder: (context, index) {
                final coffee = favoriteCoffees[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                            coffee: coffee, cartItems: widget.cartItems),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Hero(
                                tag: coffee.image,
                                child: Image.asset(
                                  coffee.image,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "images/ic_star_filled.png",
                                      height: 12,
                                      width: 12,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${coffee.rate}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          coffee.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          coffee.type,
                          style: const TextStyle(
                            color: AppPallate.xsecondaryColor,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currencyFormatter.format(coffee.price),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppPallate.xprimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // Kiểm tra nếu sản phẩm đã có trong giỏ hàng
                                    final existingItem =
                                        widget.cartItems.firstWhere(
                                      (item) => item.id == coffee.id,
                                      orElse: () =>
                                          CartItem(id: coffee.id, quantity: 0),
                                    );

                                    if (existingItem.quantity > 0) {
                                      // Nếu sản phẩm đã tồn tại, tăng số lượng
                                      existingItem.quantity++;
                                    } else {
                                      // Nếu sản phẩm chưa tồn tại, thêm sản phẩm mới vào giỏ hàng
                                      widget.cartItems.add(CartItem(
                                        id: coffee.id,
                                        quantity: 1,
                                        size: 'M',
                                      ));
                                    }
                                  });

                                  // Hiển thị thông báo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${coffee.name} has been added to the cart!'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
