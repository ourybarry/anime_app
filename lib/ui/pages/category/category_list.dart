import 'package:anime/resources/model/category/category.dart';
import 'package:anime/resources/model/category/category_result.dart';
import 'package:anime/resources/repository/category_repository.dart';
import 'package:anime/ui/pages/category/category_content.dart';
import 'package:anime/ui/themes/custom_colors.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final CategoryRepository categoryRepository = CategoryRepository();

  CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late final Future<List<Category>> _categoryFuture;
  late final ScrollController _scrollController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.extentAfter < 500) {
          print('loading more data');
        } else {
          print('no');
        }
      });
    _categoryFuture = widget.categoryRepository
        .getCategories(limit: 20)
        .then((value) => value.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: Theme.of(context).textTheme.headline1,
            ),
            FutureBuilder(
              future: _categoryFuture,
              builder: ((context, AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 60,
                              // childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final Category current =
                            snapshot.data!.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryContent(
                                          category: current,
                                        )));
                          },
                          child: Container(
                            // height: 30,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  current.title,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(current.totalMediaCount.toString())
                              ],
                            ),
                            color: CustomColors.PRIMARY_COLOR,
                          ),
                        );
                      });
                }
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: Colors.white),
                  );
                }
                return Text(
                  'loading',
                  style: TextStyle(color: Colors.white),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
