// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// class MyBottomNavBar extends StatelessWidget{
//   void Function(int)? onTabChange;
//   MyBottomNavBar({super.key, required this.onTabChange});
//
// //   @override
// //     Widget build(BuildContext context) {
// //     return Scaffold(
// //       bottomNavigationBar: ClipRRect(
// //         borderRadius: BorderRadius.vertical(
// //           top: Radius.circular(30)
// //         ),
// //         child: BottomNavigationBar(
// //             backgroundColor: Colors.black,
// //             showSelectedLabels: false,
// //             showUnselectedLabels: false,
// //             items: [
// //               BottomNavigationBarItem(
// //                 icon: Icon(CupertinoIcons.home),
// //                 label: "Home",
// //                 ),
// //
// //               BottomNavigationBarItem(
// //                 icon: Icon(CupertinoIcons.graph_square_fill),
// //                 label: "Events",
// //                 ),
// //             ]
// //         )
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       color: Colors.black,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: GNav(
//                 onTabChange: (value) => onTabChange!(value),
//                 backgroundColor: Colors.black,
//                 haptic: false,
//                 color: Colors.white,
//                 activeColor: Colors.white,
//                 tabBackgroundColor: Colors.grey.shade800,
//                 gap: 8,
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//                 tabs: const [
//                   GButton(
//                     icon: Icons.home,
//                     text: 'Home',
//                   ),
//                   GButton(
//                     icon: Icons.event,
//                     text: 'Event',
//                   ),
//                   // GButton(
//                   //     icon: Icons.person,
//                   //     text: 'Profile',
//                   // ),
//                   // GButton(
//                   //     icon: Icons.settings,
//                   //     text: 'Settings',
//                   // ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
