import 'package:anime/resources/bloc/api_result.dart';
import 'package:anime/resources/model/anime/anime_result.dart';
import 'package:anime/resources/repository/anime_repository.dart';
import 'package:rxdart/rxdart.dart';

class TrendingAnimeBloc {
  //Repo
  late final AnimeRepository _repository;
  //Subject
  late final BehaviorSubject<ApiResult<AnimeResult>> _subject;
  //Data

  TrendingAnimeBloc() {
    _repository = AnimeRepository();
    _subject = BehaviorSubject<ApiResult<AnimeResult>>();
    fetchData();
  }
  fetchData() async {
    _subject.add(ApiResult.loading('Loading trending anime'));
    try {
      AnimeResult _data = await _repository.getTrending();
      _subject.add(ApiResult.completed(_data));
    } catch (e) {
      _subject.addError(ApiResult.error(e.toString()));
    }
  }

  Stream<ApiResult<AnimeResult>> get trendingAnimeStream => _subject.stream;
}
