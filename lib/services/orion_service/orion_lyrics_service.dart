import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:music_archiecture/services/lyrics_service.dart';
import 'package:music_archiecture/services/orion_service/orion_lyrics_response.dart';

class OrionLyricsService implements LyricsService {
  final _baseUrl = 'https://orion.apiseeds.com/api/music/lyric';
  final _key = '1tfyhiKO6faDYSip7BOieMW9R2eiZwADeC0VnWkmmjZKoVdEAdz3MTinJhwZF7OC';

  Client _client = Client();

  @override
  Future<String> fetchLyrics(String artistName, String songTitle) async {
    final url = '$_baseUrl/$artistName/$songTitle?apikey=$_key';
    print('Fetching $url');
    final res = await _client.get(url);

    if (HttpStatus.ok == res.statusCode) {
      final json = jsonDecode(res.body);
      print('Response for $url: $json');

      return OrionLyricsResponse.fromJson(json).result.track.text;
    }

    throw Exception('Http Error - ${res.statusCode}');
  }


}