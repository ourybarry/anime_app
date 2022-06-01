import 'package:anime/resources/bloc/api_result.dart';
import 'package:anime/resources/model/manga/manga_result.dart';
import 'package:anime/resources/repository/manga_repository.dart';
import 'package:rxdart/rxdart.dart';

class TrendingMangaBloc {
  //Repo
  late final MangaRepository _repository;
  //Subject
  late final BehaviorSubject<ApiResult<MangaResult>> _subject;
  //Data

  TrendingMangaBloc() {
    _repository = MangaRepository();
    _subject = BehaviorSubject<ApiResult<MangaResult>>();
    fetchData();
  }
  fetchData() async {
    _subject.add(ApiResult.loading('Loading trending Manga'));
    try {
      MangaResult _data = await _repository.getTrending();
      _subject.add(ApiResult.completed(_data));
    } catch (e) {
      _subject.addError(ApiResult.error(e.toString()));
    }
  }

  Stream<ApiResult<MangaResult>> get trendingMangaStream => _subject.stream;
}
