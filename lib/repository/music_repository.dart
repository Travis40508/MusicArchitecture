
import 'package:music_archiecture/models/song.dart';
import 'package:flutter/foundation.dart';

abstract class MusicRepository {
  Future<List<Song>> fetchTopSongs();
  Future<List<Song>> fetchOtherArtistSongs({@required int artistId});
  Future<List<Song>> searchSongs(String query);
  Future<String> fetchLyrics(String artistName, String songTitle);
}