
class OrionLyricsResponse {
  final OrionLyricsResult _result;

  OrionLyricsResponse.fromJson(Map<String, dynamic> json) :
      _result = OrionLyricsResult.fromJson(json['result']);

  OrionLyricsResult get result => _result;
}

class OrionLyricsResult {
  final OrionLyricsTrack _track;
  final int _probability;

  OrionLyricsResult.fromJson(Map<String, dynamic> json) :
      _track = OrionLyricsTrack.fromJson(json['track']),
      _probability = json['probability'];

  OrionLyricsTrack get track => _track;
  int get probability => _probability;
}

class OrionLyricsTrack {
  final String _text;

  OrionLyricsTrack.fromJson(Map<String, dynamic> json) :
      _text = json['text'];

  String get text => _text;
}

