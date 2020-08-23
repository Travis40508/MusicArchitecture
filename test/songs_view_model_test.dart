import 'package:music_archiecture/models/song.dart';
import 'package:music_archiecture/screens/songs_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:music_archiecture/utils/strings.dart';
import 'package:test/test.dart';

import 'mocks/mock_repository.dart';

void main() {
  final _repository = MockRepository();
  SongsViewModel _viewModel;

  group('Title changes', () {

    setUp(() {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(<Song>[]));
      when(_repository.searchSongs(any)).thenAnswer((_) => Future.value(<Song>[]));

      _viewModel = SongsViewModel(musicRepository: _repository);
    });

    test('Title matches search criteria', () {
      final query = 'test';

      _viewModel.addListener(() async {
        expect(_viewModel.title, "Showing Results for 'test'");
      });

      _viewModel.onSearchChanged(query: query);
    });

    test('Title resets appropriately when cleared', () {
      final query = Strings.empty;

      _viewModel.addListener(() async {
        expect(_viewModel.title, 'Top Songs');
      });

      _viewModel.onSearchChanged(query: query);
    });
  });

  group('songs changes', () {

    final topSongs = <Song>[
      Song(
          artist: 'test1',
          artistImage: 'image1',
          songPreviewLink: 'link1',
          title: 'title1'
      ),
      Song(
          artist: 'test2',
          artistImage: 'image2',
          songPreviewLink: 'link2',
          title: 'title2'
      ),
      Song(
          artist: 'test3',
          artistImage: 'image3',
          songPreviewLink: 'link3',
          title: 'title3'
      )
    ];

    final searchedSongs = <Song> [
      Song(
          artist: 'test4',
          artistImage: 'image4',
          songPreviewLink: 'link4',
          title: 'title4'
      ),
      Song(
          artist: 'test5',
          artistImage: 'image5',
          songPreviewLink: 'link5',
          title: 'title5'
      ),
      Song(
          artist: 'test6',
          artistImage: 'image6',
          songPreviewLink: 'link6',
          title: 'title6'
      )
    ];

    setUp(() {
      when(_repository.fetchTopSongs()).thenAnswer((_) => Future.value(topSongs));
      when(_repository.searchSongs(any)).thenAnswer((_) => Future.value(searchedSongs));
    });

    test('fetching top songs', () {

      _viewModel = SongsViewModel(musicRepository: _repository);

      _viewModel.addListener(() async {
        expect(_viewModel.songs, topSongs);
      });

    });

    test('caching top songs', () {

    });

    test('switching to searched songs on search', () {

    });

    test('switching back to cached songs when query is empty', () {

    });
  });

  group('error scenarios', () {

  });

  group('loading scenarios', () {

  });
}
