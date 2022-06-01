import 'package:anime/resources/bloc/api_result.dart';
import 'package:anime/resources/model/announcement/site_anouncement_result.dart';
import 'package:anime/resources/repository/site_announcement_repository.dart';
import 'package:rxdart/rxdart.dart';

class SiteAnnouncementsBloc {
  //Repo
  late final SiteAnnouncementRepository _repository;
  //Subject
  late final BehaviorSubject<ApiResult<SiteAnnouncementResult>> _subject;
  //Data

  SiteAnnouncementsBloc() {
    _repository = SiteAnnouncementRepository();
    _subject = BehaviorSubject<ApiResult<SiteAnnouncementResult>>();
    fetchData();
  }
  fetchData() async {
    _subject.add(ApiResult.loading('Loading site announcements'));
    try {
      SiteAnnouncementResult _data = await _repository.getAll();
      _subject.add(ApiResult.completed(_data));
    } catch (e) {
      _subject.addError(ApiResult.error(e.toString()));
    }
  }

  Stream<ApiResult<SiteAnnouncementResult>> get siteAnnouncementsStream =>
      _subject.stream;
}
