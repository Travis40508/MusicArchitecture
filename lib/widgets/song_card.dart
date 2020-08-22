import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/utils/constants.dart';

class SongCard extends StatelessWidget {
  final Song song;

  SongCard({@required this.song});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          elevation: 4.0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Constants.borderRadius)
            ),
            child: Image(
              image: CachedNetworkImageProvider(song.artistImage),
            ),
          ),
        ),
        Positioned(
          bottom: 3.0,
          left: 3.0,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                song.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          top: 3.0,
          right: 3.0,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                song.artist,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
