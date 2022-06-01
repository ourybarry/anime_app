import 'package:anime/resources/bloc/api_result.dart';
import 'package:anime/resources/bloc/site_announcements_bloc.dart';
import 'package:anime/resources/bloc/trending_anime_bloc.dart';
import 'package:anime/resources/bloc/trending_manga_bloc.dart';
import 'package:anime/resources/model/anime/anime.dart';
import 'package:anime/resources/model/anime/anime_result.dart';
import 'package:anime/resources/model/announcement/site_announcement.dart';
import 'package:anime/resources/model/announcement/site_anouncement_result.dart';
import 'package:anime/resources/model/manga/manga.dart';
import 'package:anime/resources/model/manga/manga_result.dart';
import 'package:anime/resources/repository/anime_repository.dart';
import 'package:anime/resources/repository/manga_repository.dart';
import 'package:anime/resources/repository/site_announcement_repository.dart';
import 'package:anime/ui/components/announcement_card.dart';
import 'package:anime/ui/components/error_retry.dart';
import 'package:anime/ui/components/home_item_card.dart';
import 'package:anime/ui/pages/anime_details.dart/anime_details.dart';
import 'package:anime/ui/pages/manga_details/manga_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AnimeRepository animeRepository = AnimeRepository();
  final MangaRepository mangaRepository = MangaRepository();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Anime>> _animeFuture;
  late final Future<List<Manga>> _mangaFuture;
  late final TrendingAnimeBloc _trendingAnimeBloc;
  late final TrendingMangaBloc _trendingMangaBloc;

  @override
  void initState() {
    super.initState();
    _trendingAnimeBloc = TrendingAnimeBloc();
    _trendingMangaBloc = TrendingMangaBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SiteAnnouncementsList(),
            StreamBuilder(
                stream: _trendingAnimeBloc.trendingAnimeStream,
                builder:
                    ((context, AsyncSnapshot<ApiResult<AnimeResult>> snapshot) {
                  if (snapshot.hasError) {
                    dynamic error = snapshot.error;
                    return ErrorRetry(
                        heading: 'An error occured',
                        message: error.message,
                        onRetryPressed: () {
                          _trendingAnimeBloc.fetchData();
                        });
                  }
                  if (snapshot.hasData) {
                    return ItemGroup<Anime>(
                        title: "Trending anime", itemsData: snapshot.data!);
                  }
                  return Container();
                })),
            // ItemGroup(title: 'Trending manga', itemsFuture: _mangaFuture)
            StreamBuilder(
                stream: _trendingMangaBloc.trendingMangaStream,
                builder:
                    ((context, AsyncSnapshot<ApiResult<MangaResult>> snapshot) {
                  if (snapshot.hasError) {
                    dynamic error = snapshot.error;
                    return ErrorRetry(
                        heading: 'An error occured',
                        message: error.message,
                        onRetryPressed: () {
                          _trendingMangaBloc.fetchData();
                        });
                  }
                  if (snapshot.hasData) {
                    return ItemGroup<Manga>(
                        title: "Trending manga", itemsData: snapshot.data!);
                  }
                  return Container();
                })),
            // ItemGroup(title: 'Trending manga', itemsFuture: _mangaFuture)
          ],
        ),
      ),
    );
  }
}

class ItemGroup<T> extends StatelessWidget {
  final String title;
  final ApiResult<dynamic> itemsData;

  const ItemGroup({Key? key, required this.title, required this.itemsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 220.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (itemsData.status == Status.COMPLETED) {
                var item = itemsData.data!.data.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return item is Anime
                          ? AnimeDetails(anime: item)
                          : MangaDetails(manga: item);
                    }));
                  },
                  child: HomeItemCard(
                    item: item,
                  ),
                );
              }
              return HomeItemCardLoading(); //Show skeleton when data is still loading
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: itemsData.status == Status.COMPLETED
                ? itemsData.data!.data.length
                : 5,
          ))
    ]);
  }
}

class SiteAnnouncementsList extends StatefulWidget {
  final SiteAnnouncementsBloc _announcementsBloc = SiteAnnouncementsBloc();

  SiteAnnouncementsList({Key? key}) : super(key: key);

  @override
  State<SiteAnnouncementsList> createState() => _SiteAnnouncementsListState();
}

class _SiteAnnouncementsListState extends State<SiteAnnouncementsList> {
  late final Stream<ApiResult<SiteAnnouncementResult>> _announcementStream;

  @override
  void initState() {
    _announcementStream = widget._announcementsBloc.siteAnnouncementsStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Site announcements",
        style: Theme.of(context).textTheme.headline2,
      ),
      Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 300.0,
          child: StreamBuilder(
              stream: _announcementStream,
              builder: (context,
                  AsyncSnapshot<ApiResult<SiteAnnouncementResult>> snapshot) {
                if (snapshot.hasError) {
                  dynamic error = snapshot.error;
                  return ErrorRetry(
                      heading: 'An error occured',
                      message: error.message,
                      onRetryPressed: () {
                        widget._announcementsBloc.fetchData();
                      });
                }
                if (snapshot.hasData) {
                  print(snapshot.data!.status.toString());
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.status == Status.LOADING) {
                        return AnnouncementCardLoading();
                      }
                      return AnnouncementCard(
                          item: snapshot.data!.data!.data.elementAt(index));

                      // return AnnouncementCardLoading();
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: snapshot.data!.status == Status.COMPLETED
                        ? snapshot.data!.data!.data.length
                        : 5,
                  );
                }
                return Container();
              }))
    ]);
  }
}
