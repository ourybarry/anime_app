import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/model/announcement/site_anouncement_result.dart';

class SiteAnnouncementRepository {
  final ApiClient _client = ApiClient();

  Future<SiteAnnouncementResult> getAll() async {
    const String path = '/site/announcement';

    final result = await _client.get(path, null);

    return SiteAnnouncementResult.fromJson(result);
  }
}
