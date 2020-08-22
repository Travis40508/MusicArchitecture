
class DeezerResponse {
  final Tracks _tracks;
  
  DeezerResponse.fromJson(Map<String, dynamic> json) :
      _tracks = Tracks.fromJson(json['tracks']);

  Tracks get tracks => _tracks;
}

class Tracks {
  final List<DeezerSong> _songs;

  Tracks.fromJson(Map<String, dynamic> json) :
      _songs = (json['data'] as List).map((song) => DeezerSong.fromJson(song)).toList();

  List<DeezerSong> get songs => _songs;
}

class DeezerSong {
  final String _title;
  final DeezerArtist _artist;
  final String _songPreviewUrl;

  DeezerSong.fromJson(Map<String, dynamic> json) :
      _title = json['title'],
      _artist = DeezerArtist.fromJson(json['artist']),
      _songPreviewUrl = json['preview'];

  String get songPreviewUrl => _songPreviewUrl;

  DeezerArtist get artist => _artist;

  String get title => _title;
}

class DeezerArtist {
  final String _name;
  final String _image;

  DeezerArtist.fromJson(Map<String, dynamic> json) :
      _name = json['name'],
      _image = json['picture_medium'];

  String get image => _image;

  String get name => _name;
}