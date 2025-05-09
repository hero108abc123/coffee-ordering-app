import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/features/home/presentation/widgets/icon.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int indexMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: menu[indexMenu]['destination'] as Widget,
      backgroundColor: AppPallate.backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
            children: List.generate(menu.length, (index) {
          Map items = menu[index];
          bool isActive = indexMenu == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  indexMenu = index;
                });
              },
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Icon(
                      items['icon'],
                      color: isActive
                          ? AppPallate.xprimaryColor
                          : AppPallate.xsecondaryColor,
                      size: 25,
                    ),
                    if (isActive) const SizedBox(height: 7),
                    if (isActive)
                      Container(
                        height: 5,
                        width: 15,
                        decoration: BoxDecoration(
                          color: AppPallate.xprimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        })),
      ),
    );
  }
}
