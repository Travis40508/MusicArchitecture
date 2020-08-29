

import 'package:music_archiecture/models/song.dart';

abstract class MusicService {
  Future<List<Song>> fetchTopSongs();
  Future<List<Song>> fetchArtistTracks({int id});
  Future<List<Song>> searchSongs(String query);
}