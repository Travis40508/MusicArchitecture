import 'package:flutter/material.dart';
import 'package:music_archiecture/main.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/screens/preview_screen/preview_screen.dart';
import 'package:music_archiecture/screens/preview_screen/preview_view_model.dart';
import 'package:music_archiecture/screens/songs_screen/songs_screen.dart';
import 'package:music_archiecture/screens/songs_screen/songs_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Architecture',
      initialRoute: '/songs',
      routes: {
        '/songs': (context) => ChangeNotifierProvider(
          create: (_) => SongsViewModel(musicRepository: serviceLocator.get<MusicRepository>()),
          child: SongsScreen(),
        ),
        '/preview': (context) => PreviewScreen()
      },

      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.white
      ),
    );
  }
}
