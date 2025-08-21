import 'package:flutter/material.dart';
import 'package:msme/screen/dashboard_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selected = 0;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.vertical,
          bubbleFillStyle: BubbleFillStyle.fill,
          opacity: 0.4,
          inkEffect: true,
          iconSize: 28, // slightly bigger icons
          inkColor: const Color.fromARGB(255, 195, 245, 240),
          borderRadius: BorderRadius.circular(25),
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.house_outlined),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: Colors.teal,
            unSelectedColor: Colors.black54,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.chat_outlined),
            selectedIcon: const Icon(Icons.chat),
            selectedColor: Colors.teal,
            unSelectedColor: Colors.black54,
            title: const Text('Chats'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.contact_phone_outlined),
            selectedIcon: const Icon(Icons.contact_phone),
            selectedColor: Colors.teal,
            unSelectedColor: Colors.black54,
            title: const Text('Contacts'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.campaign_outlined),
            selectedIcon: const Icon(Icons.campaign),
            selectedColor: Colors.teal,
            unSelectedColor: Colors.black54,
            title: const Text('Campaigns'),
          ),
        ],
        currentIndex: selected,
        notchStyle: NotchStyle.square,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),

      body: SafeArea(
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(), // disables swipe
          children: const [
            Center(child: DashboardPage()),
            Center(child: Text('Chats Page')),
            Center(child: Text('Contacts Page')),
            Center(child: Text('Campaigns Page')),
          ],
        ),
      ),
    );
  }
}
