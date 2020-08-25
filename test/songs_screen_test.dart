import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/screens/songs_screen.dart';
import 'package:music_archiecture/screens/songs_view_model.dart';
import 'package:provider/provider.dart';
import 'mocks/mock_repository.dart';

void main() {
  MusicRepository _repository;
  SongsViewModel _viewModel;

   final _topSongs = <Song>[
    Song(
        artist: 'test1',
        artistImage: 'image1',
        songPreviewLink: 'link1',
        title: 'title1'),
    Song(
        artist: 'test2',
        artistImage: 'image2',
        songPreviewLink: 'link2',
        title: 'title2'),
    Song(
        artist: 'test3',
        artistImage: 'image3',
        songPreviewLink: 'link3',
        title: 'title3')
  ];

   final _searchedSongs = <Song>[
    Song(
        artist: 'test4',
        artistImage: 'image4',
        songPreviewLink: 'link4',
        title: 'title4'),
    Song(
        artist: 'test5',
        artistImage: 'image5',
        songPreviewLink: 'link5',
        title: 'title5'),
    Song(
        artist: 'test6',
        artistImage: 'image6',
        songPreviewLink: 'link6',
        title: 'title6')
  ];

  setUp(() {
    _repository = MockRepository();
  });


  testWidgets('SongsScreen - Top Artists', (WidgetTester tester) async {
    when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(_topSongs));
    final widget = MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => SongsViewModel(musicRepository: _repository),
        child: SongsScreen(),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await expectLater(find.byType(SongsScreen), matchesGoldenFile('song_screen.png'));
  });

  testWidgets('SongsScreen - Loading', (WidgetTester tester) async {
    when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(_topSongs));
    final widget = MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => SongsViewModel(musicRepository: _repository),
        child: SongsScreen(),
      ),
    );

    await tester.pumpWidget(widget);
    await expectLater(find.byType(SongsScreen), matchesGoldenFile('song_screen_loading.png'));
  });

  testWidgets('SongsScreen - Error', (WidgetTester tester) async {
    when(_repository.fetchTopSongs()).thenAnswer((_) => Future.error(Error()));
    final widget = MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => SongsViewModel(musicRepository: _repository),
        child: SongsScreen(),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await expectLater(find.byType(SongsScreen), matchesGoldenFile('song_screen_error.png'));
  });

  testWidgets('SongsScreen - Searching', (WidgetTester tester) async {
    when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(_topSongs));
    when(_repository.searchSongs(any)).thenAnswer((_) => Future.value(_searchedSongs));
    _viewModel = SongsViewModel(musicRepository: _repository, searchDelay: 0);
    final widget = MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => _viewModel,
        child: SongsScreen(),
      ),
    );

    _viewModel.onSearchChanged(query: 'The Wall');

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await expectLater(find.byType(SongsScreen), matchesGoldenFile('song_screen_searching.png'));
  });
}