import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../domain/entities/cart.dart';
import '../../domain/entities/coffee.dart';
import '../widgets/common_button.dart';

class DetailScreen extends StatefulWidget {
  final Coffee coffee;
  final List<CartItem> cartItems;
  const DetailScreen(
      {super.key, required this.coffee, required this.cartItems});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  String selectedSize = 'M'; // Kích thước mặc định
  int quantity = 1; // Số lượng mặc định

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallate.backgroundColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 65),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              const Text(
                "Detail",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Iconsax.heart),
            ],
          ),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Hero(
              tag: widget.coffee.image,
              child: Image.asset(
                widget.coffee.image,
                width: double.infinity,
                height: 270,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.coffee.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.star1, color: Colors.amber, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.coffee.rate}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Row(
                    children: [
                      const Icon(Iconsax.message, color: Colors.grey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.coffee.review} Reviews",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Divider(
                indent: 15,
                endIndent: 15,
                color: Colors.black12,
              ),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                widget.coffee.description,
                trimLength: 125,
                trimMode: TrimMode.Length,
                trimCollapsedText: " Read More",
                trimExpandedText: " Read Less",
                style: const TextStyle(
                  fontSize: 15,
                  color: AppPallate.xsecondaryColor,
                ),
                moreStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppPallate.xprimaryColor,
                ),
                lessStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppPallate.xprimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Size",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: ['S', 'M', 'L'].map((e) {
                  bool isSelected = selectedSize == e;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = e;
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppPallate.xprimaryColor.withOpacity(0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppPallate.xprimaryColor
                                : Colors.black12,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? AppPallate.xprimaryColor
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Quantity",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppPallate.xsecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    currencyFormatter.format(widget.coffee.price * quantity),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppPallate.xprimaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 240,
              child: CommonButton(
                title: "Add to Cart",
                onTab: () {
                  setState(() {
                    // Kiểm tra nếu sản phẩm đã có trong giỏ hàng
                    final existingItem = widget.cartItems.firstWhere(
                      (item) =>
                          item.id == widget.coffee.id &&
                          item.size == selectedSize,
                      orElse: () => CartItem(
                        id: widget.coffee.id,
                        size: selectedSize,
                        quantity: 0,
                      ),
                    );

                    if (existingItem.quantity > 0) {
                      // Nếu sản phẩm đã tồn tại, tăng số lượng
                      existingItem.quantity += quantity;
                    } else {
                      // Nếu sản phẩm chưa tồn tại, thêm sản phẩm mới vào giỏ hàng
                      widget.cartItems.add(CartItem(
                        id: widget.coffee.id,
                        size: selectedSize,
                        quantity: quantity,
                      ));
                    }
                  });

                  // Hiển thị thông báo
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${widget.coffee.name} ($selectedSize) has been added to the cart!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
