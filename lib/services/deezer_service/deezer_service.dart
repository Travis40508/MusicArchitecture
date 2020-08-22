
import 'dart:convert';
import 'dart:io';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/services/deezer_service/deezer_response.dart';
import 'package:music_archiecture/services/music_service.dart';
import 'package:http/http.dart' show Client;

class DeezerService implements MusicService {

  final Client _client = Client();
  static const _baseUrl = 'https://api.deezer.com';

  @override
  Future<List<Song>> fetchTopSongs() async {
    final url = '$_baseUrl/chart';
    final res = await _client.get(url);

    if (HttpStatus.ok == res.statusCode) {
      final json = jsonDecode(res.body);
      final DeezerResponse deezerResponse = DeezerResponse.fromJson(json);

      return deezerResponse.tracks.songs.map((deezerSong) => Song(
        title: deezerSong.title,
        artist: deezerSong.artist.name,
        artistImage: deezerSong.artist.image,
        songPreviewLink: deezerSong.songPreviewUrl
      )).toList();
    }

    throw Exception('Http error - ${res.statusCode}');
  }

  @override
  Future<List<Song>> searchSongs(String query) async {
    final url = '$_baseUrl/search?q=$query';
    final res = await _client.get(url);

    if (HttpStatus.ok == res.statusCode) {
      final json = jsonDecode(res.body);
      final DeezerTracks tracks = DeezerTracks.fromJson(json);

      return tracks.songs.map((deezerSong) => Song(
          title: deezerSong.title,
          artist: deezerSong.artist.name,
          artistImage: deezerSong.artist.image,
          songPreviewLink: deezerSong.songPreviewUrl
      )).toList();
    }

    throw Exception('Http error - ${res.statusCode}');
  }

}