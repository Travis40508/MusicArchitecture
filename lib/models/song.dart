import 'package:flutter/foundation.dart';

class Song {
  final String title;
  final String artist;
  final String artistImage;
  final String songPreviewLink;

  Song(
      {@required this.title,
      @required this.artist,
      @required this.artistImage,
      @required this.songPreviewLink});
}
