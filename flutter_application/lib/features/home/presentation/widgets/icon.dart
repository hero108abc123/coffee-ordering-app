import 'package:flutter_application/features/home/domain/entities/cart.dart';
import 'package:flutter_application/features/home/presentation/screens/cart_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/favorite_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_application/features/home/presentation/screens/user_screen.dart';
import 'package:iconsax/iconsax.dart';

final List<CartItem> cartItems = [];
final menu = [
  {
    'icon': Iconsax.home5,
    'destination': HomeScreen(
      cartItems: cartItems,
    ),
  },
  {
    'icon': Iconsax.heart,
    'destination': FavoriteScreen(
      cartItems: cartItems,
    ),
  },
  {
    'icon': Iconsax.shopping_cart,
    'destination': CartScreen(
      cartItems: cartItems,
    ),
  },
  {
    'icon': Iconsax.user,
    'destination': UserScreen(),
  },
];
