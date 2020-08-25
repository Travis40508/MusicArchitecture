import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:music_archiecture/app.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/repository/music_repository_impl.dart';
import 'package:music_archiecture/services/deezer_service/deezer_service.dart';
import 'package:music_archiecture/services/orion_service/orion_lyrics_service.dart';

final serviceLocator = GetIt.instance;

void main() {
  _buildDependencyGraph();
  runApp(App());
}

void _buildDependencyGraph() {
  serviceLocator.registerLazySingleton<MusicRepository>(() =>
      MusicRepositoryImpl(
          musicService: DeezerService(), lyricsService: OrionLyricsService()));
}
