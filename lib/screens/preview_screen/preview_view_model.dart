
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/repository/music_repository.dart';

class PreviewViewModel extends ChangeNotifier {

  final Song song;
  final MusicRepository repository;

  PreviewViewModel({@required this.repository, @required this.song}) {
    _registerSong(song: song);
    _fetchSongLyrics(song: song);
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

  String _lyrics = '';
  String get lyrics => _lyrics;
  set lyrics(String value) {
    _lyrics = value;

    notifyListeners();
  }

  void _registerSong({@required Song song}) {
    title = song.title;
    imageUrl = song.albumImage;
    songPreview = song.songPreviewLink;
  }

  void changeSongState() {
    isPlaying = !isPlaying;
  }

  void _fetchSongLyrics({@required Song song}) async {
    try {
      final lyrics = await repository.fetchLyrics(song.artist, song.title);
      this.lyrics = lyrics;
    } catch(e) {
      print('Error -$e');
      lyrics = 'No Lyrics Found - Bummer :(';
    }
  }

  void onPlayerStateChanged(AudioPlayerState state) {
    if (state == AudioPlayerState.COMPLETED && isPlaying) {
      changeSongState();
    }
  }
}