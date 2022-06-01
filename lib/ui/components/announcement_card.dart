import 'package:anime/resources/model/announcement/site_announcement.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final SiteAnnouncement item;

  const AnnouncementCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        item.image != null
            ? Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                child: Image.network(
                  item.image!,
                  fit: BoxFit.cover,
                ),
              )
            : SizedBox(
                width: 0,
                height: 0,
              ),
        Container(
          width: 200,
          padding: EdgeInsets.only(top: 10),
          child: Text(
            item.title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class AnnouncementCardLoading extends StatelessWidget {
  const AnnouncementCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: 200,
          color: CustomColors.TEXT_GREY,
        ),
        Container(
          width: 200,
          color: CustomColors.TEXT_GREY,
        )
      ],
    );
  }
}
