import 'package:flutter/foundation.dart';

class Song {
  final int id;
  final String title;
  final String artist;
  final String albumImage;
  final String songPreviewLink;
  final bool isPlaying = false;

  Song(
      {@required this.id,
      @required this.title,
      @required this.artist,
      @required this.albumImage,
      @required this.songPreviewLink});
}
