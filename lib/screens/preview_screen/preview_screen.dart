import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/main.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/screens/preview_screen/preview_view_model.dart';
import 'package:music_archiecture/utils/constants.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  PreviewViewModel _viewModel;

  @override
  void didChangeDependencies() {
    final PreviewScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    _viewModel = PreviewViewModel(
        repository: serviceLocator.get<MusicRepository>(), song: args.song);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<PreviewViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(viewModel.title),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Constants.borderRadius)),
                        child: Hero(
                            tag: viewModel.song.id,
                            child: Image(
                              fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    viewModel.imageUrl))),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: .7,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: IconButton(
                              onPressed: () {
                                viewModel.changeSongState();
                                if (viewModel.isPlaying) {
                                  audioPlayer.play(viewModel.songPreview);
                                } else {
                                  audioPlayer.stop();
                                }
                              },
                              color: Theme.of(context).accentColor,
                              icon: Icon(!viewModel.isPlaying
                                  ? Icons.play_arrow
                                  : Icons.pause),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Card(
                        color: Theme.of(context).primaryColor,
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _viewModel.lyrics,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PreviewScreenArguments {
  final Song song;

  PreviewScreenArguments({@required this.song});
}
