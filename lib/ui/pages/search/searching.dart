import 'package:anime/resources/model/anime/anime.dart';
import 'package:anime/resources/model/anime/anime_result.dart';
import 'package:anime/resources/model/character/character.dart';
import 'package:anime/resources/model/character/character_result.dart';
import 'package:anime/resources/repository/anime_repository.dart';
import 'package:anime/resources/repository/character_repository.dart';
import 'package:anime/ui/pages/anime_details.dart/anime_details.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class Searching extends StatefulWidget {
  final AnimeRepository _animeRepository = AnimeRepository();
  final CharacterRepository _characterRepository = CharacterRepository();
  Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching>
    with SingleTickerProviderStateMixin {
  bool searching = false;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  List<Anime> _anime = [];
  List<Character> _character = [];

  final List<String> _tabs = const ['Anime', 'Manga', 'Character'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                fillColor: Colors.grey, border: OutlineInputBorder()),
            autofocus: true,
            onChanged: (value) async {
              _autocomplete();
            },
          ),
          bottom: searching
              ? TabBar(
                  onTap: ((value) {
                    _autocomplete();
                  }),
                  padding: EdgeInsets.all(5),
                  controller: _tabController,
                  tabs: List.generate(
                      _tabs.length, (index) => Text(_tabs.elementAt(index))),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: const BubbleTabIndicator(
                      indicatorHeight: 25.0,
                      indicatorColor: Colors.blueAccent,
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      // Other flags
                      // indicatorRadius: 1,
                      // insets: EdgeInsets.all(1),
                      padding: EdgeInsets.all(20)),
                )
              : null,
        ),
        body: searching
            ? TabBarView(controller: _tabController, children: [
                AnimeSuggestions(
                  options: _anime,
                ),
                MangaSuggestions(
                  options: [],
                ),
                CharacterSuggestions(
                  options: _character,
                )
              ])
            : Container(
                padding: EdgeInsets.all(10),
                child: Center(child: RecentSearches()),
              ));
  }

  _autocomplete() {
    if (_searchController.text.isNotEmpty) {
      switch (_tabController.index) {
        case 0:
          _loadAnime();
          break;
        case 2:
          _loadCharacter();
          break;
        default:
      }
    } else {
      setState(() {
        searching = false;
      });
    }
  }

  _loadAnime() async {
    final AnimeResult result =
        await widget._animeRepository.getByQuery(_searchController.text);
    setState(() {
      searching =
          true; //Userr started searching something so we modify the body to display suggestions
      _anime = result.data;
    });
  }

  _loadManga() {}
  _loadCharacter() async {
    final CharacterResult result =
        await widget._characterRepository.getByQuery(_searchController.text);
    setState(() {
      searching =
          true; //Userr started searching something so we modify the body to display suggestions
      _character = result.data;
    });
  }
}

class AnimeSuggestions extends StatelessWidget {
  final List<Anime> options;
  const AnimeSuggestions({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: ((context, index) {
          return AnimeListItem(
            anime: options.elementAt(index),
          );
        }),
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: options.length);
  }
}

class MangaSuggestions extends StatelessWidget {
  final List<Anime> options;
  const MangaSuggestions({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('manga');
  }
}

class CharacterSuggestions extends StatelessWidget {
  final List<Character> options;
  const CharacterSuggestions({Key? key, required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 180,
          // childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return Container(
            // height: 250,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                options.elementAt(index).image!.original.toString(),
                height: 150.0,
                width: 200,
                fit: BoxFit.cover,
                // width: 100.0,
              ),
            ),
            Text(
              options.elementAt(index).name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ));
      },
      itemCount: options.length,
    );
  }
}

class RecentSearches extends StatelessWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Recent searches'),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Text('Recent');
            }),
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 2),
      ],
    );
  }
}

class AnimeListItem extends StatelessWidget {
  final Anime anime;
  const AnimeListItem({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimeDetails(
                      anime: anime,
                    )));
      },
      leading: Image.network(
        anime.posterImage.medium!,
        height: 180,
        width: 80,
        fit: BoxFit.cover,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            anime.canonicalTitle,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
