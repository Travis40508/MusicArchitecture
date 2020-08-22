
import 'package:flutter/material.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:flutter/foundation.dart';

class SongsViewModel extends ChangeNotifier {
  final MusicRepository musicRepository;

  List<Song> _songs = <Song>[];
  List<Song> get songs => _songs;
  set songs(List<Song> value) {
    _songs = value;

    notifyListeners();
  }

  bool _hasError = false;
  bool get hasError => _hasError;
  set hasError(bool value) {
    _hasError = value;

    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }

  SongsViewModel({@required this.musicRepository}) {
    _fetchTopSongs();
  }

  void _fetchTopSongs() async {
    try {
      final topSongs = await musicRepository.fetchTopSongs();

      if (topSongs.isNotEmpty) {
        isLoading = false;
        songs = topSongs;
      }
    } catch(e) {
      ///Normally we'd do more here
      print('$e');
      isLoading = false;
      hasError = true;
    }
  }

}