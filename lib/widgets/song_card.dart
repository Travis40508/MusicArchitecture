import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:music_archiecture/models/song.dart';

class SongCard extends StatelessWidget {

  final Song song;

  SongCard({@required this.song});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Image(
        image: CachedNetworkImageProvider(
          song.artistImage
        ),
      ),
    );
  }
}
