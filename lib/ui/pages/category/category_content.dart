import 'package:anime/resources/model/anime/anime.dart';
import 'package:anime/resources/model/anime/anime_result.dart';
import 'package:anime/resources/model/category/category.dart';
import 'package:anime/resources/model/manga/manga.dart';
import 'package:anime/resources/repository/anime_repository.dart';
import 'package:anime/resources/repository/manga_repository.dart';
import 'package:anime/ui/components/item_grid.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class CategoryContent extends StatefulWidget {
  final AnimeRepository animeRepository = AnimeRepository();
  final MangaRepository mangaRepository = MangaRepository();
  final Category category;

  CategoryContent({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _tabs = ['Anime', 'Manga'];
  // final List<Anime> _anime = [];
  // final List<Manga> _manga = [];
  late final Future<List<Anime>> _animeFuture;
  late final Future<List<Manga>> _mangaFuture;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _animeFuture = widget.animeRepository
        .getByCategory(category: widget.category)
        .then((result) => result.data);
    _mangaFuture = widget.mangaRepository
        .getByCategory(category: widget.category)
        .then((result) => result.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
            onTap: _handleTabChange,
            controller: _tabController,
            tabs: _tabs.map((element) => Text(element)).toList()),
      ),
      body: TabBarView(children: [
        FutureBuilder(
            future: _animeFuture,
            builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemGrid(items: snapshot.data!),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.dangerous,
                      color: CustomColors.PRIMARY_COLOR,
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Error',
                          style: TextStyle(color: Colors.white),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          color: CustomColors.PRIMARY_COLOR,
                          child: Text('Retry'),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Text(
                'loading',
                style: TextStyle(color: Colors.white),
              );
            }),
        FutureBuilder(
            future: _mangaFuture,
            builder: (context, AsyncSnapshot<List<Manga>> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemGrid(items: snapshot.data!),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: ListTile(
                    leading: Icon(Icons.dangerous),
                    title: Column(
                      children: [Text('Error')],
                    ),
                  ),
                );
              }
              return Text(
                'loading',
                style: TextStyle(color: Colors.white),
              );
            }),
      ], controller: _tabController),
    );
  }

  _loadAnimeData() {}
  _loadMangaData() {}
  void _handleTabChange(int index) {
    if (index == 0) _loadAnimeData();
    if (index == 1) _loadMangaData();
  }
}
