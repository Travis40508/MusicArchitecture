import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/models/song.dart';
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
    final PreviewScreenArguments args = ModalRoute.of(context).settings.arguments;
    _viewModel = PreviewViewModel(song: args.song);
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
            body: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Constants.borderRadius)),
                  child: Hero(
                    tag: viewModel.songPreview,
                    child: Image(image: CachedNetworkImageProvider(viewModel.imageUrl))
                  ),
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
