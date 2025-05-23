import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/features/home/domain/entities/category.dart';
import 'package:flutter_application/features/home/presentation/screens/detail_screen.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/cart.dart';
import '../../domain/entities/coffee.dart';

class HomeScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  const HomeScreen({super.key, required this.cartItems});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  int selectedIndex = 0;
  String searchText = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCoffeeList = listOfCoffee.where((coffee) {
      final matchesCategory =
          coffee.category == coffeeCategories[selectedIndex];
      final matchesSearch =
          coffee.name.toLowerCase().contains(searchText.trim().toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Stack(
          children: [
            Container(
              height: 280,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 17, 17, 17),
                    Color.fromARGB(255, 49, 49, 49),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppPallate.xsecondaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Hanoi, Vietnam",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xff2a2a2a),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/ic_search.png",
                                color: Colors.white,
                                height: 35,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Search coffee",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: AppPallate.xsecondaryColor,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      searchText = value;
                                    });
                                  },
                                  onSubmitted: (value) {
                                    // Tìm kiếm trong thể loại hiện tại
                                    final filtered =
                                        listOfCoffee.where((coffee) {
                                      final matchesCategory = coffee.category ==
                                          coffeeCategories[selectedIndex];
                                      final matchesSearch = coffee.name
                                          .toLowerCase()
                                          .contains(value.trim().toLowerCase());
                                      return matchesCategory && matchesSearch;
                                    }).toList();

                                    if (filtered.isEmpty &&
                                        value.trim().isNotEmpty) {
                                      // Tìm kiếm ở các thể loại khác
                                      int foundIndex = -1;
                                      for (int i = 0;
                                          i < coffeeCategories.length;
                                          i++) {
                                        final found = listOfCoffee.any(
                                            (coffee) =>
                                                coffee.category ==
                                                    coffeeCategories[i] &&
                                                coffee.name
                                                    .toLowerCase()
                                                    .contains(value
                                                        .trim()
                                                        .toLowerCase()));
                                        if (found) {
                                          foundIndex = i;
                                          break;
                                        }
                                      }
                                      if (foundIndex != -1) {
                                        setState(() {
                                          selectedIndex = foundIndex;
                                        });
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Thông báo'),
                                            content:
                                                const Text('Đồ uống không có'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Đóng'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "images/banner.png",
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 35),
        categorySelection(),
        const SizedBox(height: 20),
        filteredCoffeeList.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.error_outline,
                          color: AppPallate.xprimaryColor, size: 48),
                      SizedBox(height: 12),
                      Text(
                        '404 not found',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppPallate.xprimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCoffeeList.length,
                itemBuilder: (context, index) {
                  final coffee = filteredCoffeeList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            coffee: coffee,
                            cartItems: widget.cartItems,
                          ),
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
                                        (item) =>
                                            item.id ==
                                            coffee
                                                .id, // So sánh theo id của coffee
                                        orElse: () => CartItem(
                                            id: coffee.id, quantity: 0),
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
      ],
    );
  }

  SizedBox categorySelection() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        itemCount: coffeeCategories.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 25 : 10,
                right: index == coffeeCategories.length - 1 ? 25 : 10,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppPallate.xprimaryColor
                    : AppPallate.xsecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: Text(
                coffeeCategories[index],
                style: TextStyle(
                    fontWeight: selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 16,
                    color:
                        selectedIndex == index ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
