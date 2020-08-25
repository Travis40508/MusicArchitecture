
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/services/lyrics_service.dart';
import 'package:music_archiecture/services/music_service.dart';
import 'package:flutter/foundation.dart';

class MusicRepositoryImpl implements MusicRepository {

  final MusicService musicService;
  final LyricsService lyricsService;

  MusicRepositoryImpl({@required this.musicService, @required this.lyricsService});

  @override
  Future<List<Song>> fetchTopSongs() {
    return musicService.fetchTopSongs();
  }

  @override
  Future<List<Song>> searchSongs(String query) {
    return musicService.searchSongs(query);
  }

  @override
  Future<String> fetchLyrics(String artistName, String songTitle) {
    return lyricsService.fetchLyrics(artistName, songTitle);
  }

}