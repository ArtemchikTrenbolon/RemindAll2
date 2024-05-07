import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NoteTile extends StatelessWidget {
  final String text;
  const NoteTile({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
          top: 10,
          left: 25,
          right: 25,
      ),
      child: ListTile(
        title: Text(text),
        // trailing: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Ic
        //   ],
        // ),
      ),
    );
  }
}