import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/screens/preview_screen/preview_screen.dart';
import 'package:music_archiecture/screens/preview_screen/preview_view_model.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_repository.dart';

void main() {
  MusicRepository _repository;
  PreviewViewModel _viewModel;

  final song = Song(
    id: 1,
    title: 'Test Song',
    artist: 'Test Artist',
    albumImage: '',
    songPreviewLink: '',
  );

  group('Playing', () {

    setUp(() {
      _repository = MockRepository();
    });

    testWidgets('PreviewScreen - Playing with Lyrics', (WidgetTester tester) async {
      when(_repository.fetchLyrics(any, any)).thenAnswer((_) => Future.value('Test Lyrics'));
      _viewModel = PreviewViewModel(repository: _repository, song: song);
      _viewModel.changeSongState();

      final widget = MaterialApp(
        home: PreviewScreen(
          viewModel: _viewModel,
        )
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await expectLater(find.byType(PreviewScreen), matchesGoldenFile('preview_screen_playing_lyrics.png'));

    });
  });

}