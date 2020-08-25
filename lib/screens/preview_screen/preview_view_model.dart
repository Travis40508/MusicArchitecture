
import 'package:flutter/material.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:flutter/foundation.dart';

class PreviewViewModel extends ChangeNotifier {

  final Song song;

  PreviewViewModel({@required this.song}) {
    _registerSong(song: song);
  }

  String _title = 'Preview';
  String get title => _title;
  set title(String value) {
    _title = value;

    notifyListeners();
  }

  String _imageUrl;


  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;

    notifyListeners();
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;

    notifyListeners();
  }

  String _songPreview;
  String get songPreview => _songPreview;
  set songPreview(String value) {
    _songPreview = value;

    notifyListeners();
  }

  void _registerSong({@required Song song}) {
    title = song.title;
    imageUrl = song.artistImage;
    songPreview = song.songPreviewLink;
  }

  void changeSongState() {
    isPlaying = !isPlaying;
  }
}