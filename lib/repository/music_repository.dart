
import 'package:music_archiecture/models/song.dart';

abstract class MusicRepository {
  Future<List<Song>> fetchTopSongs();
  Future<List<Song>> searchSongs(String query);
  Future<String> fetchLyrics(String artistName, String songTitle);
}