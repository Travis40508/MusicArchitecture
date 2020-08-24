import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/screens/songs_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:music_archiecture/utils/strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mocks/mock_repository.dart';

void main() async {
  final _repository = MockRepository();
  SongsViewModel _viewModel;

  tearDownAll(() {
    _viewModel.dispose();
  });

  group('Title changes', () {
    setUp(() {
      when(_repository.fetchTopSongs())
          .thenAnswer((_) => Future.value(<Song>[]));
      when(_repository.searchSongs(any))
          .thenAnswer((_) => Future.value(<Song>[]));

      _viewModel = SongsViewModel(musicRepository: _repository, searchDelay: 0);
    });

    test('Title matches search criteria', () async {
      final query = 'test';
      _viewModel.onSearchChanged(query: query);

      await pumpEventQueue();
      expect(_viewModel.title, "Showing Results for 'test'");
    });

    test('Title resets appropriately when cleared', () async {
      final query = Strings.empty;
      _viewModel.onSearchChanged(query: query);

      await pumpEventQueue();
      expect(_viewModel.title, 'Top Songs');
    });
  });

  group('songs changes', () {
    final topSongs = <Song>[
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

    final searchedSongs = <Song>[
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
      when(_repository.fetchTopSongs())
          .thenAnswer((_) => Future.value(topSongs));
      when(_repository.searchSongs(any))
          .thenAnswer((_) => Future.value(searchedSongs));

      _viewModel = SongsViewModel(musicRepository: _repository, searchDelay: 0);
    });

    test('fetching top songs', () async {
      _viewModel = SongsViewModel(musicRepository: _repository);

      await pumpEventQueue();
      expect(_viewModel.songs, topSongs);
    });

    test('switching to searched songs on search', () async {
      _viewModel.onSearchChanged(query: 'The Wall');

      await pumpEventQueue();
      expect(_viewModel.songs, searchedSongs);

    });

    test('switching back to cached songs when query is empty', () async {
      _viewModel.onSearchChanged(query: 'The Wall');
      await pumpEventQueue();
      expect(_viewModel.songs, searchedSongs);

      _viewModel.onSearchChanged(query: Strings.empty);
      await pumpEventQueue();
      expect(_viewModel.songs, topSongs);
    });
  });

//  group('error scenarios', () {
//
//  });
//
//  group('loading scenarios', () {
//
//  });
}
