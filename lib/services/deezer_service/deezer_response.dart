
class DeezerResponse {
  final DeezerTracks _tracks;
  
  DeezerResponse.fromJson(Map<String, dynamic> json) :
      _tracks = DeezerTracks.fromJson(json['tracks']);

  DeezerTracks get tracks => _tracks;
}

class DeezerTracks {
  final List<DeezerSong> _songs;

  DeezerTracks.fromJson(Map<String, dynamic> json) :
      _songs = (json['data'] as List).map((song) => DeezerSong.fromJson(song)).toList();

  List<DeezerSong> get songs => _songs;
}

class DeezerSong {
  final int _id;
  final String _title;
  final DeezerArtist _artist;
  final DeezerAlbum _album;
  final String _songPreviewUrl;

  DeezerSong.fromJson(Map<String, dynamic> json) :
      _id = json['id'],
      _title = json['title'],
      _artist = DeezerArtist.fromJson(json['artist']),
      _album = DeezerAlbum.fromJson(json['album']),
      _songPreviewUrl = json['preview'];


  int get id => _id;

  String get songPreviewUrl => _songPreviewUrl;

  DeezerArtist get artist => _artist;

  DeezerAlbum get album => _album;

  String get title => _title;
}

class DeezerArtist {
  final int _id;
  final String _name;
  final String _image;

  DeezerArtist.fromJson(Map<String, dynamic> json) :
      _id = json['id'],
      _name = json['name'],
      _image = json['picture_medium'];

  String get image => _image;

  int get id => _id;

  String get name => _name;
}

class DeezerAlbum {
  final int _id;
  final String _title;
  final String _imageUrl;

  DeezerAlbum.fromJson(Map<String, dynamic> json) :
      _id = json['id'],
      _title = json['title'],
      _imageUrl = json['cover_medium'];

  String get imageUrl => _imageUrl;

  String get title => _title;

  int get id => _id;
}