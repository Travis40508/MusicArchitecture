import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "We're sorry. Something went wrong.",
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
        Icon(Icons.warning)
      ],
    );
  }
}
