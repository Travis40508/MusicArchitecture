import 'package:flutter/material.dart';
import 'package:music_archiecture/utils/strings.dart';

class SongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  get _appBar => AppBar(
    title: Text(Strings.songsScreenTitle),
  );
}
