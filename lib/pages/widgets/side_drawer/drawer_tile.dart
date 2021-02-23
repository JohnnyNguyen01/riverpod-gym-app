import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressed;

  const DrawerTile(
      {@required this.title,
      @required this.subtitle,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, constraint) => Column(
        children: [
          ListTile(
            title: Text(
              title ?? "ERROR",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(subtitle ?? "ERROR"),
            trailing: IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () => onPressed(),
            ),
          ),
          Container(
            width: constraint.maxWidth * 0.9,
            height: 1,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
