import 'package:ar_visionary_explora/components/botttom_nav_tile.dart';
import 'package:ar_visionary_explora/main/cart/cart.dart';
import 'package:ar_visionary_explora/main/home/screeen/home.dart';
import 'package:ar_visionary_explora/main/itemUploadScreen/screen/item_upload_screen.dart';
import 'package:ar_visionary_explora/main/profile/screen/profile.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // to store the active bottom bar index
  int _activeIndex = 0;

  // trigger when botton bar icon is cliked
  void onItemTaped(int i) {
    setState(() {
      _activeIndex = i;
    });
    Logger().i(_activeIndex);
  }

  // screens list
  final List<Widget> _screens = [
    Home(),
    ItemUploadScreen(),
    Cart(),
    Profile(),
  ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens.elementAt(_activeIndex),
//       bottomNavigationBar: Container(
//         height: 83,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             BottomNavTile(
//               icon: Icons.home,
//               isActive: _activeIndex == 0,
//               onTap: () => onItemTaped(0),
//             ),
//             BottomNavTile(
//               icon: Icons.camera,
//               isActive: _activeIndex == 1,
//               onTap: () => onItemTaped(1),
//             ),
//             BottomNavTile(
//               icon: Icons.person,
//               isActive: _activeIndex == 2,
//               onTap: () => onItemTaped(2),
//             ),
//             // BottomNavTile(
//             //   icon: Icons.store,
//             //   isActive: _activeIndex == 4,
//             //   onTap: () => onItemTaped(4),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_activeIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 222, 179, 157),
        buttonBackgroundColor: Color.fromARGB(255, 198, 192, 192),
        height: 70,
        items: <Widget>[
          Icon(Icons.home, size: 40),
      //    Icon(Icons.person, size: 40),
          Icon(Icons.camera, size: 40),
          Icon(Icons.shopping_cart, size: 40),
          Icon(Icons.person, size: 40),
        ],
        onTap: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
    );
  }
}
