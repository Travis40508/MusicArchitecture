import 'package:flutter/material.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/utils/strings.dart';
import 'package:rxdart/rxdart.dart';

class SongsViewModel extends ChangeNotifier {
  final MusicRepository musicRepository;

  List<Song> _topSongsCache = <Song>[];
  BehaviorSubject<String> _songQuery = BehaviorSubject();
  Stream<String> get _songQueryStream => _songQuery.stream;

  String _title = Strings.songsScreenTitle;
  String get title => _title;

  set title(String value) {
    _title = value;

    notifyListeners();
  }

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
    _listenForSearch();
  }

  @override
  void dispose() {
    _songQuery.close();
    super.dispose();
  }

  void _listenForSearch() {
    _songQueryStream
        .debounceTime(Duration(milliseconds: 500))
        .flatMap(
            (query) => Stream.fromFuture(musicRepository.searchSongs(query)))
        .listen((songs) {
      isLoading = false;
      hasError = false;
      this.songs = songs;
    }, onError: (e) {
      print('$e');
      isLoading = false;
      hasError = false;
    });
  }

  void _fetchTopSongs() async {
    try {
      final topSongs = await musicRepository.fetchTopSongs();

      if (topSongs.isNotEmpty) {
        _topSongsCache.addAll(topSongs);
        isLoading = false;
        hasError = false;
        songs = topSongs;
      }
    } catch (e) {
      ///Normally we'd do more here
      print('$e');
      isLoading = false;
      hasError = true;
    }
  }

  void onSearchChanged({@required String query}) {
    if (query.isEmpty && _topSongsCache.isNotEmpty) {
      title = Strings.songsScreenTitle;
      songs = _topSongsCache;

      return;
    }

    title = "Showing Results for '$query'";
    _songQuery.add(query);
  }
}
