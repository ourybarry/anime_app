import 'package:anime/resources/model/category/category.dart';
import 'package:anime/resources/repository/category_repository.dart';
import 'package:anime/ui/pages/category/category_list.dart';
import 'package:anime/ui/pages/search/searching.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final CategoryRepository categoryRepository = CategoryRepository();

  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _categories =
        widget.categoryRepository.getCategories().then((value) => value.data);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Text('Search'),
          TextField(
            decoration: const InputDecoration(hintText: 'Search...'),
            readOnly: true,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Searching();
              }));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline2,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CategoryList())));
                    },
                    child: Text('See all'))
              ],
            ),
          ),
          FutureBuilder(
              future: _categories,
              builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 60,
                              // childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Container(
                          // height: 30,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            snapshot.data!.elementAt(index).title,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          color: CustomColors.PRIMARY_COLOR,
                        );
                      });
                }
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 60,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Container(color: CustomColors.PRIMARY_COLOR);
                    });
              }),
        ],
      ),
    );
  }
}
