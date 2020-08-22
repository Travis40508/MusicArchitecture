
import 'package:flutter/material.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:flutter/foundation.dart';

class SongsViewModel extends ChangeNotifier {
  final MusicRepository musicRepository;

  SongsViewModel({@required this.musicRepository});
}