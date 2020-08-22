import 'package:flutter/material.dart';
import 'package:music_archiecture/screens/songs_view_model.dart';
import 'package:music_archiecture/utils/strings.dart';
import 'package:music_archiecture/widgets/music_error_widget.dart';
import 'package:music_archiecture/widgets/loading_widget.dart';
import 'package:music_archiecture/widgets/search_bar.dart';
import 'package:music_archiecture/widgets/song_card.dart';
import 'package:provider/provider.dart';

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _screenContent;
  }

  Widget _fetchAppBar({@required String title}) => AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
      );

  get _screenContent => Consumer<SongsViewModel>(
        builder: (_, viewModel, __) {

          return Scaffold(
            appBar: _fetchAppBar(title: viewModel.title),
            body: Builder(builder: (context) {
              if (viewModel.isLoading) {
                return LoadingWidget();
              }

              if (viewModel.hasError) {
                return MusicErrorWidget();
              }

              return Column(
                children: <Widget>[
                  SearchBar(
                    onChanged: (query) => viewModel.onSearchChanged(query: query),
                    controller: _controller,
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.songs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (_, index) {
                        final song = viewModel.songs[index];

                        return SongCard(
                          song: song,
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          );

        },
      );
}
