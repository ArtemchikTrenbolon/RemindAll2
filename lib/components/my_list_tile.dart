// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class MyListTile extends StatelessWidget{
//   final IconData icon;
//   final String text;
//
//
//   const MyListTile({
//     super.key,
//     required this.icon,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context){
//     return Slidable(
//         endActionPane: ActionPane(
//           motion: const StretchMotion(),
//           children: [
//             SlidableAction(onPressed: onEditPressed,
//               icon: Icons.settings,
//             ),
//
//             SlidableAction(onPressed: onDeletePressed,
//               icon: Icons.delete,
//             )
//           ],
//         ),
//       child: ListTile(
//         title: Text(title),
//       ),
//     );
//   }
// }