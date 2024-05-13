// import 'package:flutter/material.dart';
// import 'package:rever/components/const.dart';

// // ignore: must_be_immutable
// class BottomNavBarItem extends StatelessWidget {
//   const BottomNavBarItem({
//     super.key,
//     this.onTap,
//     required this.icon,
//     required this.title,
//     required this.index,
//   });
//   final Function()? onTap;
//   final String icon;
//   final String title;
//   final int index;
//   final int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         enableFeedback: false,
//         highlightColor: Colors.transparent,
//         focusColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         onTap: onTap,
//         child: Column(
//           children: [
//             Image.asset(
//               '$kAssetIconsWay/$icon',
//               color: _selectedIndex != index
//                   ? const Color(0xffababab)
//                   : Colors.white,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             // title
//             Text(title,
//                 style: TextStyle(
//                     color: _selectedIndex != index
//                         ? const Color(0xffababab)
//                         : Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: "Raleway",
//                     fontStyle: FontStyle.normal,
//                     fontSize: 11.0)),
//           ],
//         ),
//       ),
//     );
//   }
// }
