import 'package:flutter/foundation.dart';

class Song {
  final String title;
  final String artist;
  final String artistImage;
  final String songPreviewLink;
  final bool isPlaying = false;

  Song(
      {@required this.title,
      @required this.artist,
      @required this.artistImage,
      @required this.songPreviewLink});
}
