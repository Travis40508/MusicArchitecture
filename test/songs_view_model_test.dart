import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/screens/songs_screen/songs_view_model.dart';
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

  final topSongs = <Song>[
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

  final searchedSongs = <Song>[
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

  group('Title changes', () {
    setUp(() {
      when(_repository.fetchTopSongs())
          .thenAnswer((_) => Future.value(<Song>[]));
      when(_repository.searchSongs(any))
          .thenAnswer((_) => Future.value(<Song>[]));

      _viewModel = SongsViewModel(musicRepository: _repository, searchDelay: 0);
    });

    test('Default title', () async {
      await pumpEventQueue();

      expect(_viewModel.title, Strings.songsScreenTitle);
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
      expect(_viewModel.title, Strings.songsScreenTitle);
    });

    test('Default title', () async {
      await pumpEventQueue();

      expect(_viewModel.title, Strings.songsScreenTitle);
    });
  });

  group('songs changes', () {

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

  group('error scenarios', () {

    test('Error in fetching top songs', () async {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.error(Error()));
      _viewModel = SongsViewModel(musicRepository: _repository);

      await pumpEventQueue();

      expect(_viewModel.hasError, isTrue);
    });

    test('No error in fetching top songs', () async {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(topSongs));
      _viewModel = SongsViewModel(musicRepository: _repository);

      await pumpEventQueue();

      expect(_viewModel.hasError, isFalse);
    });

    test('Error in searching for songs', () async {
      when(_repository.searchSongs(any)).thenAnswer((_) => Future.error(Error()));
      _viewModel = SongsViewModel(musicRepository: _repository, searchDelay: 0);

      _viewModel.onSearchChanged(query: "The Wall");
      await pumpEventQueue();

      expect(_viewModel.hasError, isTrue);
    });

    test('No error in searching for songs', () async {
      when(_repository.searchSongs(any)).thenAnswer((_) => Future.value(searchedSongs));
      _viewModel = SongsViewModel(musicRepository: _repository, searchDelay: 0);

      _viewModel.onSearchChanged(query: "The Wall");
      await pumpEventQueue();

      expect(_viewModel.hasError, isFalse);
    });
  });

  group('loading scenarios', () {

    test('initial value', () async {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.delayed(Duration(seconds: 1), () => topSongs));
      _viewModel = SongsViewModel(musicRepository: _repository);

      //intentionally not waiting for the fetching of top songs to complete
      expect(_viewModel.isLoading, isTrue);
    });


    test('after fetching top songs', () async {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(topSongs));
      _viewModel = SongsViewModel(musicRepository: _repository);

      //awaiting the top songs to be fetched
      await pumpEventQueue();
      expect(_viewModel.isLoading, isFalse);
    });

    test('after error in fetching top songs', () async {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.error(Error()));
      _viewModel = SongsViewModel(musicRepository: _repository);

      await pumpEventQueue();
      expect(_viewModel.isLoading, isFalse);
    });

    test('after searching for songs', () async {
      when(_repository.searchSongs(any)).thenAnswer((_) => Future.value(searchedSongs));
      _viewModel = SongsViewModel(musicRepository: _repository);

      await pumpEventQueue();
      expect(_viewModel.isLoading, isFalse);
    });

    test('after searching for songs with error', () async {
      when(_repository.searchSongs(any)).thenAnswer((_) => Future.error(Error()));
      _viewModel = SongsViewModel(musicRepository: _repository);

      await pumpEventQueue();
      expect(_viewModel.isLoading, isFalse);
    });
  });
}
