
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/services/music_service.dart';
import 'package:flutter/foundation.dart';

class MusicRepositoryImpl implements MusicRepository {

  final MusicService musicService;

  MusicRepositoryImpl({@required this.musicService});

  @override
  Future<List<Song>> fetchTopSongs() {
    return musicService.fetchTopSongs();
  }

  @override
  Future<List<Song>> searchSongs(String query) {
    // TODO: implement searchSongs
    throw UnimplementedError();
  }

}