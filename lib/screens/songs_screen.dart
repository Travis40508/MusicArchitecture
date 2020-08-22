import 'package:flutter/material.dart';
import 'package:music_archiecture/screens/songs_view_model.dart';
import 'package:music_archiecture/utils/strings.dart';
import 'package:music_archiecture/widgets/music_error_widget.dart';
import 'package:music_archiecture/widgets/loading_widget.dart';
import 'package:music_archiecture/widgets/song_card.dart';
import 'package:provider/provider.dart';

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _songList,
    );
  }

  get _appBar => AppBar(
        centerTitle: true,
        title: Text(Strings.songsScreenTitle),
        backgroundColor: Theme.of(context).primaryColor,
      );

  get _songList => Consumer<SongsViewModel>(
        builder: (_, viewModel, __) {
          if (viewModel.isLoading) {
            return LoadingWidget();
          }

          if (viewModel.hasError) {
            return MusicErrorWidget();
          }

          return GridView.builder(
            itemCount: viewModel.songs.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, index) {
              final song = viewModel.songs[index];

              return SongCard(
                song: song,
              );
            },
          );
        },
      );
}
