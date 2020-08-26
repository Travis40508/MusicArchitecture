import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/repository/music_repository.dart';
import 'package:music_archiecture/screens/songs_screen/songs_screen.dart';
import 'package:music_archiecture/screens/songs_screen/songs_view_model.dart';
import 'package:provider/provider.dart';
import 'mocks/mock_repository.dart';

void main() {
  MusicRepository _repository;
  SongsViewModel _viewModel;

   final _topSongs = <Song>[
    Song(
        id: 1,
        artist: 'test1',
        albumImage: 'image1',
        songPreviewLink: 'link1',
        title: 'title1'),
    Song(
        id: 2,
        artist: 'test2',
        albumImage: 'image2',
        songPreviewLink: 'link2',
        title: 'title2'),
    Song(
        id: 3,
        artist: 'test3',
        albumImage: 'image3',
        songPreviewLink: 'link3',
        title: 'title3')
  ];

   final _searchedSongs = <Song>[
    Song(
        id: 4,
        artist: 'test4',
        albumImage: 'image4',
        songPreviewLink: 'link4',
        title: 'title4'),
    Song(
        id: 5,
        artist: 'test5',
        albumImage: 'image5',
        songPreviewLink: 'link5',
        title: 'title5'),
    Song(
        id: 6,
        artist: 'test6',
        albumImage: 'image6',
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
      home: ChangeNotifierProvider.value(
        value: _viewModel,
        child: SongsScreen(),
      ),
    );

    _viewModel.onSearchChanged(query: 'The Wall');

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await expectLater(find.byType(SongsScreen), matchesGoldenFile('song_screen_searching.png'));
  });
}