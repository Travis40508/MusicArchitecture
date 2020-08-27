import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/screens/preview_screen/preview_view_model.dart';
import 'package:music_archiecture/utils/constants.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatefulWidget {

  final PreviewViewModel viewModel;

  PreviewScreen({@required this.viewModel});

  @override
  _PreviewScreenState createState() => _PreviewScreenState(viewModel: viewModel);
}

class _PreviewScreenState extends State<PreviewScreen> {
  final PreviewViewModel viewModel;
  final AudioPlayer audioPlayer = AudioPlayer();

  _PreviewScreenState({@required this.viewModel});

  @override
  void initState() {
    ///Listens for the song to end so that the pause button can once again become a play button
    audioPlayer.onPlayerStateChanged.listen(viewModel.onPlayerStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<PreviewViewModel>(
          builder: (_, viewModel, __) {
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).accentColor,
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              viewModel.lyrics,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
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
