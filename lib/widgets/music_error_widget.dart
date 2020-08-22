import 'package:flutter/material.dart';
import 'package:music_archiecture/utils/strings.dart';

class MusicErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Strings.errorString,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0
            ),
            textAlign: TextAlign.center,
          ),
          Icon(
              Icons.warning,
            color: Theme.of(context).primaryColor,
            size: 50.0,
          )
        ],
      ),
    );
  }
}
