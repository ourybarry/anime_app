import 'package:anime/resources/model/announcement/site_announcement.dart';
import 'package:deep_pick/deep_pick.dart';

class SiteAnnouncementResult {
  final List<SiteAnnouncement> data;

  SiteAnnouncementResult({required this.data});

  factory SiteAnnouncementResult.fromJson(Map<String, dynamic> json) {
    final List<SiteAnnouncement> data =
        pick(json, 'data').asListOrEmpty((p0) => SiteAnnouncement.fromPick(p0));
    return SiteAnnouncementResult(data: data);
  }
}
